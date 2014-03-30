define [
        "underscore",
        "nvd3"
], (_, nv) ->
        parse = (models) ->
                # parse marks, and identify what charts to render
                return nv.models.multiBarChart
                
        exports = {
                parse: parse
        }

        return exports
