module Web.UrlTest (tests) where

import Cahier.Web.Url (slugify)
import Test.Tasty
import Test.Tasty.HUnit

tests :: TestTree
tests =
  testGroup
    "slugify"
    [ testCase "Letters and numbers are valid" $
        slugify "test123" @?= "test123"
    , testCase "Converts letters to lowercase" $
        slugify "ThIs Is A MiXeD CaSe!" @?= "this-is-a-mixed-case"
    , testCase "Removes leading and trailing spaces" $
        slugify "  * Hello, World *  " @?= "hello-world"
    , testCase "Removes spaces between words" $
        slugify "  Hello     World  " @?= "hello-world"
    , testCase "Collapses multiple hyphens" $
        slugify "Hello---World" @?= "hello-world"
    , testCase "Empty string" $
        slugify "" @?= ""
    , testCase "Strips special characters" $
        slugify "!@#$%^&*()" @?= ""
    , testCase "Strips leading and trailing hyphens" $
        slugify "--Hello World--" @?= "hello-world"
    ]
