module Templates.Layout (baseTemplate) where

import Data.Text.Lazy (Text)
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

baseTemplate :: Text -> H.Html -> H.Html
baseTemplate title content = H.docTypeHtml do
  H.head do
    H.meta H.! A.charset "UTF-8"
    H.meta H.! A.name "viewport" H.! A.content "width=device-width, initial-scale=1.0"
    H.meta H.! A.name "color-scheme" H.! A.content "light dark"
    H.title (H.toHtml title)
    H.link H.! A.rel "stylesheet" H.! A.href "/css/style.css"
    H.script H.! A.src "/js/theme-switcher.js" $ ""
    H.script H.! A.type_ "module" H.! A.src "/js/app.js" $ ""
  H.body do
    H.header H.! A.class_ "container" $ do
      H.nav do
        H.a H.! A.href "/" $ "Home"
        H.a H.! A.href "/blog" $ "Blog"
        H.a H.! A.href "/articles" $ "Articles"
        H.a H.! A.href "/contact" $ "Contact"
        H.a H.! A.href "/about" $ "About"
        H.a H.! A.href "#" H.! A.class_ "toggle" H.! A.id "theme_switcher" H.! A.title "Toggle light or dark theme" $ ""
    H.main H.! A.class_ "container" $ content
    H.footer H.! A.class_ "container" $ ""
