module Cahier.Web.Templates.Poetry.Show (pagePoem) where

import Cahier.Content (Poem (..), PoemMetadata (..))
import Cahier.Web.Templates.Layout (layoutTemplate)
import Data.Time.Calendar (Day, toGregorian)
import Text.Blaze.Html (Html, preEscapedToMarkup)
import Text.Hamlet (shamlet)

pagePoem :: Poem -> Html
pagePoem (Poem (PoemMetadata title date author) content) =
  layoutTemplate
    title
    [shamlet|
  <article>
    <header>
      <h1>#{title}
      <p>
        <small>
          <i>By #{author}, #{getYear date}
    #{preEscapedToMarkup content}
|]

getYear :: Day -> Integer
getYear day = let (year, _, _) = toGregorian day in year
