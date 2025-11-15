module Cahier.Web.Presenters.Poetry (list) where

import Cahier.Core.Content (ContentCache, getAllPoems)
import Cahier.Web.Templates.Poetry.Index (pagePoetry)
import Text.Blaze.Html (Html)

list :: ContentCache -> Html
list cache = pagePoetry (getAllPoems cache)
