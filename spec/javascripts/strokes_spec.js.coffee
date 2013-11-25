#= require underscore-min
#= require sylvester
#= require strokes

describe 'strokes', ->

  stroke = null

  beforeEach ->
    stroke = _(_.range(10)).map -> Vector.Random(2)

  p1 = Vector.Random(2)
  p2 = Vector.Random(2)
  p3 = Vector.Random(2)
  p4 = Vector.Random(2)

  it "is similar for same strokes", ->
    expect( Strokes.sim(stroke, stroke) ).to.equal(true)

  it "Different vectors are dissimilar", ->
    expect( Strokes.sim(stroke, []) ).to.equal(false)

  it "length", ->
    stroke = [$V([0,0]), $V([0.1,0]), $V([0.2,0]), $V([0.3,0]), $V([0.4,0]), $V([0.5,0])]
    expect( Strokes.length(stroke) ).to.equal( 0.5 )

  it "unduplicate", ->
    point = Vector.Random(2);
    expect( Strokes.sim( [point], Strokes.unduplicate([point, point]) ) ).to.equal(true)

  it "smooth", ->
    expect( Strokes.sim( [], Strokes.smooth([]) ) ).to.equal(true)
    expect( Strokes.sim( [p1], Strokes.smooth([p1]) ) ).to.equal(true)
    expect( Strokes.sim( [p1, p2], Strokes.smooth([p1, p2]) ) ).to.equal(true)
    expect( Strokes.sim( Strokes.smooth([p1, p2, p3]), [p1, p1.add(p2).add(p3).x(1.0/3.0), p3] ) ).to.equal(true)
    expect( Strokes.sim( Strokes.smooth([p1, p2, p3, p4]), [p1, p1.add(p2).add(p3).x(1.0/3.0), p2.add(p3).add(p4).x(1.0/3.0), p4]) ).to.equal(true)

  it "bounding box", ->
    bl = $V([0,0]);
    tr = $V([2,2]);
    bb = Strokes.boundingbox([bl, tr]);
    expect( bb.col(1).eql(bl) ).to.equal(true)
    expect( bb.col(2).eql(tr) ).to.equal(true)

  it "fit into", ->
    targetBB = $M([[0, 1], [0, 1]])
    bb = Strokes.boundingbox(Strokes.fitInto(stroke, targetBB))
    expect( bb.eql(targetBB) ).to.equal(true)

  it "bounding box fit", ->
    targetBB = $M([
      [0, 1],
      [0, 1]
    ])
    sourceBB = $M([
      [1, 2],
      [1, 2]
    ])
    bb = Strokes.bbFit(sourceBB, targetBB)
    expect( bb.eql(targetBB) ).to.equal(true)

    targetBB = $M([
      [0, 3],
      [0, 1]
    ])
    sourceBB = $M([
      [0, 1],
      [0, 1]
    ])
    fitBB = $M([
      [1, 2],
      [0, 1]
    ])
    bb = Strokes.bbFit(sourceBB, targetBB)
    expect(bb.eql(fitBB)).to.equal(true)

    targetBB = $M([
      [0, 2],
      [0, 1]
    ])
    sourceBB = $M([
      [0, 0],
      [0, 0]
    ])
    fitBB = $M([
      [1, 1],
      [0.5, 0.5]
    ])
    bb = Strokes.bbFit(sourceBB, targetBB)
    expect(bb.eql(fitBB)).to.equal(true)

  it 'redistribute', ->
    stroke = [$V([0,0]), $V([0.5,0])]
    expected = [$V([0,0]), $V([0.1,0]), $V([0.2,0]), $V([0.3,0]), $V([0.4,0]), $V([0.5,0])]
    actual = Strokes.redistribute(stroke, 0.1)
    expect( Strokes.sim(expected, actual) ).to.equal(true)

    # edge cases
    expect( Strokes.sim([], Strokes.redistribute([], 0.1)) ).to.equal(true)
    expect( Strokes.sim([$V([0,0])], Strokes.redistribute([$V([0,0])], 0.1)) ).to.equal(true)

  it 'dominant', ->
    stroke = [$V([0,0]), $V([1,0]), $V([1,1])]
    # leave middle
    expected = stroke
    actual = Strokes.dominant(stroke, 85/180*Math.PI)
    expect( Strokes.sim(expected, actual) ).to.equal(true)
    # kill middle
    expected = [$V([0,0]), $V([1,1])]
    actual = Strokes.dominant(stroke, 95/180*Math.PI)
    expect( Strokes.sim(expected, actual) ).to.equal(true)
