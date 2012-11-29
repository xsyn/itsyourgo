#!/usr/bin/env ruby

require 'rubygems'
require 'mechanize'
require 'terminal-notifier'

agent = Mechanize.new

# Log into server
page = agent.get('http://www.dragongoserver.net/')

login_form = page.form('loginform')
login_form.userid = username
login_form.passwd = password

page = agent.submit(login_form, login_form.buttons.first)

# Scrape data to see if there is a new game

games = agent.get(page).search("div#sectGames").children[1].content.gsub(/"/, '')

if games == "No games found"
else
  user = agent.get(page).search("div#sectGames").text.delete("\n")
  while user.gsub!(/\([^()]*\)/,""); end
  user = user.split(/ /)[37]
  message = Time.now.to_s + "\nYour oppent: " + user + ", has moved."
  TerminalNotifier.notify(message, :open => "http://www.dragongoserver.net", :title => "It's your Go")
end

