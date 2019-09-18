require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  # index
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  # new
  get '/recipes/new' do
    @recipe = Recipe.new
    erb :new
  end

  # create recieve data from new. do NOT forget ?!!
  post '/recipes/?' do  
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end
  
  # show
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  # edit
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end
  
  # update recieve data from edit
  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end
  
  # destroy
  delete '/recipes/:id' do
    Recipe.destroy(params[:id])
    redirect to "/recipes"
  end
    


end
