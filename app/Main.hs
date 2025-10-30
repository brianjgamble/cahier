import Config (webOptions)
import Network.Wai.Middleware.RequestLogger (logStdoutDev)
import Network.Wai.Middleware.Static
import Templates.About (pageAbout)
import Templates.Articles (pageArticles)
import Templates.Blog (pageBlog)
import Templates.Contact (pageContact)
import Templates.Home (pageHome)
import Templates.Layout (baseTemplate)
import qualified Text.Blaze.Html.Renderer.Text as R
import Web.Scotty

main :: IO ()
main = do
  opts <- webOptions
  scottyOpts opts do
    middleware $ staticPolicy (noDots >-> addBase "static")
    middleware logStdoutDev

    get "/" $
      html . R.renderHtml $
        baseTemplate "Home" pageHome

    get "/blog" $
      html . R.renderHtml $
        baseTemplate "Blog" pageBlog

    get "/articles" $
      html . R.renderHtml $
        baseTemplate "Articles" pageArticles

    get "/contact" $
      html . R.renderHtml $
        baseTemplate "Contact" pageContact

    get "/about" $
      html . R.renderHtml $
        baseTemplate "About" pageAbout
