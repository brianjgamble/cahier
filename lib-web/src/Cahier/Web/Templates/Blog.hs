module Cahier.Web.Templates.Blog (pageBlog) where

import Cahier.Web.Templates.Layout (layoutTemplate)
import Text.Blaze.Html (Html)
import Text.Hamlet (shamlet)

pageBlog :: Html
pageBlog =
  layoutTemplate
    "Blog"
    [shamlet|
  <h1>Blog
  <p>Here are my latest posts.
  <ul>
    <li>Learning Haskell
    <li>Functional Web Development
    <li>Building with Scotty and Blaze
|]
