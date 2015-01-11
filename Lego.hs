module Lego (Lego(..), Color(..), Dimension(..), (><), turn, setX, setY, setColor) where

data Color = Black | Red     | Green | Yellow
           | Blue  | Magenta | Cyan  | White
           deriving (Enum, Show)

data Dimension = D {_x :: Int, _y :: Int}
data Lego = Lego {dim :: Dimension, _color :: Color}

instance Show Dimension where
  show (D x y) = show x ++" x "++show y

instance Show Lego where
  show (Lego d c) = "["++show d++" | "++show c++"]"

pprint :: Lego -> IO ()
pprint = undefined

char :: Color -> Char
char = undefined

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
