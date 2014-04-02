define [
        "d3",
        "nvd3"
], (d3, nvd3) ->
        render = (spec, el) ->
                nv.addGraph () ->
                        chart = spec.chart()
                        chart.width(spec.width)
                        chart.height(spec.height)

                        # setting axis, scale, ..etc.
                        chart.transitionDuration(350)

                        d3.select(el + ' svg').datum(spec.data).call(chart)
                        d3.select(el).style("height", spec.height.toString(10)+'px')
                        
                        nv.utils.windowResize(chart.update)
                        return chart
