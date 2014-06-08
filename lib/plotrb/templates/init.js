if(window['d3'] === undefined ||
   window['vg'] === undefined){
    var paths = {
	d3: 'http://d3js.org/d3.v3.min',
	vg: 'http://trifacta.github.io/vega/vega.min'
    };

    require.config({paths: paths});

    require(['d3'], function(d3){
	window['d3'] = d3;
	console.log('Finished loading d3.js');
	require(['vg'], function(vg){
	    window['vg'] = vg;
	    console.log('Finished loading Vega');
	    for(var key in paths){
		d3.select('head')
		    .append('script')
		    .attr('type', 'text/javascript')
		    .attr('src', paths[key] + '.js');
	    }
	});
    });
}
