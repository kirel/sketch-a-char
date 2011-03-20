$(function(){
  $('.sample-canvas').each(function(){
    var json = $(this).attr('data-strokes');
    $.canvassify(this, {width: 400, height: 400, disabled: true}).insert(JSON.parse(json));
  });  
});
