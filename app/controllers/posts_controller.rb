class PostsController < ApplicationController

    before_filter :current_user, :only => [:update, :edit, :destroy, :new, :create, :vote_up, :vote_down]

  def index
    @posts = current_user.posts.all
    @title = "Post Panel"
  end
 
  def create
    @post = current_user.posts.build(params[:post])
    @post.save
    if @post.save
      current_user.vote_exclusively_for(@post)
      flash[:notice] = "Post successfully created!"
      redirect_to posts_path
    else
      render('new')
    end
  end
  
  def new
    @post = current_user.posts.new
    @title = "New post"
  end
  
  def edit
   @post = current_user.posts.find(params[:id])
   @title = "edit"
  end
  
  def show
    @post = Post.find(params[:id]) 
    @title = @post.title
    @posts = Post.find(params[:id])

  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      flash[:notice] = "Successfully updated"
      redirect_to posts_path
    else
      render('new')
    end
  end
   
  def destroy
   @post = current_user.posts.find(params[:id])
   @post.destroy
   redirect_to posts_path
  end
   
   def vote_up
       @post_votes = {}
       post = Post.find_by_id(params[:post_id])
       current_user.vote_exclusively_for(post)
       @post_votes[:count] = "#{post.votes.count} votes"
       respond_to do |format|
         format.json { render :json => @post_votes}
       end
     
   end

   def vote_down
       @post_votes = {}
       post = Post.find_by_id(params[:post_id])
       current_user.vote_exclusively_against(post)
       @post_votes[:count] = "#{post.votes.count} votes"
       respond_to do |format|
         format.json { render :json => @post_votes}
       end
     end
   
end