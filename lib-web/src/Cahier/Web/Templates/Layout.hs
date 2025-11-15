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
    <title>#{formattedTitle pageTitle}
    <script src="js/load-theme.js">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@450" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.sand.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <script type="module" src="/js/app.js">
    <link rel="preload" href="/images/logo-dark.png" as="image">
    <link rel="preload" href="/images/logo-light.png" as="image">
    <link rel="preload" href="/images/logo-small-dark.png" as="image">
    <link rel="preload" href="/images/logo-small-light.png" as="image">
  <body>
    <header .container>
      <nav>
        <a href="/">
          <div .logo></div>
        <ul .mobile_nav>
          <li>
            <details .dropdown .dropdown-toggle-no-caret>
              <summary .menu-icon>
                <span>
                <span>
                <span>
              <ul>
                #{links}
        <ul .desktop_nav>
          #{links}
        <ul>
          <li>
            <a href="#" .toggle id="theme-toggle" title="Toggle light or dark theme">
    <main .container>
      #{content}
    <footer .container>
      <div>
        <small>
          Made with &#9749;&nbsp;+&nbsp;
          <a href="https://www.haskell.org" target="_blank" rel="noreferrer noopener">Haskell
          &nbsp;+&nbsp;
          <a href="https://picocss.com" target="_blank" rel="noreferrer noopener">pico
      <div>
        <small>
          Copyright &copy; 2014-2025 Brian J. Gamble.  All rights reserved.
|]

links :: Html
links =
  [shamlet|
<li>
  <a href="/">Home
<li>
  <a href="/posts">Blog
<li>
  <a href="/poetry">Poetry
<li>
  <a href="/contact">Contact
<li>
  <a href="/about">About
|]

formattedTitle :: T.Text -> T.Text
formattedTitle pageTitle =
  case T.null pageTitle of
    True -> "Brian J. Gamble"
    False -> pageTitle <> " • Brian J. Gamble"
