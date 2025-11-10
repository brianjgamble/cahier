module Cahier.Web.Controllers.Blog (index) where

import Cahier.Web.Templates.Blog.Index (pageBlog)
import Text.Blaze.Html (Html)

index :: Html
index = pageBlog
