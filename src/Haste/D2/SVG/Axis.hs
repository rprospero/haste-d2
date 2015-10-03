{-# LANGUAGE OverloadedStrings #-}

module Haste.D2.SVG.Axis (axis,scale,orient,ticks,AxisOrientation(Bottom,Left)) where

import Haste.Foreign
import Haste.D2.Scale (Scale)
import Prelude hiding (Left, Right)

type Axis = JSAny

axis :: IO Axis
axis = ffi "d3.svg.axis"

scale :: Scale -> Axis -> IO Axis
scale = ffi "function(x,y){return y.scale(x);}"

data AxisOrientation = Bottom | Top | Left | Right

orient :: AxisOrientation -> Axis -> IO Axis
orient Bottom = ffi "function(x){return x.orient('bottom');}"
orient Top = ffi "function(x){return x.orient('top');}"
orient Left = ffi "function(x){return x.orient('left');}"
orient Right = ffi "function(x){return x.orient('right');}"

-- FIXME: ticks takes no arguments for log scale axes
ticks :: Double -> Axis -> IO Axis
ticks = ffi "function(x,y){return y.ticks(x);}"
