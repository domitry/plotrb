module.exports = (grunt) ->
        grunt.initConfig
                copy:
                        vendor:
                                files: [
                                        expand: true
                                        cwd: 'src/vendor'
                                        src: ['**/*']
                                        dest: 'build/js/vendor'
                                ]
                        release:
                                files: [
                                        expand: true
                                        cwd: 'build/js'
                                        src: '*.js'
                                        dest: 'release/js'
                                       ,
                                        expand: true
                                        cwd: 'build/css'
                                        src: ['*.css']
                                        dest: 'release/css'
                                ]
                 coffee:
                        compile:
                                expand: true
                                cwd: 'src/coffee'
                                src: '**/*.coffee'
                                dest: 'build/js'
                                ext: '.js'
                 requirejs:
                        options:
                                baseUrl: 'build/js'
                                name: 'vendor/almond/almond'
                                paths:
                                        underscore: "vendor/underscore/underscore"
                                        d3: "vendor/d3/d3"
                                        nvd3: "vendor/nvd3/nv.d3"
                                        vega: "vendor/vega/vega"
                                shim:
                                        d3:
                                                exports: 'd3'
                                        nvd3:
                                                exports: 'nv'
                                                deps: ['d3']
                                        vega:
                                                exports: 'vg'
                                                deps: ['d3']
                                include: ['underscore', 'main']
                                wrap: {
                                        startFile: 'src/js/start.js'
                                        endFile: 'src/js/end.js'
                                }
                         production:
                                 options:
                                         optimizeAllPluginResources: true
                                         optimize: 'uglify2'
                                         out: "build/js/plotrb.min.js"
                         development:
                                 options:
                                         optimize: "none"
                                         out: "build/js/plotrb.js"
                 concat:
                        options:
                                separator: ""
                        css:
                                src: [
                                        "build/js/vendor/nvd3/nv.d3.min.css"
                                ]
                                dest: "build/css/plotrb.css"
                 cssmin:
                        minify:
                                expand: true
                                cwd: "build/css"
                                src: "plotrb.css"
                                dest: "build/css"
                                ext: ".min.css"
                                
        grunt.loadNpmTasks("grunt-contrib-coffee")
        grunt.loadNpmTasks("grunt-contrib-requirejs")
        grunt.loadNpmTasks("grunt-contrib-cssmin")
        grunt.loadNpmTasks("grunt-contrib-concat")
        grunt.loadNpmTasks("grunt-contrib-copy")

        grunt.registerTask("default", ["build"])
        grunt.registerTask("build", ["coffee", "copy:vendor", "concat"])
        grunt.registerTask("deploy", ["build", "requirejs", "cssmin"])
        grunt.registerTask("release", ["deploy", "copy:release"])
