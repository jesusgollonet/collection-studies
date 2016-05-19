module Main exposing (..) 

import Sq exposing (Sq, squareWith, drawSq)
import Cnv exposing (Cnv, cnv, drawCnv)
import Collage exposing (..)
import Element exposing (..)
import Color exposing (..)
import Array exposing (..)
import List exposing (concat)
import Html exposing(..)

-- what is this program trying to accomplish?
-- draw a collection of objects in a 'canvas'
-- render canvas collection

-- create cnv (conceptual canvas)
-- create collage passing background and collection
main : Html msg
main =
  let c = cnv 500 500 blue
      elements = collection c
  in
    toHtml (render c (collection c))

render : Cnv -> List Form -> Element
render cnv l = 
  collage cnv.width cnv.height ((drawCnv cnv)::l)

-- create collection of objects (i think this should be split into 2. create collection + render)
collection : Cnv -> List Form 
collection cnv = 
  toList ( map drawSq ( arrangeCollection cnv 500 (arrangeElementInSquare)))

-- number of items, canvas + arrange function
arrangeCollection : Cnv -> Int -> (Cnv -> Int -> Sq) -> Array Sq
arrangeCollection c n arrangeFun  =
  initialize n (arrangeFun c)

-- arrange single element given its index.
arrangeElementInCircle : Cnv -> Int -> Sq
arrangeElementInCircle cnv i =
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

arrangeElementInSquare : Cnv -> Int -> Sq
arrangeElementInSquare cnv i =
  let cellSize = 30 
      size = cellSize - 7  
      widthDiv = cnv.width // cellSize 
      position = 
        ( toFloat ((i % widthDiv) * cellSize) - (toFloat cnv.width - cellSize + 1)/ 2 
        , toFloat ((i // widthDiv) * cellSize) - (toFloat cnv.height - cellSize + 1)/ 2 

        )
      rotation = (degrees 45)  + sin(toFloat i / 500)
  in
      squareWith position size rotation

