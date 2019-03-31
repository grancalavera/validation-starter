module Main where

import           Lib

main :: IO ()
main = do

  -- collections
  print $ traverse ((value <$>) . mkEven) [1 .. 5]
  print $ traverse ((value <$>) . mkEven) [2, 4 .. 10]

  -- singles
  print $ value <$> mkDivisor 0
  print $ value <$> mkDivisor 9
  print $ value <$> mkEven 9
  print $ value <$> mkEven 2

  -- pairs
  print $ pairValue <$> mkEvenPair 9 2
  print $ pairValue <$> mkEvenPair 9 5
  print $ pairValue <$> mkEvenPair 4 2
  print $ pairValue <$> mkDivisorPair 0 9
  print $ pairValue <$> mkDivisorPair 0 0
