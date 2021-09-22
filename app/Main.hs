module Main where

import Remez.Parsing (
  Command,
  tryGetCommand,
  retryWith
 )

import Remez.Map ( initialRoom, initialInventory )
import Remez.Engine ( initialize, process, GameState )

import Control.Monad.State (execStateT)

initGame :: IO GameState
initGame = initialize initialRoom initialInventory

getHuh = retryWith "Huh?" tryGetCommand

main :: IO ()
main = do 
  initialS' <- initGame
  gameLoop initialS'
  return ()

gameLoop :: GameState -> IO ()
gameLoop state = do
  comm <- getHuh
  state' <- execStateT (process comm) state
  gameLoop state'
