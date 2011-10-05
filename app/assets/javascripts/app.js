//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require rails
//= require underscore-min
//= require underscore-mixins
//= require backbone-min
//= require raphael-min
//= require jquery.tmpl
//= require canvassify
//= require jquery.hive
//
//= require_self

// main app js
$(function(){

  var Symbol = Backbone.Model.extend({});
  var Symbols = Backbone.Collection.extend({
    model: Symbol,
  });
  var symbols = new Symbols();

  // TODO symbols refresh

  // Strokes & Canvas
  var StrokesModel = Backbone.Model.extend({
    clear: function() {
      this.set({strokes:[]});
    }
  });

  var CanvasView = Backbone.View.extend({
    // className: 'canvas',

    initialize: function(options) {
      _.bindAll(this, "render");
      var canvas = $('<div/>').addClass('canvas').appendTo(this.el);
      this.model.bind('change:strokes', this.render); // automatic updates on changes to the model
      this.canvassified = $.canvassify(canvas, _(options).extend({callback: function(strokes){
        // this.model.unset('strokes'); // workaround
        this.model.set({strokes: strokes});
        // this.model.trigger('change:strokes');
      }}));
    },

    // events: {
    //   "click .clear" : "clear",
    // },

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

  var Hit = Backbone.Model.extend({});

  var Hitlist = Backbone.Collection.extend({
    model: Hit,
    comparator: function(hit) { return hit.get('score'); }
  });

  var HitlistView = Backbone.View.extend({

    tagName: 'ul',

    className: 'hits',

    initialize: function() {
      _.bindAll(this, "render");
      this.collection.bind("refresh", this.render);
    },

    render: function() {
      var html = $('#hits-template').tmpl(this.collection.toJSON());
      $(this.el).html(html).find('> li').addClass('collapsed').click(function() { $(this).removeClass('collapsed'); });
      return this;
    }

  });

  // setting everything up
  var strokes = new StrokesModel({strokes:[]});
  var canvas = new CanvasView({el: $('#canvas'), model:strokes, width: 400, height: 400, clear: true});

  var hits = new Hitlist([new Hit()]);
  var hitlist = new HitlistView({collection: hits});

  // get app data and initialize hive
  // TODO App not fully initialized until the next request is done.
  $.getJSON('index.json', function(app_data) {

    var symbol_map = _(app_data).inject(function(acc, sym) { return _(acc).extend(_({}).tap(function(obj){ obj[sym.id] = sym }))}, {});

    // worker
    $.Hive.create({
      worker: 'javascripts/classifier.worker.js',
      receive: function (data) {
        if (data.message) {
          console.group('RECEIVED MESSAGE - WORKER: #' + data.WORKER_ID);
            console.log( data.message );
          console.groupEnd();
        }
        else if (data.result) {
          var h = _(data.result).map(function(score, id) { return new Hit({score: score, symbol: symbol_map[id]}); });
          hits.refresh(h);
        }
      }
    });

    $.Hive.get(0).send({
      init: _(app_data).inject(function(acc, sym) { return _(acc).extend(_({}).tap(function(obj){ obj[sym.id] = sym.sam }))}, {}) // sample map { id => samples }
    });

    // TODO: App is initialized and can be used now?!?

  });

  // interaction

  $('#canvas-controls .clear').click(function(){
    strokes.clear();
    hits.refresh([]);
    return false;
  });

  $('#canvas-controls .submit').click(function(){
    $.Hive.get(0).send({ strokes: strokes.get('strokes') });
    return false;
  });

  $(hitlist.el).appendTo('#hitlist-area');

  // hitlist.render();
  //
  // hits.refresh([new Hit(), new Hit()]);

});
