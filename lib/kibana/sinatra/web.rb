module Kibana
  module Sinatra

    class Web < ::Sinatra::Base
      set :root, File.expand_path(File.dirname(__FILE__) + "/../../kibana")
      set :public_folder, Proc.new { "#{root}/assets" }
      set :views, Proc.new { "#{root}/views" }

      get '/' do
        File.read("#{settings.public_folder}/index.html")
      end

      get '/config.js' do
        content_type 'text/javascript'
        erb :config
      end

      get '/app/dashboards/:name' do
        render_dashboard params[:name]
      end

      def elasticsearch_url
        "http://\"+window.location.hostname+\":9200"
      end

      def kibana_index
        "kibana-int"
      end

      def default_route
        "/dashboard/file/default.json"
      end

      def render_dashboard(name)
        status 404
      end
    end

  end
end
