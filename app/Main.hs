{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE OverloadedStrings #-}

import Text.Blaze.Html.Renderer.Text (renderHtml)
import qualified Text.Blaze.Html5 as H
import Web.Scotty

import Templates.About (pageAbout)
import Templates.Articles (pageArticles)
import Templates.Blog (pageBlog)
import Templates.Contact (pageContact)
import Templates.Home (pageHome)

main :: IO ()
main = scotty 3000 do
  get "/" $ blaze pageHome
  get "/blog" $ blaze pageBlog
  get "/articles" $ blaze pageArticles
  get "/contact" $ blaze pageContact
  get "/about" $ blaze pageAbout

-- Helper: render Blaze HTML in Scotty
blaze :: H.Html -> ActionM ()
blaze = html . renderHtml
