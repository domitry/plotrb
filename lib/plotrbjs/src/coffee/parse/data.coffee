define [
        "underscore"
], (_) ->
        parse = (models) ->
                data = []
                # convert vega style data to nvd3 style
                _.each models.data, (src_data) ->
                        data.push {
                                values: src_data.values
                                key: src_data.name
                        }
                return data

        exports = {
                parse: parse
        }

        return exports
