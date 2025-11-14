module Cahier.Web.Templates.Pages.Home where

import Cahier.Web.Templates.Layout (layoutTemplate)
import Text.Blaze.Html (Html)
import Text.Hamlet (shamlet)

pageHome :: Html
pageHome =
  layoutTemplate
    ""
    [shamlet|
  <hgroup>
    <h1>Brian J. Gamble
    <h2>
      Believer &bullet; Developer &bullet; Writer
  <p>
    Building software is my bread and butter, but I'm also a writer.  I write poetry, and I'm working on my own fantasy world and stories.

  <article .social>
    <header>
      Social Links
    <ul>
      <li><a href="https://github.com/brianjgamble" target="_blank" rel="noreferrer noopener">GitHub</a>
      <li><a href="https://x.com/brianjgamble" target="_blank" rel="noreferrer noopener">X</a>
      <li><a href="https://www.linkedin.com/in/bjgamble/" target="_blank" rel="noreferrer noopener">LinkedIn</a>
|]
