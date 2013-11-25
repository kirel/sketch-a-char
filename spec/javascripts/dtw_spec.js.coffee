#= require underscore-min
#= require sylvester
#= require dtw

describe 'dtw', ->
  poly = null

  beforeEach -> poly = _(_.range(10)).map -> Vector.Random(2)

  p1 = Vector.Random(2)
  p2 = Vector.Random(2)
  p3 = Vector.Random(2)
  p4 = Vector.Random(2)

  distance = (a, b) -> a.distanceFrom(b)

  it "The same poly has zero gdtw distance", -> expect( gdtw(distance , poly, poly) ).to.equal(0)
  it "Single point poly has euclidean distance", ->  expect( gdtw(distance , [p1], [p2]) ).to.equal( p1.distanceFrom(p2) )
  it "average euclidean distance", ->
    expect( gdtw(distance , [p1], [p1, p2]) ).to.equal( p1.distanceFrom(p2)/2 )
    expect( gdtw(distance , [p1], [p2, p2]) ).to.equal(  p1.distanceFrom(p2) )
