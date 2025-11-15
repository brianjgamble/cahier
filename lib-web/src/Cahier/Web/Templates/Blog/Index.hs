module Cahier.Web.Templates.Blog.Index (pageBlog) where

import Cahier.Core.Content (ContentDigest (..))
import Cahier.Web.Templates.Layout (layoutTemplate)
import Text.Blaze.Html (Html)
import Text.Hamlet (shamlet)

pageBlog :: [ContentDigest] -> Html
pageBlog digests =
  layoutTemplate
    "Blog"
    [shamlet|
  <h1>Blog
  <p>Here are my latest posts.
  <ul>
    $forall ContentDigest title slug <- digests
      <li>
        <a href="/posts/#{slug}">#{title}
|]
