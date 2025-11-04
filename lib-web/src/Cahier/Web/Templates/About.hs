module Cahier.Web.Templates.About (pageAbout) where

import Cahier.Web.Templates.Layout (layoutTemplate)
import Text.Blaze.Html (Html)
import Text.Hamlet (shamlet)

pageAbout :: Html
pageAbout =
  layoutTemplate
    "About"
    [shamlet|
  <h1>About
  <p>This website is built using Haskell, Scotty, and Blaze HTML templates.
|]
