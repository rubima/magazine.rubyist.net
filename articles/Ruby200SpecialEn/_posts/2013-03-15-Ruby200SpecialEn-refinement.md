---
layout: post
title: Ruby 2.0.0： refinement
short_title: Ruby 2.0.0： refinement
tags: Ruby200SpecialEn refinement
---


Author: Shugo Maeda([@shugomaeda](https://twitter.com/shugomaeda))
Translator: Makoto Inoue([@makoto_inoue](https://twitter.com/makoto_inoue))

## Introduction

In this article, I will talk about Refinements which were supposed to be officially included as part of Ruby 2.0

## What are Refinements ?

Ruby has a feature to extend a class by redefining it. It's called an "open class" or "monkey patching".
It's widely used in Rails, but overusing it may cause unexpected problems.

For example, requiring "mathn" that comes as part of standard library globally changes the behaviour of Fixnum#/

{% highlight text %}
{% raw %}
p 1 / 2 #=> 0
require "mathn"
p 1 / 2 #=> (1/2)
{% endraw %}
{% endhighlight %}


Refinements are intended to restrict the impact of monkey patching to a certain scope, and I proposed it.

Module#refine extends the class that is passed in as an argument

{% highlight text %}
{% raw %}
# rationalize.rb
module Rationalize
  refine Fixnum do
    def /(other)
      quo(other)
    end
  end
end
{% endraw %}
{% endhighlight %}


Inside the refine block, "self" is set to an anonymous module called refinement, and you can add methods to the anonymous module.

The following is how you use it.

{% highlight text %}
{% raw %}
using Rationalize
p 1 / 2 #=> (1/2)
{% endraw %}
{% endhighlight %}


This extension is only useful within the file; it does not affect other files.

## The specification of Refinements

The specification of Refinements is described in the Wiki

* [Refinements Specification](https://bugs.ruby-lang.org/projects/ruby-trunk/wiki/RefinementsSpec)


It may contain some bugs as I haven't received much feedback.

## So what happened in the end?

Refinements were supposed to be the big features in Ruby 2.0.
However, they ended up as an experimental feature after stripping away a lot of functionality. (At one point, I suggested we remove the feature completely.)

Specifying "refine" or "using" will display a warning because they are still experimental features.

{% highlight text %}
{% raw %}
$ ruby -e 'module M; refine String do end; end'
-e:1: warning: Refinements are experimental, and their behaviour may change in future versions of Ruby!
{% endraw %}
{% endhighlight %}


Please use them at your own risk (Don't complain to me if the feature changes in future).

## The deleted functionalities

As mentioned earlier, much functionality has been removed since the initial proposal.

Here is a list of the deletions:

* Enabling refinement per module
* Inheriting a module that is extended with "using"
* Extending a module (not a class) with "refine"
* Calling "super" in order among multiple classes extended with refinement
* Enabling refinement in module_eval and instance_eval


The removal of the last feature has the biggest impact, since it is not as easy to use refinements in an internal DSL.

If we had this functionality, we might have had a feature [activerecord-refinements](https://github.com/amatsuda/activerecord-refinements) that was implemented by Akira Matsuda.

{% highlight text %}
{% raw %}
User.where { :name == 'matz' }
{% endraw %}
{% endhighlight %}


The above code would let you change the behaviour of an instance of the existing class (Symbol in this case) only within the block.

I was very disappointed because I was thinking about the following library using these features.

{% highlight text %}
{% raw %}
require "sexy_regexp"
re = SexyRegexp.new { ("foo" | "bar") + (?0..?9).one_or_more }
p re.is_a?(Regexp) #=> true
p re.source #=> "(foo|bar)[0-9]+"
{% endraw %}
{% endhighlight %}


(Did you just say you were glad that this functionality was removed???)

If you read the specification in detail, you may have spotted that you can do similar things at the string level (not in the block level) by doing

eval("using M; #{s}", TOPLEVEL_BINDING)

However, this is not good enough because you cannot pass in local variables.

## So why were they removed?

We've received the following criticism when introducing Refinements

* 1. Too complex
* 2. The specification is not clear
  * No documentation
  * No spec in RubySpec
* 3.  It's hard to implement effectively in JRuby
* 4. Mine is better than yours


Regarding 1, it's the nature of refinements

Regarding 2, I created the Wiki page I mentioned earlier. I also added some specs to RubySpec, though they may not have been sufficient (In fact, it was harder to add Ruby 2.0 changes in RubySpec)

Regarding 3, 'module_eval' does play nicely with JRuby's inline caching. I won't go into detail on this for now.

Regarding 4, I'm sure there are many opinions.

I remember that there were other arguments. In the end, these arguments happened right before the release and therefore we didn't have time to address all the issues.

## Finally

I have so far proposed "continuation" and "protected" (I'm sure I've made other useful proposals, but can't remember all of them.)

I wonder if Refinements will be "never two without three" or "third time lucky".

I am passionate about proposing interesting yet odd features. Stay tuned for my next proposal.

## About the author

### Shugo Maeda

A programmer born in 1975. My favourite music album is "Now and Then" (the cover of "Give Me the Night" is cool) released in 30th Jan by Cloudberry Jam and "Lua no Ceu Congadeiro" by Yuri Popoff

URL: [http://shugo.net](http://shugo.net)


