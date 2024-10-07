module Adapter.HTTP.Web.Routes (routes) where


import ClassyPrelude
import Web.Scotty.Trans
import qualified Web.Scotty.Trans as WST
import qualified Text.Blaze.Html.Renderer.Text as H
import Adapter.HTTP.Web.HtmlTemplates.ExampleIndexPage (fullIndexPageExample)


routes :: (MonadUnliftIO m) => ScottyT m ()
routes = do
  get "/" $
    redirect "/index"

  get "/index" $
    WST.html $ H.renderHtml fullIndexPageExample
    -- file "ui1/index.html"
