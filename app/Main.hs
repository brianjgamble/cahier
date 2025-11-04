import Config (scottyOptions)
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Network.Wai.Middleware.Static
import Cahier.Web.Templates.About (pageAbout)
import Cahier.Web.Templates.Articles (pageArticles)
import Cahier.Web.Templates.Blog (pageBlog)
import Cahier.Web.Templates.Contact (pageContact)
import Cahier.Web.Templates.Home (pageHome)
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

    get "/" $ render pageHome
    get "/blog" $ render pageBlog
    get "/articles" $ render pageArticles
    get "/contact" $ render pageContact
    get "/about" $ render pageAbout
