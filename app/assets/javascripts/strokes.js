// uses sylvester and Underscore
var Strokes = (function () {
  var width = function(bb) {
    return bb.e(1,2) - bb.e(1,1);
  }
  
  var height = function(bb) {
    return bb.e(2,2) - bb.e(2,1);
  } 
  
  return {
    sim: function(fst, snd) {
      if (fst.length === snd.length) {
        return _(_.zip(fst, snd)).all(function (vs) {
          v = vs[0]; w = vs[1];
          return v.eql(w);
        });      
      }
      else {
        return false;
      }
    },
    length: function(stroke) {
      if (_(stroke).size() < 2) return 0;
      var current = _(stroke).first();
      stroke = _(stroke).rest();
      var next = _(stroke).first();
      var res = 0;
      var dir, d;
      while (!_(stroke).isEmpty()) {
        dir = next.subtract(current);
        d = Math.sqrt(dir.dot(dir));
        res += d;
        var current = next;
        stroke = _(stroke).rest();
        var next = _(stroke).first();
      }
      return res;
    },
    unduplicate: function(stroke) {
      var res = _.first(stroke, 1);
      _(_.rest(stroke)).each(function(v) {
        if (!v.eql(_.last(res))) {
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
    fitIntoFactors: function(sourceBB, targetBB) {
      var reset = sourceBB.col(1);
      var bbWidth = width(sourceBB);
      var bbHeight = height(sourceBB);
      var targetWidth = width(targetBB);
      var targetHeight = height(targetBB);
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
      
      return {
        scale: scale, reset: reset, trans: trans
      };
    },
    // use fitInto(stroke, bbFit(boundingbox(stroke), targetBB)) !
    fitInto: function(stroke, targetBB) {
      var sourceBB = this.boundingbox(stroke);
      
      var factors = this.fitIntoFactors(sourceBB, targetBB)
      
      return _(stroke).map(function(p){
        return factors.scale.multiply(p.subtract(factors.reset)).add(factors.trans);
      });
    },
    multiFitInto: function(strokes, targetBB) {
      var sourceBB = this.boundingbox(_(strokes).flatten());
      
      var factors = this.fitIntoFactors(sourceBB, targetBB)
      
      return _(strokes).map(function(stroke){        
        return _(stroke).map(function(p){
          return factors.scale.multiply(p.subtract(factors.reset)).add(factors.trans);
        });
      });
    },
    bbFit: function(sourceBB, targetBB) {
      var reset = sourceBB.col(1);
      
      // Hack for degenerated sourceBB
      if (reset.eql(sourceBB.col(2))) return $M([
        targetBB.col(1).add(targetBB.col(2)).x(1/2).elements,
        targetBB.col(1).add(targetBB.col(2)).x(1/2).elements
      ]).transpose();
      
      // non degenerated cases
      var sourceWidth = width(sourceBB);
      var sourceHeight = height(sourceBB);
      var targetWidth = width(targetBB);
      var targetHeight = height(targetBB);
      var sourceRatio = sourceWidth/sourceHeight;
      var targetRatio = targetWidth/targetHeight;
      // bigger ratio <~> wider
      var sourceWider = sourceRatio > targetRatio;
      if (sourceWider) {
        var scaleFactor = targetWidth/sourceWidth;
        var offset = $V([0, (targetHeight - scaleFactor*sourceHeight)/2]);
      }
      else {
        var scaleFactor = targetHeight/sourceHeight;
        var offset = $V([(targetWidth - scaleFactor*sourceWidth)/2, 0]);
      }
      var scale = Matrix.Diagonal([scaleFactor, scaleFactor]);
      var trans = targetBB.col(1);
      
      return $M(_([sourceBB.col(1), sourceBB.col(2)]).map(function(p){
        return scale.multiply(p.subtract(reset)).add(offset).add(trans).elements;
      })).transpose();
    },
    // use redistribute(stroke, length(stroke)/n)
    redistribute: function(stroke, length) {
      // redistribute' dist s@(p:q:ps) = p:(redist dist s) where -- first point always part of new stroke
      //   redist :: Double -> Stroke -> Stroke
      //   redist left (p:q:ps) | d < left = redist (left - d) (q:ps)
      //                        | otherwise = ins:(redist dist (ins:q:ps))
      //                          where
      //                            dir = q `sub` p
      //                            d = norm dir
      //                            ins = p `add` ((left/d) `scalar` dir)
      //   redist _ ps = ps -- done when only one left
      // redistribute' _ ps = ps -- empty or single point strokes stay unmodified
      
      if (_(stroke).size() < 2) return stroke;
      
      var left = length;
      var current = _(stroke).first();
      var res = [current];
      stroke = _(stroke).rest();
      var next = _(stroke).first();
      var dir, d, ins;
      while (!_(stroke).isEmpty()) {
        dir = next.subtract(current);
        d = Math.sqrt(dir.dot(dir));
        if (d < left) {
          current = next;
          stroke = _(stroke).rest();
          next = _(stroke).first();
          left = left - d;
        }
        else {
          ins = current.add(dir.x(left/d));
          res.push(ins);
          current = ins;
          // next stays as is
          left = length;
        }
      }
      res.push(current);
      return res;
    },
    dominant: function(stroke, angle) {
      // dominant :: Double -> Stroke -> Stroke
      // dominant alpha s@(x:y:z:ps) = x:(dominant' alpha s) where
      //   dominant' alpha (x:y:z:ps) | angle x y z < alpha = dominant' alpha (x:z:ps)
      //                              | otherwise = y:(dominant' alpha (y:z:ps))
      //   dominant' _ (x:ps) = ps
      //   -- angle x y z = acos (min 1 (max (-1) (1/((norm v)*(norm w)) `scalar` v `dot` w))) where
      //   angle x y z = acos $ fixdomain $ (v `dot` w)/((norm v)*(norm w)) where
      //     fixdomain = (min 1).(max (-1))
      //     v = y `sub` x
      //     w = z `sub` y
      // dominant _ ps = ps
      if (_(stroke).size() < 3) return stroke;
      
      var current = _(stroke).first();
      var res = [current];
      stroke = _(stroke).rest();
      var middle = _(stroke).first();
      stroke = _(stroke).rest();
      var next = _(stroke).first();
      while (next) {
        if (middle.subtract(current).angleFrom(next.subtract(middle)) > angle) {
          res.push(middle);
          current = middle;
        }
        middle = next;
        stroke = _(stroke).rest();
        next = _(stroke).first();
      }      
      res.push(middle);
      return res;
    }
  };
})();