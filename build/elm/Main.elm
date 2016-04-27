module Main (..) where

import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Color exposing (..)
import Array exposing (..)
import List exposing (concat)

-- what is this program trying to accomplish?
-- draw a square and a collection of objects


-- create cnv (conceptual canvas)
-- create collage passing background and collection
main : Element
main =
  let c = cnv 500 500 grey
      {width, height} = c
  in
      collage width height ((bg c):: (collection c))

-- background
bg : Cnv -> Form
bg cnv =
  filled cnv.color (square (toFloat cnv.width))

-- create collection of objects
collection : Cnv -> List Form 
collection cnv = 
  let w = toFloat cnv.width
      h = toFloat cnv.height
  in
      toList ( map drawSq ( initialize 1480 (arrange w h ((w / 2) * 0.9) )))

-- arrange single element give its index
arrange : Float -> Float -> Float -> Int -> Sq
arrange w h r i =
  let tau = 2 * pi
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


-- an element in our collection
type alias Sq =
  { position : ( Float, Float )
  , size : Float
  , rotation : Float
  }

squareWith : ( Float, Float ) -> Float -> Float -> Sq
squareWith pos size rotation =
  { position = pos
  , size = size
  , rotation = rotation
  }

-- render element
drawSq : Sq -> Form
drawSq m =
  rotate m.rotation (move m.position (filled black (square m.size)))
