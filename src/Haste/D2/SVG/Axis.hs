{-# LANGUAGE OverloadedStrings #-}

-- | This module talks helps with the axes objects from the d3 library.

module Haste.D2.SVG.Axis (axis,scale,orient,ticks,AxisOrientation(Bottom,Left)) where

import Haste.Foreign
import Haste.D2.Scale (Scale)
import Prelude hiding (Left, Right)

type Axis = JSAny

-- | Creates a new axis object
axis :: IO Axis
axis = ffi "d3.svg.axis"

-- | Attaches a scaling between model space and screen space to the axis
scale :: Scale -> Axis -> IO Axis
scale = ffi "function(x,y){return y.scale(x);}"

-- | A position for the axis on the graph.  I think that this mostly
-- controls the tick label positions.
data AxisOrientation = Bottom | Top | Left | Right

-- | Sets the orientation for an axis
orient :: AxisOrientation -> Axis -> IO Axis
orient Bottom = ffi "function(x){return x.orient('bottom');}"
orient Top = ffi "function(x){return x.orient('top');}"
orient Left = ffi "function(x){return x.orient('left');}"
orient Right = ffi "function(x){return x.orient('right');}"

-- | Gives the number of ticks for an axis.  FIXME:  This does not work for log scaled axes, as it's not supported by the underlying d3 library.
ticks :: Double -> Axis -> IO Axis
ticks = ffi "function(x,y){return y.ticks(x);}"
