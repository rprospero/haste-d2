{-# LANGUAGE OverloadedStrings #-}

-- | This module handles the basics of d3 selectors.  The Select
-- object forms the basis for most d3 vizualizations.
--
-- The following code would add an SVG element to the body of the
-- document and return a selector that can be used for vizualizations.
--
-- > svg <- select "body"
-- >       >>= append "svg"
-- >       >>= attr "width" 400
-- >       >>= attr "height" 400



module Haste.D2.Select (select,selectAll,append,enter,attr,call,d3data,transition,duration) where

import Haste.Foreign
import Haste.Prim (JSString)

import Data.String

type Select = JSAny

d3data' :: JSAny -> Select -> IO Select
d3data' = ffi "function(x,y){return y.data(x);}"

-- | Attach a dataset to the current selection
d3data :: ToAny a => a -> Select -> IO Select
d3data s = d3data' (toAny s)

select' :: JSString -> IO Select
select' = ffi "function(x){return d3.select(x);}"

-- | Acquire a single selection for d3 to operate on.  The single argument is an element selector.
select :: String -> IO Select
select s = select' (fromString s)

selectAll' :: JSString -> Select -> IO Select
selectAll' = ffi "function(x,y){return y.selectAll(x);}"

-- | Acquires all of the elements given by the element selector string.  Only returns elements within the already given selection.
selectAll :: String -> Select -> IO Select
selectAll s = selectAll' (fromString s)

append' :: JSString -> Select -> IO Select
append' = ffi "function(x,y){return y.append(x);}"

-- | Adds a new child element to the current selection. The node type of the child is passed by the string argument.
append :: String -> Select -> IO Select
append s = append' (fromString s)

attr' :: JSString -> JSAny -> Select -> IO Select
attr' = ffi "function(x,z,y){return y.attr(x,z);}"

-- | Sets the attribute given in the string argument to the Javascript value given in the second argument to the current selection.
attr :: (ToAny a) => String -> a -> Select -> IO Select
attr name value =  attr' (fromString name) (toAny value)

-- | Begins the definition of the d3 entrance action for the current action.
enter :: Select -> IO Select
enter = ffi "function(y){return y.enter();}"

call' :: JSAny -> Select -> IO Select
call' = ffi "function(x,y){return y.call(x);}"

-- | Call a Javascript object on the current selection?  I really don't get how this works yet
call :: ToAny a => a -> Select -> IO Select
call method = call' (toAny method)

-- | Begin a d3 transition on the current selection
transition :: Select -> IO Select
transition = ffi "function(x){return x.transition();}"

-- | Gives the time in milliseconds that should be spent performing the current transition.
duration :: Double -> Select -> IO Select
duration = ffi "function(x,y){return y.duration(x);}"
