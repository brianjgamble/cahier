module Templates.Articles (pageArticles) where

import qualified Text.Blaze.Html5 as H

pageArticles :: H.Html
pageArticles = do
  H.h1 "Articles"
  H.p "Technical and creative writings."
  H.ul do
    H.li "Monads Explained Simply"
    H.li "The Magic of Type Systems"
    H.li "Composing Functions in Real Life"
