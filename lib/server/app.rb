require 'sinatra/base'
require 'erb'

class PlotrbApp < Sinatra::Base
  helpers do
    def show_file_list
      Dir.glob(@data_dir + "/*.js").map do |path|
        path.match(/.+\/(.+?).js/)[1]
      end
    end

    def existing_file?(file_name)
      Dir.glob(@data_dir + "/*.js").each do |path|
        return true if file_name == path.match(/.+\/(.+?).js/)[1]
      end
      false
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

  get '/show/js/*' do |file_name|
    path = @data_dir+"/"+file_name + ".js"
    send_file(path)
  end

  get '/show/*' do |file_name|
    @file_name = file_name
    erb :plot_template
  end

  post '/post/*' do |file_name|
    save_file(file_name, request.body.read)
  end
end
