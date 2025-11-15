module Cahier.Web.Controllers.Blog (index, view) where

import Cahier.Core.Content (BlogPost, ContentCache, getAllPosts)
import Cahier.Web.Templates.Blog.Index (pageBlog)
import Cahier.Web.Templates.Blog.Show (pageBlogShow)
import Text.Blaze.Html (Html)

index :: ContentCache -> Html
index cache = pageBlog (getAllPosts cache)

view :: BlogPost -> Html
view = pageBlogShow
