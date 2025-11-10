module Cahier.Core.Content.Parse (parsePoem, parsePost) where

import Cahier.Core.Content.Types
import Data.Bifunctor (first)
import Data.Text (Text)
import Data.Text qualified as T
import Data.Text.Encoding qualified as TE
import Data.Yaml (decodeEither')

-- | Parse a poem file
parsePoem :: Text -> Either String Poem
parsePoem input = do
  (yamlText, markdownText) <- extractFrontmatter input
  meta <- first show $ decodeEither' (TE.encodeUtf8 yamlText)
  return $ Poem meta markdownText

-- | Parse a blog post file
parsePost :: Text -> Either String BlogPost
parsePost input = do
  (yamlText, markdownText) <- extractFrontmatter input
  meta <- first show $ decodeEither' (TE.encodeUtf8 yamlText)
  return $ BlogPost meta markdownText

-- Extract YAML frontmatter and markdown content
extractFrontmatter :: Text -> Either String (Text, Text)
extractFrontmatter input =
  case T.lines input of
    ("---" : rest) ->
      case break (== "---") rest of
        (yamlLines, "---" : contentLines) ->
          Right (T.unlines yamlLines, T.unlines contentLines)
        _ -> Left "Missing closing --- delimiter for frontmatter"
    _ -> Left "File must start with --- delimiter"
