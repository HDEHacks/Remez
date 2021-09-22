module Remez.Entities (
  Direction(..),
  Item,
  Person,
  Room(..)
 ) where

data Direction = North | South | East | West deriving (Show, Eq)

data Item = Book

data Person = Joe

data Room = Room {
 name :: String,
 description :: String,
 exits :: [(Direction, Room)],
 items :: [Item],
 triggers :: [Item],
 people :: [Person]
}
