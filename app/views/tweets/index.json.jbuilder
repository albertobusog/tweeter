json.user do
  json.username @user.username
  json.full_name @user.full_name
end
json.tweets do
  json.array! @tweets do |tweet|
    json.content tweet.content
  end
end
