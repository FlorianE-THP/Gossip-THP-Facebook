module CommentHelper
    def comment_is
        @comment = Comment.find(params[:id])
        if current_user.id == @comment.user_id 
            return true 
        else 
            return false
        end
    end 
end
