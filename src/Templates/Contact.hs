module Templates.Contact (pageContact) where

import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

pageContact :: H.Html
pageContact = do
  H.h1 "Contact"
  H.p do
    "You can reach me at "
    H.a H.! A.href "mailto:example@example.com" $ "example@example.com"
