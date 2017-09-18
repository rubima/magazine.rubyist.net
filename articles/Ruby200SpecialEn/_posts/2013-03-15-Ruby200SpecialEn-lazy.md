---
layout: post
title: Ruby 2.0.0： Enumerable#lazy
short_title: Ruby 2.0.0： Enumerable#lazy
tags: Ruby200SpecialEn lazy
---


Author: Yutaka Hara ([@yhara_en](https://twitter.com/yhara_en))
Translator: makoto ([@makoto_inoue](https://twitter.com/makoto_inoue))

## Introduction

In this post, I will talk about the Enumerable#lazy method and the Enumerator::Lazy object it returns. Both have been added as new features in Ruby 2.0. [^1]

Related ticket

* [http://bugs.ruby-lang.org/issues/4890](http://bugs.ruby-lang.org/issues/4890)


## What is Enumerable#lazy ?

Enumerable#lazy is often explained as "a method that enables lazy versions of methods like 'map' and 'select'". If you would like to be seen as an advanced Rubyist, you would describe it more accurately by saying it is "a method __that provides a namespace__ for lazy versions of 'map', 'select', etc".

Let's first define what "lazy version of 'map' and 'select'" means, and then explain what "providing a namespace" means.

## Lazy version of __map__ and __select__

Ruby's 'map' method returns a result set after a block is applied to each element of an Enumerable object such as Array.

{% highlight text %}
{% raw %}
p [1, 2, 3].map{|x| x * 2}
#=> [2, 4, 6]
{% endraw %}
{% endhighlight %}


'map' is a very useful method, but it has one limitation: it cannot return infinite lists, as it tries to create an array with an infinite number of elements.

{% highlight text %}
{% raw %}
p (1..Float::INFINITY).map{|x| x * 2}
#=> ...
{% endraw %}
{% endhighlight %}


You may think this is obvious. Who would try to map an infinite list? Well, functional programming languages, especially Haskell are based on lazy evaluation, so this is a very common programming style. In Ruby, there is a case where a lazy version of the 'map' method is useful. I will explain it later on.

### Enumerator represents a sequence of objects.

What if there were a method that could map an infinite list? How would it behave? (Let's call it 'lazy_map' for now)

Ruby already has a class called Enumerator for lazy evaluation. So 'lazy_map' should just return an object.
Enumerator represents "a sequence of objects" and you can generate a new instance by passing a block into Enumerator.new.

The block receives a special object called a "yielder", and you can define each element by passing a value with the &lt;&lt; ("shovel") operator.

Let's try out the FizzBuzz program using Enumerator.

{% highlight text %}
{% raw %}
fizzbuzz = Enumerator.new{|yielder|
  1.upto(Float::INFINITY) do |n|
    case
    when n % 15 == 0 then yielder << "FizzBuzz"
    when n % 5 == 0 then yielder << "Buzz"
    when n % 3 == 0 then yielder << "Fizz"
    else yielder << n.to_s
    end
  end
}
fizzbuzz.each do |str|
  puts str
end
{% endraw %}
{% endhighlight %}


The variable fizzbuzz contains an Enumerator object, and you can access the next FizzBuzz string via the 'each' method.

You can use any of the Enumerable methods such as 'map', 'select', and 'take', because Enumerator includes Enumerable.

The above code runs endlessly; let's change the code to display only first 100 rows.

{% highlight text %}
{% raw %}
fizzbuzz.first(100).each do |str|
  puts str
end
{% endraw %}
{% endhighlight %}


### Casual Enumerator

I've shown you how to generate Enumerator objects. In fact, some of Ruby's built in methods return Enumerator, such as 'each', 'each_line', 'each_byte'. Many of these "each"-related methods returns an Enumerator if you don't pass a block.

As an example, I wrote a program to display the first 10 lines of a file.

{% highlight text %}
{% raw %}
File.open("log.txt") do |f|
  puts f.each_line.first(10)
end
{% endraw %}
{% endhighlight %}


If you don't pass in a block, IO#each_line returns an Enumerator object that yields each row of the file.
Since Enumerator includes all Enumerable methods, you can use 'first' method to take the first ten rows.

There are three important things happening here:

1. each_line does not read the entire file
:  IO#each_line starts reading only the required portion rather than the entire file rows. Therefore this program finishes in less than a second, even when log.txt is several gigabytes in size.

2. It is easy to change to 'each_byte' that reads data per byte.
:  Let's change the above program to show the first ten bytes rather than the first ten rows. You can easily do this by replacing 'each_line' with a similar IO method called 'each_byte'. Enumerator provides an abstracted interface that acts like an Enumerable object array, so it can handle either each row or each byte.

3 (FYI) IO#lines is deprecated in 2.0.
:  It's not directly related to __lazy__, but some methods in String class, such as 'lines', 'chars', 'bytes', 'codepoints' return arrays instead of Enumerator([#6670](http://bugs.ruby-lang.org/issues/6670)). To stay consistent, the 'lines' method in IO is not recommended. Please use 'each_line' instead of 'lines' when you when you want to be _lazy_.

### Enumerator and 'map'

Let's get back to the 'map' method. Thus far, I have been talking about a case where you don't want 'map' to return an entire array. For example, let's write a program that reads the first ten rows matching a certain condition. Here is an example using 'map' and 'select'.

{% highlight text %}
{% raw %}
File.open(path) do |f|
  puts f.each_line.map{|line| ...(modify line)...}
  .select{|line| ...(return true if line matches the condition)...}
  .first(10)
end
{% endraw %}
{% endhighlight %}


This program defeats the purpose of using 'each_line', because the 'map' method tries to return the entire file (such as log.txt) to convert it into an array.

Now let's imagine that there are methods called 'lazy_map' and 'lazy_select' that act similarly to 'map' and 'select', but return an Enumerator instead of an Array.

You can then rewrite the code like this:

{% highlight text %}
{% raw %}
File.open(path) do |f|
  puts f.each_line.lazy_map{|line| ... (modify line)... }
  .lazy_select{|line| ...(return true if line matches the condition)... }
  .first(10)
end
{% endraw %}
{% endhighlight %}


This is almost identical to the previous example, but 'lazy_map' returns Enumerator that yields the modified rows and therefore lazily evaluates the program. 'lazy_select' works in the same way: it only reads the first ten rows that match the condition so the program ends without using up all your memory.

## The naming issue.

The lazy version of 'map' is very convenient, but there is a issue with the method names. The Enumerable module includes many other methods that can be lazily evaluated, such as 'map', 'select', 'reject' and 'drop', but we did not want to inflate Enumerable module with methods such as 'lazy_map' and 'lazy_select'.

Then I came up with an API that changes its mode by appending .lazy. I added a method called "lazy" in the Enumerable module. If you call this method, it returns an instance of a special class called Enumerator::Lazy. Enumerator::Lazy is almost identical to Enumerator, but certain methods (such as 'map' and 'select') are overwritten by the lazy version.

Now you can rewrite the previous example like this in Ruby 2.0.

{% highlight text %}
{% raw %}
File.open(path) do |f|
  puts f.each_line.lazy.map{|line| ...(modify line)...}
  .select{|line| ...(return true if line matches the condition)...}
  .first(10)
end
{% endraw %}
{% endhighlight %}


Thanks to Enumerable#lazy and Enumerator::Lazy you can easily switch methods to the lazy version by simply adding "lazy" method, without adding a large number of new methods. This is what I meant by "a method that provides a namespace" at the very beginning.

## An example

Enumerable#lazy lets you handle an array that is either huge, infinite, or endless with familiar interfaces such as 'select' and 'map'.
One example of an "endless map" is streaming data over a network. For example, you can write a program that parses a public timeline on Twitter, then extracts and modifies the tweets like this:

{% highlight text %}
{% raw %}
TwitterPublicTimeline.each.lazy.map{|json| ...(modify json)...}
.select{|tweet| ...(return true if the tweet matches a condition)...}
.each{|tweet| p tweet}
{% endraw %}
{% endhighlight %}


If there were no lazy version of 'map' and 'select', you would have to write it like this:

{% highlight text %}
{% raw %}
TwitterPublicTimeline.each do |json|
  tweet = ...(modify json)...
  next unless ...(return true if the tweet matches a condition)...
  p tweet
end
{% endraw %}
{% endhighlight %}


Some of you may think the latter is easier to understand. It may be true for shorter programs.
However, while the former example uses Enumerable's API effectively, the latter reimplements part of Enumerable's logic.

What if TwitterPublicTimeline.each returned multiple tweets in chunks rather than single tweets one at a time? With lazy, you can simply swap .map with .flat_map to handle the difference.

{% highlight text %}
{% raw %}
TwitterPublicTimeline.each.lazy.flat_map{|json| ...(modify json)...}
.select{|tweet| ...(return true if tweet matches a condition)...}
.each{|tweet| p tweet}
{% endraw %}
{% endhighlight %}


How would you handle this without lazy? Would you use a nested loop? Either way, it won't be as easy as the lazy version.

You may not be familiar with using 'map' and 'select' to handle unusual types of arrays such as streaming data, but you may discover a new programming style once you try.

## Summary

Enumerable#lazy in Ruby 2.0 gives you lazily evaluatable versions of 'map' and 'select', and so on with its ".lazy.map" interface. It provides a unified interface for handling huge or infinite arrays because its methods return an instance of Enumerator::Lazy rather than a normal array.

## About the author

Yutaka Hara (Network Applied Communication Laboratory) has been living in Matsue City for the past five years. His latest hobby is Minecraft.

----

[^1]: Note that a class named 'Enumerable::Lazy' does not exist; only 'Enumerable#lazy' and 'Enumerator::Lazy' are correct.
