module Core.Content.UtilTest (tests) where

import Cahier.Core.Content.Util (slugify)
import Data.Text qualified as T
import Test.Tasty
import Test.Tasty.HUnit

tests :: TestTree
tests =
  testGroup
    "slugify"
    [ testCase "Letters and numbers are valid" $
        slugify (T.pack "test123") @?= T.pack "test123"
    , testCase "Converts letters to lowercase" $
        slugify (T.pack "ThIs Is A MiXeD CaSe!") @?= T.pack "this-is-a-mixed-case"
    , testCase "Removes leading and trailing spaces" $
        slugify (T.pack "  * Hello, World *  ") @?= T.pack "hello-world"
    , testCase "Removes spaces between words" $
        slugify (T.pack "  Hello     World  ") @?= T.pack "hello-world"
    , testCase "Collapses multiple hyphens" $
        slugify (T.pack "Hello---World") @?= T.pack "hello-world"
    , testCase "Empty string" $
        slugify (T.pack "") @?= T.pack ""
    , testCase "Strips special characters" $
        slugify (T.pack "!@#$%^&*()") @?= T.pack ""
    , testCase "Strips leading and trailing hyphens" $
        slugify (T.pack "--Hello World--") @?= T.pack "hello-world"
    ]
