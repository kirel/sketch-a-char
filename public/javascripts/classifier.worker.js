importScripts('jquery.hive.pollen.js');
importScripts('underscore-min.js');
importScripts('underscore-mixins.js');
importScripts('dtw.js');

var samples = {};
var counter = 0;

var measure = function(a, b) {
  return Math.abs(a.x - b.x) + Math.abs(a.y - b.y);
}

$.ajax.get({
  url: '../api/samples.json',
  dataType:'json',
  success: function(jsonObj) {
    samples = jsonObj;
    $.send({message:'...loaded /api/samples.json'});
    $.send({message:samples});
  }
});

// TODO implement some clever logic that aborts current computation on new incoming message...

$(function (data) {

  // `this` equals WorkerGlobalScope
  // classify
  var stroke = _.flatten(data.strokes); // TODO real preprocessing
  counter += 1;
  
  res = {};
  _(samples).each(function(samples, id){
    _(samples).each(function(sample){
      var dist = gdtw(measure, _.flatten(sample), stroke); // TODO real preprocessing
      $.send({message:dist});
      _.mergeWith(res, $.combine([id], [dist]), Math.min)
    });
  });
  
  $.send({message:"classified. go"+counter});

  $.send({message:res});    

});