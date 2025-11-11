import Cahier.Web.Controllers.Blog qualified as Blog
import Cahier.Web.Controllers.Pages qualified as Pages
import Cahier.Web.Controllers.Poetry qualified as Poetry

import Config (scottyOptions)
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Network.Wai.Middleware.Static
import Text.Blaze.Html (Html)
import Text.Blaze.Html.Renderer.Text qualified as R
import Web.Scotty

render :: Html -> ActionM ()
render = html . R.renderHtml

main :: IO ()
main = do
  opts <- scottyOptions
  scottyOpts opts do
    middleware $ staticPolicy (noDots >-> addBase "static")
    middleware logStdoutDev

    get "/" $ render Pages.home
    get "/posts" $ render Blog.index
    get "/poetry" $ render Poetry.index
    get "/contact" $ render Pages.contact
    get "/about" $ render Pages.about
