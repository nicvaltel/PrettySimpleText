module Adapter.HTTP.API.Routes (routes) where


import ClassyPrelude
import Web.Scotty.Trans
import qualified Domain.Server as D



routes :: (MonadUnliftIO m, D.SessionRepo m) => ScottyT m ()
routes = pure ()