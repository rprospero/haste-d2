{-# LANGUAGE OverloadedStrings #-}

module Haste.D2.Select (select,append,enter,attr,call) where

import Haste.Foreign
import Haste.Prim (JSString)

type Select = JSAny

select :: JSString -> IO Select
select = ffi "function(x){return d3.select(x);}"

append :: JSString -> Select -> IO Select
append = ffi "function(x,y){return y.append(x);}"

attr :: JSString -> JSAny -> Select -> IO Select
attr = ffi "function(x,z,y){return y.attr(x,z);}"

enter :: JSString -> Select -> IO Select
enter = ffi "function(x,y){return y.enter(x);}"

call :: JSAny -> Select -> IO Select
call = ffi "function(x,y){return y.call(x);}"
