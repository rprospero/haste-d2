{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Haste.D2.Scale
import Haste.D2.SVG.Axis as Ax
import Haste.D2.SVG
import Haste.D2.Select
import Haste.Foreign (toAny)
import Haste.Prim (JSString)
import Data.Monoid
import Data.String
    
width = 400 :: Double
height = 400 :: Double
margin = 30 :: Double
    
main :: IO ()
main = do
  print "Hello, World!"
  x <- linear >>= domain [0, 10]
      >>= range([0,width])
  y <- linear >>= domain [0, 10]
      >>= range([height,0])

  xAxis <- Ax.axis >>= Ax.scale x
          >>= Ax.orient Ax.Bottom
          >>= Ax.ticks(5)

  yAxis <- Ax.axis >>= Ax.scale y
          >>= Ax.orient Ax.Left
          >>= Ax.ticks(5)

  l <- line

  svg <- select "body"
        >>= append "svg"
        >>= attr "width" (toAny $ width + margin/2)
        >>= attr "height" (toAny $ height + margin / 2)
        >>= append "g"
        >>= attr "transform" (toAny ("translate(30,0)" :: JSString))


  let axisTransform = fromString $ "translate(0," <> show height <> ")" :: JSString
  _ <- append "g" svg
      >>= attr "class" (toAny ("x axis" :: JSString))
      >>= attr "transform" (toAny axisTransform)
      >>= call (toAny xAxis)

  
  _ <- append "g" svg
      >>= attr "class" (toAny ("y axis" :: JSString))
      >>= call (toAny yAxis)

  print "Done"
