#!/usr/bin/env ruby
require 'rubygems'
require 'mechanize'
require 'terminal-notifier'

username = ARGV[0]
password = ARGV[1]

if ARGV[0].nil? or ARGV[1].nil?
  puts "Please supply a valid username and password"
  puts "Usage: itsyourgo username password"
  exit
end

def connect_to_go(username, password)

  agent = Mechanize.new

  # Log into server
  page = agent.get('http://www.dragongoserver.net/')

  login_form = page.form('loginform')
  login_form.userid = username
  login_form.passwd = password

  page = agent.submit(login_form, login_form.buttons.first)

  # Scrape data to see if there is a new game

  games = agent.get(page).search("div#sectGames").children[1].content.gsub(/"/, '')

  unless games == "No games found"
    user = agent.get(page).search("div#sectGames").text.delete("\n")
    while user.gsub!(/\([^()]*\)/,""); end
    user = user.split(/ /)[37]
    message = Time.now.to_s + "\nYour oppent: " + user + " has moved."
    TerminalNotifier.notify(message, :open => "http://www.dragongoserver.net", :title => "It's your Go")
  end
end


loop do
    connect_to_go(username, password)
    sleep(1800)
end
