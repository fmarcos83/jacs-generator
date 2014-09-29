'use strict'
yeoman         = require 'yeoman-generator'
literal = 
    PROMPT_APP_MESSAGE :
       name    : 'appName'
       message : 'Name of your app'
    DEFAULT_FOLDERS : [
          'build'
          'src/views'
          'src/style/sass'
          'src/scripts'
        ]
    DEFAULT_FILES : [
        'Gruntfile.coffee'
        'package.json'
        'bower.json'
    ]
    NPM_DEPENDENCIES:
        MODULES:[
            'bower'
            'coffee-script'
            'groc'
            'growl'
            'grunt'
            'grunt-bower-task'
            'grunt-contrib-clean'
            'grunt-contrib-coffee'
            'grunt-contrib-compass'
            'grunt-contrib-jade'
            'grunt-contrib-requirejs'
            'grunt-contrib-uglify'
            'grunt-contrib-watch'
            'grunt-http-server'
            'grunt-notify'
            'karma'
            'karma-chrome-launcher'
            'karma-firefox-launcher'
            'karma-jasmine'
            'karma-requirejs'
            'requirejs'
        ]
        CONFIG:
            saveDev: true
            save   : true

populatePropertiesMethod = (properties) ->
    nodeName = literal.PROMPT_APP_MESSAGE.name
    @[nodeName] = properties[nodeName]
    @done()
    @done = undefined

npmModules = (modules, config, callBack) ->
    @npmInstall modules, config, callBack

folderGenerator = (folderName) ->
    @mkdir "#{folderName}"

copyFiles = (fileName) ->
    @src.copy fileName, fileName

jacsGenerator  = {
                    constructor: ->
                      @folders = literal.DEFAULT_FOLDERS
                      @files   = literal.DEFAULT_FILES
                      @npmdeps = literal.NPM_DEPENDENCIES.MODULES
                      @npmconfig = literal.NPM_DEPENDENCIES.CONFIG
                      @appName = undefined
                      yeoman.generators.Base.apply @, arguments
                    prompting:
                        promptUserNameApp: ->
                          @done = @async()
                          console.log @yeoman
                          @prompt(
                            literal.PROMPT_APP_MESSAGE,
                            populatePropertiesMethod.bind @
                          )
                    writing:
                        scaffoldAppFolders: ->
                          @destinationRoot "./#{@appName}"
                          @folders.map folderGenerator.bind @
                        createMainFiles: ->
                          #TODO: passing arguments in coffee more elegantly
                          @files.map copyFiles.bind @
                    install:
                        resolveNpmDependencies: ->
                          @done = @async()
                          npmModules.call @, @npmdeps, @npmconfig, @done
                    end:
                        sayGoodBye: ->
                            console.log @yeoman
                            console.log "#{@appName} configured"
                            console.log "use grunt develop to start to develop"
                            console.log 'Bye Bye'
                 }
module.exports = yeoman.generators.Base.extend jacsGenerator
