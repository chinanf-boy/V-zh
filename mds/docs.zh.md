<!-- @t header h2 { border-top: 1px solid #dfdfdf; padding-top: 10px; } comment { font-family: 'Roboto Mono'; color: #777; } code { font-family: 'Roboto Mono'; background-color: #fafafa; padding: 1px 3px 1px 3px; } -->

[例子](https://github.com/vlang-io/V/tree/master/examples) [文档](/docs) [操场](/play) [博客](/blog) [常问问题](/#faq) [软件内置V](/#software)

# V编程语言

为开发创建快速，安全，编译的语言[伏特](https://volt.ws)，很快就可供所有人使用。

2019年中期开源发布。

在0.5秒内从源安装V.

```
wget vlang.io/v.c && gcc -o v v.c
```

[介绍](#introduction) [你好，世界](#hello) [评论](#comments) [功能](#fns) [变量](#vars) [基本类型](#btypes) [常量](#consts) [字符串](#strings) [数组](#arrays) [如果声明](#if) [对于循环](#for) [开关](#switch) [结构](#structs) [方法](#methods) [可变接收器](#recvs) [接口](#interfaces) [选项类型](#option) [泛型](#generics) [解码JSON](#json)\
[将C / C ++翻译成V.](#cpp)

## 介绍

V是一种静态类型的编译编程语言，用于构建可维护的软件。

它与Go非常相似，也受到Oberon，Rust，Swift的影响。

V是一种非常简单的语言。通过这个文档将花费你大约半个小时，到最后你将学习几乎整个语言。

尽管很简单，但它为开发人员提供了很多动力。你可以用其他语言做任何事情，你可以用V做。

发现错误/拼写错误？请[提交拉取请求](https://github.com/vlang-io/V/blob/master/website/templates/docs.html)。

## 你好，世界

```
fn main() {
	println('hello world')
}
```

声明函数`fn`。返回类型在函数名称后面。在这种情况下`main`不返回任何内容，因此省略了类型。

就像在C和所有相关语言中一样`main`是一个切入点。

`println`是为数不多的内置函数之一。它将值打印到标准输出。

## 评论

```v
// This is a single line comment

/* This is a multiline comment.
   /* It can be nested */
*/
```

## 功能

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

同样，类型出现在参数的名称之后。

## 变量

```
fn main() {
	name := 'Bob'
	age := 20
	large_number := i64(0)
	println(name)
	println(age)
}
```

使用变量声明和初始化变量`:=`。这是在V中声明变量的唯一方法。这意味着变量始终具有初始值。变量的类型是从右侧的值推断出来的。

要强制使用其他类型，请使用类型转换：表达式转换价值`T(v)`到类型`v`。`T`与大多数其他语言不同，V只允许在函数中定义变量。

不允许使用全局（模块级别）变量。V中没有全球状态。要更改变量的值，请使用

```go
fn main() {
	mut age := 20
	println(age)
	age = 21
	println(age)
}
```

。`=`在V中，默认情况下变量是不可变的。为了能够更改变量的值，您必须使用它来声明它`mut`。

请注意两者之间的区别`:=`和`=`：\
`:=`用于声明和初始化，`=`用于分配。

```go
fn main() {
	age = 21
}
```

这段代码不会编译，因为变量`age`没有宣布。所有变量都需要在V中声明。

## 基本类型

```v
bool

string

i8  i16  i32  i64
u8  u16  u32  u64

byte // alias for u8
int  // alias for i32
rune // alias for i32, represents a Unicode code point

f32 f64
```

请注意，与C和Go不同，`int`始终是32位整数。

## 常量

```v
const PI = 3.14

fn main() {
	println(PI)
	const WORLD = '世界'
	println(WORLD)
}
```

常量用a声明`const`关键词。它们可以在模块级别（功能之外）定义。

常量名称必须大写。这有助于将它们与变量区分开来

永远不能改变常量值。

## 字符串

```v
fn main() {
	name := 'Bob'
	// Interpolated variable in string
	println('Hello, $name!')

	println(name.len)
        bobby := name + 'by' // + is used to concatenate strings
        println(bobby) // ==> Bobby

        println(bobby.substr(1, 3)) // ==> ob
        // println(bobby[1:3]) // This syntax will most likely replace the substr() method
}
```

在V中，字符串是只读字节数组。字符串数据使用UTF-8编码。

字符串内容是不可变的。这意味着子字符串函数非常有效：不执行复制，不需要额外的分配。

## 数组

```v
fn main() {
	nums := [1, 2, 3]
	println(nums)
	println(nums[1]) // ==> "2"

	mut names := ['John']
	names << 'Peter'
	names << 'Sam'
	// names << 10  <-- This will not compile. `names` is an array of strings.
	println(names.len) // ==> "3"
	println(names.contains('Alex')) // ==> "false"

	// We can also preallocate a certain amount of elements.
	nr_ids := 50
	mut ids := [0 ; nr_ids] // This creates an array with 50 zeroes
	for i := 0; i < nr_ids; i++ {
		ids[i] = i // This is more efficient than
		           // ids << i
	}
}
```

数组类型由第一个元素决定：`[1, 2, 3]`是一组整数\
（`[]int`）。\
`['a', 'b']`是一个字符串数组（`[]string`）。

数组中的所有元素必须具有相同的类型。`[1, 'a']`不会编译。

`<<`是一个将值附加到数组末尾的运算符。

`.len`field返回数组的长度。请注意，它是一个只读字段，用户无法修改。默认情况下，所有导出的字段都是只读的。

`.contains(val)`如果数组包含，则method返回true`val`。

## 如果

```v
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

与其他类C语言不同，条件周围没有括号，并且始终需要大括号。

## 对于循环

V只有一个循环结构：`for`。

```v
fn main() {
	numbers := [1, 2, 3, 4, 5]
	for num in numbers {
		println(num)
	}
	names := ['Sam', 'Peter']
	for i, name in names {
		println('$i) $name')  // Output: 0) Sam
	}                                        1) Peter
}
```

该`for .. in`loop用于遍历数组的元素。如果需要索引，则使用另一种形式`for index, value in`可以使用。

```v
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

这种形式的循环类似于`while`用其他语言循环。

一旦布尔条件求值为false，循环将停止迭代。

同样，条件周围没有括号，并且总是需要括号。

```v
fn main() {
	mut sum := 0
	for {
		sum++
	}
	println('This will never be printed')
}
```

条件可以省略，这会导致无限循环。

```v
fn main() {
	for i := 0; i < 10; i++ {
		println(i)
	}
}
```

最后，还有传统的C风格`for`环。它比安全更安全\`而\`形式因为后者很容易忘记更新计数器并陷入无限循环。

## 开关

```v
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

switch语句是编写序列的较短方式`if - else`声明。它运行第一种情况，其值等于条件表达式。

与C不同，`break`每个块末尾都不需要声明。

## 结构

```v
struct Point {
	x int
	y int
}

fn main() {
	p := Point{10, 20}
	println(p.x) // Struct fields are accessed using a dot
	p2 := Point{ // Fields can also be set using this syntax
		x: 20
		y: 30
	}
	// & prefix returns a pointer to the struct value.
	// It's allocated on the heap and automatically cleaned up
	// by V at the end of the function, since it doesn't escape.
	pointer := &Point{10,10}
	println(pointer.x, pointer.y) // Pointers have the same syntax for accessing fields
}
```

## 方法

```v
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

V没有课程。但您可以在类型上定义方法。

方法是具有特殊接收器参数的函数。

接收器出现在它自己的参数列表中`fn`关键字和方法名称。

在这个例子中，`distance_to`方法有一个类型的接收器`Point`命名`a`。

## 可变接收器

去做

## 接口

```v
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

类型通过实现其方法来实现接口。没有明确的意图声明，没有“implements”关键字。

V接口非常有效。没有动态调度。

## 选项类型

```v
struct User {
	id int
}

struct Repo {
	users []User
}

fn (r Repo) find_user_by_id(id int) User? {
	for user in r.users {
		if user.id == id {
			// V automatically wraps this into an option type
			return user
		}
	}
	return error('User $id not found')
}

fn main() {
	repo := // ... initialize the repository here and load users data
	// either get the user or handle an error and leave the current scope
	user := repo.find_user_by_id(10) or {
		eprintln(err)
		return
	}
	println(user.id) // 10
	user = repo.find_user_by_id(11)? // ? propagates an error
	println(user.id) // 11
}
```

另请注意，将函数“升级”为可选函数所需的工作量很小：您必须添加一个`?`返回类型并在出现错误时返回错误。

## 泛型

```v
import database

struct Repo <T> {
	db DB
}

// Generic code is notoriously verbose. To reduce clutter, V doesn't require you
// to add `<T>` every time, since it already knows that Repo is a generic type.
// Here the function return type is an unspecified instance of Repo.
fn new_repo<T>(db DB) Repo {
	return Repo<T>{db: db}
}

// This is a generic method. V will generate it for every Repo instance it's used with.
// Again <T> is implied by just writing Repo for the receiver type, so V makes the method take <T> too:
// fn (r Repo<T>) find_by_id<T>(id int) T?
fn (r Repo) find_by_id(id int) T? {
	table_name := T.name // in this example getting the name of the type gives us the table name
	//lookup a value of type T from the database, or return an error
	return r.db.query_one<T>('select * from $table_name where id = ?', id)
}

struct User { name string }
struct Post { text string }

fn main() {
	db := new_db()
	users_repo := new_repo<User>(db)
	posts_repo := new_repo<Post>(db)
	// find_by_id is inferred from users_repo:
	user := users_repo.find_by_id(1)?
	// find_by_id is inferred from posts_repo:
	post := posts_repo.find_by_id(1)?
	println(user.name)
	println(post.text)
}
```

## 解码JSON

```v
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

JSON现在非常流行，这就是内置JSON支持的原因。

的第一个论点`json.decode`function是要解码的类型。第二个参数是json字符串。

V生成用于json编码和解码的代码。没有使用反射。这导致更好的性能。

## 将C / C ++翻译成V.

V可以将您的C / C ++代码转换为人类可读的V代码。让我们创建一个简单的程序`test.cpp`第一：

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

跑`v translate test.cpp`和V将生成`test.v`：

```v
fn main {
        mut s := []string
	s << 'V is '
	s << 'awesome'
	println(s.len)
}
```

<!-- @t footer -->
