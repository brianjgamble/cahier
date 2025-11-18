module Main where

import Test.DocTest (doctest)

main :: IO ()
main =
  doctest
    [ "--fast"
    , "-XOverloadedStrings"
    , "src/Cahier/Core/Content/Util.hs"
    ]
