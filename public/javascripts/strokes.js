var Strokes = (function () {
  return {
    sim: function(fst, snd) {
      if (fst.length === snd.length) {
        return _(_.zip(fst, snd)).all(function (vs) {
          v = vs[0]; w = vs[1];
          return v.distanceFrom(w) === 0;
        });      
      }
      else {
        return false;
      }
    },
    unduplicate: function(stroke) {
      var res = _.first(stroke, 1);
      _(_.rest(stroke)).each(function(v) {
        if (v.distanceFrom(_.last(res)) !== 0) {
          res.push(v);
        }
      });
      return res;
    },
    smooth: function(stroke) {
      var res = _.first(stroke, 1);
      while (stroke.length > 2) {
        var last = stroke[0];
        var current = stroke[1];
        var next = stroke[2];
        stroke = _.rest(stroke);
        res.push(last.add(current).add(next).x(1.0/3.0));
      }
      return res.concat(_.rest(stroke));
    },
    redistribute: function(stroke, length) {
      // var res = _.first(stroke, 1);
      // var current = _.first(stroke);
      // stroke = _.rest(stroke);
      // while (stroke.length > 1) {
      //   var last = _.last(res);
      //   var next = _.first(stroke);
      //   stroke = _.rest(stroke);
      // }
      // return res.concat(_.rest(stroke));
      return stroke;
    }
  };
})();