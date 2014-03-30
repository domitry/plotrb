define [
        "parse/data",
        "parse/chart"
], (data, chart) ->
        parse = (models) ->
                spec = {
                        width: models.width
                        height: models.height
                        data: data.parse(models)
                        chart: chart.parse(models)
                        # axis, scales,..etc. options will be supported.
                }
                
        return parse
