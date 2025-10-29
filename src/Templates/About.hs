module Templates.About (pageAbout) where

import qualified Text.Blaze.Html5 as H

pageAbout :: H.Html
pageAbout = do
  H.h1 "About"
  H.p "This website is built using Haskell, Scotty, and Blaze HTML templates."
