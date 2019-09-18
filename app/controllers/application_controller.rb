class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #READ
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  #CREATE
  get '/recipes/new' do
    @recipe = Recipe.new
    erb :new
  end

  #READ
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  #CREATE
  post '/recipes/?' do
    @recipe = Recipe.create(params)
    redirect "/recipes/#{@recipe.id}"
  end

  #UPDATE
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  #UPDATE
  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save

    redirect "/recipes/#{@recipe.id}"
  end

  #DELETE
  delete '/recipes/:id' do
    Recipe.destroy(params[:id])
    redirect "/recipes"
  end

end
