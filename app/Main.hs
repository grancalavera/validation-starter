module Main where

import           Lib

main :: IO ()
main = do
  print $ mkDivisor 0
  print $ mkDivisorPair 0 0
  print $ mkDivisorPair 0 9
  print $ mkDivisor 9
  print $ mkEven 9
  print $ mkEven 2
  print $ mkEvenPair 9 5
  print $ mkEvenPair 9 2
  print $ mkEvenPair 4 2
