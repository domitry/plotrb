module Plotrb

  # The container for all visual elements.
  # See {https://github.com/trifacta/vega/wiki/Visualization}
  class Visualization

    include ::Plotrb::Base
    include ::Plotrb::Kernel

    # @!attributes name
    #   @return [String] the name of the visualization
    # @!attributes width
    #   @return [Integer] the total width of the data rectangle
    # @!attributes height
    #   @return [Integer] the total height of the data rectangle
    # @!attributes viewport
    #   @return [Array(Integer, Integer)] the width and height of the viewport
    # @!attributes padding
    #   @return [Integer, Hash] the internal padding from the visualization
    # @!attributes data
    #   @return [Array<Data>] the data for visualization
    # @!attributes scales
    #   @return [Array<Scales>] the scales for visualization
    # @!attributes marks
    #   @return [Array<Marks>] the marks for visualization
    # @!attributes axes
    #   @return [Array<Axis>] the axes for visualization
    # @!attributes legends
    #   @return [Array<Legend>] the legends for visualization
    # @!attributes enable
    #   @return [Array<Symbol>] the options for visualization
    add_attributes :name, :width, :height, :viewport, :padding, :data, :scales,
                  :marks, :axes, :legends, :enable

    require 'erb'

    def initialize(&block)
      define_single_val_attributes(:name, :width, :height, :viewport, :padding)
      define_multi_val_attributes(:data, :scales, :marks, :axes, :legends)
      define_multi_val_attribute(:enable) do |args|
        args.map do |arg|
          unless arg.is_a?(Symbol) then raise ArgumentError end
          arg.to_s
        end
      end
      self.instance_eval(&block) if block_given?
    end

    def generate_spec(format=nil)
      if format == :pretty
        JSON.pretty_generate(self.collect_attributes)
      else
        JSON.generate(self.collect_attributes)
      end
    end

    def output_server(plot_name)
      require 'net/http'

      models = generate_spec()
      js = generate_embed_js(models)

      http = Net::HTTP.new('localhost',4567)
      response = http.post('/post/'+plot_name, js)
    end

    def display()
      unless defined?(IRuby)
        puts 'IRuby notebook is not loaded.'
        return
      end
      IRuby.display(generate_html, mime: 'text/html')
    end

  private

    def attribute_post_processing

    end

    def generate_html
      base_path = File.dirname(__FILE__) + '/templates'

      template = File.read(base_path + '/plot_result.erb')
      plotrb_min_css = File.read(base_path + '/css/plotrb.min.css')
      d3_min_js = File.read(base_path + '/js/d3.min.js')
      plotrb_js = File.read(base_path + '/js/plotrb.js')
      embed_js = generate_embed_js(generate_spec)

      html = ERB.new(template).result(binding)
    end

    def generate_embed_js(models)
      path = File.dirname(__FILE__) + '/templates/embed.js.erb'
      template = File.read(path)
      js = ERB.new(template).result(binding)
    end

  end

end
