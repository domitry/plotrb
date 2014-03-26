require 'sinatra/base'
require 'erb'

class PlotrbApp < Sinatra::Base
  helpers do
    def show_files
      Dir.glob(@data_dir + "/*.js").map do |path|
        path.match(/.+\/(.+?).js/)[1]
      end
    end

    def save_file(file_name, content)
      path = @data_dir + "/" + file_name
      file = File::open(path, "w")
      file.write content
    end
  end

  configure do
    enable :sessions
  end

  before do
    @data_dir = settings.plotrb_options[:data_dir]
    @data_dir ||= Dir::pwd
  end

  get '/' do
    erb :index
  end

  get '/show/*' do |file_name|

  end

  post '/post/*' do |file_name|
    save_file(file_name, request.body.read)
  end
end
