---
layout: post
title: Ruby 2.0.0： require improvements
short_title: Ruby 2.0.0： require improvements
tags: Ruby200SpecialEn require
---
{% include base.html %}


Author: Masaya TARUI, Translator: Tatsuya Ono ([@ono](https://twitter.com/ono))

## It's got faster.

Among bunch of new features and improvements, we have also improved the performance of require.

The number of libraries Rubygems distributes has been increased tremendously.
Sometimes you can get your programming work done only with writing little code by yourself.
Typical Ruby on Rails applications also depend on a lot of gem libraries these days.
Especially when you build a large Rails application, the loading time of gem libraries has been the one of most frustrating things to developers.

As a trade-off for adding some features, the file loading speed of require in Ruby 1.9 had got slower than Ruby 1.8.
Although we have been improving it in Ruby 1.9 upgrade, we also have succeeded to make it even faster in Ruby 2.0 with a few changes in the specification.
Please see the benchmark below (I took benchmarks several times and chose the best results):

{% highlight text %}
{% raw %}
files=2000
begin
    files.times{|i|
        file = "req/file#{i}.rb"
        open(file,"wb"){}
    }
rescue
end
100.times{ $LOAD_PATH << "/" } # emulates gem
$LOAD_PATH << "."
start = Time.now
cnt=0
files.times{|j|
    file = "req/file#{j}.rb"
    require file
    cnt +=1
    puts "#{cnt}, #{Time.now - start}" if cnt % 100 == 0
}
{% endraw %}
{% endhighlight %}


![require_bench_linux.png]({{site.baseurl}}/images/Ruby200SpecialEn-require/require_bench_linux.png)
![require_bench_win.png]({{site.baseurl}}/images/Ruby200SpecialEn-require/require_bench_win.png)

Since I have been putting a quite effort on opptimizing the performance, I am still bit annoyed with the fact 1.8.7 is the fastest ever.
However you can see it is getting closer to 1.8.7 and most of you would not notice the difference when you develop an application.

## Changes

I said "with a few changes in the specification" above.
Although I think most of you don't care, I am explaining about these changes anyway.

1. Ruby 2.0 does _freeze_ String objects in $LOAD_PATH
1. Ruby 2.0 does _freeze_ String objects in $LOADED_FEATURES
1. Ruby 2.0 doesn't call _to_path_ method for String objects in $LOAD_PATH


Regarding the number 1, Ruby 2.0 _freeze_ String object when _require_ is called. We think that it would not hurt you because String object doesn't have so many methods changing the contents.
If you are eccentric enough to try to manipulate some objects in $LOAD_PATH... please regret that.

Sample code:

{% highlight text %}
{% raw %}
$LOAD_PATH << "/hoge"
require 'hoga'
$LOAD_PATH[-1] << "/fuga"
 => Ruby 1.9: "/hoge" is changed to "/hoge/fuga" in the load path
 => Ruby 2.0: TypeError(can't modify frozen string) will be raised
{% endraw %}
{% endhighlight %}


About the second point, $LOADED_FEATURES is an array that is used to indentify the file required.
Ruby 2.0 does _freeze_ String objects in $LOADED_FEATURES like $LOAD_PATH.

Lastly about the third point, you probably even did not know this: if an object in $LOAD_PATH has _to_path_ method, Ruby would call the method and use its return value as the path.
Obviously it is just a needless step for any String objects in $LOAD_PATH.
Therefore Ruby 2.0 does not call _to_path_ method for the String objects anymore.

Sample code:

{% highlight text %}
{% raw %}
path = "/foo"
class << path
  def to_path
    self + $MAGIC
  end
end
$LOAD_PATH << path
$MAGIC = "/bar"
 => Ruby 1.9: the load path is changed to "/foo/bar"
 => Ruby 2.0: "/foo" is still the load path
{% endraw %}
{% endhighlight %}


Main reason behind those changes is to cache file paths in order to speed it up. _freeze_ can ensure that the value is not changed.
However, since you can change the return value of _to_path_ method without changing contents, we had to stop calling it for String objects in order to guarantee the file path is not changed.

You can still add non-String objects to $LOAD_PATH. In this case, Ruby 2.0 still calls _to_path_ for the objects but you won't get any benefit from the performance improvement.
I don't recommend it[^1].

In addition, you can find very interesting gimmick in the implementation of the logic detecting the changes on $LOAD_PATH and $LOADED_FEATURES.
It uses share flag of the array inside $LOAD_PATH and $LOADED_FEATURES.
Check out [https://bugs.ruby-lang.org/issues/7158](https://bugs.ruby-lang.org/issues/7158) for the details if you are interested.

## The last message

Have a fast Ruby life with Ruby 2.0!

## About the author

Masaya TARUI

"No Tool, No Life. How wonderful civilization is. Let's civilize!"

I am living in IRB on Windoes and pretty mad at the speed.
Imagine a tool is improved, gets 1 second faster and a thousand people use it a thousand times: it can save a million seconds.
That sounds amazing, doesn't it?

----

[^1]: I don't know how many people have tried that :-)
