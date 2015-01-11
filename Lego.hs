module Lego (Lego(..), Color(..), Dimension(..), (><), turn, setX, setY, setColor) where

data Color = Color

data Dimension = Dimension
data Lego = Lego

(><) :: Int -> Int -> Dimension
_ >< _ = undefined

_turn :: Dimension -> Dimension
_turn = undefined

turn :: Lego -> Lego
turn = undefined

setX ::  Int -> Lego -> Lego
setX = undefined

setY ::  Int -> Lego -> Lego
setY = undefined

setColor :: Color -> Lego -> Lego
setColor = undefined
