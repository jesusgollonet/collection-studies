module Main (..) where

import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Color exposing (..)
import Array exposing (..)
import List exposing (concat)

main =
  let w = 500
      h = 500
  in
      collage w h
        (concat [[filled grey (square (500))], toList ( map drawSq ( initialize 1480 (arrangeInCircle w h ((w / 2) * 0.9) )))])

arrangeInCircle w h r i =
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


drawSq : Sq -> Form
drawSq m =
  rotate m.rotation (move m.position (filled black (square m.size)))