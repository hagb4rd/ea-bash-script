/usr/bin/env node

var len=12; 
var xs="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=,./?<>".split("")

var xss=(new Array(len).fill(0)).map(c=>xs[Math.floor((Math.random()*xs.length))])
console.log(xss.join(''));

