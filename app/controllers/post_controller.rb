class PostController < ApplicationController
    get '/posts' do
        if logged_in?
          @posts = Adventure.all
          erb :'posts/posts'
        else
          redirect to '/login'
        end
    end
    get '/posts/new' do
        if logged_in?
          erb :'posts/create_posts'
        else
          redirect to '/login'
        end
    end
    post '/posts' do
        if logged_in?
          if params[:name] == "" || params[:description] == "" || params[:season]==''||params[:length]==''||params[:address]==''
            redirect to "/posts/new"
          else
            @post = current_user.adventures.build(name: params[:name], address: params[:address], length: params[:length], season: params[:season], description: params[:description])
            if @post.save
              redirect to "/posts/#{@post.id}"
            else
              redirect to "/posts/new"
            end
          end
        else
          redirect to '/login'
        end
    end
    get '/posts/:id' do
        if logged_in?
         @post = Adventure.find_by_id(params[:id])
          erb :'posts/show_post'
        else
          redirect to '/login'
        end
    end
    get '/posts/:id/edit' do
      if logged_in?
        @post = Adventure.find_by_id(params[:id])
        if @post && @post.user == current_user
          erb :'posts/edit_post'
        else
          redirect to '/posts'
        end
      else
        redirect to '/login'
      end
    end
    patch '/posts/:id' do
      if logged_in?
        if params[:name] == "" || params[:description] == "" || params[:season]==''||params[:length]==''||params[:address]==''
          redirect to "/posts/#{params[:id]}/edit"
        else
          @post = Adventure.find_by_id(params[:id])
          if @post && @post.user == current_user
            if @post.update(name: params[:name], address: params[:address], length: params[:length], season: params[:season], description: params[:description])
              redirect to "/posts/#{@post.id}"
            else
              redirect to "/posts/#{@post.id}/edit"
            end
          else
            redirect to '/posts'
          end
        end
      else
        redirect to '/login'
      end
    end
    delete '/posts/:id/delete' do
      if logged_in?
        @post = Post.find_by_id(params[:id])
        if @post && @post.user == current_user
          @post.delete
        end
        redirect to '/posts'
      else
        redirect to '/login'
      end
    end

 
  


  end