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

To get Rails version 2.3.5, you can run:

    $ sudo gem install -v=2.3.5 rails --no-ri --no-rdoc

### Ubuntu
 
If you start from a base Ubuntu maverick installation, you can get the
prerequisites by running:

    sudo apt-get install git ruby mysql-server rubygems libdbd-mysql-ruby

You'll then want to install the Rails gem (described above), rather than 
installing it via `apt-get`. Once you've done that, run:

    sudo ln -s /var/lib/gems/1.8/gems/rake-0.8.7/bin/rake /usr/bin/rake

## Installation ##

First, download the source:

    $ git clone https://github.com/awesomefoundation/awesomefoundation.git

This will make a directory called `awesomefoundation`. Enter it.

Now set up mysql. Create the `awesomefound` user and grant it access to the databases that don't exist yet:

    $ mysql -u root -p
    mysql> grant all on awesomefound.* to awesomefound@'%';

Now let rake set up the databases and tables and seed data:

    $ rake db:setup
    $ rake db:seed

After that, edit the `config/secrets.yml` file and fill it with something
like this:

    username: test
    password: test

You can use this username and password to get past HTTP Basic Authentication
that some endpoints present you with, such as `/submissions`.

Finally you can run the WEBrick server:

    $ ./script/server
