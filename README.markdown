# matahari

* http://tomstuart.co.uk/2011/06/05/mocks-suck-matahari-sucks-less.html

[![Build Status](https://secure.travis-ci.org/mortice/matahari.png)](http://travis-ci.org/mortice/matahari)

## DESCRIPTION:

Matahari is a test spy library, heavily inspired by Java's Mockito and btakita's RR.

It is designed to allow you to test interactions between objects *without* requiring
you to specify all method calls, including uninteresting ones.

## SYNOPSIS:
Matahari allows you to do this (RSpec example)

    describe "my object" do
      obj = MyAwesomeObject.new
      collaborator = spy(:collaborator)
      obj.collaborator = collaborator

      obj.my_awesome_method

      collaborator.should have_received(3.times).some_interesting_method("Some", "arguments")
    end

See also the cucumber features, easily viewable at http://relishapp.com/mortice/matahari

## USING:

### RSpec

In your spec_helper, include this:

    RSpec.configure do |config|
      config.include Matahari::Adapters::RSpec
    end

### test/unit
In your test_helper, include this:

    class Test::Unit::TestCase
      include Matahari::Adapters::TestUnit
    end

## CONTEXT:

Traditional mocks require you to put expectations (my_mock.should_receive) before action, 
potentially with assertions coming after that. They also do stubbing at the same time as 
setting up expectations (my_mock.should_receive(:something).and_return). These issues 
lead to less readable tests and a tendency to set an expectation when only a stub is
required, or vice versa.

Test spies present an alternative philosophy to traditional mocking by acting as null 
objects and then allowing assertions after the fact on method calls they have received. 
This means that stubbing and asserting on collaborations can be separated and that all 
assertions in a given test go in the same place.

The RR project provides test spies, but due to the way it is built (it supports a 
variety of different double strategies), it requires the user to call 'stub' on any 
method which will later be asserted on. As @dchemlimsky puts it, this 'adds the need 
for an extra line, binds these two lines [the stub call and the assertion] together, 
and generally makes [the test] more difficult to understand.'

By sticking to spies as a double strategy, matahari is able to avoid the need for a 
similar call in the setup portion of the test - matahari spies simply collect the 
details of all messages passed to them and provide a means for inspecting those 
messages later.

### Further reading
https://gist.github.com/716640 - Conversation between dchelimsky and myself about Ruby test 
doubles

http://dannorth.net/2008/09/14/the-end-of-endotesting/ - Article about mockito, which heavily 
influenced the creation of Matahari

## KNOWN ISSUES/TODO:

* Stubbing implementation is incredibly basic
* Not very usable or test/unit users (it works, but you don't get a fancy DSL.)
* No support for argument matchers - arguments must match exactly via == or not at all
* We need to be able to remote-control BMWs.

## INSTALL:

* gem install matahari

## ACKNOWLEDGEMENTS:

* David Chelimsky, for putting up with my robust criticisms of RSpec mocks
* Aslak Hellesøy, for giving interesting feedback on an early version
* Szczepan Faber, for creating Mockito
* Brian Takita, for creating RR
* James Adam, for encouraging people to add CONTEXT sections to their READMEs

## LICENSE:

(The MIT License)

Copyright (c) 2010-2011 Tom Stuart

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
