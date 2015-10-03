{-# LANGUAGE OverloadedStrings #-}

module Haste.D2.Scale (linear, log,Scale,domain,range) where

import Haste.Foreign
import Prelude hiding (log)

type Scale = JSAny

class Interpable a
instance Interpable Double

linear :: IO Scale
linear = ffi "function(){return d3.scale.linear();};"

log :: IO Scale
log = ffi "function(){return d3.scale.log();}"

domain :: [Double] -> Scale -> IO Scale
domain = ffi "function(x,y){return y.domain(x);}"

range :: (ToAny a, Interpable a) => [a] -> Scale -> IO Scale
range = ffi "(function(x,y){return y.range(x);})"
