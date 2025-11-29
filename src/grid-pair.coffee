import { metaclass } from "@dashkite/joy/metaclass"
import { Grid } from "./grid"

class GridPair extends metaclass()
  
  @make: ({ input, output }) ->
    Object.assign ( new @ ),
      _: { input, output }

  @zip: ({ inputs, outputs }) ->
    for input, i in inputs
      output = outputs[ i ]
      GridPair.make { input, output }

  @getters

    input: -> @_.input

    output: -> @_.output

    scale: ->
      @_.scale ?= [
        ( @output.rows / @input.rows )
        ( @output.columns / @input.columns )
      ]

    congruent: ->
      [ m, n ] = @scale
      ( m == 1 ) && ( n == 1 )

    similar: ->
      [ m, n ] = @scale
      m == n

export { GridPair }