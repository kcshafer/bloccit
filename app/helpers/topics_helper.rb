module TopicsHelper
	def user_is_authorized_for_topics?
		current_user && current_user.admin?
	end

	def is_moderator?
		current_user && current_user.role == 'moderator'
	end
end
