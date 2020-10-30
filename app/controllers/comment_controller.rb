class CommentController < ApplicationController
  def index
    @commentall = Comment.all
  end

  def show
    id = params[:id]
    @comment = Comment.find(params[:id])
    @user = User.find(params[:id])
  end

  def create
    @comment = Comment.new(content: params[:content], gossip_id: params[:gossip_id], user_id: session[:user_id])
    if @comment.save
      flash[:notice] = "Good"
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = "Not good"
      render "new"
    end
    # Méthode qui créé un potin à partir du contenu du formulaire de new.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params (ton meilleur pote)
    # Une fois la création faite, on redirige généralement vers la méthode show (pour afficher le potin créé)
  end

  def edit
    @comment = Comment.find(params[:id])

    # Méthode qui récupère le potin concerné et l'envoie à la view edit (edit.html.erb) pour affichage dans un formulaire d'édition
  end

  def update
    @comment = Comment.find(params[:id])
    post_params = params.require(:comment).permit(:title, :content)
    @comment.update(post_params)

    if @comment.update(post_params)
      redirect_to gossip_path(@comment[:gossip_id])
    else
      render :new
    end
    # Méthode qui met à jour le potin à partir du contenu du formulaire de edit.html.erb, soumis par l'utilisateur
    # pour info, le contenu de ce formulaire sera accessible dans le hash params
    # Une fois la modification faite, on redirige généralement vers la méthode show (pour afficher le potin modifié)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Delete"
    redirect_to root_path
    # Méthode qui récupère le potin concerné et le détruit en base
    # Une fois la suppression faite, on redirige généralement vers la méthode index (pour afficher la liste à jour)
  end
end
