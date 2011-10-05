_.mixin({
  mergeWith : function(dest, source, fn) {
    _(source).each(function(val, key){
      if (dest[key]) {
        dest[key] = fn(dest[key], val);
      }
      else {
        dest[key] = val;
      }
    });
    return dest;
  }
});