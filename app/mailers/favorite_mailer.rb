class FavoriteMailer < ApplicationMailer
    default from: "kclshafer@gmail.com"

    def new_comment(user, post, comment)
        headers["Message-ID"] = "comments/#{comment.id}@morning-tor-67924.herokuapp"
        headers["In-Reply-To"] = "<post/#{post.id}@morning-tor-67924.herokuapp>"
        headers["References"] = "<post/#{post.id}@morning-tor-67924.herokuapp>"   

        @user = user
        @post = post
        @comment = comment

        mail(to: user.email, subject: "New comment on #{post.title}")
    end
end
