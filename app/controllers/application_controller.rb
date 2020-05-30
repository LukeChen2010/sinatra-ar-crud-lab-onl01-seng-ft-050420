require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/' do
  end
  
  get '/articles/new' do
    erb :new
  end
  
  post '/articles' do
    article = Article.create(:title => params[:title], :content => params[:content])
    redirect "/articles/#{article.id}"
  end
  
  get '/articles/:id' do
    id = params[:id]
    article = Article.find(id)
    @articles = []
    @articles << article
    erb :show
  end
  
  get '/articles' do
    @articles = []
    @articles = Article.all
    erb :show
  end
  
  get '/articles/:id/edit' do
    id = params[:id]
    @article = Article.find(id)
    erb :edit
  end
  
  patch "/articles/:id" do
    id = params[:id]
    @article = Article.find(id)
    @article.update(title: params[:title])
    @article.update(content: params[:content])
    redirect to "/articles/#{@article.id}"
  end
  
  delete '/articles/:id' do
    id = params[:id]
    Article.destroy(id)
  end
  
end
