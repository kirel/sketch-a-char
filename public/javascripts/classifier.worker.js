importScripts('jquery.hive.pollen.js');
importScripts('sylvester.js');
importScripts('underscore-min.js');
importScripts('underscore-mixins.js');
importScripts('dtw.js');
importScripts('strokes.js');

var samples = {};
var counter = 0;

var measure = function(a, b) {
  return a.distanceFrom(b);
}

// sanitize = (map (dominant alpha
//                 .unduplicate
//                 .redistribute 10
//                 .aspectrefit (Point (0,0), Point (1,1))
//                 .smooth
//                 .unduplicate)
//                 ).limit 10
                
var process = function(sample) {
  return _(sample).chain().map(function(stroke){
    stroke = _(stroke).map(function(point){return $V(point.slice(0,2));});
    stroke = Strokes.unduplicate(stroke);
    stroke = Strokes.smooth(stroke);
    stroke = Strokes.fitInto(stroke, Strokes.bbFit(Strokes.boundingbox(stroke), $M([[0, 1], [0, 1]])));
    stroke = Strokes.redistribute(stroke, Strokes.length(stroke)/10);
    stroke = Strokes.unduplicate(stroke);    
    return stroke;
  }).flatten().value();
}

// TODO implement some clever logic that aborts current computation on new incoming message...

$(function (data) {
  // `this` equals WorkerGlobalScope
  // initialize samples
  if (data.init) {
    // initialize with Sylvester
    samples =
      _(data.init).reduce(function(memo, samplesForId, id){
        memo[id] = _(samplesForId).map(function(sample){
          return process(sample);
        });
        return memo;
      }, {});
    // done initializing
    $.send({message:"initialized. "+counter});
    $.send({message:samples});
  }
  else if (data.strokes) {
    // classify
    var stroke = process(data.strokes);
    counter += 1;

    res = {};
    _(samples).each(function(samples, id){
      _(samples).each(function(sample){
        var dist = gdtw(measure, sample, stroke); // TODO real preprocessing
        $.send({message:{dist:dist,stroke:stroke, sample: sample}});
        _.mergeWith(res, $.combine([id], [dist]), Math.min)
      });
    });

    $.send({message:"classified. "+counter});

    // send as {id:score}
    $.send({result:res});
  }
});