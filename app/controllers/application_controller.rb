require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  # Index
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  # New
  get '/recipes/new' do
    @recipe = Recipe.new
    erb :new
  end

  # Create recieve data from new. DO NOT FORGET?!!
  post '/recipes/?' do  
    @recipe = Recipe.create(params) # Can use params to set all attributes together as there is no _method involved at this stage
    redirect to "/recipes/#{@recipe.id}"
  end
  
  # Show
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  # Edit
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end
  
  # Update recieve data from edit
  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])  # Can NOT use params as _method involved. Compare with Create
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end
  
  # Destroy
  delete '/recipes/:id' do
    Recipe.destroy(params[:id])
    redirect to "/recipes"
  end
    


end
