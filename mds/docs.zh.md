<!-- @t header h2 { border-top: 1px solid #dfdfdf; padding-top: 10px; } comment { font-family: 'Roboto Mono'; color: #777; } code { font-family: 'Roboto Mono'; background-color: #fafafa; padding: 1px 3px 1px 3px; } -->

# V 编程语言

为开发[vlot](https://volt.ws)，创建快速，安全，编译的语言，很快与大家见面。

2019 年中期，发布开源。

在 0.5 秒内，从源安装 V.

```
wget vlang.io/v.c && gcc -o v v.c
```

## 语法目录

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [介绍](#%E4%BB%8B%E7%BB%8D)
- [你好，世界](#%E4%BD%A0%E5%A5%BD%E4%B8%96%E7%95%8C)
- [注释](#%E6%B3%A8%E9%87%8A)
- [函数](#%E5%87%BD%E6%95%B0)
- [变量](#%E5%8F%98%E9%87%8F)
- [基本类型](#%E5%9F%BA%E6%9C%AC%E7%B1%BB%E5%9E%8B)
- [常量](#%E5%B8%B8%E9%87%8F)
- [字符串(Strings)](#%E5%AD%97%E7%AC%A6%E4%B8%B2strings)
- [数组](#%E6%95%B0%E7%BB%84)
- [if](#if)
- [for 循环](#for-%E5%BE%AA%E7%8E%AF)
- [Switch](#switch)
- [结构(Structs)](#%E7%BB%93%E6%9E%84structs)
- [方法(Methods)](#%E6%96%B9%E6%B3%95methods)
- [可变接收器](#%E5%8F%AF%E5%8F%98%E6%8E%A5%E6%94%B6%E5%99%A8)
- [接口(Interfaces)](#%E6%8E%A5%E5%8F%A3interfaces)
- [Option 类型](#option-%E7%B1%BB%E5%9E%8B)
- [泛型](#%E6%B3%9B%E5%9E%8B)
- [解码 JSON](#%E8%A7%A3%E7%A0%81-json)
- [将 C/C++ 转译成 V.](#%E5%B0%86-cc-%E8%BD%AC%E8%AF%91%E6%88%90-v)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 介绍

V 是一种静态类型的编译编程语言，用于构建可维护的软件。

它与 Go 非常相似，也受到 Oberon，Rust，Swift 的影响。

V 是一种非常简单的语言。这个文档，会花费你大约半个小时，到最后，你就学习了几乎整个语言。

尽管很简单，但它为开发人员提供了很多动力。你用其他语言做的任何事情，你都可以用 V 做。

发现错误/拼写错误？请[提交拉取请求](https://github.com/vlang-io/V/blob/master/website/templates/docs.html)。

## 你好，世界

```go
fn main() {
	println('hello world')
}
```

声明函数用`fn`。返回类型，在函数名称后面。在这种情况下，`main`不返回任何内容，因此省略了类型。

就像在 C 和所有相关语言中一样，`main`是一个切入点。

`println`是为数不多的内置函数之一。它将‘值’，打印到标准输出。

## 注释

```go
// 单行 注释

/* 多行 注释.
   /* 可以嵌套 */
*/
```

## 函数

```go
fn add(x int, y int) int {
	return x + y
}

fn sub(x, y int) int {
	return x - y
}

fn main() {
	println(add(77, 33))
	println(sub(100, 50))
}
```

同样，类型，在参数名称之后出现。

## 变量

```go
fn main() {
	name := 'Bob'
	age := 20
	large_number := i64(0)
	println(name)
	println(age)
}
```

变量声明和初始化变量，用`:=`。这是在 V 中声明变量的唯一方法。这意味着，变量始终具有初始值。

变量的类型是从右侧的值推断出来的。要强制使用其他类型，请使用类型转换：`T(v)`表达式会转换，`v`值到类型`T`。

与大多数其他语言不同，V 只允许在函数中，定义变量。不允许使用全局（模块级别）变量。V 中没有全局状态。要更改变量的值，请使用：

```go
fn main() {
	mut age := 20
	println(age)
	age = 21
	println(age)
}
```

用`=`，改变变量的值。在 V 中，默认情况下变量是不可变的。为了能够更改变量的值，您必须使用`mut`来声明该变量。

请注意`:=`和`=`两者之间的区别：
`:=`用于声明和初始化，`=`用于分配(值)。

```go
fn main() {
	age = 21
}
```

这段代码不会编译，因为变量`age`没有用`:=`声明。所有变量都需要在 V 中声明。

## 基本类型

```go
bool

string

i8  i16  i32  i64
u8  u16  u32  u64

byte //  u8 的别名
int  //  i32 的别名
rune //  i32 的别名, 表示一个 Unicode 代码点

f32 f64
```

请注意，与 C 和 Go 不同，`int`始终是 32 位整数。

## 常量

```go
const PI = 3.14

fn main() {
	println(PI)
	const WORLD = '世界'
	println(WORLD)
}
```

常量用一个`const`关键词声明。它们可以在模块级别（函数之外）定义。

常量名称必须大写。这有助于，将它们与变量区分开来

永远不能改变常量值。

## 字符串(Strings)

```go
fn main() {
	name := 'Bob'
	// 在字符串中，插入变量，以显示其值
	println('Hello, $name!')

	println(name.len)
        bobby := name + 'by' // + 用于连接字符串
        println(bobby) // ==> Bobby

        println(bobby.substr(1, 3)) // ==> ob
        // println(bobby[1:3]) // 更喜欢，这种语法写法，代替substr()方法
}
```

在 V 中，字符串是只读的字节数组。字符串数据使用 UTF-8 编码。

字符串内容是不可变的。这意味着，子字符串函数非常有效：不执行复制，不需要额外的分配。

## 数组

```go
fn main() {
	nums := [1, 2, 3]
	println(nums)
	println(nums[1]) // ==> "2"

	mut names := ['John']
	names << 'Peter'
	names << 'Sam'
	// names << 10  <-- 这不会编译. `names` 是一个字符串数组
	println(names.len) // ==> "3"
	println(names.contains('Alex')) // ==> "false"

	// 我们还可以预先分配一定数量的元素。
	nr_ids := 50
	mut ids := [0 ; nr_ids] // 这将创建一个包含50个零的数组
	for i := 0; i < nr_ids; i++ {
		ids[i] = i // 这比 ids << i ，效率更高
		           //
	}
}
```

数组类型由第一个元素决定：

- `[1, 2, 3]`是一个整数数组（`[]int`。
- `['a', 'b']`是一个字符串数组（`[]string`）。

数组中的所有元素必须具有相同的类型。`[1, 'a']`不会编译。

`<<`是一个将值附加到数组末尾的**运算符**。

`.len`字段，返回数组的长度。请注意，它是一个只读字段，用户无法修改。默认情况下，所有导出的字段，都是只读的。

`.contains(val)`方法为，若数组包含该 `val`，则 method 返回 true。

## if

```go
fn main() {
	a := 10
	b := 20
	if a < b {
		println('$a < $b')
	} else if a > b {
		println('$a > $b')
	} else {
		println('$a == $b')
	}
}
```

`if`语句非常简单，与大多数其他语言类似。

与其他类 C 语言不同，条件语句周围没有括号`(if ..)`，并且始终需要大括号。

## for 循环

V 只有一个循环结构：`for`。

```go
fn main() {
	numbers := [1, 2, 3, 4, 5]
	for num in numbers {
		println(num)
	}
	names := ['Sam', 'Peter']
	for i, name in names {
		println('$i) $name')  // 输出: 0) Sam
	}                         //      1) Peter
}
```

该`for .. in`循环，用于遍历数组的元素。如果需要索引，则可用另一种形式`for index, value in`。

```go
fn main() {
	mut sum := 0
	mut i := 0
	for i < 100 {
		sum += i
		i++
	}
	println(sum)
}
```

这种形式的循环类似于，其他语言的`while`循环。

一旦 bool 条件求值为 false，循环将停止迭代。

同样，条件语句周围没有括号，并且总是需要括号。

```go
fn main() {
	mut sum := 0
	for {
		sum++
	}
	println('This will never be printed')
}
```

条件语句可以省略，这会导致无限循环。

```go
fn main() {
	for i := 0; i < 10; i++ {
		println(i)
	}
}
```

最后，还有传统 C 风格的`for`循环。它比`while`形式更安全，因为后者很容易忘记，更新计数器并陷入无限循环。

## Switch

```go
import os

fn main() {
	print('V runs on ')
	switch os.OS_NAME {
	case 'darwin':
		println('macOS.')
	case 'linux':
		println('Linux.')
	default:
		println(os.OS_NAME)
	}
}
```

switch 语句是编写一连串`if - else`声明语句的较短方式。它运行第一种情况，其值等于条件表达式。

与 C 不同，每个块末尾都不需要`break`声明。

## 结构(Structs)

```go
struct Point {
	x int
	y int
}

fn main() {
	p := Point{10, 20}
	println(p.x) // 使用 .(点) 就可以访问结构字段
	p2 := Point{ // 也可以用这种语法写法，设置字段
		x: 20
		y: 30
	}
	// 具有 & 前缀 ，会返回该结构值的指针
	// 在 堆 中分配内存 和 在它(们)没跑路前，被 V 在函数结尾，自动清除。
	pointer := &Point{10,10}
	println(pointer.x, pointer.y) // 指针，具有访问字段的同语法写法
}
```

## 方法(Methods)

```go
import math

struct Point {
	x int
	y int
}

fn (a Point) distance_to(b Point) f64 {
	return math.sqrt((a.x-b.x)**2 + (a.y-b.y)**2)
}

fn main () {
	p := Point{10,10}
	p2 := Point{20,20}
	println(p.distance_to(p2))
}
```

V 没有类。但您可以在类型上，定义方法。

方法是具有一个特定接收参数的函数。

接收参数出现在它自己的参数列表中，位于`fn`关键字和方法名称之间。

在这个例子中，`distance_to`方法有一个类型`Point`的接收参数，其命名`a`。

## 可变接收器

TODO

## 接口(Interfaces)

```go
struct Dog {}
struct Cat {}

fn (d Dog) speak() string { return 'woof' }
fn (c Cat) speak() string { return 'meow' }

interface Speaker {
	speak() string
}

fn perform(s Speaker) { println(s.speak()) }

fn main() {
	dog := Dog{}
	cat := Cat{}
	perform(dog) // ==> "woof"
	perform(cat) // ==> "meow"
}
```

类型通过实现其方法，来实现接口。没有明确的意图声明，没有“implements”关键字。

V 接口非常有效。没有动态调度。

## Option 类型

```go
struct User {
	id int
}

struct Repo {
	users []User
}

fn (r Repo) find_user_by_id(id int) User? {
	for user in r.users {
		if user.id == id {
			// V 自动把它包进一个 option 类型
			return user
		}
	}
	return error('User $id not found')
}

fn main() {
	repo := // ... 在这里，初始化一个存储库 here
	// 和加载到用户数据，获取用户或者处理一个错误，再离开当前作用域
	user := repo.find_user_by_id(10) or {
		eprintln(err)
		return
	}
	println(user.id) // 10
	user = repo.find_user_by_id(11)? // ? 传播一个错误
	println(user.id) // 11
}
```

另请注意，将函数“升级”为可选(option)函数所需的工作量很小，就是：您必须添加一个`?`返回类型，并在出现错误时，返回错误。

## 泛型

```go
import database

struct Repo <T> {
	db DB
}

// 众所周知，泛型代码很冗长。 为了减少混乱, V 不要求你每次都
// 添加 `<T>`, 因为它已经知道这个Repo 是个泛型类型
// 这里的函数，会返回一个不明确的 Repo实例
fn new_repo<T>(db DB) Repo {
	return Repo<T>{db: db}
}

// 这里是一个泛型方法. V 会为每个Repo实例所用到的，生成代码。
// 再次说明， <T> 是隐性的，因Repo作为了该函数的接收参数, 所以
//  V 也让该方法知道 <T>:
// fn (r Repo<T>) find_by_id<T>(id int) T?
fn (r Repo) find_by_id(id int) T? {
	table_name := T.name // 在这里示例中，我们获取 T 的name，
	// 赋给 table_name ，从数据库(db)找寻一个类型 T 的值, 或
	// 返回一个错误
	return r.db.query_one<T>('select * from $table_name where id = ?', id)
}

struct User { name string }
struct Post { text string }

fn main() {
	db := new_db()
	users_repo := new_repo<User>(db)
	posts_repo := new_repo<Post>(db)
	// find_by_id的泛型 从 users_repo 推断而来:
	user := users_repo.find_by_id(1)?
	// find_by_id的泛型 从 posts_repo 推断而来:
	post := posts_repo.find_by_id(1)?
	println(user.name)
	println(post.text)
}
```

## 解码 JSON

```go
struct User {
	name string
	age  int
}

fn main() {
	const input = '{ "name": "Frodo", "age": 25 }'
	user := json.decode(User, input) or {
		eprintln('Failed to decode json')
		return
	}
	println(user.name)
	println(user.age)
}
```

JSON 现在非常流行，这就是 JSON 内置支持的原因。

`json.decode`函数的第一个参数，是要解码的类型(结构)。第二个参数是 json 字符串。

V 生成用于 json 编码和解码的代码。没有使用反射(reflection)。这导致更好的性能。

## 将 C/C++ 转译成 V.

V 可以将您的 C/C++ 代码，转换为人类可读的 V 代码。让我们先创建一个简单的程序`test.cpp`：

```c
#include <vector>
#include <string>
#include <iostream>

int main() {
        std::vector<std::string> s;
        s.push_back("V is ");
        s.push_back("awesome");
        std::cout << s.size() << std::endl;
        return 0;
}
```

运行`v translate test.cpp`，那么 V 将生成`test.v`：

```go
fn main {
        mut s := []string
	s << 'V is '
	s << 'awesome'
	println(s.len)
}
```

<!-- @t footer -->
