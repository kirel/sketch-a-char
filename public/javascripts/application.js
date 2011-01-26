// main app js
$(function(){
  var classify = function(strokes, canvassified) { console.log(strokes); }
  
  var canvas = $.canvassify('#recognition-canvas .canvas', {width: 400, height: 400, callback: classify});
  $('#recognition-canvas button.clear').click(function(){
    canvas.clear();
    return false;
  });
  $('#recognition-canvas button.recognize').click(function(){
    classify(canvas.strokes, canvas);
    canvas.clear();
    return false;
  });
});