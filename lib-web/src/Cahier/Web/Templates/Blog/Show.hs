module Cahier.Web.Templates.Blog.Show (pageBlogShow) where

import Cahier.Core.Content (BlogPost (..), PostMetadata (..))
import Cahier.Web.Templates.Layout (layoutTemplate)
import Data.Text qualified as T
import Data.Time.Calendar (Day)
import Data.Time.Format (defaultTimeLocale, formatTime)
import Text.Blaze.Html (Html, preEscapedToMarkup)
import Text.Hamlet (shamlet)

pageBlogShow :: BlogPost -> Html
pageBlogShow (BlogPost (PostMetadata postTitle day _ _ _) content) =
  layoutTemplate
    postTitle
    [shamlet|
  <article>
    <header>
      <h1>#{postTitle}
      <p>
        <small>
          <i>#{formattedDate day}
    #{preEscapedToMarkup content}
|]

formattedDate :: Day -> T.Text
formattedDate day = T.pack $ formatTime defaultTimeLocale "%A, %d %B %Y" day
