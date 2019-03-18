<!-- @t header h2 { border-top: 1px solid #dfdfdf; padding-top: 10px; } comment { font-family: 'Roboto Mono'; color: #777; } -->

[Examples](https://github.com/vlang-io/V/tree/master/examples) [Documentation](/docs) [Playground](/play) [Blog](/blog) [FAQ](/#faq) [Software built in V](/#software)

# V programming language

Fast, safe, compiled language created for developing [Volt](https://volt.ws), soon available for everyone.

Open source release in mid 2019.

Install V from source in 0.5 seconds

wget vlang.io/v.c && gcc -o v v.c

## Compilation speed benchmark

| lang  | cmd                      | time                     |
| ----- | ------------------------ | ------------------------ |
| C     | `gcc test.c`             | 5.2s                     |
| C++   | `g++ test.cpp`           | 1m 25s                   |
| Zig   | `zig build-exe test.zig` | 10.1s                    |
| Nim   | `nim c test.nim`         | 45s                      |
| Rust  | `rustc test.rs`          | Stopped after 30 minutes |
| Swift | `swiftc test.swift`      | Stopped after 30 minutes |
| V     | `v test.v`               | 0.6s                     |

I developed a small program that generates 400 000 lines of code in several languages to benchmark their compilation speed.

You can read the code of the generator [here](https://github.com/vlang-io/V/blob/master/website/compilation_speed_test_gen.v).

It's a bit silly, all it does is generate the following statement 200 000 times:

```v
a = 1
println(a)

a = 2
println(a)
...
```

I'm aware that in no way does this code represent real code, but it can give a general picture, and all compilers face the same challenge. If you have a better idea how to generate code for benchmarking, please let me know, I'll update it.

Rust and Swift took too long to compile 400k lines, so I tried smaller numbers, and was surprised to find out that compilation speed is not linear:

| #lines | Rust   | Swift  | D        |
| ------- | ------ | ------ | -------- |
| 2k      | 3.4s   | 0.8s   |
| 4k      | 9.0s   | 1.0s   |
| 8k      | 30.8s  | 2.3s   |
| 20k     | 3m 52s | 11.8s  | 4.7s     |
| 100k    | \-     | 5m 57s | segfault |

<!-- @t footer -->
