{-# LANGUAGE OverloadedStrings #-}

-- | This module handles general SVG operations from D3
module Haste.D2.SVG (line,translate,Line) where

import Haste.Foreign
import Haste.Graphics.Canvas (Point)
import Data.Monoid

import Haste.D2.Scale

type Line = JSAny

-- | Creates a d3 line helper for translating between sets of data
-- points and the SVG drawing commands.
line :: Scale -> Scale -> IO Line
line = ffi "function(x,y){return d3.svg.line().x(function(d,i){console.log('x',d,i);return x(d[0]);}).y(function(d,i){console.log('y',d,i);return y(d[1]);});}"

-- | A simple helper function for creating the strings needed for the transform attribute of SVG.
translate :: Point -> String
translate (x,y) = "translate(" <> show x <> "," <> show y <> ")"
