module Remez.Map (
  initialRoom, initialInventory,
  den, veranda
) where

import Remez.Entities (
  Direction(..),
  Item,
  Person,
  Room(..)
 )
 
initialRoom :: Room
initialRoom = den

initialInventory :: [Item]
initialInventory = []

veranda :: Room
veranda = Room {
 name = "The Veranda",
 description = "A veranda overlooks a balcony. To the West, a door opens into a house.",
 exits = [(West, den)],
 items = [], triggers = [], people = []
}

den :: Room
den = Room {
 name = "The Den",
 description = "A small den keeps you warm from the elements. To the East, a door opens to a veranda.",
 exits = [(East, veranda)],
 items = [], triggers = [], people = []
}
