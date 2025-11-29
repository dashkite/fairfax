import assert from "@dashkite/assert"
import {test, success} from "@dashkite/amen"
import print from "@dashkite/amen-console"

import * as M from "mathjs"

import { Grid, Subgrids, debug } from "@dashkite/fairfax"

do ->

  print await test "Fairfax", [

    test "subgrids", do ->

      A = Grid.from M.ones 9, 9
      grids = Array.from Subgrids.from A, [ 3, 3 ]
      subgrid = grids[ 8 ]
  
      [

        test "method", ->
          assert.equal 9, grids.length

        test "get", ->
          assert.equal 1, subgrid.get [ 2, 2 ]
          assert.throws -> subgrid.get [ 3, 3 ]
          subgrid.set [ 1, 1 ], 0
          assert.equal 0, subgrid.get [ 1, 1 ]

        test "set", ->
          assert.equal 0, A.get [ 7, 7 ]
          debug A

      ] 
  
  ]

  process.exit if success then 0 else 1
