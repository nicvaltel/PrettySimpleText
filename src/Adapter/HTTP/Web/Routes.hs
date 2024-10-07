module Adapter.HTTP.Web.Routes (routes) where


import ClassyPrelude
import Web.Scotty.Trans



routes :: (MonadUnliftIO m) => ScottyT m ()
routes = do
  get "/" $
    redirect "/index"

  get "/index" $
    file "ui1/index.html"
