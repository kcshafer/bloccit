class Comment < ActiveRecord::Base
    after_create :send_favorite_emails
    
    belongs_to :post
    belongs_to :topic
    belongs_to :user

    validates :body, length: { minimum: 5 }, presence: true
    validates :user, presence: true
    
    default_scope { order('updated_at DESC') }

    private

    def send_favorite_emails
        if post then
            post.favorites.each do |favorite|
                FavoriteMailer.new_comment(favorite.user, post, self).deliver_now
            end
        end
    end
end
