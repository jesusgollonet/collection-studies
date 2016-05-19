module Sq exposing (..) 
import Collage exposing (..)
import Color exposing (..)

-- an element in our collection
type alias Sq =
  { position : ( Float, Float )
  , size : Float
  , rotation : Float
  }

-- constructor
squareWith : ( Float, Float ) -> Float -> Float -> Sq
squareWith pos size rotation =
  { position = pos
  , size = size
  , rotation = rotation
  }

-- render 
drawSq : Sq -> Form
drawSq m =
  rotate m.rotation (move m.position (filled black (square m.size)))
