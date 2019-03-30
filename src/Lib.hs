module Lib
    ( mkDivisor
    , mkDivisorPair
    , mkEven
    , mkEvenPair
    )
where

import           Data.Validation
import           Data.List.NonEmpty                       ( NonEmpty((:|)) )
import qualified Data.List.NonEmpty            as NonEmpty

newtype Err = Err { unErr ::  NonEmpty String }

instance Semigroup Err where
    left <> right = Err (unErr left <> unErr right)

instance Show Err where
    show (Err (e :| [])) = show e
    show (Err es       ) = show (NonEmpty.toList es)

newtype Divisor = Divisor { unDivisor:: Int } deriving Show

newtype Even = Even { unEven::Int } deriving Show

mkDivisor :: Int -> Validation Err Divisor
mkDivisor n = Divisor <$> validate (mkErr "Divisor can't be zero") isNotZero n

mkDivisorPair :: Int -> Int -> Validation Err (Divisor, Divisor)
mkDivisorPair x y = (,) <$> mkDivisor x <*> mkDivisor y

isNotZero :: Int -> Bool
isNotZero 0 = False
isNotZero _ = True


mkErr :: String -> Err
mkErr = Err . (:| [])

mkEven :: Int -> Validation Err Even
mkEven n = Even <$> validate (mkErr (show n <> " is not even")) even n

mkEvenPair :: Int -> Int -> Validation Err (Even, Even)
mkEvenPair x y = (,) <$> mkEven x <*> mkEven y
