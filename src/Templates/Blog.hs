module Templates.Blog (pageBlog) where

import qualified Text.Blaze.Html5 as H

pageBlog :: H.Html
pageBlog = do
  H.h1 "Blog"
  H.p "Here are my latest posts."
  H.ul do
    H.li "Learning Haskell"
    H.li "Functional Web Development"
    H.li "Building with Scotty and Blaze"
