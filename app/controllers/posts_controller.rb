class PostsController < ApplicationController
  def index
    @posts = []
    Post.all.each_with_index do |p,i|
        if i % 5 == 0 then
            p.title = 'SPAM'
        end
            @posts << p
        end
    end

    def show
        @post = Post.find(params[:id])  
    end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    if @post.save
        flash[:notice] = "Post was saved."
        redirect_to @post
    else
        @flash.now[:alert] = "There was an error, please try again"
        render :new
    end
  end

  def edit
  end
end
