module CommentsHelper
    def user_is_authorized_for_comment?(comment)
        current_user && (current_user == comment.user || current_user.admin?)
    end

    def is_post?
    	#if params contains topic_id this is actually coming from a post
    	params.has_key? :topic_id
    end
end
