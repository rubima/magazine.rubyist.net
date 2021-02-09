---
layout: post
title: Introducing ruby-dev Translation
short_title: Introducing ruby-dev Translation
created_on: 2011-11-28
tags: 0036 ruby
---
{% include base.html %}


Author: yhara (Network Applied Communication Laboratory)

Translator: @cwgem (Engine Yard)

* Table of content
{:toc}


## Introduction

ruby-dev translation ([http://ruby-dev.info](http://ruby-dev.info)) is a web site personally maintained by the author to assist with the translation of the developer oriented Ruby implementation mailing list "ruby-dev" into English, and in doing so help break the language barrier.

This article is meant to serve as an overview of ruby-dev translation, possible issues, and what lies ahead for the project.

## What is ruby-dev?

First we'll take a look at what ruby-dev itself is. There are many [official Ruby mailing lists](http://www.ruby-lang.org/ja/community/mailing-lists/), but the four lists below are the most frequently utilized:

|           | English| Japanese|
| User Oriented| ruby-talk| ruby-list|
| Developer Oriented| ruby-core| ruby-dev|


ruby-dev is a mailing list for "CRuby[^1] developers to participate in discussions in the Japanese language."

Ruby is a programming language that has gained worldwide adoption, but the number of Japanese CRuby developers is [considerably high](http://rubycommitters.org/).

The main reason for splitting up the developer oriented mailing lists into English and Japanese was so that the Japanese developers could participate in discussions with ease. On the other hand, developers unable to comprehend Japanese might see the list as a place where extremely useful information is being presented which they are unable to access. It could also be perceived as a place where "secret talks" occur.

* [Held at RubyKaigi, the theme was "Conflict and Resolution" − ＠IT](http://www.atmarkit.co.jp/news/201009/13/rubykaigi.html)


With this in mind, the ruby-dev translation project is meant to resolve issues regarding the language barrier, that is to say, the separation of Japanese and English communication.

## ruby-dev translation features

Now then I'll introduce the (present) features of ruby-dev translation. The top page can be found here.

* [http://ruby-dev.info/](http://ruby-dev.info/) [^2]


### Browsing messages

ruby-dev sorts messages from newest to oldest. Messages in the same topic are displayed in expanded thread format on the same page. 

Messages can also be searched via keyword, and clicking on an author's name will display a list of emails they have written.

### Submitting translations

Click the "Sign in with Twitter" link in the upper right to login. Once logged in, you will be able to submit translations for specific messages. Existing translations by other users can also be edited.

In the event that translating the entire message body is too much, just the title alone can be translated. When logged in, you will find an "(edit)" link next to message titles which are only provided in Japanese, when present on the [Recent Posts](http://ruby-dev.info/posts) page.

### Translation request

When reading the message listing while logged in, a star mark "☆" is displayed next to each message. This mark is meant to indicate that a user wishes a message to be translated. The idea is that it will be used by non-Japanese speakers to indicate which messages are deemed important to them.

A listing of marked messages can be accessed from the menu
([Ordered By Date|](http://ruby-dev.info/posts?view=recent_requested) / [Ordered By Popularity](http://ruby-dev.info/posts?view=top_requested)).

## Issues

Now then, some of you may have realized that there are not many starred messages in the previously noted links. Unfortunately I can't say that ruby-dev translation could be considered a highly active project at its current state. I've thought of a few reasons for this. 

### It's difficult/bothersome for non-Japanese speakers to find interesting messages

Messages with the title translated are quite numerous, but the body itself is, with the exception of English words, often written with lots of kanji and hiragana. For English speakers, finding messages that they wish to read can be quite a laborious task.

On the other hand there is the possibility that there are message they will read if translated, but searching through them all can be quite troublesome.

### Reader barrier of entry

Topics on ruby-dev tend to be highly technical content related to the Ruby interpreter, and as such might prove problematic for those who are more interested in Rails and other forms of application development.

### Not enough advertising

At the moment ruby-dev translation has been advertised a bit on Twitter and ruby-talk/ruby-core, so submissions to sites such as [rubyflow](http://www.rubyflow.com/) is all that remains. This article happens to be one such advertising method. :-)

## What now?

### The original plan

To continue translation work, some feedback is necessary. It is difficult to be motivated to translate when there is a lack of response. The following design points were considered before going live with the site.

"Translation Requested" Mark
:  This makes it apparent that one's translations are important to others. The hope is that even if translators are few in numbers, this will make it easy to distribute the work.

Translation Editing
: Corrections by native speakers are useful in study of English for those doing translations (of course the task of translation itself is also useful).

### Making translation fun

It would be great if the above model was materialized, but there remains a large problem. With this model, there needs to be an increase of readers and translators for everything to work as planned. However, for translations to occur readers are necessary, and for readers to gather translations are necessary. Herein lies a chicken and the egg problem.

In order to bootstrap this properly, either a system attracting only readers, or a system attracting only translators is necessary. Readers gathering without translations is highly unlikely, so the later method is most suitable. 

Proceeding with translations on a site without readers is a deviation from the original object. However even in the extreme case that there are no English speaking readers, and the site becomes primarily used by Japanese speakers, it is still possible to make translation an interesting activity. Also, if translations are provided in a steady stream, readers are more likely to gather little by little.

The reality of the current situation is that it will take time for the project to bear fruit. Until then I've conceived ideas such as a translation ranking, or a badge system much like [Foursquare](https://foursquare.com/) uses.

### Feature Addition

Putting these long term goals aside, I've thought of more short term items that can help to improve the site.

Use Google Translate By Default
: For those messages without a translation, utilize the [Google Natural Language Translation API](http://www.google.com/webelements/#!/translate) to provide machine based translation.

Mark Items In English As Already Translated
: For messages already in English, such as those cross posted to ruby-core, mark as already translated.

Tweet Button, Like Button, etc.
: Easily introduce a message on other sites.

Ability For Anonymous Users To Add ☆s
: Make it easier to participate. Also, make it so that it's not just one person one star, but instead the ability to add multiple stars such as used by [Hatena Star](http://s.hatena.ne.jp/).

## Conclusion

This concludes the introduction to ruby-dev translation, including an overview of the system, and the challenges faced hereon. 

For now, those using [blade](http://blade.nagaokaut.ac.jp/ruby/ruby-dev/index.shtml) to view ruby-dev, please use [ruby-dev translation](http://ruby-dev.info/) instead. The same topic can be read on one screen, threads can be grouped by Redmine units, and other adjustments have been made to make reading easier.

For those interested in contributing, please login and give translating a try. Even if it's just the title that's translated, it is help enough. Helpful features such as automated translation of Redmine system strings are available as assistance, but there are many more improvements that can be made. If you think up any ideas, please contact me on Twitter ([@yhara](http://twitter.com/yhara)), or utilize [github's ITS](https://github.com/yhara/dev-ruby/issues).

The source code is available on [github](https://github.com/yhara/dev-ruby), and patches are more than welcome. Rails3 is the framework used, and hosting is done on [Heroku](http://www.heorku.com).

### About the author

yhara(Yutaka HARA)
: Network Applied Communication Laboratory member. It has been 4 years since the move from Shiga prefecture to Matsue. Please also check out [BiwaScheme](http://www.biwascheme.org/).

### About the translator

@cwgem (Chris White) - Software Engineer at Engine Yard. Lives in Southern California where he enjoys the relatively calm weather. Japanese studies include 2 years of college courses and self study, and has been to Japan 4 times in his lifetime. Likes Starbucks, Mac, Ruby, JRuby, Rubinius, MacRuby, and anything else Ruby related.

[^1]: In contrast with JRuby, MacRuby, Rubinius, etc., CRuby is a Ruby implementation created in the C programming language
[^2]: A special thanks to @mrkn for providing the domain name
