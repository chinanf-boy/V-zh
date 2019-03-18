<!-- @t header function isMob() { return typeof( window.orientation ) !== "undefined" || navigator.userAgent.indexOf('IEMobile') !== -1; } function isMac() { return false; return window.navigator.platform.toLowerCase().indexOf('mac') > -1 ; } document.addEventListener("DOMContentLoaded", function(event) { if (isMac()) { document.getElementById('macos').style.display = 'block'; } }) function soon() { alert('Coming in early March') return false } -->

# V 编程语言

为开发[volt](https://volt.ws)，创建快速，安全，编译的语言，很快，所有人都能用啦。

2019 年中期，发布开源。

### 安装（`2019.3.18`官方未发布，但网页注释中有）

在 0.5 秒内，从源安装 V.

```bash
wget vlang.io/v.c && gcc -o v v.c
```

## 尝试

<details>

<summary>1. hello-world</summary>

```go
fn main() {
	types := \[ 'game', 'web', 'tools', 'GUI' \]
	for typ in types {
		println('Hello, $typ developers!')
	}
}
```

<details>

<summary>2. Concurrent news fetcher</summary>

```go
struct Story {
    title string
}

// Fetches top HN stories in 8 coroutines
fn main() {
    resp := http.get('https://hacker-news.firebaseio.com/v0/topstories.json')?
    ids := json.decode([]int, resp.body)?
    mut cursor := 0
    for _ in 0..8 {
        go fn() {
            for  {
                lock { // Without this lock the program will not compile
                    if cursor >= ids.len {
                        break
                    }
                    id := ids[cursor]
                    cursor++
                }
                resp := http.get('https://hacker-news.firebaseio.com/v0/item/$id.json')?
                story := json.decode(Story, resp.body)?
                println(story.title)
            }
        }()
    }
    runtime.wait() // Waits for all coroutines to finish
}
```

<details>

<summary>3.Simple GUI app</summary>

```go
import ui  // Native cross platform ui toolkit (uses Cocoa, win32, GTK+)

// There are no globals, so we have to use a context struct
struct Context {
    input ui.TextBox // this uses native conrols (NSTextView on macOS, edit HWND on Windows)
    names []string   // let's log the names to demonstrate how arrays work
}

fn main() {
    wnd := ui.new_window(ui.WindowCfg{  // V has no default arguments and overloading.
        width:  600                     // All stdlib functions with many args use Cfg wrappers.
        height: 300
        title:  'hello world'
    })
    ctx := Context{
        input: ui.new_textbox(wnd)
        // we don't need to initialize the names array, it's done automatically
    }
    ctx.input.set_placeholder('Enter your name')
    btn := ui.new_button(wnd, 'Click me', ctx.btn_click)
    for {
        ui.wait_events()
    }
}

fn (ctx mut Context) btn_click() {
    name := ctx.input.text()
    ctx.input.hide()
    println('current list of names: $ctx.names')  // >> current list of names: [ "Bob", "Alex" ]
    ui.alert('Hello, $name!')
    if ctx.names.contains(name) {
        ui.alert('I already greeted you ;)')
    }
    ctx.names << name
}
```

<details>

<summary>4. Generic SQL repository</summary>

```go
struct User { /* ... */ }
struct Post { /* ... */ }
struct DB   { /* ... */ }

struct Repo <T> {
    db DB
}

fn new_repo<T>(db DB) Repo {
    return Repo<T>{db: db}
}

fn (r Repo) find_by_id(id int) T? { // `?` means the function returns an optional
    table_name := T.name // in this example getting the name of the type gives us the table name
    return r.db.query_one<T>('select * from $table_name where id = ?', id)
}

fn main() {
    db := new_db()
    users_repo := new_repo<User>(db)
    posts_repo := new_repo<Post>(db)
    user := users_repo.find_by_id(1) or {
        eprintln('User not found')
        return
    }
    post := posts_repo.find_by_id(1) or {
        eprintln('Post not found')
        return
    }
}
```

</details>

## 快速编译

V 用一个 CPU 核心，能每秒编译 150 万行代码

```
cd doom3/
wc -l doom3.v # 458 713
time v doom3.v # 0.5s
```

[和其他语言的，编译速度基准的比较](/compilation_speed.zh.md)。

## 安全

- 没有全局变量
- 没有 null
- 没有未定义的值
- [选项类型](/docs.zh.md#option)
- [泛型](/docs.zh.md#generics)
- 默认不变性
- 部分纯粹的功能

## C/C ++ 转译

V 可以转译整个 C / C ++项目，为您提供安全性，简单性，还有高达 200 倍提升的编译速度。

```
std::vector<std::string> s;      s := \[\]string
s.push_back("V is "); 			 s << 'V is '
s.push_back("awesome");			 s << 'awesome'
std::cout << s.size();			 println(s.len)
```

阅读有关转译 Doom＆Doom 3，LevelDB，SQLite 的内容。（即将于 3 月发布）

## 400 KB 编译器，具有零依赖性

整个 V 语言及其标准库小于 400 KB。你可以在 0.3 秒内，构建 V。

为了比较：

|       | 需要空间                                                  | 构建时间 |
| ----- | --------------------------------------------------------- | -------- |
|       |                                                           |          |
| Go    | 525 MB                                                    | 1m 33s   |
| Rust  | 30 GB                                                     | 45m      |
| gcc   | 8 GB                                                      | 50m      |
| Clang | 15-20 GB                                                  | 25m      |
| Swift | 70 GB[\*](https://github.com/apple/swift#getting-started) | 90m      |
| V     | 0.4 MB                                                    | 0.3s     |

## 性能

- 和 C 一样快
- 最少的内存分配数量

- 内置序列化，无需反射(reflection)

## 热代码重载

无需重新编译，即可立即获取更改！

由于您在每次编译后，不必浪费时间进入状态，因此可以节省大量宝贵的开发时间。

[演示热代码重新加载。](https://volt.ws/img/lang.webm)

## 用于构建可维护程序的简单语言

你可以通过浏览[文档](/docs.zh.md)来学习整个语言，半小时内搞定。

尽管很简单，但它为开发人员提供了很多动力。你用其他语言做的任何事情，你都可以用 V 做。

## REPL

```bash
>$ v
>  data := http.get('https://vlang.io/utc\_now')?
>  data
>  '1551205308'
```

## 原生跨平台 UI 库

构建原生的原生应用程序。您不再需要嵌入浏览器，来快速开发跨平台应用程序。

## 到处都行

V 可以编译为（人类可读的）C，因此您可以获得 gcc 和 Clang 的优秀平台支持和优化。

# 常问问题

**为什么在已经有这么多语言的情况下，创建 V？为什么不使用 Go，Rust，C ++，Python 等？**

[V 和其他语言的详细比较。](/compare.zh.md)

**V 是用什么语言写成的？**

V。编译器可以自行编译。原始版本是用 Go 编写的。

**V 使用 LLVM 吗？**

No。V 直接编译为机器代码。这是它如此轻盈和快速的主要原因之一。目前仅支持 x64 架构。

V 还可以发出人类可读的 C，然后可以在任何平台上，编译运行。

**那么优化呢？**

目前，V 发出 C ，可使用 gcc/clang 来优化生产构建。这样您就可以访问复杂的优化。

这样构建的编译速度比 V 开发版本慢大约 150 倍（但仍比 C++构建快）。

对于开发过程中，优化为刚需的行业（例如 AAA(3A) 游戏），这可能是一个问题。在这种情况下，可以使用热代码重新加载，不需要重新编译。

将来, V 将拥有自己的优化器。

**有垃圾收集吗？**

不。V 的内存管理类似于 Rust，但更容易使用。有关它的更多信息，将在不久的将来发布。

**会有一个包管理器吗？**

对！V 是一种非常模块化的语言，它鼓励创建易于重用的模块。将有一个中央包管理器，安装模块将非常简单，就像这样:

```
v install sqlite
```

# v 的内置软件

## V 语言

V 本身是用 V 写的。

## [Volt](https://volt.ws)

原生桌面客户端，为 Slack、Skype、Matrix、Telegram、Twitch 等多种服务。

## Filey

带 Miller Columns 的跨平台文件管理器，内置有，与主流云平台的选择性同步。

## [Vid](https://github.com/medvednikov/vid)

200kb 的开源编辑器，具备 Sublime Text 性能的卓越。

## C/C++到 V 转译器

该工具支持最新的，是人都觉得复杂的， C++标准，并允许全自动转译为人类可读代码。

## V ui

使用原生 API 的跨平台小部件工具包。

你是用 v 来构建你的产品还是库？[把它加到这个名单上](mailto:alex@medvednikov.com)。

<!-- @t footer -->
