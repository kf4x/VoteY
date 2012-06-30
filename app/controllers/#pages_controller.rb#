class PagesController < ApplicationController
  def index
    @post = Post.all
    @posts = Post.plusminus_tally(
    { 
        :at_most => 10000,
        :limit => 10,
        :order => "votes.count desc"
    })
    
    @title = "Home"
  end
  
  def about
    @title = "About"
  end
end
