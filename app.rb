require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'bcrypt'
require 'date'

set :database, "sqlite3:db_store.sqlite3"

require_relative 'models/user'
require_relative 'models/products'
require_relative 'models/tops'
require_relative 'models/shoes'
require_relative 'models/order_items'
require_relative 'models/order_status'
require_relative 'models/orders'
require_relative 'models/comments'
require_relative 'routes/home'
require_relative 'routes/login'
require_relative 'routes/create_user'
require_relative 'routes/shoes'
require_relative 'routes/add_shoes'
require_relative 'routes/add_comment'
require_relative 'routes/open_shoes'
require_relative 'routes/delete_comment'
require_relative 'routes/cart'
require_relative 'routes/update_order'
require_relative 'routes/confirm_order'

set :root, __dir__
enable :sessions
set :session_secret, '*&(^B234'
