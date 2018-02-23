---
layout: post
title: Ruby 2.0.0： Release Progress
short_title: Ruby 2.0.0： Release Progress
tags: Ruby200SpecialEn release
---
{% include base.html %}


Author: Yusuke Endoh ([@mametter](https://twitter.com/mametter)), Translator: Shota Fukumori ([sorah.jp](http://sorah.jp/))

## Introduction

Hi, I'm Yusuke Endoh. I think this is the first time I have written an article for Rubyist Magazine.

We are happy to be able to release Ruby 2.0.0.

I'm the release manager for 2.0, but a lot of the work was done by many other committers. So, actually I'm the release announcement writer.

This article describes the brief story of the release. This is based on my memory, so apologies for any errors.

## Summer 2010: Publicly mentioned for the first time

As I remember, 2.0 was first publicly mentioned at the [developer meeting in RubyKaigi 2010](http://bugs.ruby-lang.org/projects/ruby/wiki/DevelopersMeeting20100827).

Not much time had passed since the 1.9.3 release. We only talked about classbox and keyword arguments for 2.0, and there wasn't much discussion.

I should mention specifically that Matz defined 2.0 as 100% compatible with 1.9. Imagine if this hadn't been the case - we would have been sidetracked with discussion of new features and 2.0 would not have been released for another 10 years at least.

The year following RubyKaigi 2010 was spent on 1.9.3 development, so no decisions about 2.0 were made during that year.

## Fall 2011: Kick off

At the beginning of October 2011, before the 1.9.3 release, Koichi Sasada suggested starting discussion of the 2.0 specification. ([[ruby-core:39824]](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-core/39824)) [^1]
I proposed that we distinguish between dreams and requirements ([[ruby-core:39836]](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-core/39836)). Matz said that refinements and keyword arguments were requirements for Ruby 2.0.

10/18/2011 was a significant day. I'd implemented the keyword arguments feature experimentally and asked for approval to commit to trunk [^2]. ([[ruby-dev:44602]](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/44602))
This feature is not so significant, but it does include a syntax change. We had to separate the 1.9 branch and trunk to commit this.
On the same day, Yui Naruse proposed to change the version number in trunk to 2.0.0. ([[ruby-dev:44604]](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/44604))

These proposals triggered a lot of progress and ended up with Matz committing a change to the version number from 1.9.4 to 2.0.0 at ([r33483](http://svn.ruby-lang.org/cgi-bin/viewvc.cgi?revision=33483&view=revision)). 

> * version.h (RUBY_RELEASE_DATE): finally declare start of 2.0 work!


During this busy time, I was approved as release manager of 2.0. ([[ruby-dev:44672]](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/44672))
Quoting a message from Matz:

> Hi,
> 
> Ruby 2.0 doesn't need a release manager yet, but I don't have any reason to disagree with mame's candidacy. Go ahead.
> 
> Developing new features is more important, isn't it?


Following this, I announced the release schedule: ([[ruby-dev:44691]](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/44691)).

* 08/24/2012: big feature freeze
* 10/24/2012: feature freeze
* 02/24/2013: 2.0.0 release (Ruby's 20th birthday)


Finally we started 2.0.0 development. People seem to not work until a deadline approaches and nothing much happened for the next 6 months. [^3]
I didn't see any problems with setting deadlines loosely. This lesson will take effect later.

## Spring and Summer 2012: Reviewing feature requests
: ![dm1.jpg]({{site.baseurl}}/images/Ruby200SpecialEn-release/dm1.jpg)
: ![dm2.jpg]({{site.baseurl}}/images/Ruby200SpecialEn-release/dm2.jpg)

As the deadline approached I organized an offline meeting to discuss feature requests for 2.0.0. ([[ruby-dev:45708]](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/45708))
I requested an 1 page slide to introduce each feature request and we discussed the feature requests as we viewed the slides.

On July 21, 2012 we spent 5 minutes looking at each request with Matz and marked them as approved, rejected or pending with a comment. (Thank you to @hsbt and his company; paperboy&amp;co., Inc for providing us with a place to meet.)

The following are some of the features which were approved at this meeting:

* Make const_get("Foo::Bar") work [[#5690]](http://bugs.ruby-lang.org/issues/5690)
* % literal for array of symbols: %i(foo bar baz) [[#4985]](http://bugs.ruby-lang.org/issues/4985)
* Make UTF-8 the default encoding for ruby scripts [[#6679]](http://bugs.ruby-lang.org/issues/6679)
* New method Kernel#__dir__ returns the directory path of the source code [[#3346]](http://bugs.ruby-lang.org/issues/3346)
* Return an Array instead of an Enumerator from #chars, #lines etc. [[#6670]](http://bugs.ruby-lang.org/issues/6670)


I praised myself that the meeting was a success, but the preparation and cleanup took up so much of my time that I was burned out for a while after.

I was also busy with preparation for a talk at the [Summer Programming Symposium 2012](http://spro2012.prosym.jp/) and [IOCCC](http://d.hatena.ne.jp/ku-ma-me/20120930/p1).

Due to the reasons above, I regret that I could not take any action for the August deadlines for new feature proposals.
I guess this is the problem with volunteer-based development.

I started to write a [weekly release management report](http://d.hatena.ne.jp/ku-ma-me/20120521/p1) (in Japanese), but this lasted for only 3 weeks.

## Fall 2012 .. and now: the feature-request deadline, releasing previews and RCs

This was not good, so I pushed myself to move things forward. So suddenly, on October 24th, I declared the end of new feature proposals. This was originally supposed to happen in August. It was a brutal declaration!! However, this decision was made under the assumption that extending things further would not improve the result massively, because nothing happened for almost 6 months after I originally decided the schedule. Sure, I know it's just an excuse.

Next I released the 2.0.0-preview1 package from trunk on Nov 11, 2012. ([[ruby-dev:46348]](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/46348)).
I also announced a detailed release schedule at the same time:

* Beginning of Dec 2012: 2.0.0-preview2
* Around Christmas: code freeze
* Beginning of 2013: 2.0.0-rc1
* Beginning of Feb 2013: 2.0.0-rc2
* 2/24: 2.0.0-p0


There's a critical problem in this plan. Can you spot the problem?

The answer is: there's only 1 week between the code freeze and the rc1 release.

Of course new features wouldn't be stable instantly, and there would be no time to process bug tickets.

... Actually, rc1 didn't have the quality of a release candidate so I continued to allow normal bug fixes. This is something I regret.

Also I couldn't look at bug tickets around the rc1 release due to another engagement at the same time (see below).
This work was done by many another people. Thank you guys. (Koichi, drbrain, yhara - thank you for your hard work).

Finally, I have so many regrets, but I worked to keep things going. So my major contribution for 2.0 was writing release announcements. Sorry...

## The Future of 2.0

### Maintenance plan of 2.0.0

I'm not good at doing precise work continuously. So, I recommended @nagachika as a 2.0.0 maintainer, and I've got consent.

@nagachika is writing a diary [ruby-trunk-changes](http://d.hatena.ne.jp/nagachika/) (in Japanese) that describes all the commits in Ruby trunk for many years.

His consistent commitment is among the best of all committers.

### Next for 2.0.0?

We are aiming to release 2.1.0 around Christmas of this year.[^4]

This decision has been made very recently (Feb 15, 2013), and nothing concrete has been decided yet.
The following are my expectations:

First, refinements are still experimental. I guess this will be improved by real use cases in 2.0.0.
Next, the API for debuggers will be enhanced (TracePoint for instance).
Finally, many new features introduced in 2.0.0 will be brushed up by real use cases in 2.0.0.

If there are no objections, I would like to continue release management of 2.0. But I'll hand it over if anyone has any issues with this.

## Finally

It's hard to reflect on the Ruby 2.0.0 release at this point, because the release was not finished at the time of writing this article.

It's worrying because of the rubygems.org cracking incident and the recent Rails vulnerability reports. I wish I could have written this article after the release.

Anyway, I believe you're seeing this article on Feb 24.

Thank you to all people who put up with my release management and contributed to the release of Ruby 2.0.0.

## One more thing....

You may wonder what distracted me from concentrating on release management. Apart from my day job, I spent my time translating a book.

I was translating Benjamin C. Pierce's ["Types and Programming Languages"](http://www.cis.upenn.edu/~bcpierce/tapl/) (TAPL).
This book is used as the textbook of "types" in programming languages. "types" are... yes, they don't exist in Ruby.

The book is going to be published from [Ohmsha](http://www.ohmsha.co.jp/kaihatsu/archive/2013/01/17112000.html) in March.

You can't talk about why Ruby's dynamic typing is good without reading this book.

## About the author

Yusuke Endoh is a Ruby committer (account name: mame). Bump test coverage of Ruby, assisting with 1.9.2 release manager, and doing 2.0.0 release management.
He is also presenting [Esoteric Obfuscated Programming](http://www.slideshare.net/mametter/ruby-2012).

----

[^1]: Note from Koichi: I've posted a questionnaire about the 2.0 specification for RubyConf2011 before: [[ruby-core:39810]]
[^2]: Repository of the latest development version
[^3]: Note from Koichi: This isn't a big deal, but we had several offline meetings (3/11, 3,18, 3/28 and 7/14) to discuss detailed specifications. We had to discuss many detailed specs, I guess that was the first time we worked with any intensity.
[^4]: At the developers meeting on 02/23/2013, I decided to withdraw this. We agreed that we should specify features to be included in 2.1.0 before scheduling a release.
