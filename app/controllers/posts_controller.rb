class PostsController < ApplicationController
  def index
    @posts = []
    Post.all.each_with_index do |p,i|
        puts p
        if i % 5 == 0 then
            p.title = 'SPAM'
        end
        @posts << p
    end
  end

  def show
  end

  def new
  end

  def edit
  end
end
