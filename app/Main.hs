module Main (main) where

import Haste.D2.Scale
import Haste.D2.SVG.Axis as Ax
import Haste.D2.SVG
import Haste.D2.Select

width = 400 :: Double
height = 400 :: Double
margin = 50 :: Double

dataset :: [[Double]]
dataset = map (\x ->  [x,sin x]) [0,0.1..10]

dataset2 :: [[Double]]
dataset2 = map (\x ->  [x,cos x]) [0,0.1..10]
    
main :: IO ()
main = do
  print "Hello, World!"
  x <- linear >>= domain [0, 10]
      >>= range [0,width]
  y <- linear >>= domain [-1, 1]
      >>= range [height,0]

  xAxis <- Ax.axis >>= Ax.scale x
          >>= Ax.orient Ax.Bottom
          >>= Ax.ticks 5

  yAxis <- Ax.axis >>= Ax.scale y
          >>= Ax.orient Ax.Left
          >>= Ax.ticks 5

  l <- line x y

  svg <- select "body"
        >>= append "svg"
        >>= attr "width" (width + margin)
        >>= attr "height" (height + margin)
        >>= append "g"
        >>= attr "transform" (translate (margin/2,margin/2))


  _ <- append "g" svg
      >>= attr "class" "x axis"
      >>= attr "transform" (translate (0,height))
      >>= call xAxis

  
  _ <- append "g" svg
      >>= attr "class" "y axis"
      >>= call yAxis

  _ <- append "g" svg
      >>= attr "class" "lines"
      >>= attr "clip-path" "url(#clip)"
      >>= selectAll "path"
      >>= d3data [dataset,dataset]
      >>= enter
      >>= append "path"
      >>= attr "d" l
      >>= attr "style" "stroke: black; fill: none"

  _ <- select ".lines"
      >>= selectAll "path"
      >>= d3data [dataset,dataset2]
      >>= transition
      >>= duration 10000
      >>= attr "d" l

  print "Done"
