module Main (main) where

import ClassyPrelude
import qualified Application

main :: IO ()
main = do
  Application.runApp 3000
