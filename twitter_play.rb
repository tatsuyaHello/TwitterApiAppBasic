require 'twitter'

	
@client = Twitter::REST::Client.new do |config|
	config.consumer_key = "#"
	config.consumer_secret = "#"
	config.access_token = "#"
	config.access_token_secret = "#"
end

def tutorial
	puts "Welcome to Tatsuya"
	puts "このクライアントを起動する際、末尾にオプションをつけてね"
	puts "-t HomeのTimelineを所得する"
	puts "-m リプライの所得"
	puts "-l リストの所得"
	puts "ツイートしたい内容　ツイートする"
end

def homeTimeline
	@client.home_timeline.each do |tweet|
		puts "\e[33m" + tweet.user.name + "\e[32m" + "[ID:" + tweet.user.screen_name + "]"
		puts "\e[0m" + tweet.text 
	end
end

def mentionTimeline
	@client.mentions_timeline.each do |tweet|
		puts "\e[33m" + tweet.user.name + "\e[32m" + "[ID" + tweet.user.screen_name + "]"
		puts "\e[0m" + tweet.text
	end
end

def mentionTimelinePro
	list = {}
	@client.mentions_timeline.take(10).each do |tweet|
		if !list.has_key?(tweet.user.name)
			list[tweet.user.name] = 1
		else 
			list[tweet.user.name] += 1
		end
		#puts "\e[33m" + tweet.user.name + "\e[32m" + "[ID" + tweet.user.screen_name + "]"
		#puts "\e[0m" + tweet.text
	end
	p list.sort_by{ |key, value| value }.reverse
end

def tweet 
	@client.update(ARGV[0])
	puts "Tweetしたよ〜"
end

def search
	puts @client.user
end


option = ARGV[0].to_s

if option == "" then
	tutorial
elsif option == "-t" then 
	homeTimeline
elsif option == "-m" then 
	mentionTimeline 
elsif option == "-mp" then 
	mentionTimelinePro	
elsif option == "-s" then
	search
else 
	tweet
	homeTimeline
end