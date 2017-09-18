---
layout: post
title: Ruby 2.0.0： Note
short_title: Ruby 2.0.0： Note
tags: Ruby200SpecialEn note
---


* Table of content
{:toc}


## Introduction

In this post, I will summarise things you should be aware when start using Ruby 2.0.0 including some of new features.

The official summary is in the [NEWS file](http://svn.ruby-lang.org/cgi-bin/viewvc.cgi/tags/v2_0_0_0/NEWS?view=markup)

## Significant incompatibilities

### Character encoding incompatibility

Author：naruse

#### The default script encoding change.

Default script encoding (when magic comment is not specified) is changed into UTF8[[#6679]](http://bugs.ruby-lang.org/issues/6679)

In Ruby 1.9, the default script encoding is US-ASCII. We changed it to be UTF-8 after considering the following pros and cons.

* UTF-8 default is convenient because the majority of modern application uses UTF-8
* This change doe not impact any 1.9 codes if Magic Comments are in place.
* The default script encoding in 1.9 without Magic Comment is either US-ASCII or ASCII-8BIT. In UTF-8, then some string manipulation could become slower.
* Most codes which written for Ruby 1.8 and not written in UTF-8 don't have a Magic Comment, but they raise an error due to invalid bytes in UTF-8. So in the most of that case, won't be a silent problem.


You may encounter problems if your code does not use Magic Comment, and also contains a string with escaped binary. In this case, you should either specify Magic Comment, or convert to ASCII-8bit with String#b that is added at [[#6767]](http://bugs.ruby-lang.org/issues/6767). 

#### iconv library is deleted

iconv, a Ruby extension library, is deleted from the core[[#6322]](http://bugs.ruby-lang.org/issues/6322)

Please use [iconv.gem](https://rubygems.org/gems/iconv) if you need to use iconv related methods such as String#encode and Encoding::Converter.

#### -K will raise warning

If you still use -K option (as used in 1.8) it will raise warning.

### String#lines returns an array rather than Enumerator

Author：yhara (Yutaka Hara)

In Ruby 1.9, String has methods that iterate string , such as each_line, each_char, each_byte, and each_codepoint, as well as their identical methods such as  lines,chars, bytes, code points 

In, Ruby 2.0.0, lines, chars, bytes, and code points returns an array rather than Enumerator.

Here are some Ruby 1.9 examples.

{% highlight text %}
{% raw %}
 # Returns the last line
 str.lines.to_a.last
 # Returns the second last line
 str.chars.to_a[1]
{% endraw %}
{% endhighlight %}


Here are the equivalent code in Ruby 2.0

{% highlight text %}
{% raw %}
 # Returns the last line
   str.lines.last
 # Returns the second last line
   str.chars[1]
{% endraw %}
{% endhighlight %}


As you can see, you do not have to convert with to_a

However, the following code now raises errors.

{% highlight text %}
{% raw %}
 str.chars.with_index{ ... }
{% endraw %}
{% endhighlight %}


This is because an array does not have with_index method. To work this around, please replace with each_char.

{% highlight text %}
{% raw %}
 str.each_char.with_index{ ... }
{% endraw %}
{% endhighlight %}


BTW IO, StringIO, ARGF has methods with same names, but methods such as IO#bytes are deprecated in Ruby 2.0 and raises warning if you use the method.

We decided to deprecate IO#bytes [^1]  [^2]  because no one will want to convert an entire file into an array (It may look strange that IO#bytes and String#bytes returns different result format) [^3].

each_byte is recommended over each in this situation.

The associated ticket：[http://bugs.ruby-lang.org/issues/6670](http://bugs.ruby-lang.org/issues/6670)

### Number (Integer and Float) is frozen

Author: Koichi Sasada

Integer (Fixnum, Bignum) and Float objects are always frozen. If (quite unlikely though) there are any codes that add instance variable or eigen method into these numerical objects, these programs will break.  Let's throw away such codes.

The associated ticket(Japanese)：[http://bugs.ruby-lang.org/issues/3222,](http://bugs.ruby-lang.org/issues/3222,) [http://bugs.ruby-lang.org/issues/6936](http://bugs.ruby-lang.org/issues/6936)

## Other new features

### New symbol notation

Author: Koichi Sasada

You can now shorten [:a, :b, :c] to %i(a b c)

Like %W expands characters, %I expands characters.

{% highlight text %}
{% raw %}
p %w(a b#{1} c) #=> ["a", "b\#{1}", "c"]
p %W(a b#{1} c) #=> ["a", "b1", "c"]

p %i(a b#{1} c) #=> [:a, :"b\#{1}", :c]
p %I(a b#{1} c) #=> [:a, :b1, :c]
{% endraw %}
{% endhighlight %}


### New method: Module#prepend

Author：Koichi Sasada

Module#prepend is similar to Module#include Unlike Module#include, the method prepends the specified class(module) into the method lookup order rather than appends.

The following article has more detail (Japanese)

* [#19 Introduction of Module#prepend](http://www.atdot.net/~ko1/diary/201212.html#d19)
* [#20 Application of Module#prepend](http://www.atdot.net/~ko1/diary/201212.html#d20)


### new method: Enumerable#size

Author：yhara

Enumerable now contains a method called "size" Enumerable already has a similar method called "count" but the method has a shortcoming of returning all the array element even when you only want to count the number of elements.

size method counts the number of elements without returning entire elements because the method is overwritten in all class that includes Enumerable.

For example, you can write a programme of counting the combination of 1000 elements in Ruby 2.0 as follows. 

{% highlight text %}
{% raw %}
 p [*1..1000].combination(3).size
 #=> 166167000
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
(If you use "count", it takes too long because it tries to secure 166167000 elements of array into memory space) .
{% endraw %}
{% endhighlight %}


The "size" method returns nil if you won't be able to know the size in advance. 
For example the following program returns nil because you won't be able to know the total line size until you read the entire file.

{% highlight text %}
{% raw %}
 File.open("log.txt"){|f|
   p f.each_line.size
 }
{% endraw %}
{% endhighlight %}


The related method：[https://bugs.ruby-lang.org/issues/6636](https://bugs.ruby-lang.org/issues/6636)

### to_h

Author：yhara (Yutaka Hara)

Ruby has methods that converts an object into array or string, such as to_a and to_s. In Ruby 2.0, there is a new method called to_h that converts an object into a hash.

Struct, OpenStruct, and ENV cow can be converted into a hash with to_h. When a hash is passed to to_h, it just returns self. When nil is passed to to_h, it returns an empty hash ({}) .[^4]

Going forward, I would suggest that you name to_h to methods that returns hash representation of an object.

### Kernel#__dir__

Author: Koichi Sasada

Kernel#__dir__  method is added. This method is same as File.dirname(__FILE__)  You can obtain the directory name of a file with __dir__

### Array#bsearch

Author: nari

Array#bsearch [^5] takes a sorted array [^6] and matches a condition using binary search. It's nice that you don't have to build your own bsearch for programming competitions :-)

Here is the example. The following examples are all from [Ruby's RDoc](https://github.com/ruby/ruby/blob/v2_0_0_0/array.c#L2404-2408)

{% highlight text %}
{% raw %}
ary = [0, 4, 7, 10, 12]
ary.bsearch {|x| x >=   4 } #=> 4
ary.bsearch {|x| x >=   6 } #=> 7
ary.bsearch {|x| x >=  -1 } #=> 0
ary.bsearch {|x| x >= 100 } #=> nil
{% endraw %}
{% endhighlight %}


bsearch passes an array into an arugment inside block, and the block has to return either true or false.

* When true is returned, the searching element locates in the same index or bigger.
* When true is returned, the searching element locates in the smaller index.


It will be easier to understand if you read the both example and the descriptions together.

bsearch has two different mode, and I have explained _find-minimum_ so far.
I will now explain the second mode,  _find-any_

{% highlight text %}
{% raw %}
# In most case, you may only wan to use find-minimum mode.
# So this is only for people interested in this topic.
{% endraw %}
{% endhighlight %}


You can switch the mode by the returning value of the block.

{% highlight text %}
{% raw %}
When true/false is passed, it's in find-minimum mode, and when a number is returned, then it will be in find-any mode.
{% endraw %}
{% endhighlight %}


find-any finds a first element that matches a range of condition（i...j). The behavior depends on its returning value.

* When positive is returned, ary[k] is outside of i...j range, and the searching element is in larger index than k
* When 0 is returned ary[k] is within i...j（i &lt;= ary[k] &lt; j）
* When negative is returned, ary[k] is outside of i...j range, and the searching element is in smaller index than k


{% highlight text %}
{% raw %}
ary = [0, 4, 7, 10, 12]
# 4 <= x < 8
ary.bsearch {|x| 1 - x / 4 } #=> 4 or 7
# 8 <= x < 10 (returns 0 since nothing matches)
ary.bsearch {|x| 4 - x / 2 } #=> nil
{% endraw %}
{% endhighlight %}


It will be easier to understand if you read the both example and the descriptions together.
By the way, find-any mode is based on libc の bsearch(2) API

### Thread local variable (Not Fiber local)

Author：Koichi Sasada

Thread#[] allows you to use thread local variables (variables that can be shared among threads), but these variables become invalid when switched by Fiber (Let's call this as Fiber local variables).

To avoid this problem, we careated a new API for handling thread local variables that are not affected by Fiber local variables.

* Thread#thread_variable_get(sym) gets a thread local variable "sym"
* Thread#thread_variable_set(sym, obj) sets a thread local variable "sym"
* Thread#thread_variables  gets all thread local variables
* Thread#thread_variable?(sym) checks if there is a thread local variable called "sym"


In most cases, you can just use Thread#[] to control Fiber local variables per fiber, though you may occasionally need this API. Use it with caution.

### Stack size option

Author：Koichi Sasada

You can now specify VM and machine stack sizes (used by threads and fibers) in environment variables.

* RUBY_THREAD_VM_STACK_SIZE: VM stack size for threads（Default: 128KB (32bit CPU) or 256KB (64bit CPU)）
* RUBY_THREAD_MACHINE_STACK_SIZE: Machine stack size for threads（Default：512KB or 1024KB）
* RUBY_FIBER_VM_STACK_SIZE: VM stack size for fibers（Default：64KB or 128KB）
* RUBY_FIBER_MACHINE_STACK_SIZE: Machine stack size for fibers（Default：256KB or 512KB）


The default stack size gets bigger, though you don't have to worry about it for normal usages.

The associated article (in Japanese)：[Ruby VM Advent calendar #21 VM stack size tuning](http://www.atdot.net/~ko1/diary/201212.html#d21)

----

### More debugging functionalities

Author：Koichi Sasada

Ruby 2.0.0 added some debugging functions

* TracePoint,  replacement of set_trace_func
* caller_locations(), better alternative to caller()
* ObjectSpace.reachable_objects_from(), retrieves object reference relations


The more detail is in Ruby VM advent calendar referred in [YARV Maniacs 【第 11 回】 最近の YARV の事情]({% post_url articles/0041/2013-02-24-0041-YarvManiacs %}) (sorry, they are written in Japanese).

---

[^1]: This may get reverted in 2.0.1, if no one likes it :-p
[^2]: knu (Akinori Musha) seems thinking about returning a class such as LazyArray that has both Enumerable and index access
[^3]: You can use IO#readlines if you want to create an array of rows
[^4]: this feature lets you write hash = opts[:foo].to_h  without worrying whether opts[:foo] is nil or not
[^5]: There is also a similar function called Range#bsearch
[^6]: binary search assumes that the given array is sorted, and an un-sorted array is not taken into account
