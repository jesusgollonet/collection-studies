module Cnv where 
import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)

-- canvas
type alias Cnv = 
  { width : Int 
  , height : Int 
  , color : Color
  }

cnv : Int -> Int -> Color -> Cnv
cnv w h c =
  { width = w
  , height = h
  , color = c
  }

drawCnv : Cnv -> List Form -> Element
drawCnv cnv coll = 
  collage cnv.width cnv.height ((filled cnv.color (square (toFloat cnv.width))):: coll)

