require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'sqlite3'


DataMapper::setup(:default, "sqlite3://" + Dir.pwd + "/drinkorder.db")

class Drink
  include DataMapper::Resource
  property :id, Serial
  property :d_order, Text, :required => true
  property :name, Text, :required => true
  property :complete, Boolean, :required => true, :default => false
  property :ordered_at, DateTime
  property :updated_at, DateTime
end
 
DataMapper.finalize.auto_upgrade!

get '/' do 
  @drinks = Drink.all(:order => :id.desc)
  @title = 'All drinks'
  erb :home
end

post '/' do
  n = Drink.new
  n.d_order = params[:ordered_drink]
  n.name = params[:person_name]
  n.ordered_at = Time.now
  n.updated_at = Time.now
  n.save
  redirect '/'
end

get '/:id' do
@drinks = Drink.get params[:id]
@title = "Edit note ##{params[:id]}"
erb :edit
end

put '/:id' do
n = Drink.get params[:id]
n.d_order = params[:edited_order]
n.complete = params[:complete] ? 1:0 
n.updated_at =Time.now 
n.save
redirect '/'
end 

get '/:id/delete' do 
	@drinks = Drink.get params[:id]
	@title = "Confirm deletion of the order ##{params[:id]}"
	erb :delete
end

delete '/:id' do 
	n= Drink.get params[:id]
	n.destroy
	redirect '/'
end





