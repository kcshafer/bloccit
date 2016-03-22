class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
    before_save :make_title_case

    validates :name, length: { minimum: 1, maximum: 100 }, presence: true
    validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
    validates :password, length: { minimum: 6 }, allow_blank: true

    validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 254 }

    has_secure_password

    def make_title_case
        new_name = []
        if self.name != nil
            self.name.split.map do |n|
                new_name << n.capitalize
            end
            self.name = new_name.join(' ')
        end
    end
end
