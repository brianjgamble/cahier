module Templates.Contact (pageContact) where

import Templates.Layout (layoutTemplate)
import Text.Blaze.Html (Html)
import Text.Hamlet (shamlet)

pageContact :: Html
pageContact =
  layoutTemplate
    "Contact"
    [shamlet|
  <h1>Contact
  <p>
    You can reach me at
    <a href="mailto:example@example.com">example@example.com
|]
