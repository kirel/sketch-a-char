// uses sylvester and Underscore
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
    },
    // returns a Matrix where the cols are bottom-left and top-right
    boundingbox: function(stroke) {
      var l = _(stroke).first().e(1);
      var b = _(stroke).first().e(2);
      var r = _(stroke).first().e(1);
      var t = _(stroke).first().e(2);
      var lbrt = _(stroke).chain().rest().reduce(function(lbrt, v) {
        var l = v.e(1);
        var b = v.e(2);
        var r = v.e(1);
        var t = v.e(2);
        var lMin = lbrt[0];
        var bMin = lbrt[1];
        var rMax = lbrt[2];
        var tMax = lbrt[3];
        return [Math.min(l, lMin), Math.min(b, bMin), Math.max(r, rMax), Math.max(t, tMax)];
      }, [l,b,r,t]).value();
      var lMin = lbrt[0];
      var bMin = lbrt[1];
      var rMax = lbrt[2];
      var tMax = lbrt[3];
      return $M([[lbrt[0], lbrt[2]], [lbrt[1], lbrt[3]]]);
    },
    fitInto: function(stroke, targetBB) {
      var sourceBB = this.boundingbox(stroke);
      var reset = sourceBB.col(1);
      var bbWidth = sourceBB.e(1,1) - sourceBB.e(1,2);
      var bbHeight = sourceBB.e(2,1) - sourceBB.e(2,2);
      var targetWidth = targetBB.e(1,1) - targetBB.e(1,2);
      var targetHeight = targetBB.e(2,1) - targetBB.e(2,2);
      var scaleX = 1;
      if (bbWidth !== 0) scaleX = 1/bbWidth * targetWidth;
      var scaleY = 1;
      if (bbHeight !== 0) scaleY = 1/bbHeight * targetHeight;
      var scale = Matrix.Diagonal([scaleX, scaleY]);
      var transX = targetBB.e(1,1);
      if (bbWidth === 0) transX = transX + 1/2 * targetWidth;
      var transY = targetBB.e(2,1);
      if (bbHeight === 0) transY = transY + 1/2 * targetHeight;
      var trans = $V([transX, transY]);
      
      return _(stroke).map(function(p){
        return scale.multiply(p.subtract(reset)).add(trans);
      });
    }
  };
})();