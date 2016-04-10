module UsersHelper
	def has_posts_or_comments?(user)
		puts "calling has_posts_or_comments?"
		puts "counts"
		puts user.comments
		puts user.posts
		if user.comments.count + user.posts.count == 0 then
			puts "no posts or comments"
			return "No posts or comments"
		else
			return "has posts or comments"
		end
	end
end
