# JCMBayes v2.0

[...Some Ruby pun...]

## Behaviour

### Channel message gatekeeping

The purpose of this bot is to monitor the messages sent to a specific channel
in a discord server and check that they adhere to the arbitrary rules which are
as follows:

1) the message starts with either "JCMB" or "Bayes" (case insensitive and non-optional)
2) followed by one or more spaces, then a word (optional)
3) followed by one punctuation mark

Any messages sent to the channel in question which do not adhere to these rules
receive a sequence of demeining reactions.
And then, after a delay, the message is deleted by this bot.

If message adheres to rules, bot posts a picture to remind people of everybody's choices
between JMCMB and Bayes.

## Setup

### Requirements

[Ruby](www.ruby-lang.org)
and Imagemagick.

### Initialization

- Install Ruby Gem dependencies with `bundle install`
- Copy `auth.sample.yml` to `auth.yml` and edit with your Bot Token and Channel ID

### Start

``bundle exec ruby main.rb``
