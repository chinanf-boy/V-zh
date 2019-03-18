<!-- @t header h2 { border-top: 1px solid #dfdfdf; padding-top: 10px; } pre { font-size:80%; } comment { font-family: 'Roboto Mono'; color: #777; } -->

# V 编程语言

为开发[volt](https://volt.ws)，创建快速，安全，编译的语言，很快，所有人都能用啦。

2019 年中期，发布开源。

在 0.5 秒内，从源安装 V.

```bash
wget vlang.io/v.c && gcc -o v v.c
```

## V 和其他语言的比较

### Go

V 与 Go 非常相似，这些是 V 改进的东西：

- 没有全局状态
- 只有一种声明风格（`a := 0`）
- 没有 null
- 没有未定义(undefined)的值
- 没有`err != nil`检查（由 option 类型替换）
- 默认不变性
- 更加严格的 vfmt
- 没有运行时
- 更小的二进制文件
- 零成本 C 互操作
- 没有 GC
- 无所畏惧的并发（编译时，保证没有数据竞争）
- 泛型
- 没有动态调度，更便宜的接口

### 锈 Rust

Rust 有着截然不同的哲学。

它是一种复杂的语言，具有越来越多的功能和陡峭的学习曲线。毫无疑问，一旦您学习并理解了该语言，它就成为开发安全，快速，稳定软件的强大工具。但**复杂性**仍然存在。

V 的目标是允许构建可维护，且可预测的软件。这就是为什么语言如此简单，甚至可能对某些人来说无聊。好处是，你可以跳进项目的任何部分，并了解正在发生的事情，感觉就像是你写的那样，因为语言很简单，而且只有一种做事方式。

Rust 的编译速度很慢，与 C ++相比的话。V 每秒每个 CPU 能编译 150 万行代码。

### V vs Rust vs Go：例子

由于 V 的作用领域，接近 Go 和 Rust，我决定使用一个简单的例子来比较这三者。

我遇到了一位开发人员[比拼](https://github.com/hyperium/hyper/issues/777)，语言使用分别是 Rust 和 Go。他们编写了一个简单的并发程序，同时获取了 `Hacker News` 的前排新闻。

在得到两个社区的帮助后，这是他们的最终代码：

**Rust**

```rust
extern crate hyper;
extern crate rustc_serialize;

use std::thread;
use std::io::Read;
use std::ops::DerefMut;
use std::sync::Mutex;
use std::sync::MutexGuard;
use std::sync::LockResult;
use std::sync::Arc;

use hyper::Client;
use hyper::header::Connection;
use rustc_serialize::json;

#[derive(RustcDecodable, RustcEncodable)]
struct Story {
    by: String,
    id: i32,
    score: i32,
    time: i32,
    title: String,
}

fn next(cursor: &mut Arc<Mutex<usize>>) -> usize {
    let result: LockResult<MutexGuard<usize>> = cursor.lock();
    let mut guard: MutexGuard<usize> = result.unwrap();
    let mut temp = guard.deref_mut();
    *temp = *temp+1;
    return *temp;
}

fn main() {
    let client = Arc::new(Client::new());
    let url = "https://hacker-news.firebaseio.com/v0/topstories.json";
    let mut res = client.get(url).header(Connection::close()).send().unwrap();
    let mut body = String::new();
    res.read_to_string(&mut body).unwrap();
    let vec: Vec<i32> = json::decode(body.as_str()).unwrap();
    let lock: Arc<Mutex<usize>> = Arc::new(Mutex::new(0));

    let mut handles: Vec<thread::JoinHandle<()>> = Vec::new();
    for _ in 0..8 {
        let client2 = client.clone();
        let mut lock2 = lock.clone();
        let vec2 = vec.clone();
        handles.push(thread::spawn(move|| {
            loop {
                let cursor = next(&mut lock2);

                if cursor >= vec2.len() {
                    break;
                }

                let url = format!(
                    "https://hacker-news.firebaseio.com/v0/item/{}.json",
                    vec2[cursor],
                );

                let mut res = client2.get(url.as_str())
                    .header(Connection::close())
                    .send()
                    .unwrap();

                let mut body = String::new();
                res.read_to_string(&mut body).unwrap();
                let story: Story = json::decode(body.as_str()).unwrap();
                println!("{}", story.title);
            };
        }));
    }

    for handle in handles.into_iter() {
        handle.join().unwrap();
    }
}
```

**Go**

```go
package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"sync"
)

type Story struct {
	Title string
}

func main() {
	rsp, err := http.Get("https://hacker-news.firebaseio.com/v0/topstories.json")
	if err != nil {
		panic(err)
	}
	defer rsp.Body.Close()

	data, err := ioutil.ReadAll(rsp.Body)
	if err != nil {
		panic(err)
	}

	var ids []int
	if err := json.Unmarshal(data, &ids); err != nil {
		panic(err)
	}

	var cursor int
	var mutex sync.Mutex

	next := func() int {
		mutex.Lock()
		defer mutex.Unlock()
		temp := cursor
		cursor++
		return temp
	}

	wg := sync.WaitGroup{}
	for i := 0; i < 8; i++ {
		wg.Add(1)
		go func() {
			for cursor := next(); cursor < len(ids); cursor = next() {
				url := fmt.Sprintf(
					"https://hacker-news.firebaseio.com/v0/item/%d.json",
					ids[cursor],
				)
				rsp, err := http.Get(url)
				if err != nil {
					panic(err)
				}
				defer rsp.Body.Close()

				data, err := ioutil.ReadAll(rsp.Body)
				if err != nil {
					panic(err)
				}
				var story Story
				if err := json.Unmarshal(data, &story); err != nil {
					panic(err)
				}
				fmt.Println(story.Title)
			}
			wg.Done()
		}()
	}

	wg.Wait()
}
```

**V**

```v
import http
import json
import runtime

struct Story {
        title string
}

fn main() {
        resp := http.get('https://hacker-news.firebaseio.com/v0/topstories.json')?
        ids := json.decode([]int, resp.body)?  // ? propagates the error
        mut cursor := 0
        for _ in 0..8 {
                go fn() {
                        for cursor < ids.len {
                                lock { // Without this lock block the program will not compile
                                        id := ids[cursor]
                                        cursor++
                                }
                                url := 'https://hacker-news.firebaseio.com/v0/item/$id.json'
                                resp := http.get(url)?
                                story := json.decode(Story, resp.body)?
                                println(story.title)
                        }
                }()
        }
        runtime.wait() // Waits for all coroutines to finish
}
```

即将推出，更多语言...

<!-- @t footer -->
