require './config/environment'
require 'sinatra/flash'
require 'sinatra'

use Rack::MethodOverride
use UserController
use TaskController
run ApplicationController