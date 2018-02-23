---
layout: post
title: Ruby 2.0.0： Keyword arguments
short_title: Ruby 2.0.0： Keyword arguments
tags: Ruby200SpecialEn kwarg
---
{% include base.html %}


Author: Yusuke Endoh
Translator: Leonard Chin ([@lchin](https://twitter.com/lchin))

## Foreword

Congratulations for the release of Ruby 2.0.0!

In this article, I will introduce one of the new features in Ruby 2.0.0, Keyword Arguments.

## Keyword Arguments in a Nutshell

The following example implements a logging method.

{% highlight text %}
{% raw %}
def log(msg, level: "ERROR", time: Time.now)
  puts "#{ time.ctime } [#{ level }] #{ msg }"
end
{% endraw %}
{% endhighlight %}


{% highlight text %}
{% raw %}
log("Hello!", level: "INFO")  #=> Mon Feb 18 01:46:22 2013 [INFO] Hello!
{% endraw %}
{% endhighlight %}


It looks so ordinary. It doesn't exactly look like anything new, does it?

## Explanation

We can already call methods with keyword arguments in 1.9.

{% highlight text %}
{% raw %}
log("Hello!", level: "INFO")
{% endraw %}
{% endhighlight %}


The keyword arguments here are passed to the method as the hash  { :level =&gt; "INFO" } 
To actually make use of the arguments, we need to access them through the hash.

{% highlight text %}
{% raw %}
def log(msg, opt = {})
  level = opt[:level] || "ERROR"
  time  = opt[:time]  || Time.now
  puts "#{ time.ctime } [#{ level }] #{ msg }"
end
{% endraw %}
{% endhighlight %}


So far, it isn't all that complicated. However, things can get hairy real fast if we consider the following situations

* Using keyword arguments along with variable length argument lists
* Raising exceptions when we get unexpected keyword arguments
* When we want to pass in nil as an argument


To handle all the above cases, we end up with something like the following.

{% highlight text %}
{% raw %}
def log(*msgs)
  opt = msgs.last.is_a?(Hash) ? msgs.pop : {}
  level = opt.key?(:level) ? opt.delete(:level) : "ERROR"
  time  = opt.key?(:time ) ? opt.delete(:time ) : Time.now
  raise "unknown keyword: #{ opt.keys.first }" if !opt.empty?
  msgs.each {|msg| puts "#{ time.ctime } [#{ level }] #{ msg }" }
end
{% endraw %}
{% endhighlight %}


Not something you'd want to write over and over again. 
Handling these kinds of situations is the motivation behind keyword arguments.
By using this new feature of Ruby 2.0.0, we can process keyword arguments extremely cleanly.
Just like our opening example, in fact.

{% highlight text %}
{% raw %}
def log(msg, level: "ERROR", time: Time.now)
  puts "#{ time.ctime } [#{ level }] #{ msg }"
end
{% endraw %}
{% endhighlight %}


## A Little More Detail...

When we call this method without any keyword arguments, it behaves as we had passed it level: "ERROR", time: Time.now

{% highlight text %}
{% raw %}
log("Hello!")                                  #=> Mon Feb 18 01:46:22 2013 [ERROR] Hello!
log("Hello!", level: "ERROR", time: Time.now)  #=> Mon Feb 18 01:46:22 2013 [ERROR] Hello!
{% endraw %}
{% endhighlight %}


Order is not important of keyword arguments. However, you still need to pay attention to the order of the other arguments.

{% highlight text %}
{% raw %}
log("Hello!", time: Time.now, level: "ERROR")  #=> Mon Feb 18 01:46:22 2013 [ERROR] Hello!
log(level: "ERROR", time: Time.now, "Hello!")  # This doesn't work
{% endraw %}
{% endhighlight %}


You can even leave out one of the keyword arguments.

{% highlight text %}
{% raw %}
log("Hello!", level: "INFO")  #=> Mon Feb 18 01:46:22 2013 [INFO] Hello!
{% endraw %}
{% endhighlight %}


If you supply an unknown keyword, an exception is raised.

{% highlight text %}
{% raw %}
log("Hello!", date: Time.new)  #=> unknown keyword: date
{% endraw %}
{% endhighlight %}


Those who don't want exceptions to be raised for unknown keywords can specify a hash argument with ** to explicitly group the other keyword arguments.

{% highlight text %}
{% raw %}
def log(msg, level: "ERROR", time: Time.now, **kwrest)
  puts "#{ time.ctime } [#{ level }] #{ msg }"
end

log("Hello!", date: Time.now)  #=> Mon Feb 18 01:46:22 2013 [ERROR] Hello!
{% endraw %}
{% endhighlight %}


It is also possible to combine keyword arguments with optional arguments or variable-length argument lists. (But don't go overboard!)

{% highlight text %}
{% raw %}
def f(a, b, c, m = 1, n = 1, *rest, x, y, z, k: 1, **kwrest, &blk)
  puts "a: %p" % a
  puts "b: %p" % b
  puts "c: %p" % c
  puts "m: %p" % m
  puts "n: %p" % n
  puts "rest: %p" % rest
  puts "x: %p" % x
  puts "y: %p" % y
  puts "z: %p" % z
  puts "k: %p" % k
  puts "kwrest: %p" % kwrest
  puts "blk: %p" % blk
end

f("a", "b", "c", 2, 3, "foo", "bar", "baz", "x", "y", "z", k: 42, u: "unknown") { }
  #=> a: "a"
      b: "b"
      c: "c"
      m: 2
      n: 3
      rest: "foo"
      x: "x"
      y: "y"
      z: "z"
      k: 42
      kwrest: {:u=>"unknown"}
      blk: #<Proc:0x007f7e7d8dd6c0@-:16>
{% endraw %}
{% endhighlight %}


## Limitations

Be careful when passing hashes to methods with both variable length argument lists and keyword arguments. For example, in the case below, the last hash is interpreted as a keyword argument and won't be assigned to the args parameter.

{% highlight text %}
{% raw %}
def foo(*args, k: 1)
  p args
end

args = [{}, {}, {}]

foo(*args) #=> [{}, {}]
{% endraw %}
{% endhighlight %}


Also, you cannot omit the name of the ** parameter used to suppress unknown keyword exceptions.

{% highlight text %}
{% raw %}
def foo(**)
end
foo(k: 1) #=> unknown keyword: k
{% endraw %}
{% endhighlight %}


(While writing this article, I started having doubts about this behaviour...)[^1]

Care must also be taken when rewriting existing functions to take advantage of this feature. Unlike hash keys, keywords can not be reserved words in Ruby.

{% highlight text %}
{% raw %}
def foo(if: false)
end
foo(if: true)
{% endraw %}
{% endhighlight %}


The above code won't explicitly fail, but you won't be able to access the contents of the local variable named `if`. To get around this, you will need to use the ** parameter.

{% highlight text %}
{% raw %}
def foo(**kwrest)
  p kwrest[:if]
end
foo(if: true) #=> true
{% endraw %}
{% endhighlight %}


## Closing Thoughts

In Ruby 2.0.0, keyword arguments were made available by adding new syntax for defining method parameters.

The implementation of the feature is mostly syntax sugar, and can hardly be called a significant new feature. From the standpoint of the Ruby culture, however, I believe it is important that keyword arguments are now first class citizens.
I think we will be seeing many new APIs taking advantage of keyword arguments, hopefully making your Ruby life just a little bit nicer.

## About the Author

Yusuke Endoh is a Ruby committer (account: mame). His contributions include increasing the test coverage of Ruby, serving as the assistant Release Manager of Ruby 1.9.2, and the Release Manager of Ruby 2.0.0.

[^1]: This behaviour has been fixed. It will be included in a future patch level release of Ruby. https://bugs.ruby-lang.org/issues/7922
