module Adapter.HTTP.API.Main (mainAPI) where

import ClassyPrelude
import qualified Domain.Server as D
import Web.Scotty.Trans
import Network.HTTP.Types.Status
import Network.Wai ( Response, Application )
import Network.Wai.Middleware.Gzip ( def, gzip, GzipFiles(GzipCompress), GzipSettings(gzipFiles) )
import qualified Adapter.HTTP.API.Routes as APIRoutes
import Utils.Logger (logger)


mainAPI :: 
  (MonadUnliftIO m, D.SessionRepo m) =>
  (m Response -> IO Response) -> IO Application
mainAPI runner = scottyAppT defaultOptions runner routesAPI



routesAPI :: 
  (MonadUnliftIO m, D.SessionRepo m) =>
  ScottyT m ()
routesAPI = do
  middleware $ gzip $ def {gzipFiles = GzipCompress}

  APIRoutes.routes

  notFound $ do
    status status404
    json ("Not Found" :: Text)

  defaultHandler $ Handler $ \(e :: SomeException) -> do
    -- lift $ $(logTM) ErrorS $ "Unhandeled error: " <> ls (show e)
    liftIO $ logger "ErrorS" ("Unhandeled error: " <> tshow e)
    status status500
    json ("Internal Server Error" :: Text)