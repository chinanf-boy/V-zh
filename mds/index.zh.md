<!-- @t header function isMob() { return typeof( window.orientation ) !== "undefined" || navigator.userAgent.indexOf('IEMobile') !== -1; } function isMac() { return false; return window.navigator.platform.toLowerCase().indexOf('mac') > -1 ; } document.addEventListener("DOMContentLoaded", function(event) { if (isMac()) { document.getElementById('macos').style.display = 'block'; } }) function soon() { alert('Coming in early March') return false } -->

[![](img/github.png)GitHub回购](https://github.com/vlang-io/V) [![](img/slack.png)讨论Slack](https://join.slack.com/t/vlang-io/shared_invite/enQtNTQ4NDk4OTE1NTM2LWQ4YmU2YjgzYWIxMzg5NzVjY2RiNGZiNTY2YmU2MjE4MGM1NzhhZTY4MmNkYTRhYmUxY2Q4OTM0OTdiOTY5Yzc) [![](img/twitter.png)@vlang_io](https://twitter.com/vlang_io) [![](img/reddit.png)/ R / vlang](https://old.reddit.com/r/vlang) [![](img/gmail.png)V邮件列表](https://groups.google.com/forum/#!forum/vlang)

[![](/img/patreon.png)](https://www.patreon.com/vlang) [通过PayPal捐款](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=HRGVJ2LA2LKJ8&item_name=Support+V+development&currency_code=USD&source=url&lc=US)

[例子](https://github.com/vlang-io/V/tree/master/examples) [文档](/docs) [操场](/play) [博客](/blog) [常问问题](/#faq) [软件内置V](/#software)

# V编程语言

为开发创建快速，安全，编译的语言[伏特](https://volt.ws)，很快就可供所有人使用。

2019年中期开源发布。

## 安装（官方未发布，但源码中有）

在0.5秒内从源安装V.

```bash
wget vlang.io/v.c && gcc -o v v.c
```

## 尝试

```go
fn main() {
	types := \[ 'game', 'web', 'tools', 'GUI' \]
	for typ in types {
		println('Hello, $typ developers!')
	}
}
```

## 快速编译

V每个CPU核心每秒编译150万行代码

```
cd doom3/
wc -l doom3.v # 458 713
time v doom3.v # 0.5s
```

[编译速度基准和与其他语言的比较](/compilation_speed)。

## 安全

-   没有全局变量
-   没有
-   没有未定义的值
-   [选项类型](/docs#option)
-   [泛型](/docs#generics)
-   默认不变性
-   部分纯粹的功能

## C / C ++翻译

V可以翻译整个C / C ++项目，为您提供安全性，简单性和高达200倍的编译速度。

```
std::vector<std::string> s;      s := \[\]string
s.push_back("V is "); 			 s << 'V is '
s.push_back("awesome");			 s << 'awesome'
std::cout << s.size();			 println(s.len)
```

阅读有关翻译Doom＆Doom 3，LevelDB，SQLite（即将于3月发布）的内容。

## 400 KB编译器，具有零依赖性

整个V语言及其标准库小于400 KB。你可以在0.3秒内构建V.

为了比较：

|  | 需要空间 | 建立时间 |
| --- | ---- | ---- |
|  |  |  |
| 走 | 525 MB | 1分33秒 |
| 锈 | 30 GB | 45米 |
| gcc | 8 GB | 50公尺 |
| 铛 | 15-20 GB | 25米 |
| 迅速 | 70 GB[\*](https://github.com/apple/swift#getting-started) | 90米 |
| V | 0.4 MB | 0.3秒 |

## 性能

-   和C一样快
-   分配数量最少

-   内置序列化，无需反射

## 热门代码重装

无需重新编译即可立即获取更改！

由于您在每次编译后也不必浪费时间进入您正在处理的状态，因此可以节省大量宝贵的开发时间。

[演示热代码重新加载。](https://volt.ws/img/lang.webm)

## 用于构建可维护程序的简单语言

你可以通过浏览来学习整个语言[文件](/docs)在半小时内。

尽管很简单，但它为开发人员提供了很多动力。你可以用其他语言做任何事情，你可以用V做。

## REPL

v

> > data：= http.get（'[https://vlang.io/utc\_现在'](https://vlang.io/utc\_now')）？数据'1551205308'

## 本机跨平台UI库

构建原生的原生应用程序。您不再需要嵌入浏览器来快速开发跨平台应用程序。

## 到处跑

V可以编译为（人类可读）C，因此您可以获得gcc和Clang的优秀平台支持和优化。

# 常问问题

**为什么在已经有这么多语言的情况下创建V？为什么不使用Go，Rust，C ++，Python等？**

[V和其他语言的详细比较。](/compare)

**V写的是什么语言？**

V.编译器可以自行编译。原始版本是用Go编写的。V使用LLVM吗？

**No.V直接编译为机器代码。**

这是它如此轻盈和快速的主要原因之一。目前仅支持x64架构。

V还可以发出人类可读的C，然后可以编译为在任何平台上运行。

**那么优化呢？**

目前，V发出c并使用gcc/clang来优化生产构建。这样您就可以访问复杂的优化。

这样的编译编译速度比V开发版本慢150倍（但仍比C++构建快）。

对于开发过程中需要优化的行业（例如AAA游戏），这可能是一个问题。在这种情况下，可以使用热代码重新加载，不需要重新编译。

将来V将拥有自己的优化器。

**有垃圾收集吗？**

不。V的内存管理类似于生锈，但更容易使用。有关它的更多信息将在不久的将来发布。

**会有一个包经理吗？**

对！V是一种非常模块化的语言，它鼓励创建易于重用的模块。将有一个中央包管理器，安装模块将非常简单

v安装sqlite

# 软件内置v

## V语言

V本身是用V写的。

## [伏特](https://volt.ws)

本机桌面客户端，用于Slack、Skype、Matrix、Telegram、Twitch等多种服务。

## 菲利

带Miller列的跨平台文件管理器，内置与主要云平台的选择性同步。

## [维生素D](https://github.com/medvednikov/vid)

开源200kb编辑器，性能卓越。

## C/C++到V转换器

该工具支持最新的著名的复杂C++标准，并允许全自动转换为人类可读代码。

## 输入用户界面

使用本机API的跨平台小部件工具包。

你是用v来构建你的产品还是库？[把它加到这个名单上](mailto:alex@medvednikov.com).

<!-- @t footer -->
