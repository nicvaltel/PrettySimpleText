module Application 
  ( runApp
  )

 where

import ClassyPrelude
import qualified Lib
import qualified Adapter.HTTP.Main as HTTP

type Port = Int


runApp :: Port -> IO ()
runApp port = do
  putStrLn $ "Starting web application server on port " <> tshow port <> "..."
  let appRunner =  Lib.runAppRoutine
  HTTP.main port appRunner
  pure ()