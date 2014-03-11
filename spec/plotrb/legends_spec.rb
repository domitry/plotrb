require_relative '../spec_helper'

describe 'Legend' do
  subject { ::Plotrb::Legend.new }
  
  describe '#size' do    
    it 'sets the scale backing the legend size by name' do
      subject.size('foo_scale')
      subject.size.should == 'foo_scale'
    end
  
    it 'sets the scale backing the legend size by the scale object' do
      scale = ::Plotrb::Scale.new.name('foo_scale')
      subject.size(scale)
      subject.send(:process_size)
      subject.size.should == 'foo_scale'
    end

    it 'raises error if scale is not found' do
      subject.size('foo_scale')
      ::Plotrb::Kernel.stub(:find_scale).and_return(nil)
      expect { subject.send(:process_size) }.to raise_error(ArgumentError)
    end
  
  end

  describe '#shape' do
    
    it 'sets the scale backing the legend shape by name' do
      subject.shape('foo_scale')
      subject.shape.should == 'foo_scale'
    end
  
    it 'sets the scale backing the legend shape by the scale object' do
      scale = ::Plotrb::Scale.new.name('foo_scale')
      subject.shape(scale)
      subject.send(:process_shape)
      subject.shape.should == 'foo_scale'
    end

    it 'raises error if scale is not found' do
      subject.shape('foo_scale')
      ::Plotrb::Kernel.stub(:find_scale).and_return(nil)
      expect { subject.send(:process_shape) }.to raise_error(ArgumentError)
    end
  
  end

  describe '#fill' do
    
    it 'sets the scale backing the legend fill color by name' do
      subject.fill('foo_scale')
      subject.fill.should == 'foo_scale'
    end
  
    it 'sets the scale backing the legend fill color by the scale object' do
      scale = ::Plotrb::Scale.new.name('foo_scale')
      subject.fill(scale)
      subject.send(:process_fill)
      subject.fill.should == 'foo_scale'
    end

    it 'raises error if scale is not found' do
      subject.fill('foo_scale')
      ::Plotrb::Kernel.stub(:find_scale).and_return(nil)
      expect { subject.send(:process_fill) }.to raise_error(ArgumentError)
    end
  
  end

  describe '#stroke' do
    
    it 'sets the scale backing the legend stroke color by name' do
      subject.stroke('foo_scale')
      subject.stroke.should == 'foo_scale'
    end
  
    it 'sets the scale backing the legend stroke color by the scale object' do
      scale = ::Plotrb::Scale.new.name('foo_scale')
      subject.stroke(scale)
      subject.send(:process_stroke)
      subject.stroke.should == 'foo_scale'
    end

    it 'raises error if scale is not found' do
      subject.stroke('foo_scale')
      ::Plotrb::Kernel.stub(:find_scale).and_return(nil)
      expect { subject.send(:process_stroke) }.to raise_error(ArgumentError)
    end
  
  end
  
  describe '#orient' do

    it 'sets the orient of the axis' do
      subject.at_left
      subject.orient.should == :left
    end
    
    it 'raises error if orient is invalid' do
      subject.orient(:top)
      expect { subject.send(:process_orient) }.to raise_error(ArgumentError)
    end

  end
  
  describe '#title' do

    it 'sets title of the axis' do
      subject.title('foo')
      subject.title.should == 'foo'
    end

  end
  
    describe 'format' do

    it 'accepts valid format specifier' do
      subject.format('04d')
      expect { subject.send(:process_format) }.to_not raise_error(ArgumentError)
    end

    it 'raises error if format specifier is invalid' do
      subject.format('{$s04d,g')
      expect { subject.send(:process_format) }.to raise_error(ArgumentError)
    end

  end

  describe '#offset' do

    it 'sets offset of the axis' do
      subject.offset_by(10)
      subject.offset.should == 10
    end

  end
  
  
  describe '#values' do

    it 'sets values if given as an array' do
      subject.values([1,2,3,4])
      subject.values.should match_array([1,2,3,4])
    end

    it 'sets values if given one by one as arguments' do
      subject.values(1,2,3,4)
      subject.values.should match_array([1,2,3,4])
    end

  end
  
end

