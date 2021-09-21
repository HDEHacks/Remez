module MyGame.Parsing (
  Command(..),
  tryGetCommand,
  retryWith
) where

{-The possible commands are enumerated below. Note that some commands are
dependent of context, like who is around to talk to. These are left tokenized.-}

data Command = GoNorth
             | GoEast
             | GoSouth
             | GoWest
             | Use String
             | Take String
             | Talk String
  deriving Show

parseCommand :: [String] -> Maybe Command
parseCommand ["go", "north"] = Just GoNorth
parseCommand ["go", "n"] = Just GoNorth
parseCommand ["go", "east"] = Just GoEast
parseCommand ["go", "e"] = Just GoEast
parseCommand ["go", "south"] = Just GoSouth
parseCommand ["go", "s"] = Just GoSouth
parseCommand ["go", "west"] = Just GoWest
parseCommand ["go", "w"] = Just GoWest
parseCommand ["use", s] = Just $ Use s
parseCommand ["take", s] = Just $ Take s
parseCommand ["talk", s] = Just $ Talk s
parseCommand _ = Nothing

tryGetCommand :: IO (Maybe Command)
tryGetCommand = do
  tokenized <- words <$> getLine
  return $ parseCommand tokenized

retryWith :: String -> IO (Maybe a) -> IO a
retryWith msg prog = do
  attempt <- prog
  case attempt of
    Just a -> return a
    Nothing -> do putStrLn msg ; retryWith msg prog
