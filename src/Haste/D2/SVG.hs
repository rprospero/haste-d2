{-# LANGUAGE OverloadedStrings #-}

module Haste.D2.SVG (line,translate) where

import Haste.Foreign
import Haste.Graphics.Canvas (Point)
import Data.Monoid

import Haste.D2.Scale

type Line = JSAny

line :: Scale -> Scale -> IO Line
line = ffi "function(x,y){return d3.svg.line().x(function(d,i){console.log('x',d,i);return x(d[0]);}).y(function(d,i){console.log('y',d,i);return y(d[1]);});}"

translate :: Point -> String
translate (x,y) = "translate(" <> show x <> "," <> show y <> ")"
