<!-- @t header h2 { border-top: 1px solid #dfdfdf; padding-top: 10px; } pre { font-size:80%; } comment { font-family: 'Roboto Mono'; color: #777; } -->

[例子](https://github.com/vlang-io/V/tree/master/examples) [文档](/docs) [操场](/play) [博客](/blog) [常问问题](/#faq) [软件内置V](/#software)

# V编程语言

为开发创建快速，安全，编译的语言[伏特](https://volt.ws)，很快就可供所有人使用。

2019年中期开源发布。

在0.5秒内从源安装V.

```
wget vlang.io/v.c && gcc -o v v.c
```

## V和其他语言的比较

### 走

V与Go非常相似，这些是它改进的东西：

-   没有全球状态
-   只有一种宣言风格（`a := 0`）
-   没有
-   没有未定义的值
-   没有`err != nil`检查（由选项类型替换）
-   默认不变性
-   更加严格的vfmt
-   没有运行时
-   更小的二进制文件
-   零成本C互操作
-   没有GC
-   无所畏的并发（编译时没有数据竞争保证）
-   泛型
-   没有动态调度的更便宜的接口

### 锈

Rust有着截然不同的哲学。

它是一种复杂的语言，具有越来越多的功能和陡峭的学习曲线。毫无疑问，一旦您学习并理解了该语言，它就成为开发安全，快速，稳定软件的强大工具。但复杂性仍然存在。

V的目标是允许构建可维护且可预测的软件。这就是为什么语言如此简单，甚至可能对某些人来说无聊。好处是，你可以跳进项目的任何部分并了解正在发生的事情，感觉就像是你写的那样，因为语言很简单而且只有一种做事方式。

Rust的编译速度很慢，与C ++相当。V每秒每个CPU编译150万行代码。

### V vs Rust vs Go：例子

由于V的域接近Go和Rust，我决定使用一个简单的例子来比较这三者。

我遇到了一位开发人员[播放](https://github.com/hyperium/hyper/issues/777)与Rust和Go。他们编写了一个简单的并发程序，同时获取了顶级的黑客新闻故事。

在得到两个社区的帮助后，这是他们的最终代码：

**锈**

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

**走**

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

即将推出更多语言...

<!-- @t footer -->
