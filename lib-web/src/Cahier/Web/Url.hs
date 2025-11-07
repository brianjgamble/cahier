module Cahier.Web.Url (slugify) where

import Data.Char (isAlphaNum, isSpace, toLower)

{- | Converts a string into an URL slug.

>>> slugify "Hello, World"
"hello-world"
-}
slugify :: String -> String
slugify =
  stripHyphens
    . collapseHyphens
    . map spaceToHyphen
    . filter allowedChar
    . map toLower

-- Only allow alphanumeric characters, spaces, and hyphens
allowedChar :: Char -> Bool
allowedChar c = isAlphaNum c || isSpace c || c == '-'

-- Collapse multiple consecutive '-' into a single '-'
collapseHyphens :: String -> String
collapseHyphens [] = []
collapseHyphens [x] = [x]
collapseHyphens (x : y : xs)
  | x == '-' && y == '-' = collapseHyphens (y : xs)
  | otherwise = x : collapseHyphens (y : xs)

-- Convert spaces to hyphens
spaceToHyphen :: Char -> Char
spaceToHyphen c
  | isSpace c = '-'
  | otherwise = c

-- Remove leading and trailing '-'
stripHyphens :: String -> String
stripHyphens = dropWhile (== '-') . reverse . dropWhile (== '-') . reverse
