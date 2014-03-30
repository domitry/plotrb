define (require, exports, module) ->
        Plotrb = {}

        Plotrb.embed_core = require("core/embed_core")
        
        exports.Plotrb = Plotrb
        
        return Plotrb
        
