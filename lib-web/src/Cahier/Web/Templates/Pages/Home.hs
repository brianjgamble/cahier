module Cahier.Web.Templates.Pages.Home where

import Cahier.Web.Templates.Layout (layoutTemplate)
import Text.Blaze.Html (Html)
import Text.Hamlet (shamlet)

pageHome :: Html
pageHome =
  layoutTemplate
    "Home"
    [shamlet|
  <h1>Welcome to My Haskell Website
  <p>This is the home page. Built with Scotty and Blaze HTML.
|]
