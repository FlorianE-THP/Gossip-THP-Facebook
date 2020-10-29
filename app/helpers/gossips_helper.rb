module GossipsHelper
    def user_is
        @gossip = Gossip.find(params[:id])
        if current_user.id == @gossip.user_id 
            return true 
        else 
            return false
    
        end
    end 
end
