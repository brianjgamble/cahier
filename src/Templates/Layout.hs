{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE OverloadedStrings #-}

module Templates.Layout (baseTemplate) where

import Data.Text.Lazy (Text)
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

baseTemplate :: Text -> H.Html -> H.Html
baseTemplate title content = H.docTypeHtml do
  H.head do
    H.meta H.! A.charset "UTF-8"
    H.meta H.! A.name "viewport" H.! A.content "width=device-width, initial-scale=1.0"
    H.title (H.toHtml title)
    H.style
      "body { font-family: sans-serif; max-width: 800px; margin: 2rem auto; line-height: 1.6; }\
      \nav a { margin-right: 1em; text-decoration: none; color: #3366cc; }\
      \nav a:hover { text-decoration: underline; }\
      \hr { margin: 1.5em 0; }"
  H.body do
    H.nav do
      H.a H.! A.href "/" $ "Home"
      H.a H.! A.href "/blog" $ "Blog"
      H.a H.! A.href "/articles" $ "Articles"
      H.a H.! A.href "/contact" $ "Contact"
      H.a H.! A.href "/about" $ "About"
    H.hr
    content
