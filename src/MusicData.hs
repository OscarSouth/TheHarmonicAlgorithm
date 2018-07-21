module MusicData where

import GHC.Real ( (%) )
import GHC.Base ( quotInt, remInt, modInt )
import Data.Map (Map)
import qualified Data.Map as Map

import qualified Sound.Tidal.Scales as Scales

-- |set of pitch classes
newtype PitchClass = P Int deriving (Ord, Eq, Show)

instance Bounded PitchClass where
  minBound = P 0
  maxBound = P 11

instance Num PitchClass where
  (+) (P n1) (P n2) = P (n1 + n2) `mod` P 12
  (-) (P n1) (P n2) = P (n1 - n2) `mod` P 12
  (*) (P n1) (P n2) = P (n1 * n2) `mod` P 12
  negate = id
  fromInteger n = P $ fromInteger n `mod` 12
  abs = id
  signum a = 1

instance Integral PitchClass where
  toInteger = toInteger . fromEnum
  a `mod` b   
    | b == 0 = error "divide by zero"
    | b == (-1) = 0
    | otherwise = P $ a' `modInt` b'
      where toInt = fromIntegral . toInteger
            (a', b') = (toInt a, toInt b)
  a `quotRem` b
    | b == 0 = error "divide by zero"
    | b == (-1) && a == minBound = (error "divide by zero", P 0)
    | otherwise = (P $ a' `quotInt` b', P $ a' `remInt` b' )
      where toInt = fromIntegral . toInteger
            (a', b') = (toInt a, toInt b)

instance Real PitchClass where
  toRational n = toInteger n % 1

instance Enum PitchClass where
  succ n
    | n == maxBound = minBound
    | otherwise = n + 1
  pred n
    | n == minBound = maxBound
    | otherwise = n - 1
  toEnum n = P $ n `mod` 12
  fromEnum n = case n of {P v -> v}

class MusicData a where
  pitchClass :: a -> PitchClass -- mappings into pitch classes
  sharp :: a -> NoteName -- mappings into sharp note names
  flat :: a -> NoteName -- mappings into flat note names
  (<+>) :: a -> Integer -> PitchClass 
  (<->) :: a -> Integer -> PitchClass 
  (+|) :: a -> Integer -> NoteName
  (-|) :: a -> Integer -> NoteName
  (+#) :: a -> Integer -> NoteName
  (-#) :: a -> Integer -> NoteName
  (+|) a = flat . (<+>) a
  (-|) a = flat . (<->) a
  (+#) a = sharp . (<+>) a
  (-#) a = sharp . (<->) a

-- |set of note names
data NoteName = C 
              | C' 
              | Db 
              | D 
              | D' 
              | Eb 
              | E 
              | F 
              | F' 
              | Gb 
              | G 
              | G' 
              | Ab 
              | A 
              | A' 
              | Bb 
              | B deriving (Eq, Show)

instance MusicData NoteName where
  pitchClass n 
    | n == C  = 0
    | n == C' = 1
    | n == Db = 1
    | n == D  = 2
    | n == D' = 3
    | n == Eb = 3
    | n == E  = 4
    | n == F  = 5
    | n == F' = 6
    | n == Gb = 6
    | n == G  = 7
    | n == G' = 8
    | n == Ab = 8
    | n == A  = 9
    | n == A' = 10
    | n == Bb = 10
    | n == B  = 11
  sharp n
    | n == Db = C'
    | n == Eb = D'
    | n == Gb = F'
    | n == Ab = G'
    | n == Bb = A'
    | otherwise = n
  flat n
    | n == C' = Db
    | n == D' = Eb
    | n == F' = Gb
    | n == G' = Ab
    | n == A' = Bb
    | otherwise = n
  a <+> b = pitchClass a + fromInteger b
  a <-> b = pitchClass a + fromInteger b

instance MusicData PitchClass where
  pitchClass = id
  sharp n 
    | n == 0 = C
    | n == 1 = C'
    | n == 2 = D
    | n == 3 = D'
    | n == 4 = E
    | n == 5 = F
    | n == 6 = F'
    | n == 7 = G
    | n == 8 = G'
    | n == 9 = A
    | n == 10 = A'
    | n == 11 = B
  flat n 
    | n == 0 = C
    | n == 1 = Db
    | n == 2 = D
    | n == 3 = Eb
    | n == 4 = E
    | n == 5 = F
    | n == 6 = Gb
    | n == 7 = G
    | n == 8 = Ab
    | n == 9 = A
    | n == 10 = Bb
    | n == 11 = B
  a <+> b = a + fromInteger b
  a <-> b = a - fromInteger b

dorian = Scales.dorian

-- addition and subtraction that maintains key