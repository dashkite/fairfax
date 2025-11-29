import Generic from "@dashkite/generic"
import { isNumber } from "@dashkite/joy/type"

Size =

  normalize: do ->

    ( Generic.make "Size.normalize" )

      .define [ Object ], ({ rows, columns }) ->
         [ rows, columns ]
      
      .define [ Function ], ( f ) ->
        ( args... ) ->
          f.apply @, Size.normalize args...

      .define [ Array ], ( size ) -> size

      .define [ isNumber, isNumber ], ( m, n ) -> [ m, n ]

export { Size }