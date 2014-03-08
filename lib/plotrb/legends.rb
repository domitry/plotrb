module Plotrb
	
	class Legend
		
		include ::Plotrb::Base
		
		LEGEND_PROPERTIES = [:size, :shape, :fill, :stroke, :orient, :title, 
		:format, :values, :properties]
		
		add_attributes *LEGEND_PROPERTIES
		
		def initialize(&block)
			define_single_val_attributes(:size, :shape, :fill, :stroke, :orient, 
			:title, :format)			
			define_multi_val_attributes(:values)
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
	
	end

end
