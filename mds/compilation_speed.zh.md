<!-- @t header h2 { border-top: 1px solid #dfdfdf; padding-top: 10px; } comment { font-family: 'Roboto Mono'; color: #777; } -->

# V 编程语言

为开发[volt](https://volt.ws)，创建快速，安全，编译的语言，很快，所有人都能用啦。

2019 年中期，发布开源。

在 0.5 秒内，从源安装 V.

```bash
wget vlang.io/v.c && gcc -o v v.c
```

## 编译速度基准

| lang  | cmd                      | time   |
| ----- | ------------------------ | ------ |
| C     | `gcc test.c`             | 5.2s   |
| C++   | `g++ test.cpp`           | 1m 25s |
| Zig   | `zig build-exe test.zig` | 10.1s  |
| Nim   | `nim c test.nim`         | 45s    |
| Rust  | `rustc test.rs`          | > 30m  |
| Swift | `swiftc test.swift`      | > 30m  |
| V     | `v test.v`               | 0.6s   |

我开发了一个小程序，用几种语言生成 40 万行代码，来测试它们的编译速度。

您可以阅读该小程序的代码，在[这里](https://github.com/vlang-io/V/blob/master/website/compilation_speed_test_gen.v)。

这有点傻，它所做的只是产生，以下声明语句 20 万次：

```v
a = 1
println(a)

a = 2
println(a)
...
```

我知道这段代码绝不代表真正的代码，但它可以给出一般情况，所有编译器都面临同样的挑战。如果您对如何生成基准测试代码有更好的了解，请告诉我，我会更新它。

Rust 和 Swift 花了太长时间来编译 400k 行代码，所以我尝试了较小的数字，并且惊讶地发现编译速度不是线性的：

| #lines | Rust   | Swift  | D        |
| ------ | ------ | ------ | -------- |
| 2k     | 3.4s   | 0.8s   |
| 4k     | 9.0s   | 1.0s   |
| 8k     | 30.8s  | 2.3s   |
| 20k    | 3m 52s | 11.8s  | 4.7s     |
| 100k   | \-     | 5m 57s | segfault |

<!-- @t footer -->
