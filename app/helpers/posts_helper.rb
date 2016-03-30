module PostsHelper
	def user_is_authorized_for_posts?(post)
		current_user && (current_user == post.user || current_user.admin?)
	end

	def is_moderator?
		current_user && current_user.role == 'moderator'
	end
end
