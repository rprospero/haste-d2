{-# LANGUAGE OverloadedStrings #-}

module Haste.D2.SVG (line) where

import Haste.Foreign

type Line = JSAny

line :: IO Line
line = ffi "d3.svg.line"
