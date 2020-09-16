module Lib (
------------
-- |MusicData
MusicData,
PitchClass (P),
NoteName,
Chord (Chord),
Cadence,
i,
pitchClass,
mostConsonant,
possibleTriads'',
toTriad,
flatTriad,
sharpTriad,
flat,
sharp,
showTriad,
dissonanceLevel,
toCadence,
pc,
fromCadence,
movementFromCadence,
transposeCadence,
rootNote,
-----------
-- |Analysis
prog3ecbc, pentaPatterns, -- temp
fullSet3title,
pentatonicSet1title,
pentatonicSet2title,
pentatonicSet3title,
diatonicSet12title,
diatonicSet23title,
diatonicSet31title,
-----------
-- |Markov
MarkovMap,
markovMap,
bigrams,
------------
-- |Overtone
chordList',
parseOvertones,
parseNotes,
parseTuning,
parseKey,
parseFunds,
------------
-- |Utility
unique,
-- uniqueAnalysis,
-- |GraphDB
-- testFunction,
-- testData
  ) where

import           Markov -- contains markov chain numerical processing machinery
import           MusicData -- defines MusicData and many pitchclass analysis functions
import           Analysis -- ad hoc analysis functionality for composing
import           Overtone -- mainly parsing functions for generating lists of MusicData
import           Utility -- various 'misc' helper functions
import           GraphDB -- functions to populate and access markov graph database (Neo4j)
import           Perform -- functions related to performance with TidalCycles