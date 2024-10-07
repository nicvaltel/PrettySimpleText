module Utils.Logger where

import ClassyPrelude

type Severity = Text

logger :: Text -> Text -> IO ()
logger sev mgs = do
  putStrLn $ sev <> ": " <> mgs