module Cahier.Web.Templates.Blog.Index (pageBlog) where

import Cahier.Content (ContentDigest (..))
import Cahier.Web.Templates.Layout (layoutTemplate)
import Text.Blaze.Html (Html)
import Text.Hamlet (shamlet)

pageBlog :: [ContentDigest] -> Html
pageBlog digests =
  layoutTemplate
    "Posts"
    [shamlet|
  <h1 .center>Posts Archive.
  <p .summary>Covers software development, writing, and life
  <ul>
    $forall ContentDigest title slug <- digests
      <li>
        <a href="/posts/#{slug}">#{title}
|]
