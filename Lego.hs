module Lego (Lego(..), Color(..), Dimension(..), (><), pprint, pprint2, turn, setX, setY, setColor) where

import Data.List (foldl1', intersperse)

data Color = Black | Red     | Green | Yellow
           | Blue  | Magenta | Cyan  | White
           deriving (Enum, Show)

data Dimension = D {_x :: Int, _y :: Int}
data Lego = Lego {dim :: Dimension, _color :: Color}
data STRego = STRego String [String] String

instance Show Dimension where
  show (D x y) = show x ++" x "++show y

instance Show Lego where
  show (Lego d c) = "["++show d++" | "++show c++"]"

instance Show STRego where
  show (STRego t m b) = unlines ([""]++[t]++m++[b])

brick :: Int -> Int -> Color -> Lego
brick a b c = Lego (a >< b) c

strLegos :: [Lego] -> [[String]]
strLegos [] = [] -- to catch the maximum [] = error case
strLegos ll = let mx = maximum $ map (_y.dim) ll
              in map (strExt mx) ll

combine :: [[String]] -> [String]
combine [] = []
combine b = foldl1' (<>) b

(<>) :: [String] -> [String] -> [String]
(<>) = zipWith (++)

pprint2 :: [Lego] -> IO ()
pprint2 = putStr . unlines . combine . strLegos

strExt :: Int -> Lego -> [String]
strExt n lego@(Lego (D x y) _)
    = let STRego t m b = strLego lego
          line   = replicate (2*x+1) ' '
      in [t] ++ m ++ [b] ++
         replicate (n-y) line

pprint :: Lego -> IO ()
pprint lego = putStr . show $ strLego lego

strLego ::  Lego -> STRego
strLego (Lego (D x y) col)= STRego t (replicate y m) b
    where t = fg col (" " ++ replicate (2*x-1) '_' ++" ")
          m = fg col "│" ++
              bg col (intersperse ' ' (replicate x 'O'))++
              fg col "│"
          b = fg col (" " ++ replicate (2*x-1) '‾' ++" ")


fg :: Color -> String -> String
fg c str = "\x1b["++show (30+fromEnum c) ++";1m"++str++reset

bg :: Color -> String -> String
bg c str = "\x1b["++show (40+fromEnum c) ++";1m"++str++reset

reset :: String
reset = "\x1b[0m"

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
