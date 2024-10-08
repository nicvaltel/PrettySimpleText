module Adapter.HTTP.Web.Routes (routes) where


import ClassyPrelude
import Web.Scotty.Trans
import qualified Web.Scotty.Trans as WST
import qualified Text.Blaze.Html.Renderer.Text as H
import Adapter.HTTP.Web.HtmlTemplates.ExampleIndexPage (fullIndexPageExample)
import Adapter.HTTP.Web.HtmlTemplates.Template (testExample)


routes :: (MonadUnliftIO m) => ScottyT m ()
routes = do
  get "/" $
    redirect "/index"

  get "/index" $
    WST.html $ H.renderHtml testExample
    -- file "ui1/index.html"
