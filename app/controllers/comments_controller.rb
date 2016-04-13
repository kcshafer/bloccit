class CommentsController < ApplicationController
    before_action :require_sign_in
    before_action :authorize_user, only: [:destroy]
    
    def create
        puts "calling create"
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new(comment_params)
        @comment.user = current_user
        @new_comment = Comment.new
        
        if @comment.save
            flash[:notice] = "Comment saved successfully."
        else
            flash[:alert] = "Comment failed to save."
        end

        respond_to do |format|
            format.html
            format.js
        end
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])

        if @comment.destroy
            flash[:notice] = "Comment was deleted."
        else
            flash[:alert] = "Comment couldn't be deleted. Try again."
        end

        respond_to do |format|
            format.html
            format.js
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
