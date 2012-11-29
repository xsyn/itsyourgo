# It's your Go

Itsyourgo is a ruby library designed to notify OS X users of when somebody has played in the Dragon Go Server.

Clone the repo to a directory of your choice.

> git clone && cd itsyourgo

Make sure that all the gems are installed

> gem install bundler
> bundle install

Now you can run the script to see if if it's your turn:

> ruby itsyourgo.rb username password &

Obviously you need to change username and password

## Scheduling

After fighting with plist and rbenv et al, I've seriously struggled with getting this scheduled, and is now moving into a TODO.
I've been lazy and thrown in a sleep cycle.

## TODO 

* Deamonize
