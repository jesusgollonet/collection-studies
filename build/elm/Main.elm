module Main (..) where

import Sq exposing (Sq, squareWith, drawSq)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Color exposing (..)
import Array exposing (..)
import List exposing (concat)

-- what is this program trying to accomplish?
-- draw a collection of objects in a 'canvas'
-- render canvas collection

-- create cnv (conceptual canvas)
-- create collage passing background and collection
main : Element
main =
  let c = cnv 500 500 grey
      elements = collection c
  in
      drawCnv c elements

-- create collection of objects (i think this should be split into 2. create collection + render)
collection : Cnv -> List Form 
collection cnv = 
  toList ( map drawSq ( initialize 1480 (arrange cnv)))


-- arrange single element given its index.
arrange : Cnv -> Int -> Sq
arrange cnv i =
  let r =  ((toFloat cnv.width / 2) * 0.9)
      tau = 2 * pi
      pctInRing = toFloat (i % 40) / 40
      ring = toFloat (i // 40)
      ringPct = ring /toFloat (480 // 40)

      position = 
        ( cos ( pctInRing * tau ) * ( r * ringPct ) 
        , sin ( pctInRing * tau ) * ( r * ringPct )
        )
      size =  (1 + ringPct) * 8 
      rotation =   ((1 - pctInRing) * tau )
  in
      squareWith position size rotation

-- MODELS 

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

