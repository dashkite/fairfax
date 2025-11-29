import { metaclass } from "@dashkite/joy/metaclass"
import { parseNumber } from "@dashkite/joy/text"

encode = ({ index: [ row, column ], value }) -> 
  "#{ row }:#{ column }:#{ value }"

decode = ( text ) ->
  [ index..., value ] = do ->
    text
      .split ":"
      .map parseNumber
  { index, value }

class Pixel extends metaclass()

  @make: ({ index, value }) ->
    Object.assign ( new @ ), { index, value }

  @decode: ( text ) -> 
    @make decode text

  @getters
    encoded: -> @_encoded ?= encode @
    row: -> @index[0]
    m: -> @row
    column: -> @index[1]
    n: -> @column

  get: -> @value

  set: ( value ) ->
    Pixel.make { @index, value }

  offset: ([ m, n ]) ->
    Pixel.make
      index: [
          @m + m
          @n + n
        ]
      value: @value

  toString: -> encode @

export { Pixel }
