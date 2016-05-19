module Cnv exposing (..) 
import Color exposing (..)
import Collage exposing (..)
import Element exposing (..)

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

drawCnv : Cnv -> Form
drawCnv cnv = 
  filled cnv.color (square (toFloat cnv.width))

