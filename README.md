# The Awesome Foundation Website #

This is the source code for the Awesome Foundation's website at [awesomefoundation.org][].

  [awesomefoundation.org]: http://awesomefoundation.org/

## Prerequisites ##

* git
* ruby
* mysql
* gem
* ruby mysql bindings
* paperclip (and ImageMagick)
* comma
* rails (v 2.3.11)

To get Rails version 2.3.11, you can run:

    $ sudo gem install -v=2.3.11 rails --no-ri --no-rdoc

### Ubuntu
 
If you start from a base Ubuntu maverick installation, you can get the
prerequisites by running:

    sudo apt-get install git ruby mysql-server rubygems libdbd-mysql-ruby

You'll then want to install the Rails gem (described above), rather than 
installing it via `apt-get`. Once you've done that, run:

    sudo ln -s /var/lib/gems/1.8/gems/rake-0.8.7/bin/rake /usr/bin/rake
    sudo gem install paperclip --no-ri --no-rdoc

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

The seed data sets up a fictional Awesome Foundation chapter called Atlantis
with a single administrator account whose username is `poseidon` with
password `password`.

After that, do:

    $ cp config/secrets.yml.dist config/secrets.yml

Then edit `config/secrets.yml` as needed.

Finally you can run the WEBrick server:

    $ ./script/server
