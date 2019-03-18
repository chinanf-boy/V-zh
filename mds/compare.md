@t header h2 { border-top: 1px solid #dfdfdf; padding-top: 10px; } pre { font-size:80%; } comment { font-family: 'Roboto Mono'; color: #777; }

[Examples](https://github.com/vlang-io/V/tree/master/examples) [Documentation](/docs) [Playground](/play) [Blog](/blog) [FAQ](/#faq) [Software built in V](/#software)

# V programming language

Fast, safe, compiled language created for developing [Volt](https://volt.ws), soon available for everyone.  
  
Open source release in mid 2019.

Install V from source in 0.5 seconds

wget vlang.io/v.c && gcc -o v v.c

## Comparison of V and other languages

### Go

V is very similar to Go, and these are the things it improves upon:

\- No global state  

\- Only one declaration style (`a := 0`)

\- No null

\- No undefined values

\- No `err != nil` checks (replaced by option types)

\- Immutability by default

\- Much stricter vfmt

\- No runtime

\- Much smaller binaries

\- Zero cost C interop

\- No GC

\- Fearless concurrency (no data race guarantee at compilation)

\- Generics

\- Cheaper interfaces without dynamic dispatch

  

### Rust

Rust has a very different philosophy.

It is a complex language with a growing set of features and a steep learning curve. No doubt, once you learn and understand the language, it becomes a very powerful tool for developing safe, fast, and stable software. But the complexity is still there.

V's goal is to allow building maintainable and predictable software. That's why the language is so simple and maybe even boring for some. The good thing is, you can jump into any part of the project and understand what's going on, feel like it was you who wrote it, because the language is simple and there's only one way of doing things.

Rust's compilation speed is slow, on par with C++. V compiles 1.5 million lines of code per cpu per second.

  

### V vs Rust vs Go: example

Since V's domain is close to both Go and Rust, I decided to use a simple example to compare the three.

I came across a developer [playing](https://github.com/hyperium/hyper/issues/777) with Rust and Go. They wrote a simple concurrent program that fetches top Hacker News stories concurrently.

After getting help from both communities, this is their final code:

**Rust**

extern crate hyper;
extern crate rustc\_serialize;

use std::thread;
use std::io::Read;
use std::ops::DerefMut;
use std::sync::Mutex;
use std::sync::MutexGuard;
use std::sync::LockResult;
use std::sync::Arc;

use hyper::Client;
use hyper::header::Connection;
use rustc\_serialize::json;

#\[derive(RustcDecodable, RustcEncodable)\]
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
    let mut temp = guard.deref\_mut();
    \*temp = \*temp+1;
    return \*temp;
}

fn main() {
    let client = Arc::new(Client::new());
    let url = "https://hacker-news.firebaseio.com/v0/topstories.json";
    let mut res = client.get(url).header(Connection::close()).send().unwrap();
    let mut body = String::new();
    res.read\_to\_string(&mut body).unwrap();
    let vec: Vec<i32> = json::decode(body.as\_str()).unwrap();
    let lock: Arc<Mutex<usize>> = Arc::new(Mutex::new(0));

    let mut handles: Vec<thread::JoinHandle<()>> = Vec::new();
    for \_ in 0..8 {
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
                    vec2\[cursor\],
                );

                let mut res = client2.get(url.as\_str())
                    .header(Connection::close())
                    .send()
                    .unwrap();

                let mut body = String::new();
                res.read\_to\_string(&mut body).unwrap();
                let story: Story = json::decode(body.as\_str()).unwrap();
                println!("{}", story.title);
            };
        }));
    }

    for handle in handles.into\_iter() {
        handle.join().unwrap();
    }
}

**Go**

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

	var ids \[\]int
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
					ids\[cursor\],
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

**V**  

import http
import json
import runtime

struct Story {
        title string
}

fn main() {
        resp := http.get('https://hacker-news.firebaseio.com/v0/topstories.json')? 
        ids := json.decode(\[\]int, resp.body)?  // ? propagates the error 
        mut cursor := 0
        for \_ in 0..8 { 
                go fn() {
                        for cursor < ids.len {
                                lock { // Without this lock block the program will not compile
                                        id := ids\[cursor\]
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

  
  
More languages coming soon...

@t footer