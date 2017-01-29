require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'bcrypt'

set :database, "sqlite3:db_store.sqlite3"
require_relative 'models/user'
require_relative 'models/admin'
require_relative 'models/tops'
require_relative 'models/shoes'
require_relative 'routes/home'
require_relative 'routes/login'
require_relative 'routes/admin_login'
require_relative 'routes/create_user'
require_relative 'routes/shoes'
require_relative 'routes/add_shoes'

#get '/' do
#"Hello World"
#end
set :root, __dir__
enable :sessions
set :session_secret, '*&(^B234'
