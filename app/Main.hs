module Main where

import MyGame.Parsing (
  Command,
  tryGetCommand,
  retryWith
 )

main :: IO ()
main = do retryWith "Huh?" tryGetCommand ; return ()
