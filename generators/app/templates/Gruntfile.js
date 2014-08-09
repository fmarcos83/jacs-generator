// Generated by CoffeeScript 1.4.0
(function() {

  module.exports = function(grunt) {
    grunt.initConfig({
      pkg: grunt.file.readJSON('package.json'),
      clean: {
        options: {
          force: true
        },
        all: ["build"]
      },
      bower: {
        "default": {
          options: {
            targetDir: 'build/lib/',
            cleanBowerDir: false,
            cleanTargetDir: false
          }
        }
      },
      jade: {
        mocking: {
          options: {
            data: {
              debug: false
            }
          },
          files: [
            {
              cwd: "src",
              src: "**/*.jade",
              dest: "build/",
              expand: true,
              ext: ".html"
            }
          ]
        }
      },
      coffee: {
        mocking: {
          files: [
            {
              cwd: 'src',
              src: ['**/*.coffee'],
              dest: 'build',
              expand: true,
              ext: '.js'
            }
          ]
        }
      },
      compass: {
        mocking: {
          options: {
            sassDir: 'src/style',
            cssDir: 'build/style',
            outputStyle: 'nested',
            httpImagesPath: "img"
          }
        }
      },
      watch: {
        mocking: {
          files: './src/**',
          tasks: ['precompile:mocking'],
          options: {
            livereload: true
          }
        }
      },
      'http-server': {
        mocking: {
          root: 'build/',
          port: 5000,
          autoIndex: true,
          defaultExt: 'html',
          runInBackground: true
        }
      },
      uglify: {
        options: {
          banner: '/*!<%=pkg.name%><%=grunt.template.today("yyyy-mm-dd")%>*/\n'
        },
        build: {
          src: 'src/js/<%= pkg.name %>.js',
          dest: 'build/<%= pkg.name %>.min.js'
        }
      }
    });
    grunt.loadNpmTasks('grunt-notify');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-jade');
    grunt.loadNpmTasks('grunt-contrib-compass');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-http-server');
    grunt.loadNpmTasks('grunt-bower-task');
    grunt.registerTask('server', ['compile', 'http-server:mocking', 'watch:mocking']);
    grunt.registerTask('develop', ['server']);
    grunt.registerTask('precompile', ['jade', 'coffee', 'compass']);
    grunt.registerTask('compile', ['bower', 'precompile']);
    grunt.registerTask('mocking', 'Prepares project for mocking', ["clean:all", "compile"]);
    return grunt.registerTask('production', 'Prepares project for production', ["clean:all", "validate", "compile:production", "optimize", "package:browser"]);
  };

}).call(this);
