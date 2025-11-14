module Cahier.Web.Controllers.Blog (index) where

import Cahier.Core.Content (ContentCache, getAllPosts)
import Cahier.Web.Templates.Blog.Index (pageBlog)
import Text.Blaze.Html (Html)

index :: ContentCache -> Html
index cache = pageBlog (getAllPosts cache)
