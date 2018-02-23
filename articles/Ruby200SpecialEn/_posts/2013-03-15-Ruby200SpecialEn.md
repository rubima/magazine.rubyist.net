---
layout: post
title: Ruby 2.0.0 Release special articles
short_title: 2.0.0 Special (EN)
tags: Ruby200SpecialEn index
---
{% include base.html %}


* Table of content
{:toc}


Editor: ko1

## About Ruby 2.0.0 Release special articles

Ruby 2.0.0 was released at 2/24/2013 ([Ruby 2.0.0-p0 is released](http://www.ruby-lang.org/ja/news/2013/02/24/ruby-2-0-0-p0-is-released/)). Please check the official news for basic information such as how to download the source code.

Here's a highlight of the new features quoted from the news:

* Language core features
  * Keyword arguments, which give flexibility to API design
  * Module#prepend, which is a new way to extend a class
  * A literal %i, which creates an array of symbols easily
  * __dir__, which returns the dirname of the file currently being executed
  * The UTF-8 default encoding, which make many magic comments omissible
* Built-in libraries
  * Enumerable#lazy and Enumerator::Lazy, for (possibly infinite) lazy stream
  * Enumerator#size and Range#size, for lazy size evaluation
  * #to_h, which is a new convention for conversion to Hash
  * Onigmo, which is a new regexp engine (a fork of Oniguruma)
  * Asynchronous exception handling API
* Debug support
  * DTrace support, which enables run-time diagnosis in production
  * TracePoint, which is an improved tracing API
* Performance improvements
  * GC optimization by bitmap marking
  * Kernel#require optimization which makes Rails startup very fast
  * VM optimization such as method dispatch
  * Float operation optimization


Because there isn’t a lot of information about these new features and performance improvements, we’ve asked the Ruby core developers to write introductory articles for each one.

* [Ruby200SpecialEn-release](Ruby200SpecialEn-release) summarises a development progress of Ruby 2.0.0. Written by Yusuke Endo, the release manager of Ruby 2.0.0.
* [Ruby200SpecialEn-kwarg](Ruby200SpecialEn-kwarg) introduces the new keyword arguments syntax for methods. Written by Yusuke Endo.
* [Ruby200SpecialEn-lazy](Ruby200SpecialEn-lazy) introduces lazy enumerators and enumerables. Written by Yu Hara.
* [Ruby200SpecialEn-refinement](Ruby200SpecialEn-refinement) discusses  the new ‘refinements’ and the controversy surrounding them, written by Shugo Maeda.
* [Ruby200SpecialEn-dtrace](Ruby200SpecialEn-dtrace) introduces Ruby's DTrace support. Written by Aaron Patterson.
* [Ruby200SpecialEn-gc](Ruby200SpecialEn-gc) summarises GC performance improvements on Ruby 2.0.0. Written by nari.
* [Ruby200SpecialEn-require](Ruby200SpecialEn-require) summarises the performance improvements for ‘require’. Writen by Masaya TARUI.
* [Ruby200SpecialEn-note](Ruby200SpecialEn-note) goes into detail about compatibility issues as well as other features.


Moreover, [Ruby200SpecialEn-193](Ruby200SpecialEn-193) explains the stable release and maintenance policies for Ruby 2.0.0 and 1.9.3 by usa, the release manager for Ruby 1.9.3.

## Messages from Rubyists

We gathered messages from famous Rubyists, including Matz, the father of Ruby.

### Message from Matz

Author: Yukihiro Matsumoto([@yukihiro_matz](https://twitter.com/yukihiro_matz/)), Translator: Tatsuya Ono ([@ono](https://twitter.com/ono))

I have hesitated to rapidly increase Ruby’s version number for 20 years. Although I have seen some software - such as Solaris - increment its version number for some sort of marketing reason, I believe that open source projects should not conform to any marketing strategies. It has been my honest opinion that the version number is just like an ornament, and high profile people do not understand that.

Having said that, It has been ten years since I first hinted at Ruby 2.0. Like dangling a carrot in front of a horse, I thought it would cheer up the core team developers.

Around 2011, some of the features I’ve wanted to implement for over ten years had already been proposed by some community members, such as Refinements and Module#prepend. I felt like my unfulfilled dream was getting close to coming true.

I finally decided to release Ruby 2.0 when I was told, “Ruby turns 20 years old in 2013. It’s a perfect timing to release Ruby 2.0.” I’m afraid I don’t remember who said that, but I was no longer able to resist incrementing the major version number.

The updates in Ruby 2.0 are in a variety of places (which will be explained throughout this issue), however our basic principle remains: we want to provide a good programming language, while staying backwards compatible.

Keyword arguments will help you create and use elaborate APIs in a cleaner way. Module#prepend and Refinements will help you tackle the complexity of extending classes. 

They are intended to prepare large scale and more elaborate software development projects.

In addition, looking at improvements on GC and debug tools such as DTrace and TracePoint,
Ruby 2.0 anticipates the environment around Ruby development in future and tries to evolve in order to cope with it.

We in Ruby community have put big effort night and day to keep Ruby to be a useful language that people love.
We will continue the work after Ruby 2.0 is released.

Please keep watching Ruby tenderly if possible.
I would also suggest you to join a Ruby community when you feel like it.
You can start with a local meetup or mailing list linked with Ruby.
We always welcome you.

### Ruby 2.0 on Rails

Author: Akira Matsuda ([@a_matsuda](https://twitter.com/a_matsuda)),  Translator: Tatsuya Ono ([@ono](https://twitter.com/ono))

You may be concerned about the compatibility between Ruby 2.0 and Ruby on Rails, particularly if you work with the framework. It’s understandable because you can’t update Ruby in production until the framework offers support for it.

You don’t have to worry, however. Jeremy Kemper explained in his talk at RubyWorld Conference 2009, Matsue, that the Rails core team offers full support for Ruby as it evolves (I definitely recommend you watch [that talk](http://2009.rubyworld-conf.org/ja/program/abstract/a-5/), it’s awfully good). Ruby 2.0 has been declared the ‘preferred’ version in Rails 4.0 ([https://github.com/rails/rails/commit/a0380e8)](https://github.com/rails/rails/commit/a0380e8))

Of course, it’s not just a declaration. Rails is built and tested against Ruby 2.0 on [Travis CI](https://travis-ci.org/rails/rails) after every commit. If you’ve found an issue when using Ruby 2.0 with Rails, please report that [here](https://github.com/rails/rails/issues).

WIth new attractive features, better performance, 100% backwards compatibility, and the support of the Rails core team, there is no reason not to use Ruby 2.0 in your next Rails project.

### Change something silently

Author: id:secondlife ([@hotchpotch](https://twitter.com/hotchpotch)), Translator: Shota Fukumori ([sorah.jp](http://sorah.jp/))

Recently I worked on a system with a tremendous amount of users. I tried to change the backend system drastically without users noticing it.
The users were sometimes the users of the site, and other times developers.

Once you've tried, you realise how hard it is to change the environment as if nothing has happened.

How can we change the environment while also keeping the changes as inconspicuous as possible?

There are many opportunities to change the back-end, and many advantages to doing so, but it should cause as little inconvenience as possible to the end users.

Okay, let's get back to talk about Ruby 2.0. Ruby 2.0 includes variety of changes, from new features to performance improvements. For instance, Refinements enable you to implement flexible DSLs but may become a source of black magic. Keyword arguments are something people have waited for for a long time. I think Ruby took a big step toward by 2.0.

The biggest surprise for me is the fact that Ruby 2.0 has changed the environment without much disruption. I've been using Ruby 2.0 HEAD since late 2012. There's no problem to migrate from 1.9.3, and most of the specs in my company's projects passed (and 20-80% faster!). Some projects in my company have already been running stably in Ruby 2.0 HEAD.
Ruby 2.0's slogan - "100% compatibility" - is true, really.

Ruby 2.0 can change your environment silently. I love it, and please try it on your project.

Thank you to the developers involved in making Ruby 2.0 happen. A lot of hard work was put in to maintain compatibility.

### Message from Dave Thomas

Author: Dave Thomas

#### Message

I've known Ruby since she was just 4 or 5 years old. Of course, I knew her parents, Smalltalk and Perl, and had a nodding acquaintance with Aunt Clu, so I knew she was in good hands. I watched with pleasure as she took her first tentative steps into the wide world. Even as a young language, she captured the hearts of some wonderful people―I think it was her relaxed and happy nature.

Of course, when she became a teenager, she had a few rough times. She got involved with some strange friends, but her character and strength means that she simply developed into a deeper and more confident language.

Now, at 20, Ruby shows fantastic maturity and composure. She is loved by hundreds of thousands of people, and she makes their lives better.

I'm looking forward to watching her continue to grow over the next 20 years. 

Happy birthday.

#### Favorite Feature

Obviously, the new keyword arguments are very cool. But when I was playing with them, I came across an implementation detail that just made me smile like a fool:

{% highlight text %}
{% raw %}
   APP_OPTS     = { name: 'play', author: 'dave' }
   LOG_OPTS     = { level: 2, color: 'blue', line: "3pt" }

   def log(msg, options)
     p msg
     p options
   end

   log("Starting", **APP_OPTS)
   log("Connected", **APP_OPTS, **LOG_OPTS)
   log("Giving up", **APP_OPTS, **LOG_OPTS, color: "VERY RED")
{% endraw %}
{% endhighlight %}


produces:

{% highlight text %}
{% raw %}
   "Starting"
   {:name=>"play", :author=>"dave"}
   "Connected"
   {:name=>"play", :author=>"dave", :level=>2, :color=>"blue", :line=>"3pt"}
   "Giving up"
   {:name=>"play", :author=>"dave", :level=>2, :color=>"VERY RED", :line=>"3pt"}
{% endraw %}
{% endhighlight %}


The **arg converts the hash into the equivalent of the individual options (in the same way that a single star expands an array into individual parameters. And then Ruby collects all these values into the hash that it eventually passes to the method.

It's this kind of attention to small details that makes Ruby such a fun language―there's always something to discover.

### Message from Charles Oliver Nutter

Author: Charles Oliver Nutter

Congratulations to the MRI team on releasing 2.0! We are looking forward to implementing Ruby 2.0 features like keyword arguments in upcoming releases of JRuby, and I'm personally excited to see where we can take Ruby in the post-2.0 era. I've also seen solid improvements in performance and GC overhead while playing with the release candidates. Great job!

### Message from Thomas E Enebo

Author: Thomas E Enebo

I have been very excited to see Ruby 2.0.0 released.  This release has
been the dream of many Ruby programmers for quite some time.  As for
Ruby 2 features, I expect keyword arguments will have the largest
impact on how people change their APIs; so I predict it will have the
largest visible impact in how we think in terms of writing Ruby code.

I am also excited to see how features like refinements and
Module#prepend get used in unexpected ways.  Unexpected uses often end
up being responsible for game-changing idioms and I am hoping these
features deliver something amazing.

## Finally

Happy Hacking with Ruby 2.0.0!!

----


