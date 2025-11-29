import * as M from "mathjs"
import { Grid } from "./grid"

class Subgrid extends Grid

  @make: ( parent, indices ) ->
    indices = structuredClone indices
    Object.assign ( new @ ), { parent, indices }

  @getters

    _: -> 
      M.subset @parent._,
        ( M.index ( M.range @indices[ 0 ]..., true ),
          ( M.range @indices[ 1 ]..., true )),

  set: ( index, value ) ->
    @parent.set ( @offset index ), value

  offset: ( index ) ->
    [
      ( @indices[ 0 ][ 0 ]) + ( index[ 0 ]),
      ( @indices[ 1 ][ 0 ]) + ( index[ 1 ])
    ]


Subgrids =

  from: ( parent, [ rows, columns ]) ->    
    yield from do ( indices = []) ->
      indices[ 0 ] = [ 0, ( rows - 1 )]
      while ( indices[0][ 0 ] < parent.rows )
        indices[ 1 ] = [ 0, ( columns - 1 )]
        while ( indices[ 1 ][ 0 ] < parent.columns )
          yield Subgrid.make parent, indices
          indices[ 1 ] = [
            ( indices[ 1 ][ 1 ] + 1 ) # start
            ( indices[ 1 ][ 1 ] + columns ) # end
          ]
        indices[ 0 ] = [
          ( indices[ 0 ][ 1 ] + 1 ) # start
          ( indices[ 0 ][ 1 ] + rows ) # end
        ]
      return

export { Subgrid, Subgrids }