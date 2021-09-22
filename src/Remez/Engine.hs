{-# LANGUAGE NamedFieldPuns #-}

module Remez.Engine (
  initialize,
  process,
  GameState
 ) where

import Remez.Entities (
  Direction(..),
  Item,
  Person,
  Room(..)
 )

import Remez.Parsing (
  Command(..)
 )

import Control.Monad.State (StateT, lift, gets, modify)
import Data.Functor.Contravariant (Predicate(..))
import Data.AssocList.List.Predicate as ALP (lookupFirst)

data GameState = GameState {
  room :: Room,
  inventory :: [Item]
}

move :: Room -> GameState -> GameState
move room' state = state { room = room' }

initialize :: Room -> [Item] -> IO GameState
initialize r i = do
  showRoom r
  return $ GameState { room = r, inventory = i }

showRoom :: Room -> IO ()
showRoom r = do
  putStrLn $ "You are in " ++ (name r) ++ "."
  putStrLn $ description r

type GameStep a = StateT GameState IO a

process :: Command -> GameStep ()
process GoNorth = do r' <- gets room ; resolveMove $ attemptMove North r'
process GoEast = do r' <- gets room ; resolveMove $ attemptMove East r'
process GoSouth = do r' <- gets room ; resolveMove $ attemptMove South r'
process GoWest = do r' <- gets room ; resolveMove $ attemptMove West r'
process (Use s) = lift $ putStrLn $ "You don't have a " ++ s ++ "."
process (Take s) = lift $ putStrLn $ "There isn't a " ++ s ++ "."
process (Talk s) = lift $ putStrLn $ s ++ " isn't here!"

attemptMove :: Direction -> Room -> Maybe Room
attemptMove d (Room { exits }) = ALP.lookupFirst (Predicate (== d)) exits 

resolveMove :: Maybe Room -> GameStep ()
resolveMove Nothing = lift $ putStrLn "You can't move that way!"
resolveMove (Just r) = do
  modify (move r)
  lift $ showRoom r
