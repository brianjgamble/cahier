module Cahier.Web.Templates.Poetry.Index where

import Cahier.Web.Templates.Layout (layoutTemplate)
import Text.Blaze.Html (Html)
import Text.Hamlet (shamlet)

pagePoetry :: Html
pagePoetry =
  layoutTemplate
    "Poetry"
    [shamlet|
  <h1>Poetry
  <p>Technical and creative writings.
  <ul>
    <li>Monads Explained Simply
    <li>The Magic of Type Systems
    <li>Composing Functions in Real Life
|]
