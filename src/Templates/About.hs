{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE OverloadedStrings #-}

module Templates.About (pageAbout) where

import Templates.Layout (baseTemplate)
import qualified Text.Blaze.Html5 as H

pageAbout :: H.Html
pageAbout = baseTemplate "About" do
  H.h1 "About"
  H.p "This website is built using Haskell, Scotty, and Blaze HTML templates."
