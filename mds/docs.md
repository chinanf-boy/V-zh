<!-- @t header h2 { border-top: 1px solid #dfdfdf; padding-top: 10px; } comment { font-family: 'Roboto Mono'; color: #777; } code { font-family: 'Roboto Mono'; background-color: #fafafa; padding: 1px 3px 1px 3px; } -->

[Examples](https://github.com/vlang-io/V/tree/master/examples) [Documentation](/docs) [Playground](/play) [Blog](/blog) [FAQ](/#faq) [Software built in V](/#software)

# V programming language

Fast, safe, compiled language created for developing [Volt](https://volt.ws), soon available for everyone.

Open source release in mid 2019.

Install V from source in 0.5 seconds

```
wget vlang.io/v.c && gcc -o v v.c
```

[Introduction](#introduction) [Hello World](#hello) [Comments](#comments) [Functions](#fns) [Variables](#vars) [Basic types](#btypes) [Constants](#consts) [Strings](#strings) [Arrays](#arrays) [If statement](#if) [For loop](#for) [Switch](#switch) [Structs](#structs) [Methods](#methods) [Mutable receivers](#recvs) [Interfaces](#interfaces) [Option types](#option) [Generics](#generics) [Decoding JSON](#json)  
[Translating C/C++ to V](#cpp)

## Introduction

V is a statically typed compiled programming language designed for building maintainable software.

It's very similar to Go and is also influenced by Oberon, Rust, Swift.

V is a very simple language. Going through this documentation will take you about half an hour, and by the end of it you will learn pretty much the entire language.

Despite being simple, it gives a lot of power to the developer. Anything you can do in other languages, you can do in V.

Found an error/typo? Please [submit a pull request](https://github.com/vlang-io/V/blob/master/website/templates/docs.html).

## Hello World

```
fn main() {
	println('hello world')
}
```

Functions are declared with `fn`. Return type goes after the function name. In this case `main` doesn't return anything, so the type is omitted.

Just like in C and all related languages, `main` is an entry point.

`println` is one of the few builtin functions. It prints the value to standard output.

## Comments

```v
// This is a single line comment

/* This is a multiline comment.
   /* It can be nested */
*/
```

## Functions

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

Again, the type comes after the argument's name.

## Variables

```

fn main() {
	name := 'Bob'
	age := 20
	large_number := i64(0)
	println(name)
	println(age)
}

```

Variables are declared and initialized with `:=`. This is the only way to declare variables in V. This means that variables always have an initial value.

The variable's type is inferred from the value on the right hand side. To force a different type, use type conversion: the expression `T(v)` converts the value `v` to the type `T`.

Unlike most other languages, V only allows defining variables in functions. Global (module level) variables are not allowed. There's no global state in V.

```go
fn main() {
	mut age := 20
	println(age)
	age = 21
	println(age)
}

```

To change the value of the variable use `=`. In V variables are immutable by default. To be able to change the value of the variable, you have to declare it with `mut`.

Please note the difference between `:=` and `=`:  
`:=` is used for declaring and initializing, `=` is used for assigning.

```go
fn main() {
	age = 21
}
```

This code will not compile, because variable `age` is not declared. All variables need to be declared in V.

## Basic types

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

Please note, than unlike C and Go, `int` is always a 32 bit integer.

## Constants

```v

const PI = 3.14

fn main() {
	println(PI)
	const WORLD = '世界'
	println(WORLD)
}

```

Constants are declared with a `const` keyword. They can be defined at the module level (outside of functions).

Constant names must be capitalized. This helps distinguish them from variables.

Constant values can never be changed.

## Strings

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

In V, a string is a read-only array of bytes. String data is encoded using UTF-8.

String contents are immutable. This means that the substring function is very efficient: no copying is performed, no extra allocations required.

## Arrays

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

Array type is determined by the first element: `[1, 2, 3]` is an array of ints  
(`[]int`).  
`['a', 'b']` is an array of strings (`[]string`).

All elements in an array must have the same type. `[1, 'a']` will not compile.

`<<` is an operator that appends a value to the end of the array.

`.len` field returns the length of the array. Note, that it's a read-only field, and it can't be modified by the user. All exported fields are read-only by default in V.

`.contains(val)` method returns true if the array contains `val`.

## If

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

`if` statements are pretty straightforward and similar to most other languages.

Unlike other C-like languages, there are no parentheses surrounding the condition, and the braces are always required.

## For loop

V has only one looping construct: `for`.

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

The `for .. in` loop is used for going through elements of an array. If an index is required, an alternative form `for index, value in` can be used.

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

This form of the loop is similar to `while` loops in other languages.

The loop will stop iterating once the boolean condition evaluates to false.

Again, there are no parentheses surrounding the condition, and the braces are always required.

```v

fn main() {
	mut sum := 0
	for {
		sum++
	}
	println('This will never be printed')
}

```

The condition can be omitted, this results in an infinite loop.

```v

fn main() {
	for i := 0; i < 10; i++ {
		println(i)
	}
}

```

Finally, there's the traditional C style `for` loop. It's safer than the \`while\` form because with the latter it's easy to forget to update the counter and get stuck in an infinite loop.

## Switch

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

A switch statement is a shorter way to write a sequence of `if - else` statements. It runs the first case whose value is equal to the condition expression.

Unlike C, `break` statement is not needed at the end of every block.

## Structs

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

## Methods

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

V doesn't have classes. But you can define methods on types.

A method is a function with a special receiver argument.

The receiver appears in its own argument list between the `fn` keyword and the method name.

In this example, the `distance_to` method has a receiver of type `Point` named `a`.

## Mutable receivers

TODO

## Interfaces

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

A type implements an interface by implementing its methods. There is no explicit declaration of intent, no "implements" keyword.

V interfaces are very efficient. There's no dynamic dispatch.

## Option types

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

Also note that the amount of work required to "upgrade" a function to an optional function is minimal: you have to add a `?` to the return type and return an error when something goes wrong.

## Generics

```go
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

## Decoding JSON

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

JSON is very popular nowadays, that's why JSON support is built in.

The first argument of the `json.decode` function is the type to decode to. The second argument is the json string.

V generates code for json encoding and decoding. No reflection is used. This results in much better performance.

## Translating C/C++ to V

V can translate your C/C++ code to human readable V code. Let's create a simple program `test.cpp` first:

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

Run `v translate test.cpp` and V will generate `test.v`:

```v
fn main {
        mut s := []string
	s << 'V is '
	s << 'awesome'
	println(s.len)
}

```

<!-- @t footer -->
