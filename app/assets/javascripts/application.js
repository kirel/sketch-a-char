//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require rails.validations
//= require glow
//= require humane
//= require underscore-min
//= require underscore-mixins
//= require sylvester
//= require strokes
//= require backbone-min
//= require raphael-min
//= require canvassify
//
//= require_self

var processSample = function(sample, width, height) {

  var vectorsample = _(sample).map(function(stroke){
    stroke = _(stroke).map(function(point){return $V(point.slice(0,2));});
    // stroke = Strokes.unduplicate(stroke);
    // stroke = Strokes.smooth(stroke);
    // stroke = Strokes.redistribute(stroke, Strokes.length(stroke)/10);
    // stroke = Strokes.unduplicate(stroke);
    return stroke;
  });

  var bb = Strokes.boundingbox(_(vectorsample).flatten());

  var refitsample = Strokes.multiFitInto(vectorsample, Strokes.bbFit(bb, $M([[0.1*width, 0.9*width], [0.1*height, 0.9*height]])));

  var sample = _(refitsample).map(function(stroke){
    stroke = _(stroke).map(function(vector){return vector.elements;});
    return stroke;
  });

  return sample;
}

var setupSampleCanvas = function(jquery) {
  $(jquery).each(function(){
    var json = $(this).attr('data-strokes');
    $.canvassify(this, {width: 300, height: 300, disabled: true}).insert(processSample(JSON.parse(json), 300, 300));
  });
}

$(function(){
  humane.notice = humane.info;
  $(document).bind('glow:flash', function(evt, flash) {
    humane[flash.type](flash.message);
  });
  setupSampleCanvas('.sample-canvas');
});
