module Plotrb
	
	# Legends visualize scales. Legends aid interpretation of scales with ranges
	# such as colors, shapes and sizes.
	# See {https://github.com/trifacta/vega/wiki/Legends}
	class Legend
		
		include ::Plotrb::Base
		
	    # @!attribute size
		#   @return [Symbol] the name of the scale that determines an item's size
		# @!attribute shape
		#   @return [Symbol] the name of the scale that determines an item's shape
		# @!attribute fill
		#   @return [Symbol] the name of the scale that determines an item's fill color
		# @!attribute stroke
		#   @return [Symbol] the name of the scale that determines an item's stroke color
		# @!attribute orient
		#   @return [Symbol] the orientation of the legend
		# @!attribute title
		#   @return [Symbol] the title for the legend
		# @!attribute format
		#   @return [String] an optional formatting pattern for legend labels
		# @!attribute offset
		#   @return [Integer] the offset of the legend
		#  @!attribute values
		#   @return [Array] explicitly set the visible legend values
		# @!attributes properties
		#   @return [MarkProperty] the property set definitions
		LEGEND_PROPERTIES = [:size, :shape, :fill, :stroke, :orient, :title, 
		:format, :offset, :values, :properties]
		
		add_attributes *LEGEND_PROPERTIES
		
		def initialize(&block)
			define_single_val_attributes(:size, :shape, :fill, :stroke, :orient, 
			:title, :format, :offset)			
			define_multi_val_attributes(:values)
			self.singleton_class.class_eval {
				alias_method :name, :title
				alias_method :offset_by, :offset
			}
			self.instance_eval(&block) if block_given?
			::Plotrb::Kernel.legends << self
			self
		end
		
		def properties(element=nil, &block)
			@properties ||= {}
			return @properties unless element
			@properties.merge!(
				element.to_sym => ::Plotrb::Mark::MarkProperty.new(:text, &block)
			)
			self
		end
		
		def method_missing(method, *args, &block)
			case method.to_s
				when /^at_(left|right)$/ # set orient of the legend
					self.orient($1.to_sym, &block)
				when /^with_(\d+)_name/ # set the title of the legend
					self.title($1.to_s, &block)
				else
					super
			end
		end
		
	private
	
		def attribute_post_processing
			process_orient
			process_format
			process_properties
			process_size
			process_shape
			process_fill
			process_stroke
		end		
		
		def process_orient
			return unless @orient
			unless %i(left right).include?(@orient.to_sym)
			raise ArgumentError, 'Invalid Axis orient'
			end
		end

		def process_format
			return unless @format
			# D3's format specifier has general form:
			# [​[fill]align][sign][symbol][0][width][,][.precision][type]
			# the regex is taken from d3/src/format/format.js
			re =
			/(?:([^{])?([<>=^]))?([+\- ])?([$#])?(0)?(\d+)?(,)?(\.-?\d+)?([a-z%])?/i
			@format = @format.to_s
			if @format =~ re
				if "#{$1}#{$2}#{$3}#{$4}#{$5}#{$6}#{$7}#{$8}#{$9}" != @format
				  raise ArgumentError, 'Invalid format specifier'
				end
			end
		end
		
		def process_size
			return unless @size
			case @size
				when String
					unless ::Plotrb::Kernel.find_scale(@size)
					raise ArgumentError, 'Scale not found'
					end
				when ::Plotrb::Scale
					@size = @size.name
				else
					raise ArgumentError, 'Unknown Scale'
			end
		end

		def process_shape
			return unless @shape
			case @shape
				when String
					unless ::Plotrb::Kernel.find_scale(@shape)
					raise ArgumentError, 'Scale not found'
					end
				when ::Plotrb::Scale
					@shape = @shape.name
				else
					raise ArgumentError, 'Unknown Scale'
			end
		end
		
		def process_fill
			return unless @fill
			case @fill
				when String
					unless ::Plotrb::Kernel.find_scale(@fill)
					raise ArgumentError, 'Scale not found'
					end
				when ::Plotrb::Scale
					@fill = @fill.name
				else
					raise ArgumentError, 'Unknown Scale'
			end
		end
		
		def process_stroke
			return unless @stroke
			case @stroke
				when String
					unless ::Plotrb::Kernel.find_scale(@stroke)
					raise ArgumentError, 'Scale not found'
					end
				when ::Plotrb::Scale
					@stroke = @stroke.name
				else
					raise ArgumentError, 'Unknown Scale'
			end
		end		

		
		def process_properties
			return unless @properties
			valid_elements = %i(title labels symbols gradient legend)
			unless (@properties.keys - valid_elements).empty?
				raise ArgumentError, 'Invalid property element'
			end
		end
	
	end
end
