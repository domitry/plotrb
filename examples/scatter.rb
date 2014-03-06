require 'plotrb'

raw_data = pdata.name('iris').url('iris_data.json')
xs = linear_scale.name('x').from('iris.sepalWidth').to_width.nicely
ys = linear_scale.name('y').from('iris.petalLength').to_height.nicely
cs = ordinal_scale.name('c').from('iris.species').range(["#800", "#080", "#008"])

xaxis = x_axis.scale(xs).offset(5).ticks(5).title('Sepal Width')
yaxis = y_axis.scale(ys).offset(5).ticks(5).title('Petal Length')

mark = symbol_mark.from(raw_data) do
	enter do 
		x	{ scale(xs).field('sepalWidth') }
		y 	{ scale(ys).field('petalLength') }
		fill	{ scale(cs).field('species') }
		fill_opacity		0.5
	end
	update do
		size 100
		stroke 'transparent'
	end
	hover do
		size 300
		stroke 'white'
	end
end

@vis = visualization.name('arc').width(200).height(200) do
	data raw_data
	scales xs, ys, cs
	axes xaxis, yaxis
	marks mark
end

puts @vis.generate_spec(:pretty)
