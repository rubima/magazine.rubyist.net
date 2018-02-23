---
layout: post
title: Ruby 2.0.0： GC improvements
short_title: Ruby 2.0.0： GC improvements
tags: Ruby200SpecialEn gc
---
{% include base.html %}


Author: nari ([@nari3](https://twitter.com/nari3)) 
Translator: Makoto ([@makoto_inoue](https://twitter.com/makoto_inoue)) 

## Introduction

Congratulations on the release of Ruby 2.0.0!!

In this post, I will introduce the improvements to GC in Ruby 2.0.0.
Please bear in mind that this article only covers CRuby, the C implementation of Ruby.

## Bitmap Marking

Ruby 2.0 has a new GC feature called Bitmap Marking.
In short, Bitmap marking works very well with Copy on Write (CoW) which is used in fork(2).
The following articles cover this in more detail.

* [Feature #5839: Proposal: Bitmap Marking GC(in Japanese)](https://bugs.ruby-lang.org/issues/5839)
* [Improving memory usage using Ruby Bitmap Marking (in Japanese)](http://d.hatena.ne.jp/authorNari/20120203/1328269573)
* [Why You Should Be Excited About Garbage Collection in Ruby 2.0](http://patshaughnessy.net/2012/3/23/why-you-should-be-excited-about-garbage-collection-in-ruby-2-0)


If you use fork(2) without Bitmap Marking, memory usage may dramatically increase because GC may run several times.
You may have cursed GC for this. Sorry about that.

Bitmap Marking is enabled in the Windows environment to avoid unnecessary complexity, even though there is no fork(2) in this environment and therefore no benefit to using Bitmap Marking.

Bitmap Marking was first introduced in [Ruby Enterprise Edition (REE) ](http://www.rubyenterpriseedition.com/) 

In Ruby 2.0.0 there is Bitmap Marking equivalent to that in REE or even better.

If you have only chosen REE in order to use Bitmap Marking, I would urge you to install Ruby 2.0.0 and start migration work.
BTW, REE hasn't been updated since February 2012, and its official blog already 
[announced the end of life](http://blog.phusion.nl/2012/02/21/ruby-enterprise-edition-1-8-7-2012-02-released-end-of-life-imminent/)

RIP REE.

## Recursive marking.

In previous versions of Ruby, the object graph is traversed and marked by using a recursive function call on the machine stack.
This may lead to stack overflow when a very deep object graph is traversed.
To avoid this, previous versions of Ruby GC stop using the machine stack when a stack overflow is about to happen.

However, this leads to two additional problems:

1. Marking becomes extremely slow when there are deeply referenced objects.
1. The quality of detecting a stack overflow is not accurate.


For the former case, the worst case scenario is very slow because not using the machine stack means you need to search for everything in the heap. In addition, GC will be slow as long as these deeply referenced objects exist.

For the latter, it is very difficult to accurately check stack overflow in time, and sometimes this causes SEGV.
In the worst case scenario, [Fiber fails in the unexpected timing](http://bugs.ruby-lang.org/issues/3781).

To solve these issues, Ruby 2.0.0 has its own Array based stack and marks without using recursive calls.
In this way, it won't waste machine stack, won't cause overflow, and therefore doesn't need fall back functionality used in the former case. It also doesn't need the check sequence used in the latter.

[The benchmark result shows that performance is slightly improved.](https://gist.github.com/3806667)
This is probably due to the decrease in the number of function calls.

Please refer to these if you are interested in more detail.

* [Good Bye Mr. Knuth - GC in CRuby (in Japanese)](http://d.hatena.ne.jp/authorNari/20121006/1349499801)
* [Feature #7095: Non-recursive marking(in Japanese)](https://bugs.ruby-lang.org/issues/7095)


## Summary

I have introduced the key improvements to GC in Ruby 2.0.0. I hope it was useful information.

Finally, I will introduce some other interesting topics with regards to GC.

Koichi (Sasada) has an idea about Generational Garbage Collection, so we need to keep an eye on it.
Koichi also [started working on Symbol GC](http://www.atdot.net/~ko1/diary/201212.html#d25)
because of recurring Symbol related vulnerability issues (For example  [Rack vulnerability](https://bugzilla.redhat.com/show_bug.cgi?id=895384)）.

I am also thinking about extending TracePoint.trace  (Introduced in Ruby 2.0.0) by adding extra arguments such as :obj_alloc and :obj_free.
This will be very useful for debugging, so I will add them when I have time.

## About the author

nari
GC nerd.
I want to own a Roomba, but there is too much clutter in my room, so I'm not ready to buy one.

URL: [http://www.narihiro.info/](http://www.narihiro.info/), Twitter: [@nari3](https://twitter.com/nari3)


