{-# LANGUAGE OverloadedStrings #-}

module Haste.D2.SVG (line,translate) where

import Haste.Foreign
import Haste.Graphics.Canvas (Point)
import Data.Monoid

type Line = JSAny

line :: IO Line
line = ffi "d3.svg.line"

translate :: Point -> String
translate (x,y) = "translate(" <> show x <> "," <> show y <> ")"
