module Cahier.Web.Templates.Poetry.Index where

import Cahier.Core.Content (ContentDigest (..))
import Cahier.Web.Templates.Layout (layoutTemplate)
import Text.Blaze.Html (Html)
import Text.Hamlet (shamlet)

pagePoetry :: [ContentDigest] -> Html
pagePoetry digests =
  layoutTemplate
    "Poetry"
    [shamlet|
  <h1 .center>Poetry
  <ul>
    $forall ContentDigest title slug <- digests
      <li>
        <a href="/poetry/#{slug}">#{title}
|]
