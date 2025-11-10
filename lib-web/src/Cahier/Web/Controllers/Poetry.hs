module Cahier.Web.Controllers.Poetry (index) where

import Cahier.Web.Templates.Poetry.Index (pagePoetry)
import Text.Blaze.Html (Html)

index :: Html
index = pagePoetry
