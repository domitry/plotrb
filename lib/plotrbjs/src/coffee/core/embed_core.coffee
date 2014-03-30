define [
        "vega",
        "parse/base",
        "render/base"
], (vega, parse, render) ->
        add_plot = (models, el)->
                if models.enable? and models.enable.indexOf('interactive') isnt -1
                        spec = parse models
                        render spec, el
                else
                        vg.parse.spec models, (chart) ->
                                chart({el:el, renderer:'svg'}).update()

        exports = {
                add_plot : add_plot
        }
        return exports
