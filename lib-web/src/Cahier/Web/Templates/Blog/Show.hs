module Cahier.Web.Templates.Blog.Show (pageBlogShow) where

import Cahier.Content (Post (..), PostMetadata (..))
import Cahier.Web.Templates.Layout (layoutTemplate)
import Data.Text qualified as T
import Data.Time.Calendar (Day)
import Data.Time.Format (defaultTimeLocale, formatTime)
import Text.Blaze.Html (Html, preEscapedToMarkup)
import Text.Hamlet (shamlet)

pageBlogShow :: Post -> Html
pageBlogShow (MkPost (MkPostMetadata title day _ _ _) content) =
  layoutTemplate
    title
    [shamlet|
  <article>
    <header>
      <h1>#{title}
      <p>
        <small>
          <i>#{formattedDate day}
    #{preEscapedToMarkup content}
|]

formattedDate :: Day -> T.Text
formattedDate day = T.pack $ formatTime defaultTimeLocale "%A, %d %B %Y" day
