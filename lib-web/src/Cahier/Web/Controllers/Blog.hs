module Cahier.Web.Controllers.Blog (list, view) where

import Cahier.Core.Content (ContentCache, getAllPosts, getPost)
import Cahier.Web.Templates.Blog.Index (pageBlog)
import Cahier.Web.Templates.Blog.Show (pageBlogShow)
import Data.Text (Text)
import Text.Blaze.Html (Html)

list :: ContentCache -> Html
list cache = pageBlog (getAllPosts cache)

view :: Text -> ContentCache -> Maybe Html
view slug cache = do
  case getPost slug cache of
    Nothing -> Nothing
    Just post -> Just (pageBlogShow post)
