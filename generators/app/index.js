// Generated by CoffeeScript 1.4.0
(function() {
  'use strict';

  var copyFiles, folderGenerator, jacsGenerator, literal, npmModules, populatePropertiesMethod, yeoman;

  yeoman = require('yeoman-generator');

  literal = {
    PROMPT_APP_MESSAGE: {
      name: 'appName',
      message: 'Name of your app'
    },
    DEFAULT_FOLDERS: ['src', 'src/style/sass', 'src/scripts'],
    DEFAULT_FILES: ['Gruntfile.coffee', 'package.json', 'bower.json'],
    NPM_DEPENDENCIES: {
      MODULES: ['bower', 'coffee-script', 'groc', 'growl', 'grunt', 'grunt-bower-task', 'grunt-contrib-clean', 'grunt-contrib-coffee', 'grunt-contrib-compass', 'grunt-contrib-jade', 'grunt-contrib-requirejs', 'grunt-contrib-uglify', 'grunt-contrib-watch', 'grunt-http-server', 'grunt-notify'],
      CONFIG: {
        saveDev: true,
        save: true
      }
    }
  };

  populatePropertiesMethod = function(properties) {
    var nodeName;
    nodeName = literal.PROMPT_APP_MESSAGE.name;
    this[nodeName] = properties[nodeName];
    this.done();
    return this.done = void 0;
  };

  npmModules = function(modules, config, callBack) {
    return this.npmInstall(modules, config, callBack);
  };

  folderGenerator = function(folderName) {
    return this.mkdir("" + folderName);
  };

  copyFiles = function(fileName) {
    return this.src.copy(fileName, fileName);
  };

  jacsGenerator = {
    constructor: function() {
      this.folders = literal.DEFAULT_FOLDERS;
      this.files = literal.DEFAULT_FILES;
      this.npmdeps = literal.NPM_DEPENDENCIES.MODULES;
      this.npmconfig = literal.NPM_DEPENDENCIES.CONFIG;
      this.appName = void 0;
      return yeoman.generators.Base.apply(this, arguments);
    },
    prompting: {
      promptUserNameApp: function() {
        this.done = this.async();
        console.log(this.yeoman);
        return this.prompt(literal.PROMPT_APP_MESSAGE, populatePropertiesMethod.bind(this));
      }
    },
    writing: {
      scaffoldAppFolders: function() {
        this.destinationRoot("./" + this.appName);
        return this.folders.map(folderGenerator.bind(this));
      },
      createMainFiles: function() {
        return this.files.map(copyFiles.bind(this));
      }
    },
    install: {
      resolveNpmDependencies: function() {
        this.done = this.async();
        return npmModules.call(this, this.npmdeps, this.npmconfig, this.done);
      }
    },
    end: {
      sayGoodBye: function() {
        console.log(this.yeoman);
        console.log("" + this.appName + " configured");
        console.log("use grunt develop to start to develop");
        return console.log('Bye Bye');
      }
    }
  };

  module.exports = yeoman.generators.Base.extend(jacsGenerator);

}).call(this);