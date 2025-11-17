import Cahier.Core.Content
import Cahier.Web.Presenters.Blog qualified as Blog
import Cahier.Web.Presenters.Pages qualified as Pages
import Cahier.Web.Presenters.Poetry qualified as Poetry

import Config (scottyOptions)
import Data.Text.Lazy qualified as TL
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Network.Wai.Middleware.Static
import Text.Blaze.Html (Html)
import Text.Blaze.Html.Renderer.Text qualified as R
import Web.Scotty

main :: IO ()
main = do
  cache <- loadContentCache "content"
  opts <- scottyOptions

  scottyOpts opts do
    middleware $ staticPolicy (noDots >-> addBase "static")
    middleware logStdoutDev

    get "/robots.txt" $ do
      setHeader "Content-Type" "text/plain"
      text robotsTxt

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

robotsTxt :: TL.Text
robotsTxt =
  TL.unlines
    [ "User-agent: *"
    , "Allow: /"
    , ""
    , "# Block common AI crawlers"
    , "User-agent: GPTBot"
    , "Disallow: /"
    , ""
    , "User-agent: ChatGPT-User"
    , "Disallow: /"
    , ""
    , "User-agent: CCBot"
    , "Disallow: /"
    , ""
    , "User-agent: anthropic-ai"
    , "Disallow: /"
    , ""
    , "User-agent: Claude-Web"
    , "Disallow: /"
    ]
