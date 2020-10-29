class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:index,:show, :new, :create, :edit, :update, :destroy]
  before_action :is_user?, only: [:edit, :update, :destroy]
  def index
    @gossips2 = Gossip.all  
  end

  def show
    id = params[:id]
    @gossipsfind = Gossip.find(params[:id])
    @user = User.find(params[:id])
    @comments = @gossipsfind.comments
    @comment = Comment.new
  end

  def new
    @gossip = Gossip.new
    @tag = Tag.all

    # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
  end

  def create

    @gossip = Gossip.create('title' => params[:title],
                         'content' => params[:content],
                        'user_id' => session[:user_id] )
    if @gossip.save
      flash[:notice] = "Good"
    redirect_to gossip_path(@gossip.id)
    
      else 
        flash[:notice] = "Not good"
        render 'new'
      end 


    # Méthode qui créé un potin à partir du contenu du formulaire de new.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params (ton meilleur pote)
    # Une fois la création faite, on redirige généralement vers la méthode show (pour afficher le potin créé)
  end

  def edit
    @gossip_edit = Gossip.find(params[:id])
    # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
  end

  def update
    @gossip = Gossip.find(params[:id])
    post_params = params.require(:gossip).permit(:title, :content)
    @gossip.update(post_params)
    redirect_to gossip_path(@gossip.id)


    # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params
    # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy 
    flash[:notice] = "Delete"
    redirect_to root_path
    # Méthode qui récupère le potin concerné et le détruit en base
    # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
  end

  private

  def authenticate_user
    unless current_user 
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end

  def is_user?
    @gossip = Gossip.find(params[:id])
    unless current_user.id == @gossip.user_id 
      flash[:danger] = "Tu ne peux pas modifier cela."
      render 'new'
    end
end 

end 