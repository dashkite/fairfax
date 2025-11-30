# import { table } from "table"
# import chalk from "chalk"

import SVG from "svg-builder"
import TerminalImage from "terminal-image"
import sharp from "sharp"

debug = do ({ colors } = {}) ->

  Colors =
    grid: [
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
    null: "#555"
    negative: "#FFF"
    border: "#333"



  ( grid ) ->

    k = 200
    height = grid.rows * k
    width = grid.columns * k

    svg = SVG
      .create()
      .width width
      .height height
      .viewBox("0 0 #{ width } #{ height }")

    for m in [ 0...grid.rows ]
      for n in [ 0...grid.columns ]
        value = grid.get [ m, n ]
        color =
          if !value?
            Colors.null
          else if value >= 0
            colors[ value ]
          else
            Colors.negative
        svg.rect
          x: ( n * k )
          y: ( m * k )
          width: k
          height: k
          fill: color 
          stroke: Colors.border
          "stroke-width": Math.floor k/25

    image = await do ->
      ( sharp Buffer.from svg.render())
        .png()
        .toBuffer()

    console.log { m, n }
    console.log await TerminalImage.buffer image, width: "90%"

export { debug }