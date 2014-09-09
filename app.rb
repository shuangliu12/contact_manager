require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

require_relative 'models/contact'

# before do
#   contact_attributes = [
#     { first_name: 'Eric', last_name: 'Kelly', phone_number: '1234567890' },
#     { first_name: 'Adam', last_name: 'Sheehan', phone_number: '1234567890' },
#     { first_name: 'Dan', last_name: 'Pickett', phone_number: '1234567890' },
#     { first_name: 'Evan', last_name: 'Charles', phone_number: '1234567890' },
#     { first_name: 'Faizaan', last_name: 'Shamsi', phone_number: '1234567890' },
#     { first_name: 'Helen', last_name: 'Hood', phone_number: '1234567890' },
#     { first_name: 'Corinne', last_name: 'Babel', phone_number: '1234567890' }
#   ]

#   @contacts = contact_attributes.map do |attr|
#     Contact.new(attr)
#   end
# end

get '/' do
  @page = params[:page].to_i || 0
  @contacts = Contact.limit(3).offset(@page*3 )
  @query = params[:query]
  @results = Contact.where("first_name ilike ? or last_name ilike ?", params[:query], params[:query])

  erb :index
end

get '/contacts/:id' do
  id = params[:id]
  @each_contact = Contact.find(id)
  erb :show
end

get '/add'do
  erb :add
end

post '/add' do
  Contact.create(first_name: params["first_name"], last_name: params["last_name"], phone_number: params["phone"])
end
