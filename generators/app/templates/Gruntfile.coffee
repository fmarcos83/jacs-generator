module.exports = (grunt) ->
    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'
        clean:
            options:
                force: true
            all: ["build"]
        #compile
        bower:
            default:
                options:
                    targetDir: 'build/lib/'
                    cleanBowerDir: false
                    cleanTargetDir: false
        jade:
            mocking:
                options:
                    data:
                        debug: false
                files:[
                    {
                        cwd: "src",
                        src: "**/*.jade"
                        dest: "build/"
                        expand: true
                        ext: ".html"
                    }
                ]
        coffee:
            mocking:
                files:[
                    cwd:'src'
                    src:['**/*.coffee']
                    dest:'build'
                    expand:true
                    ext: '.js'
                ]
            test:
                files:[
                    cwd:'test'
                    src:['**/*.coffee']
                    dest:'buildtest'
                    expand:true
                    ext: '.js'
                ]
        karma:
            unit:
                configFile: './karma.conf.js'
                autoWatch: true
        compass:
            mocking:
                options:
                    sassDir: 'src/style'
                    cssDir:  'build/style'
                    outputStyle: 'nested'
                    #this images should be resolved with bower
                    httpImagesPath: "img"
        #end compile
        watch:
            mocking:
                files:'./src/**'
                tasks: ['precompile:mocking']
                options:
                    livereload: true
            test:
                files:'./test/**'
                tasks: ['coffee:test']
        'http-server':
            mocking:
                root:'build/'
                port:5000
                autoIndex:true
                defaultExt:'html'
                runInBackground:true
                host: '0.0.0.0'
        uglify:
            options:
                banner: '/*!<%=pkg.name%><%=grunt.template.today("yyyy-mm-dd")%>*/\n'
            build:
                src:  'src/js/<%= pkg.name %>.js'
                dest: 'build/<%= pkg.name %>.min.js'


    grunt.loadNpmTasks 'grunt-notify'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-clean'

    #compile
    grunt.loadNpmTasks 'grunt-contrib-jade'
    grunt.loadNpmTasks 'grunt-contrib-compass'
    grunt.loadNpmTasks 'grunt-contrib-coffee'

    #livereload
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-http-server'
    grunt.loadNpmTasks 'grunt-bower-task'

    #karma
    grunt.loadNpmTasks 'grunt-karma'

    grunt.registerTask 'server',
    [
        'compile'
        'coffee:test'
        'http-server:mocking'
        'karma:unit'
        'watch'
    ]

    grunt.registerTask 'develop',
    [
        'server'
    ]

    grunt.registerTask 'precompile',
    [
        'jade'
        'coffee'
        'compass'
    ]

    grunt.registerTask 'compile',
    [
        'bower'
        'precompile'
    ]

    grunt.registerTask 'mocking'
    ,
        'Prepares project for mocking'
    ,
    [
        "clean:all"
        #"validate"
        "compile"
        #"package:local"
    ]
    grunt.registerTask 'production'
    ,
        'Prepares project for production'
    ,
    [
        "clean:all"
        "validate"
        "compile:production"
        "optimize"
        "package:browser"
    ]
