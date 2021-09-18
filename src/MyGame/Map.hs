module MyGame.Map (
  Direction,
  Item,
  Person,
  Room,
  den, veranda
) where

data Direction = North | South | East | West deriving Show

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

veranda = Room {
 name = "Veranda",
 description = "A veranda overlooks a balcony. To the West, a door opens into a house.",
 exits = [(West, den)],
 items = [], triggers = [], people = []
}
den = Room {
 name = "Den",
 description = "A small den keeps you warm from the elements. To the East, a door opens to a veranda.",
 exits = [(East, veranda)],
 items = [], triggers = [], people = []
}
