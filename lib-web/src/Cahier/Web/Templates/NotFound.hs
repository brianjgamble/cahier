module Cahier.Web.Templates.NotFound where

import Cahier.Web.Templates.Layout (layoutTemplate)
import Text.Blaze.Html (Html)
import Text.Hamlet (shamlet)

pageNotFound :: Html
pageNotFound =
  layoutTemplate
    "404"
    [shamlet|
  <div .lost>
    <h1>
      <strong>404
    <h2>Oops! Nothing was found
    <p>
      The page you're looking for doesn't exist.
      <a href="/">Return to homepage
|]
