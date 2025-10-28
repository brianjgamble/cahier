{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE OverloadedStrings #-}

module Templates.Articles (pageArticles) where

import Templates.Layout (baseTemplate)
import qualified Text.Blaze.Html5 as H

pageArticles :: H.Html
pageArticles = baseTemplate "Articles" do
  H.h1 "Articles"
  H.p "Technical and creative writings."
  H.ul do
    H.li "Monads Explained Simply"
    H.li "The Magic of Type Systems"
    H.li "Composing Functions in Real Life"
