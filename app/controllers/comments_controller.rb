class CommentsController < ApplicationController
    before_action :require_sign_in
    before_action :authorize_user, only: [:destroy]
    def create
        comment = Comment.new(comment_params)
        comment.user = current_user

        if params.key? :post_id
            create_post_comment(comment)
        elsif params.key? :topic_id
            create_topic_comment(comment)
        end         
    end

    def destroy
        if params.key? :post_id
            destroy_post_comment
        elsif params.key? :topic_id
            destroy_topic_comment
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end

    def authorize_user
        comment = Comment.find(params[:id])
        unless current_user == comment.user || current_user.admin?
            flash[:alert] = "You do not have permission to delete a comment."
            redirect_to [comment.post.topic, comment.post]
        end
    end

    def create_post_comment(comment)
        @post = Post.find(params[:post_id])
        comment.post_id = @post.id

        if comment.save
            do_redirect([@post.topic, @post], :notice, "Comment saved successfully")
        else
            do_redirect([@post.topic, @post], :alert, "Comment failed to save.")
        end
    end

    def create_topic_comment(comment)
        @topic = Topic.find(params[:topic_id])
        comment.topic_id = @topic.id

        if comment.save
            do_redirect([@topic], :notice, "Comment saved successfully.")
        else
            do_redirect([@topic], :alert, "Comment failed to save.")
        end
    end

    def destroy_topic_comment
        @topic = Topic.find(params[:topic_id])
        comment = @topic.comments.find(params[:id])

        if comment.destroy
            do_redirect([@topic], :notice, "Comment was deleted")
        else
            do_redirect([@topic], :alert, "Comment couldn't be deleted. Try again")
        end
    end

    def destroy_post_comment
        @post = Post.find(params[:post_id])
        comment = @post.comments.find(params[:id])

        if comment.destroy
            do_redirect([@post.topic, @post], :notice, "Comment was deleted.")
        else
            do_redirect([@post.topic, @post], :alert, "Comment couldn't be deleted. Try again.")
        end
    end

    def do_redirect(redirection, type, msg)
        flash[type] = msg
        redirect_to redirection
    end
end
