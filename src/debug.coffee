import { table } from "table"
import chalk from "chalk"

debug = do ({ colors } = {}) ->

  colors = [
    "#000000"
    "#1E93FF"
    "#F93C31"
    "#4FCC30"
    "#FFDC00"
    "#999999"
    "#E53AA3"
    "#FF851B"
    "#87D8F1"
    "#921231"
  ]

  ( grid ) ->
    _output =
      for m in [0...grid.rows]
        for n in [0...grid.columns]
          value = grid._.get [ m, n ]
          color =
            if !value?
              "#555" 
            else if value >= 0
              colors[ value ]
            else
              "#FFF"
          chalk.bgHex( color )("   ")  

    console.log { m, n }     
    console.log table _output, 
      columnDefault:
        paddingLeft: 0
        paddingRight: 0

export { debug }