module Adapter.HTTP.Web.Main (mainWeb) where

import ClassyPrelude
import qualified Domain.Server as D
import Network.Wai.Middleware.Static (CacheContainer, addBase, initCaching, CachingStrategy (..), Options (..), staticPolicyWithOptions)
import qualified Network.Wai.Middleware.Static as MWMS
import Web.Scotty.Trans
import qualified Web.Scotty.Trans as WST
import Network.HTTP.Types.Status
import Network.Wai ( Response, Application )
import Network.Wai.Middleware.Gzip (GzipSettings(..), GzipFiles (..), gzip, def)
import qualified Adapter.HTTP.Web.Routes as WebRoutes
import Utils.Logger (logger)

mainWeb :: 
  (MonadUnliftIO m, D.SessionRepo m) =>
  (m Response -> IO Response) -> IO Application
mainWeb runner = do
  cacheContainer <- initCaching PublicStaticCaching
  scottyAppT WST.defaultOptions runner $ routes cacheContainer

routes :: 
  (MonadUnliftIO m, D.SessionRepo m) =>
  CacheContainer -> ScottyT m ()
routes cachingStrategy = do
  middleware $ gzip $ def {gzipFiles = GzipCompress}

  let cachingOptions = MWMS.defaultOptions { cacheContainer = cachingStrategy }
  middleware $ staticPolicyWithOptions cachingOptions (addBase "ui/")

  WebRoutes.routes

  notFound $ do
    status status404
    text "Not Found"

  defaultHandler $ Handler $ \(e :: SomeException) -> do
    -- lift $ $(logTM) ErrorS $ "Unhandeled error: " <> ls (show e)
    liftIO $ logger "ErrorS" ("Unhandeled error: " <> tshow e)
    status status500
    text "Internal Server Error"