module Cahier.Web.Templates.Pages.About where

import Cahier.Web.Templates.Layout (layoutTemplate)
import Text.Blaze.Html (Html)
import Text.Hamlet (shamlet)

pageAbout :: Html
pageAbout =
  layoutTemplate
    "About"
    [shamlet|
  <h1>About
  <p>My journey in software began a generation ago. After training in the halls of higher learning, my path has wound through small startups and Fortune 500 enterprises.
  <p>Through this quest, I've seen languages and frameworks rise and fall, patterns emerge and fade, and principles that endure. With each encounter, I've gained new insights about how to think, how to solve problems, how to build systems that last.
  <p>Through it all, I've come to believe <strong><em>code should tell a story.
  <p>Well-written code should communicate its intent clearly—what it does, why it does it, and how the pieces fit together.
  <p>When I write software, I'm crafting a narrative that other developers (and future me) need to understand. My approach is simple: get to the heart of the issue, design clear solutions, and write code that reads naturally.
  <p>But I wield more than one kind of pen. Poetry throughout this site—treasures waiting to be discovered. Fantasy fiction yet to come—stories where good triumphs over evil and tales of heroes facing impossible choices.
  <p>In the end, it's all storytelling. Code that solves problems; heroes who face darkness.
  <p>Both require the same dedication to craft and a belief that clarity and structure can create something meaningful.
  <p>At least, that's what I think...
|]
