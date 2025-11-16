module Cahier.Web.Templates.Poetry.Show (pagePoem) where

import Cahier.Core.Content (Poem (..), PoemMetadata (..))
import Cahier.Web.Templates.Layout (layoutTemplate)
import Data.Time.Calendar (Day, toGregorian)
import Text.Blaze.Html (Html, preEscapedToMarkup)
import Text.Hamlet (shamlet)

pagePoem :: Poem -> Html
pagePoem (Poem (PoemMetadata postTitle postDate postAuthor) content) =
  layoutTemplate
    postTitle
    [shamlet|
  <article>
    <header>
      <h1>#{postTitle}
      <p>
        <small>
          <i>By #{postAuthor}, #{getYear postDate}
    #{preEscapedToMarkup content}
|]

getYear :: Day -> Integer
getYear day = let (year, _, _) = toGregorian day in year
