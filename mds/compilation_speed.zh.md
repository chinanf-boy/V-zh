<!-- @t header h2 { border-top: 1px solid #dfdfdf; padding-top: 10px; } comment { font-family: 'Roboto Mono'; color: #777; } -->

[例子](https://github.com/vlang-io/V/tree/master/examples) [文档](/docs) [操场](/play) [博客](/blog) [常问问题](/#faq) [软件内置V](/#software)

# V编程语言

为开发创建快速，安全，编译的语言[伏特](https://volt.ws)，很快就可供所有人使用。

2019年中期开源发布。

在0.5秒内从源安装V.

wget vlang.io/v.c&& gcc -o v v.c

## 编译速度基准

| 郎 | cmd | 时间 |
| --- | --- | --- |
| C | `gcc test.c` | 5.2s |
| C ++ | `g++ test.cpp` | 1分25秒 |
| 齐格 | `zig build-exe test.zig` | 10.1s |
| 稔 | `nim c test.nim` | 45s |
| 锈 | `rustc test.rs` | 30分钟后停止 |
| 迅速 | `swiftc test.swift` | 30分钟后停止 |
| V | `v test.v` | 0.6秒 |

我开发了一个小程序，用几种语言生成40万行代码来测试它们的编译速度。

您可以阅读生成器的代码[这里](https://github.com/vlang-io/V/blob/master/website/compilation_speed_test_gen.v)。

这有点傻，它所做的只是产生以下声明20万次：

```v
a = 1
println(a)

a = 2
println(a)
...
```

我知道这段代码绝不代表真正的代码，但它可以给出一般情况，所有编译器都面临同样的挑战。如果您对如何生成基准测试代码有更好的了解，请告诉我，我会更新它。

Rust和Swift花了太长时间来编译400k行，所以我尝试了较小的数字，并且惊讶地发现编译速度不是线性的：

| #lines | 锈 | 迅速 | D |
| ------ | --- | --- | --- |
| 2k | 3.4s | 0.8s |  |
| 4k | 9.0s | 1.0秒 |  |
| 8k | 30.8s | 达到2.3s |  |
| 20k | 3分52秒 | 11.8s | 4.7s |
| 100k | - | 5米57秒 | 段错误 |

<!-- @t footer -->
