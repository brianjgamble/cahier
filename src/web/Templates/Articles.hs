module Templates.Articles (pageArticles) where

import Templates.Layout (layoutTemplate)
import Text.Blaze.Html (Html)
import Text.Hamlet (shamlet)

pageArticles :: Html
pageArticles =
  layoutTemplate
    "Articles"
    [shamlet|
  <h1>Articles
  <p>Technical and creative writings.
  <ul>
    <li>Monads Explained Simply
    <li>The Magic of Type Systems
    <li>Composing Functions in Real Life
|]
