include SessionsHelper

class Post < ActiveRecord::Base
    after_create :create_vote

    belongs_to :topic
    has_many :comments, dependent: :destroy
    has_many :votes, dependent: :destroy
    has_many :labelings, as: :labelable
    has_many :labels, through: :labelings
    belongs_to :user

    validates :title, length: { minimum: 5 }, presence: true
    validates :body, length: { minimum: 20 }, presence: true
    validates :topic, presence: true
    validates :user, presence: true

    default_scope { order('rank DESC') }
    scope :ordered_by_title, -> { order('title ASC') }
    scope :ordered_by_reverse_created_at, -> { order('created_at ASC') }

    def up_votes
        votes.where(value: 1).count
    end

    def down_votes
        votes.where(value: -1).count
    end

    def points
        votes.sum(:value)
    end

    def update_rank
        age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
        new_rank = points + age_in_days
        puts "new_rank"
        puts new_rank
        update_attribute(:rank, new_rank)
    end

    private

    def create_vote
        vote = Vote.new
        vote.value = 1
        vote.post = self
        vote.user = self.user
        vote.save!
    end
end 
