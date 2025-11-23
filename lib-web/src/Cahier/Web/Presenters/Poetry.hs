module Cahier.Web.Presenters.Poetry (list, view) where

import Cahier.Content (ContentCache, getAllPoems, getPoem)
import Cahier.Web.Templates.Poetry.Index (pagePoetry)
import Cahier.Web.Templates.Poetry.Show (pagePoem)
import Data.Text (Text)
import Text.Blaze.Html (Html)

list :: ContentCache -> Html
list cache = pagePoetry (getAllPoems cache)

view :: Text -> ContentCache -> Maybe Html
view slug cache = do
  case getPoem slug cache of
    Nothing -> Nothing
    Just post -> Just (pagePoem post)
