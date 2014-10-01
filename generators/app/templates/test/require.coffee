'use strict'

tests = ( file for file of window.__karma__.files when /.*Spec\.js$/.test(file) )

console.log tests

require.config
  baseUrl     : "./"
  waitSeconds : 0
  paths :
    #'{requiremoduleName}':'{realpath}'
    undefined
  shim :
    #'{newRequiredmoduleName}'
       #exports:{'oldRequiredmoduleName'}
    undefined

  #loading all the tests before starting karma server
  deps: tests
  callback: window.__karma__.start
