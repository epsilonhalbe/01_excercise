{-# LANGUAGE TemplateHaskell #-}

module Lego (Lego(..), Color(..), Dimension(..), (><), pprint, pprint2, turn, setX, setY, setColor) where

import Data.List (foldl1', intersperse)
import Control.Lens

data Color = Black | Red     | Green | Yellow
           | Blue  | Magenta | Cyan  | White
           deriving (Enum, Show)

data Dimension = D {_x :: Int, _y :: Int}
makeLenses ''Dimension

data Lego = Lego {_dim :: Dimension, _color :: Color}
makeLenses ''Lego

data STRego = STRego String [String] String

instance Show Dimension where
  show (D x' y') = show x' ++" x "++show y'

instance Show Lego where
  show lego = "["++show lego^.dim++" | "++show lego^.color++"]"

instance Show STRego where
  show (STRego t m b) = unlines ([""]++[t]++m++[b])

brick :: Int -> Int -> Color -> Lego
brick a b c = Lego (a >< b) c

strLegos :: [Lego] -> [[String]]
strLegos [] = [] -- to catch the maximum [] = error case
strLegos ll = let mx = maximum $ map (_y._dim) ll
              in map (strExt mx) ll

combine :: [[String]] -> [String]
combine [] = []
combine b = foldl1' (<>) b

(<>) :: [String] -> [String] -> [String]
(<>) = zipWith (++)

pprint2 :: [Lego] -> IO ()
pprint2 = putStr . unlines . combine . strLegos

strExt :: Int -> Lego -> [String]
strExt n lego
    = let STRego t m b = strLego lego
          line   = replicate (2*lego^.dim.x+1) ' '
      in [t] ++ m ++ [b] ++
         replicate (n-lego^.dim.y) line

pprint :: Lego -> IO ()
pprint lego = putStr . show $ strLego lego

strLego ::  Lego -> STRego
strLego (Lego d col)= STRego t (replicate d^.y m) b
    where t = fg col (" " ++ replicate (2*d^.x-1) '_' ++" ")
          m = fg col "│" ++
              bg col (intersperse ' ' (replicate d^.x 'O'))++
              fg col "│"
          b = fg col (" " ++ replicate (2*d^.x-1) '‾' ++" ")


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
setX x' lego = lego&dim.x%~x'

setY ::  Int -> Lego -> Lego
setY y' lego = lego&dim.y%~y'

setColor :: Color -> Lego -> Lego
setColor c lego = lego&col%~c
