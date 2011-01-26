// main app js
$(function(){
  // Strokes & Canvas
  var StrokesModel = Backbone.Model.extend({});
  
  var CanvasView = Backbone.View.extend({
    // className: 'canvas',
    
    initialize: function(options) {
      _.bindAll(this, "render");
      var canvas = $('<div/>').addClass('canvas').appendTo(this.el);
      this.model.bind('change:strokes', this.render); // automatic updates on changes to the model
      this.canvassified = $.canvassify(canvas, _(options).extend({callback: function(strokes){
        this.model.unset('strokes'); // workaround
        this.model.set({strokes: strokes});
      }}));
      
      if (options.clear) {
        var clearButton = $('<button>clear</button>').addClass('clear').appendTo(this.el);
      }
      
    },
    
    events: {
      "click .clear" : "clear",
      
    },
      
    render: function() {
      this.update();
      return this;
    },
    
    // called on change:strokes
    update: function() {
      this.canvassified.insert(this.model.get("strokes"));
    },
    
    clear: function() {
      this.model.set({strokes:[]});
    }
  }); // CanvasView
  
  var strokes = new StrokesModel({strokes:[]});
  var canvas = new CanvasView({el: $('#canvas'), model:strokes, width: 400, height: 400, clear: true});
  
  strokes.bind('change:strokes', function() {
    canvas.render();
    console.log('strokes changed');
  });
  
  // canvas.clear();
  
  // Stuff
  
  // var classify = function(strokes, canvassified) { console.log(strokes); }
  // 
  // var canvas = $.canvassify('#recognition-canvas .canvas', {width: 400, height: 400, callback: classify});
  // $('#recognition-canvas button.clear').click(function(){
  //   canvas.clear();
  //   return false;
  // });
  // $('#recognition-canvas button.recognize').click(function(){
  //   classify(canvas.strokes, canvas);
  //   canvas.clear();
  //   return false;
  // });
  
});