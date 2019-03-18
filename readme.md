# vlang-io/V [![explain]][source] [![translate-svg]][translate-list]

<!-- [![size-img]][size] -->

[explain]: http://llever.com/explain.svg
[source]: https://github.com/chinanf-boy/Source-Explain
[translate-svg]: http://llever.com/translate.svg
[translate-list]: https://github.com/chinanf-boy/chinese-translate-list
[size-img]: https://packagephobia.now.sh/badge?p=Name
[size]: https://packagephobia.now.sh/result?p=Name

「 V 编程语言 」

[中文](./readme.md) | [english](https://github.com/vlang-io/V)

---

## 校对 🀄️

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

- [ ] [\_layout.md](mds/_layout.md)
- [ ] [compare.md](mds/compare.md)
- [ ] [compilation_speed.md](mds/compilation_speed.md)
- [ ] [docs.md](mds/docs.md)
- [ ] [index.md](mds/index.md)

### 贡献

欢迎 👏 勘误/校对/更新贡献 😊 [具体贡献请看](https://github.com/chinanf-boy/chinese-translate-list#贡献)

## 生活

[help me live , live need money 💰](https://github.com/chinanf-boy/live-need-money)

---

# V 编程语言

V 将于 2019 年 6 月开源。5 月 1 日 提供早期访问。

<https://vlang.io>

文档：<https://vlang.io/docs>

推特：<https://twitter.com/vlang_io>

## 快速编译

V 每个 CPU 核心每秒编译 150 万行代码

```
cd doom3/
wc -l doom3.v     # 458 713
time v doom3.v    # 0.5s
```

[Compilation speed benchmark and comparison with other languages.](https://vlang.io/compilation_speed)

## 安全

- 没有全球状态
- 没有
- 没有未定义的值
- 选项类型
- 泛型
- 默认不变性
- 部分纯粹的功能

## C / C ++翻译

V 可以翻译整个 C / C ++项目，为您提供安全性，简单性和高达 200 倍的编译速度。

```
std::vector<std::string> s;
s.push_back("V is ");
s.push_back("awesome");
std::cout << s.size();
```

```
s := []string
s << 'V is '
s << 'awesome'
println(s.len)
```

阅读有关翻译 Doom＆Doom 3，LevelDB，SQLite（即将于 3 月发布）的内容。

## 400 KB 编译器，具有零依赖性

整个 V 语言及其标准库小于 400 KB。你可以在 0.3 秒内构建 V.

## 性能

- 和 C 一样快
- 分配数量最少
- 内置序列化，无需反射

## 热门代码重装

无需重新编译即可立即获取更改！

由于您在每次编译后也不必浪费时间进入您正在处理的状态，因此可以节省大量宝贵的开发时间。

[Demonstration of hot code reloading.](https://volt-app.com/img/lang.webm)

## 用于构建可维护程序的简单语言

您可以在半小时内阅读文档来学习整个语言。

尽管很简单，但它为开发人员提供了很多动力。你可以用其他语言做任何事情，你可以用 V 做。

## REPL

```
 v
 >> data := http.get('https://vlang.io/utc_now')?
 >> data
 '1551205308'
```

## 本机跨平台 UI 库

构建原生的原生应用程序。您不再需要嵌入浏览器来快速开发跨平台应用程序。

## 到处跑

V 可以编译为（人类可读）C，因此您可以获得 gcc 和 Clang 的优秀平台支持和优化。
