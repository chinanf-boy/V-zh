# vlang-io/V [![translate-svg]][translate-list]

<!--[![explain]][source]-->

[explain]: http://llever.com/explain.svg
[source]: https://github.com/chinanf-boy/Source-Explain
[translate-svg]: http://llever.com/translate.svg
[translate-list]: https://github.com/chinanf-boy/chinese-translate-list
[size-img]: https://packagephobia.now.sh/badge?p=Name
[size]: https://packagephobia.now.sh/result?p=Name

「 V 编程语言 （未发布，但从数据看，值得了解一下） 」

[中文](./readme.md) | [english](https://github.com/vlang-io/V)

---

## 校对 ✅

<!-- doc-templite START generated -->
<!-- repo = 'vlang-io/V' -->
<!-- commit = '17fd9ae173543c315a24fa88d41706d9af75fd5b' -->
<!-- time = '2019-03-17' -->

| 翻译的原文 | 与日期        | 最新更新 | 更多                       |
| ---------- | ------------- | -------- | -------------------------- |
| [commit]   | ⏰ 2019-03-17 | ![last]  | [中文翻译][translate-list] |

[last]: https://img.shields.io/github/last-commit/vlang-io/V.svg
[commit]: https://github.com/vlang-io/V/tree/17fd9ae173543c315a24fa88d41706d9af75fd5b

<!-- doc-templite END generated -->

- [x] readme
- [x] [概略：一睹为快](mds/index.zh.md)
- [x] [文档](mds/docs.zh.md)
- [x] [对比](mds/compare.zh.md)
- [x] [速度基准](mds/compilation_speed.zh.md)

### 贡献

欢迎 👏 勘误/校对/更新贡献 😊 [具体贡献请看](https://github.com/chinanf-boy/chinese-translate-list#贡献)

## 生活

[help me live , live need money 💰](https://github.com/chinanf-boy/live-need-money)

---

# V 编程语言

V 将于 2019 年 6 月开源。4 月 15 日 提供早期访问。

<https://vlang.io>

文档：<https://vlang.io/docs>

推特：<https://twitter.com/vlang_io>

## 快速编译

V 每个 CPU 核心每秒编译 150 万行代码

```bash
cd doom3/
wc -l doom3.v     # 458 713
time v doom3.v    # 0.5s
```

[和其他语言的，编译速度基准的比较](/compilation_speed.zh.md)。

## 安全

- 没有全局变量
- 没有 null
- 没有未定义的值
- [选项类型](/mds/docs.zh.md#option)
- [泛型](/mds/docs.zh.md#generics)
- 默认不变性
- 部分纯粹的功能

## C/C ++ 转译

V 可以转译整个 C / C ++项目，为您提供安全性，简单性，还有高达 200 倍提升的编译速度。

```
std::vector<std::string> s;      s := []string
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

你可以通过浏览[文档](/mds/docs.zh.md)来学习整个语言，半小时内搞定。

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
