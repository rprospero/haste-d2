{-# LANGUAGE OverloadedStrings #-}

module Haste.D2.Select (select,append,enter,attr,call) where

import Haste.Foreign
import Haste.Prim (JSString)

import Data.String

type Select = JSAny

select' :: JSString -> IO Select
select' = ffi "function(x){return d3.select(x);}"

select :: String -> IO Select
select s = select' (fromString s)

append' :: JSString -> Select -> IO Select
append' = ffi "function(x,y){return y.append(x);}"

append :: String -> Select -> IO Select
append s = append' (fromString s)

attr' :: JSString -> JSAny -> Select -> IO Select
attr' = ffi "function(x,z,y){return y.attr(x,z);}"

attr :: (ToAny a) => String -> a -> Select -> IO Select
attr name value =  attr' (fromString name) (toAny value)

enter' :: JSString -> Select -> IO Select
enter' = ffi "function(x,y){return y.enter(x);}"

enter :: String -> Select -> IO Select
enter s = enter' (fromString s)

call' :: JSAny -> Select -> IO Select
call' = ffi "function(x,y){return y.call(x);}"

call :: ToAny a => a -> Select -> IO Select
call method = call' (toAny method)
