module Cahier.Web.Templates.Pages.About where

import Cahier.Web.Templates.Layout (layoutTemplate)
import Text.Blaze.Html (Html)
import Text.Hamlet (shamlet)

pageAbout :: Html
pageAbout =
  layoutTemplate
    "About"
    [shamlet|
  <h1 .center>About.
  <p .summary>Getting to know the writer behind the pages
  <p>
    My journey in software began a generation ago. After training in the halls of my chosen guild, my path has wound
    through small startups and Fortune 500 enterprises.
  <p>
    Through this quest, I've seen languages and frameworks rise and fall, patterns emerge and fade, but also principles
    that endure. With each encounter, I've gained new insights about how to think, how to solve problems, how to build
    systems that last.
  <p>
    Through it all, I've come to believe
    <strong>
      <em>code should tell a story.
  <p>
    Well-written code should communicate its intent clearly—what it does, why it does it, how the pieces fit together.
  <p>
    When I write software, I'm crafting a narrative that other developers (and the future me) need to understand. My
    approach is simple: get to the heart of the issue, design clear solutions, and write code that is easy to maintain.
  <p>
    But I wield more than one kind of pen:
  <ul>
    <li>
      Hidden treasures waiting to be discovered in the poetry throughout this site.
    <li>
      Fantasy fiction, that's yet to come, with stories of good over evil and heroes facing unimaginable choices.
  <p>
    In the end, it's all storytelling: code that solves problems; heroes who overcome darkness.
  <p>
    At least, that's how I see it.
|]
