---
layout: post
title: Ruby 2.0.0： DTrace support
short_title: Ruby 2.0.0： DTrace support
tags: Ruby200SpecialEn dtrace
---


Author：Aaron Patterson ([@tenderlove](https://twitter.com/tenderlove))

## Introduction to DTrace with Ruby 2.0

Ruby 2.0 will feature DTrace probes built in. If your system supports DTrace, you can use these probes to understand how your Ruby process is behaving. This article is a basic introduction to using DTrace probes with Ruby 2.0.

The examples in this article were done on OS X, and may be different depending on your system.

## What is DTrace?

DTrace is a tracing framework created by Sun Microsystems. It allows you to troubleshoot applications in real time, and debug processes while they are running in production.

## The D language

DTrace uses the D language for making queries about a running process. A D program is a series of statements that look like this:

{% highlight text %}
{% raw %}
probe /test/ { action }
probe /test/ { action }
{% endraw %}
{% endhighlight %}


When a probe fires, it runs the test, if the test passes, then the action is executed. The test can be omitted, and when the probe fires, the action will always run:

{% highlight text %}
{% raw %}
probe { action }
{% endraw %}
{% endhighlight %}


The format of __probe__ looks like this.

{% highlight text %}
{% raw %}
provider:module:function:name
{% endraw %}
{% endhighlight %}


* __provider__ is the name of the provider. In our case, __ruby__.
* __module__ is the software location (we won't use this)
* __function__ is the software function (we won't use this either)
* __name__ is the name of the probe.


In our case, "ruby" is the provider, and the probe names are [any of the names listed on the wiki](https://bugs.ruby-lang.org/projects/ruby/wiki/DTraceProbes).

For example, if we want to probe all method entries, we do this:

{% highlight text %}
{% raw %}
ruby:::method-entry { action }
{% endraw %}
{% endhighlight %}


In the action section, we can print "hello world" every time a method is entered like this:

{% highlight text %}
{% raw %}
ruby:::method-entry { printf("hello world\n"); }
{% endraw %}
{% endhighlight %}


Run this D program with the __dtrace__ command like this:

{% highlight text %}
{% raw %}
$ sudo dtrace -q -n'ruby$target:::method-entry { printf("hello world\n"); }' -c"ruby -e'puts :hi'"
{% endraw %}
{% endhighlight %}


Note that DTrace works with your kernel, so it requires elevated permissions, so we have to use __sudo__. Also, __$target__ is substituted for the process id of the command supplied to the __-c__ option. If you don't use __$target__, then DTrace will probe __all__ currently running Ruby process on your system.

Let's try a few more examples with Ruby!

## Probing Ruby

Here is a program I put in a file called __t.rb__:

{% highlight text %}
{% raw %}
class Foo
  def hello
    puts :hello
  end
end

5.times do
  foo = Foo.new
  foo.hello
  sleep 1
end
{% endraw %}
{% endhighlight %}


The __ruby:::method-entry__ probe receives the class name and method name when it is called. Write a file called __x.d__ with the following code:

{% highlight text %}
{% raw %}
ruby$target:::method-entry
{
  printf("%s#%s\n", copyinstr(arg0), copyinstr(arg1));
}
{% endraw %}
{% endhighlight %}


Then run the following command:

{% highlight text %}
{% raw %}
sudo dtrace -q -s x.d -c"ruby t.rb"
{% endraw %}
{% endhighlight %}


You should see lots of output, but eventually it will start to look like this:

{% highlight text %}
{% raw %}
hello
Foo#hello
hello
Foo#hello
hello
Foo#hello
hello
Foo#hello
{% endraw %}
{% endhighlight %}


In our D program, __arg0__ contains the class name, __arg1__ contains the method name. Many methods are executed when starting Ruby, so let's filter the results to just the t.rb file.

__arg2__ contains the file name, so we can change the D program and add a test like this:

{% highlight text %}
{% raw %}
ruby$target:::method-entry
/copyinstr(arg2) == "t.rb"/
{
  printf("%s#%s\n", copyinstr(arg0), copyinstr(arg1));
}
{% endraw %}
{% endhighlight %}


Now the probe only fires when the method is inside __t.rb__. If you rerun the program, you should only see something like this:

{% highlight text %}
{% raw %}
hello
Foo#hello
hello
Foo#hello
hello
Foo#hello
hello
Foo#hello
{% endraw %}
{% endhighlight %}


## Tracing a process

With DTrace, we can attach to a currently running process. Change __t.rb__ to look like this:

{% highlight text %}
{% raw %}
class Foo
  def hello
    puts :hello
  end
end

loop do
  foo = Foo.new
  foo.hello
  sleep 1
end
{% endraw %}
{% endhighlight %}


Run this program in one terminal. In a different terminal, find the process id, and run DTrace like this:

{% highlight text %}
{% raw %}
sudo dtrace -q -s x.d -p $PID
{% endraw %}
{% endhighlight %}


where $PID is the process id of the Ruby program. You should see output like this from DTrace:

{% highlight text %}
{% raw %}
Foo#hello
Foo#hello
Foo#hello
Foo#hello
Foo#hello
{% endraw %}
{% endhighlight %}


You can use DTrace to understand how a running process is behaving!

## One more trick

One powerful feature of DTrace is the ability to gather statistics. Let's write a program to count the number of methods called in a program.

Here is the Ruby program:

{% highlight text %}
{% raw %}
class Foo
  def hello
  end
  def world
  end
end

foo = Foo.new
100.times   { foo.hello }
10000.times { foo.world }
{% endraw %}
{% endhighlight %}


Here is the D program:

{% highlight text %}
{% raw %}
ruby$target:::method-entry
/copyinstr(arg2) == "t.rb"/
{
  @[copyinstr(arg0), copyinstr(arg1)] = count();
}
{% endraw %}
{% endhighlight %}


The special variable __@__ in D is similar to a Ruby hash. The key to this hash is the target class and method. The value is the number of times that method is called.

If we run the program:

{% highlight text %}
{% raw %}
$ sudo dtrace -q -s x.d -c"ruby t.rb"
{% endraw %}
{% endhighlight %}


We see output like this:

{% highlight text %}
{% raw %}
  Foo          hello          100
  Foo          world        10000
{% endraw %}
{% endhighlight %}


We can clearly see that __Foo#hello__ is called 100 times, and __Foo#world__ is called 10000 times.

## Conclusion

I hope this was a good introduction for getting started with DTrace and Ruby 2.0. Remember that you must use Ruby 2.0.0 and be on a system that supports DTrace for these examples to work.

Have fun hacking with DTrace!

## About the Author

Aaron was born and raised on the mean streets of Salt Lake City. His only hope for survival was to join the local gang of undercover street ballet performers known as the Tender Tights. As a Tender Tights member, Aaron learned to perfect the technique of self-defense pirouettes so that nobody, not even the Parkour Posse could catch him. Between vicious street dance-offs, Aaron taught himself to program. He learned to combine the art of street ballet with the craft of software engineering. Using these unique skills, he was able to leave his life on the streets and become a professional software engineer. He is currently Pirouetting through Processes, and Couruing through code for AT&amp;T. Sometimes he thinks back fondly on his life in the Tender Tights, but then he remembers that it is better to have Tender Loved and Lost than to never have Tender Taught at all.


