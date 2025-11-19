---
title: How I Use Bulma with the Phoenix Framework
date: 2017-11-11
author: Brian J. Gamble
tags: [bulma css, phoenix framework]
---

[Bulma](https://bulma.io) is a CSS framework that looks great and uses flexbox for layout. It's customizable, easy to use, and modular. I've customized it with my own colors, fonts, and sizes. Let’s walk through how I added it to my [Phoenix](http://phoenixframework.org) web application.

> The following instructions are based on Bulma 0.6.1, Phoenix 1.3 and node 6.11.5 but should work fine with newer versions. YMMV.

## Configure Brunch

In the folder `assets`, the first change I made was in the file `package.json`. I'm getting Bulma via npm instead of a stylesheet link, so I added an entry in the dependencies section.

```json
  ...
  },
  "dependencies": {
    "phoenix": "file:../deps/phoenix",
    "phoenix_html": "file:../deps/phoenix_html",
    "sass-brunch": "^2.10.4",
    "bulma": "0.6.1"
  },
  ...
```

Next, I edited `brunch-config.js` to define the scss file containing the Bulma customizations.

```javascript
    ...
    },
    stylesheets: {
      joinTo: {
        'css/app.css': 'css/app.scss',
        'css/bulma.css': 'css/bulma-customize.scss',
        'css/lost.css': 'css/lost.scss'
      }
    },
    ...
```

## CSS files

In this section, I’ve provided listings for the stylesheets I’m using. They’re stored under `assets/css`.

File: `bulma-customize.scss`

```scss
@import "../node_modules/bulma/sass/utilities/initial-variables";
@import "../node_modules/bulma/sass/utilities/functions";
@import "variables";

$family-sans-serif: "futura-pt", sans-serif;
$family-primary: $family-sans-serif;

$primary: $brand-color;
$link: $brand-color;
$code: #b94b10;
$danger: #b92110;
$success: #10b959;

$navbar-height: 4.25rem;

$size-1: 3.75rem;
$size-2: 3.125rem;
$size-3: 2.5rem;
$size-4: 1.875rem;
$size-5: 1.5625rem;
$size-6: 1.25rem;
$size-7: 0.9375rem;

$radius-small: 3px;
$radius: 4px;
$radius-large: 6px;

@import "../node_modules/bulma/bulma";
```

File: `_variables.scss`

```scss
$brand-color: #1071b9;
$grey-darker: #595959;
$grey: #7f7f7f;
$grey-light: #999;
$grey-lighter: #e0e0e0;
```

File: `app.scss`

```scss
@import "variables";

body {
  display: flex;
  min-height: 100vh;
  flex-direction: column;
}

main {
  flex: 1;
}

img.nav-logo {
  max-height: 50px;
  width: 50px;
  height: 50px;
}

img.footer-logo {
  height: 35px;
}
```

File: `lost.scss`

(This is used on the 404 page and is not part of the main layout.)

```scss
@import "variables";

html {
  background-color: $grey-lighter;
}

a:hover {
  color: $brand-color;
  opacity: 0.75;
}

img.logo {
  height: 75px;
}
```

## Layout update

Now that brunch is configured, and the CSS files are in place, the app layout needs to include the stylesheets. In `lib/<web dir>/layout/app.html.eex`, I added two stylesheet links in the HTML heading.

```html
<link rel="stylesheet" href="<%= static_path(@conn, "/css/bulma.css") %>">
<link rel="stylesheet" href="<%= static_path(@conn, "/css/app.css") %>">
```

## Now you try

I hope this walkthrough encouraged you to give Bulma a spin. I think you'll enjoy it.
