module Lib
    ( Even
    , Divisor
    , Err
    , mkDivisor
    , mkDivisorPair
    , mkEven
    , mkEvenPair
    , mkEvenDivisor
    , value
    , pairValue
    )
where

import           Data.Validation
import           Data.Bifunctor

data Err = DivisorIsZero | IsNotEven Int

instance Show Err where
    show DivisorIsZero = "Error: zero can't be a divisor"
    show (IsNotEven n) = "Error: " <> show n <> " is not an even integer"

class ValidInt a where
    value :: a -> Int
    pairValue :: (a, a) -> (Int, Int)
    pairValue = bimap value value

newtype Divisor = Divisor { unDivisor :: Int } deriving Show

instance ValidInt Divisor where
    value = unDivisor

newtype Even = Even { unEven :: Int } deriving Show

instance ValidInt Even where
    value = unEven

mkDivisor :: Int -> Validation [Err] Divisor
mkDivisor n = Divisor <$> validate [DivisorIsZero] (/= 0) n

mkDivisorPair :: Int -> Int -> Validation [Err] (Divisor, Divisor)
mkDivisorPair x y = (,) <$> mkDivisor x <*> mkDivisor y

mkEven :: Int -> Validation [Err] Even
mkEven n = Even <$> validate [IsNotEven n] even n

mkEvenPair :: Int -> Int -> Validation [Err] (Even, Even)
mkEvenPair x y = (,) <$> mkEven x <*> mkEven y

mkEvenDivisor :: Int -> Validation [Err] Divisor
mkEvenDivisor n = fromEither $ do
    n' <- toEither $ value <$> mkEven n
    toEither $ mkDivisor n'
