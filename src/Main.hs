import Config.Options (build)
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Network.Wai.Middleware.Static
import Templates.About (pageAbout)
import Templates.Articles (pageArticles)
import Templates.Blog (pageBlog)
import Templates.Contact (pageContact)
import Templates.Home (pageHome)
import Text.Blaze.Html (Html)
import Text.Blaze.Html.Renderer.Text qualified as R
import Web.Scotty

render :: Html -> ActionM ()
render = html . R.renderHtml

main :: IO ()
main = do
  opts <- build
  scottyOpts opts do
    middleware $ staticPolicy (noDots >-> addBase "static")
    middleware logStdoutDev

    get "/" $ render pageHome
    get "/blog" $ render pageBlog
    get "/articles" $ render pageArticles
    get "/contact" $ render pageContact
    get "/about" $ render pageAbout
