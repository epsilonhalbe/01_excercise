module Lego (Lego(..), Color(..), Dimension(..), (><),pprint, turn, setX, setY, setColor) where

import Data.List (intersperse)

data Color = Black | Red     | Green | Yellow
           | Blue  | Magenta | Cyan  | White
           deriving (Enum, Show)

data Dimension = D {_x :: Int, _y :: Int}
data Lego = Lego {dim :: Dimension, _color :: Color}
data STRego = STRego

instance Show Dimension where
  show (D x y) = show x ++" x "++show y

instance Show Lego where
  show (Lego d c) = "["++show d++" | "++show c++"]"

instance Show STRego where
  show = undefined

pprint :: Lego -> IO ()
pprint lego = putStr . show $ strLego lego

strLego ::  Lego -> STRego
strLego = undefined

char :: Color -> Char
char Black = '0'
char c = head (show c)

(><) :: Int -> Int -> Dimension
a >< b = D a b

_turn :: Dimension -> Dimension
_turn (D a b) = b >< a

turn :: Lego -> Lego
turn (Lego d c) = Lego (_turn d) c

setX ::  Int -> Lego -> Lego
setX x (Lego (D _ y) c) = Lego (D x y) c

setY ::  Int -> Lego -> Lego
setY y (Lego (D x _) c) = Lego (D x y) c

setColor :: Color -> Lego -> Lego
setColor c (Lego d _) = Lego d c
