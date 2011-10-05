// uses jQuery, Raphael and Underscore
(function($) {
  
  function now() {
    return (new Date()).getTime();
  }
  
  function stroke2path(stroke) {
    var first = _.first(stroke);
    var path = _.map(_.rest(stroke), function(point) { return ["L", point[0], point[1]]; })
    if (path.length == 0)
      return [["M", first[0], first[1]], ["l", 0, 0.1]];
    else
      return [["M", first[0], first[1]]].concat(path);
  }
  
  // canvassify object constructor -> new Canvassified(...) yields object
  Canvassified = function(container, config) {
    var canvassified = this;
    var defaults = {
      width: $(container).width(),
      height: $(container).height(),
      disabled: false
    }
    var config = $.extend({}, defaults, config);
    // code here...
    $(container).css({width: config.width, heigt: config.height})
    var paper = Raphael(container, config.width, config.height);
        
    var drawing = false;
    var current_stroke;
    var current_path;
    canvassified.strokes = [];
    
    var start = function (evt) {
      drawing = true;
      var x,y;
      x = evt.pageX - $(container).offset().left;
      y = evt.pageY - $(container).offset().top;

      current_stroke = [[x,y,now()]]; // initialize new stroke
      current_path = paper.path(stroke2path(current_stroke)).attr({'stroke-width': 5, 'stroke-linecap': 'round'});
    }
    var stroke = function(evt) {
      if (drawing) {
        var x,y;
        x = evt.pageX - $(this).offset().left;
        y = evt.pageY - $(this).offset().top;

        // console.log('pushing point at',x, y);
        
        current_stroke.push([x,y,now()]);
        current_path.attr('path', stroke2path(current_stroke));
      }
      // else {
      //   console.log('not drawing');
      // }
    }
    var stop = function(evt) {
      // console.log('stopping');
      // console.log(evt);
      if (drawing) {
        canvassified.strokes.push(current_stroke);
        if (config.callback) config.callback(canvassified.strokes, canvassified);
        drawing = false;
      }
    }

    if (!config.disabled) {
      $(container).mousedown(start)
        .mousemove(stroke)
        .mouseup(stop)
        .mouseleave(stop);      
    }
    
    // maintainence functions
    canvassified.clear = function() {
      this.strokes = [];
      paper.clear();
    }
    
    canvassified.insert = function(strokes) {
      paper.clear();
      this.strokes = strokes;
      _(strokes).each(function(stroke){
        paper.path(stroke2path(stroke)).attr({'stroke-width': 5, 'stroke-linecap': 'round'});
      });
    }
    
  }
  
  $.canvassify = function (container, config) {
    var container = $(container).get(0);
    return container.canvassified || (container.canvassified = new Canvassified(container, config));
  }
  
  $.fn.extend({
    canvassify: function(config) {
      $.canvassify(this, config);
      return this;
    }
  });
  
})(jQuery);