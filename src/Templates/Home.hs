{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE OverloadedStrings #-}

module Templates.Home (pageHome) where

import qualified Text.Blaze.Html5 as H

pageHome :: H.Html
pageHome = do
  H.h1 "Welcome to My Haskell Website"
  H.p "This is the home page. Built with Scotty and Blaze HTML."
