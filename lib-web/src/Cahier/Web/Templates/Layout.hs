module Cahier.Web.Templates.Layout (layoutTemplate) where

import Data.Text qualified as T
import Text.Blaze.Html (Html)
import Text.Hamlet (shamlet)

layoutTemplate :: T.Text -> Html -> Html
layoutTemplate pageTitle content =
  [shamlet|
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="color-scheme" content="light dark">
    <meta name="robots" content="noai">
    <title>#{formattedTitle pageTitle}
    <script src="/js/load-theme.js">
    <link rel="stylesheet" href="/css/pico.sand.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <script type="module" src="/js/app.js">
    <link rel="preload" href="/images/logo-small-dark.png" as="image">
    <link rel="preload" href="/images/logo-small-light.png" as="image">
  <body>
    <header .container .header>
      <nav>
        <a .logo-wrapper href="/">
          <div .logo>
        <ul .mobile_nav>
          <li>
            <details .dropdown .dropdown-toggle-no-caret>
              <summary>
                <div .menu-icon>
                  <span>
                  <span>
                  <span>
                <span .menu-text>
                  Menu
              <ul>
                #{links}
        <ul .desktop_nav>
          #{links}
        <ul .theme>
          <li>
            <a href="#" .toggle id="theme-toggle" title="Toggle light or dark theme">
    <main .container>
      #{content}
    <footer .container .footer>
      <div>
        <small>
          Made with &#9749;&nbsp;+&nbsp;
          <a href="https://www.haskell.org" target="_blank" rel="noreferrer noopener">Haskell
          &nbsp;+&nbsp;
          <a href="https://picocss.com" target="_blank" rel="noreferrer noopener">pico
      <div .copyright>
        © 2026 Brian J. Gamble &bullet; All rights reserved. Content may not be used for AI training or dataset generation.
|]

links :: Html
links =
  [shamlet|
<li>
  <a href="/">Home
<li>
  <a href="/posts">Posts
<li>
  <a href="/poetry">Poetry
<li>
  <a href="/about">About
|]

formattedTitle :: T.Text -> T.Text
formattedTitle pageTitle =
  case T.null pageTitle of
    True -> "Brian J. Gamble"
    False -> pageTitle <> " • Brian J. Gamble"
