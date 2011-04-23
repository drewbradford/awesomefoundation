# The Awesome Foundation Website #

This is the source code for the Awesome Foundation's website at [awesomefoundation.org][].

  [awesomefoundation.org]: http://awesomefoundation.org/

## Prerequisites ##

* git
* ruby
* mysql
* gem
* ruby mysql bindings
* rails (v 2.3.5)

If you don't already have the Ruby MySQL bindings, you can get them by running:

    $ sudo gem install mysql

To get Rails version 2.3.5, you can run:

    $ sudo gem install -v=2.3.5 rails

## Installation ##

First, download the source:

    $ git clone https://github.com/awesomefoundation/awesomefoundation.git

This will make a directory called `awesomefoundation`. Enter it.

Now set up mysql. Create the `awesomefound` user and grant it access to the databases that don't exist yet:

    $ mysql -u root -p
    mysql> grant all on awesomefound.* to awesomefound@'%';

Now let rake set up the databases and tables:

    $ rake db:setup

Finally you can run the WEBrick server:

    $ ./script/server

Note that there is not any data in the database as yet.
