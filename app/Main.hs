import Cahier.Content
import Cahier.Web.Presenters.Blog qualified as Blog
import Cahier.Web.Presenters.Pages qualified as Pages
import Cahier.Web.Presenters.Poetry qualified as Poetry

import Cahier.Web.Logger (logStdoutCustom)
import Config (scottyOptions)
import Network.Wai.Middleware.Static
import Text.Blaze.Html (Html)
import Text.Blaze.Html.Renderer.Text qualified as R
import Web.Scotty

main :: IO ()
main = do
  -- Load content
  cache <- loadContentCache "content"

  -- Set logger and configuration
  logger <- logStdoutCustom
  opts <- scottyOptions

  scottyOpts opts do
    middleware $ staticPolicy (noDots >-> addBase "static")
    middleware logger

    get "/" $ render Pages.home

    get "/posts" $ render (Blog.list cache)
    get "/posts/:slug" do
      slug <- pathParam "slug"
      maybe next render (Blog.view slug cache)

    get "/poetry" $ render (Poetry.list cache)
    get "/poetry/:slug" do
      slug <- pathParam "slug"
      maybe next render (Poetry.view slug cache)

    get "/about" $ render Pages.about

    notFound $ render Pages.notFound

render :: Html -> ActionM ()
render = html . R.renderHtml
