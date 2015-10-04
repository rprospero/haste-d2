{-# LANGUAGE OverloadedStrings #-}

module Haste.D2.Select (select,selectAll,append,enter,attr,call,d3data) where

import Haste.Foreign
import Haste.Prim (JSString)

import Data.String

type Select = JSAny

d3data' :: JSAny -> Select -> IO Select
d3data' = ffi "function(x,y){return y.data(x);}"

d3data :: ToAny a => a -> Select -> IO Select
d3data s = d3data' (toAny s)

select' :: JSString -> IO Select
select' = ffi "function(x){return d3.select(x);}"

select :: String -> IO Select
select s = select' (fromString s)

selectAll' :: JSString -> Select -> IO Select
selectAll' = ffi "function(x,y){return y.selectAll(x);}"

selectAll :: String -> Select -> IO Select
selectAll s = selectAll' (fromString s)

append' :: JSString -> Select -> IO Select
append' = ffi "function(x,y){return y.append(x);}"

append :: String -> Select -> IO Select
append s = append' (fromString s)

attr' :: JSString -> JSAny -> Select -> IO Select
attr' = ffi "function(x,z,y){return y.attr(x,z);}"

attr :: (ToAny a) => String -> a -> Select -> IO Select
attr name value =  attr' (fromString name) (toAny value)

enter :: Select -> IO Select
enter = ffi "function(y){return y.enter();}"

call' :: JSAny -> Select -> IO Select
call' = ffi "function(x,y){return y.call(x);}"

call :: ToAny a => a -> Select -> IO Select
call method = call' (toAny method)
