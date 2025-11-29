import { inspect } from "node:util"
import * as M from "mathjs"
import { metaclass } from "@dashkite/joy/metaclass"
import { Size } from "./size"
import { fill } from "@dashkite/metro"
import { Pixel } from "./pixel"

class Grid extends metaclass()
  
  @make: ( data ) ->
    Object.assign ( new @ ), _: M.matrix data
  
  @from: ( matrix ) ->
    Object.assign ( new @ ), _: matrix

  @fill: ( value, size... ) ->
    ( @zeros size... )
      .fill value

  @blank: Size.normalize ( m, n ) ->
    @from fill m, n, -1

  @zeros: Size.normalize ( m, n ) ->
    @from M.zeros m, n

  @ones: Size.normalize ( m, n ) ->
    @from M.ones m, n

  @getters
    data: -> @_.toArray()
    rows: -> @size[ 0 ]
    columns: -> @size[ 1 ]
    size: -> @_.size()

  has: ([ m, n ]) ->
    ( m >= 0 ) && ( n >= 0 ) &&
      ( m < @rows ) && ( n < @columns )

  get: ( index ) -> @_.get index

  set: ( index, value ) -> @_.set index, value

  resize: ( size, value = undefined ) ->
    Grid.from @_.resize size, value

  equal: ( grid ) ->
    M.deepEqual @_, grid._

  entries: ->
    matrix = @_.valueOf()
    for i in [ 0...@rows ]
      for j in [ 0...@columns ] 
        yield Pixel.make
          index: [ i, j ]
          value: matrix[ i ][ j ]
    return

  values: ->
    yield value for { value } from @entries()
      
  # feels like there should be a clever way to do this
  # but this ended up being the most expressive
  scale: ([ m, n ]) ->
    Grid.blank [( @rows * m ), ( @columns * n )]
    
  clone: -> Grid.from M.clone @_

  copy: ( target ) ->
    for { index, value } from @entries()
      target.set index, value
    target

  clip: ( indices ) ->
    Grid.from M.subset @_,
      ( M.index ( M.range indices[ 0 ]..., true ),
        ( M.range indices[ 1 ]..., true )),

  fill: ( value ) ->
    for { index } from @entries()
      @set index, value
    @
  
  zeros: -> @fill 0

  ones: -> @fill 1

  blank: -> @fill -1
    
  replace: ( change ) ->
    for { index, value } from @entries() when ( value == change.from )
      @set index, change.to
    @

  draw: ( features ) ->
    for feature from features
      for { index, value } from feature
        @set index, value
    @

  toArray: -> @_.toArray()

  toString: ->
    "Grid(#{ @rows }x#{ @columns })"
  
  [inspect.custom]: -> @toString()

export { Grid }