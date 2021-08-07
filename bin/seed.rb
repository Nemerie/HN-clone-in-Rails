# frozen_string_literal: true

# nethttp.rb
require 'uri'
require 'net/http'
require 'json'

res = Net::HTTP.get_response(URI('https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty'))
unless res.is_a?(Net::HTTPSuccess)
  puts "Couldn\'t get response"
  exit(1)
end

topstories = JSON.parse(res.body)
topstories = topstories[0..100]

def find_or_creat_user(name)
  user = User.find_by(name: name)
  if user.nil?
    user = User.create(name: name,
                       password: "#{name}-password",
                       email: "#{name}@example.com",
                       password_confirmation: "#{name}-password")
  end

  user
end

def create_comment(comment_id, parent_id, post_id)
  post_uri = "https://hacker-news.firebaseio.com/v0/item/#{comment_id}.json"
  res = Net::HTTP.get_response(URI(post_uri))
  return unless res.is_a?(Net::HTTPSuccess)

  comment = JSON.parse(res.body)
  user = find_or_creat_user(comment['by'])
  created_comment = user.comments.build({ content: comment['text'], post_id: post_id, parent_id: parent_id, points: 0 })

  return unless created_comment.save
  return if comment['kids'].nil?

  comment['kids'].each do |child_id|
    create_comment(child_id, created_comment.id, post_id)
  end
end

topstories.each do |post_id|
  post_uri = "https://hacker-news.firebaseio.com/v0/item/#{post_id}.json"
  res = Net::HTTP.get_response(URI(post_uri))
  next unless res.is_a?(Net::HTTPSuccess)

  post = JSON.parse(res.body)
  user = find_or_creat_user(post['by'])
  created_post = user.posts.build({ title: post['title'], url: post['url'], points: post['score'] })

  next unless created_post.save
  next if post['kids'].nil?

  post['kids'].each do |child_id|
    create_comment(child_id, nil, created_post.id)
  end
end
