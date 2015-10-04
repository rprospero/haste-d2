{-# LANGUAGE OverloadedStrings #-}


-- | This module handles d3 scales, which perform mappings between the
-- mapping space and the screen space.  It can also handle more
-- complex setups like colour scales for heat maps, but I don't quite
-- understand that part yet.
module Haste.D2.Scale (linear, log,Scale,domain,range) where

import Haste.Foreign
import Prelude hiding (log)

-- | A Javascript object representing a d3 scaling function.
type Scale = JSAny

class Interpable a
instance Interpable Double

-- | Creates a linear mapping between model and screen space
linear :: IO Scale
linear = ffi "function(){return d3.scale.linear();};"

-- | Creates a logarithmic mapping between model and screen space
log :: IO Scale
log = ffi "function(){return d3.scale.log();}"

-- | Declares the domain of the mapping function.  Generally, only a
-- two element list will be needed, to represent the bounds of the
-- domain.  However, lists of more elements can be used for more
-- complicated mappings.  For example, a domain of [-1,0,1] and a
-- range of [1,0,1] would give the absolute values between -1 and 1.
domain :: [Double] -> Scale -> IO Scale
domain = ffi "function(x,y){return y.domain(x);}"

-- | Declares the range of the mapping function.  Again, a two element
-- list is the usual case, representing the lower and upper bounds of
-- the function, but a more complicated mapping can be used.  See the
-- domain function for more details.
range :: (ToAny a, Interpable a) => [a] -> Scale -> IO Scale
range = ffi "(function(x,y){return y.range(x);})"
