module Main where

import MyGame.Parsing (
  Command,
  tryGetCommand,
  retryWith
 )

import MyGame.Map ( initialRoom, initialInventory )
import MyGame.Engine ( initialize, process, GameState )

import Control.Monad (mapM_)
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
