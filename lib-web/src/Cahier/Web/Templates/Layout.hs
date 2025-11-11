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
    <title>#{pageTitle}
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@450" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.sand.min.css">
    <link rel="stylesheet" href="/css/style.css">
    <script src="/js/theme-switcher.js">
    <script type="module" src="/js/app.js">
  <body>
    <header .container>
      <nav>
        <a href="/">Home
        <a href="/posts">Blog
        <a href="/poetry">Poetry
        <a href="/contact">Contact
        <a href="/about">About
        <a href="#" .toggle id="theme_switcher" title="Toggle light or dark theme">
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
