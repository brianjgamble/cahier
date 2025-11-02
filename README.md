<p>
    <a href="LICENSE-code.md" alt="Code license"><img src="https://img.shields.io/badge/code_license-BSD_3_Clause-yellow" /></a>
    <a href="https://www.haskell.org/" alt="Haskell"><img src="https://img.shields.io/badge/Haskell-5e5086?logo=haskell&logoColor=white" /></a>
</p>

# &#x1F4D3; Cahier

## What is this?

This is the code for my personal ~~notebook~~ website.

It is a [Haskell](https://www.haskell.org/) application built with the [Scotty](https://hackage.haskell.org/package/scotty) web framework, [shakespeare](https://hackage.haskell.org/package/shakespeare) template engine, [pico](https://picocss.com/) css framework, and a few other great libraries.

## Should I fork this for my website?

Probably not. **_This is not a general purpose website_**. It is a website and CMS that is specific to my needs. From the design and layout, to the content and code, I built this for me.

Why code it in Haskell? Why not? I enjoy coding in functional languages and I really wanted to build a site in it.

## What is it good for?

If you want to build a web application using Haskell (or aspire to), this is a place to poke around and see what one looks like under the hood. It's not perfect and I'm sure you could say XYZ technology would be better, but it works.

## Running the project locally

You will need to have Haskell and Cabal installed. My suggestion is to use to [GHCup](https://www.haskell.org/ghcup/).

1. Clone the repository (via SSH):

   ```bash
   git clone git@github.com:brianjgamble/cahier.git
   cd cahier
   ```

2. Install dependencies and build the project:

   ```bash
   cabal v2-update
   cabal v2-build
   ```

3. Run the application:

   ```bash
   cabal v2-run
   ```

   You can access the website at [http://localhost:3000](http://localhost:3000).

## License

The code in this repository is licensed under the [BSD 3-Clause License](LICENSE-code.md).
