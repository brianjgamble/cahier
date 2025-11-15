module Cahier.Web.Presenters.Pages where

import Cahier.Web.Templates.NotFound (pageNotFound)
import Cahier.Web.Templates.Pages.About (pageAbout)
import Cahier.Web.Templates.Pages.Contact (pageContact)
import Cahier.Web.Templates.Pages.Home (pageHome)
import Text.Blaze.Html (Html)

home :: Html
home = pageHome

contact :: Html
contact = pageContact

about :: Html
about = pageAbout

notFound :: Html
notFound = pageNotFound
