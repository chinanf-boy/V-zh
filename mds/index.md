<!-- @t header function isMob() { return typeof( window.orientation ) !== "undefined" || navigator.userAgent.indexOf('IEMobile') !== -1; } function isMac() { return false; return window.navigator.platform.toLowerCase().indexOf('mac') > -1 ; } document.addEventListener("DOMContentLoaded", function(event) { if (isMac()) { document.getElementById('macos').style.display = 'block'; } }) function soon() { alert('Coming in early March') return false } -->

[![](img/github.png)GitHub repo](https://github.com/vlang-io/V) [![](img/slack.png)Discuss on Slack](https://join.slack.com/t/vlang-io/shared_invite/enQtNTQ4NDk4OTE1NTM2LWQ4YmU2YjgzYWIxMzg5NzVjY2RiNGZiNTY2YmU2MjE4MGM1NzhhZTY4MmNkYTRhYmUxY2Q4OTM0OTdiOTY5Yzc) [![](img/twitter.png)@vlang_io](https://twitter.com/vlang_io) [![](img/reddit.png)/r/vlang](https://old.reddit.com/r/vlang) [![](img/gmail.png)V mailing list](https://groups.google.com/forum/#!forum/vlang)

[![](/img/patreon.png)](https://www.patreon.com/vlang) [Donate via PayPal](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=HRGVJ2LA2LKJ8&item_name=Support+V+development&currency_code=USD&source=url&lc=US)

[Examples](https://github.com/vlang-io/V/tree/master/examples) [Documentation](/docs) [Playground](/play) [Blog](/blog) [FAQ](/#faq) [Software built in V](/#software)

# V programming language

Fast, safe, compiled language created for developing [Volt](https://volt.ws), soon available for everyone.

Open source release in mid 2019.

## 安装(官方未发布，但源码中有)

Install V from source in 0.5 seconds

```bash
wget vlang.io/v.c && gcc -o v v.c
```

## try

```go
fn main() {
	types := \[ 'game', 'web', 'tools', 'GUI' \]
	for typ in types {
		println('Hello, $typ developers!')
	}
}
```

## Fast compilation

V compiles 1.5 million lines of code per second per CPU core

```
cd doom3/
wc -l doom3.v # 458 713
time v doom3.v # 0.5s

```

[Compilation speed benchmark and comparison with other languages](/compilation_speed).

## Safety

- No globals
- No null
- No undefined values
- [Option types](/docs#option)
- [Generics](/docs#generics)
- Immutability by default
- Partially pure functions

## C/C++ translation

V can translate your entire C/C++ project and offer you the safety, simplicity, and up to 200x compilation speed up.

```
std::vector<std::string> s;      s := \[\]string
s.push_back("V is "); 			 s << 'V is '
s.push_back("awesome");			 s << 'awesome'
std::cout << s.size();			 println(s.len)
```

Read about translating Doom & Doom 3, LevelDB, SQLite (coming in March).

## 400 KB compiler with zero dependencies

The entire V language and its standard library is less than 400 KB. You can build V in 0.3 seconds.

For comparison:

|       | Space required                                             | Build time |
| ----- | ---------------------------------------------------------- | ---------- |
|       |                                                            |            |
| Go    | 525 MB                                                     | 1m 33s     |
| Rust  | 30 GB                                                      | 45m        |
| gcc   | 8 GB                                                       | 50m        |
| Clang | 15-20 GB                                                   | 25m        |
| Swift | 70 GB [\*](https://github.com/apple/swift#getting-started) | 90m        |
| V     | 0.4 MB                                                     | 0.3s       |

## Performance

- As fast as C
- Minimal amount of allocations

- Built-in serialization without reflection

## Hot code reloading

Get your changes instantly without recompiling!

Since you also don't have to waste time to get to the state you are working on after every compilation, this can save a lot of precious minutes of your development time.

[Demonstration of hot code reloading.](https://volt.ws/img/lang.webm)

## Simple language for building maintainable programs

You can learn the entire language by going through the [documentation](/docs) in half an hour.

Despite being simple, it gives a lot of power to the developer. Anything you can do in other languages, you can do in V.

## REPL

v

> > data := http.get('https://vlang.io/utc\_now')?
> > data
> > '1551205308'

## Native cross platform UI library

Build native apps that look native. You no longer need to embed a browser to develop cross platform apps quickly.

## Run everywhere

V can compile to (human readable) C, so you get the great platform support and optimization of gcc and Clang.

# FAQ

**Why create V when there are already so many languages? Why not use Go, Rust, C++, Python etc?**

[Detailed comparison of V and other languages.](/compare)

**What language is V written in?**

V. The compiler can compile itself. The original version was written in Go.

**Does V use LLVM?**

No. V compiles directly to machine code. It's one of the main reasons it's so light and fast. Right now only x64 architecture is supported.

V can also emit human readable C, which can then be compiled to run on any platform.

**What about optimization?**

For now V emits C and uses GCC/Clang for optimized production builds. This way you get access to sophisticated optimization.

Such builds are compiled ≈150 times slower than V development builds (but are still faster than C++ builds).

This can be a problem for industries where optimization is required during development (for example AAA games). In this case hot code reloading can be used, and no recompilation will be required.

In the future V will have its own optimizer.

**Is there garbage collection?**

No. V's memory management is similar to Rust but much easier to use. More information about it will be posted in the near future.

**Is there going to be a package manager?**

Yes! V is a very modular language and encourages creation of modules that are easy to reuse. There will be a central package manager, and installing modules will be as easy as

v install sqlite

# Software built in V

## V language

V itself is written in V.

## [Volt](https://volt.ws)

Native desktop client for Slack, Skype, Matrix, Telegram, Twitch and many more services.

## Filey

Cross platform file manager with Miller Columns and built-in selective sync with major cloud platforms.

## [Vid](https://github.com/medvednikov/vid)

Open source 200 KB editor with the performance of Sublime Text.

## C/C++ to V translator

This tool supports the latest standard of notoriously complex C++ and allows full automatic conversion to human readable code.

## V ui

Cross platform widget toolkit using native APIs.

Are you using V to build your product or library? [Have it added to this list](mailto:alex@medvednikov.com).

<!-- @t footer -->
