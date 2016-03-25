require 'random_data'

5.times do
    User.create!(
        name:     RandomData.random_name,
        email:    RandomData.random_email,
        password: RandomData.random_sentence
    )
 end
 users = User.all

15.times do
    Topic.create!(
        name: RandomData.random_sentence,
        description: RandomData.random_paragraph
    )
end

topics = Topic.all

25.times do
    SponsoredPost.create!(
        topic: topics.sample,
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph,
        price: 10    
    )
end

50.times do
    Post.create!(
        user: users.sample,
        topic: topics.sample,
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph
    )
end

p = Post.find_or_create_by(title: 'Unique Post', body: 'A unqiue post body.')

posts = Post.all

100.times do
    Comment.create!(
        post: posts.sample,
        body: RandomData.random_paragraph
    )
end

10.times do
    Advertisement.create!(
            title: RandomData.random_sentence,
            copy: RandomData.random_paragraph,
            price: 50.0
        )
end

10.times do
    Question.create!(
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph,
        resolved: false
    )
end

Comment.find_or_create_by(post: p,body: 'A unique comment body')

user = User.first
user.update_attributes!(
    email: 'youremail.com', # replace this with your personal email
    password: 'helloworld'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{SponsoredPost.count} sponsored posts created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} ads created"