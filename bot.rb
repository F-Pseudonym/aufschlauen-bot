#! /usr/bin/env ruby

require 'twitter'
require 'mastodon'
require 'parseconfig'
require "#{File.dirname(__FILE__)}/bullshit.rb"


sentence = "#{@part1[rand(@part1.size)]} #{@part2[rand(@part2.size)]} #{@part3[rand(@part3.size)]} #{@part4[rand(@part4.size)]} #{@part5[rand(@part5.size)]}#{@part6[rand(@part6.size)]}#{@part7[rand(@part7.size)]}"

stored_config = ParseConfig.new("#{File.dirname(__FILE__)}/twitter.config")

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = stored_config["consumer_key"]
  config.consumer_secret     = stored_config["consumer_secret"]
  config.access_token        = stored_config["access_token"]
  config.access_token_secret = stored_config["access_token_secret"]
end

client.update(sentence)

stored_m_config = ParseConfig.new("#{File.dirname(__FILE__)}/mastodon.config")

# Set up Mastodon API client
m_client = Mastodon::REST::Client.new(base_url: stored_m_config["host"], bearer_token: stored_m_config["access_token"])

# Post the quote to Mastodon
m_client.create_status(sentence)