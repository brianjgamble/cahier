module Cahier.Core.Content.Types where

import Data.Aeson
import Data.Text (Text)
import Data.Time.Calendar (Day)
import GHC.Generics

-- | Metadata for blog posts
data PostMetadata = PostMetadata
  { postTitle :: Text
  , postDate :: Day
  , postAuthor :: Maybe Text
  , postTags :: [Text]
  , postDescription :: Maybe Text
  }
  deriving (Generic, Show, Eq)

instance FromJSON PostMetadata where
  parseJSON = withObject "PostMetadata" $ \v ->
    PostMetadata
      <$> v .: "title"
      <*> v .: "date"
      <*> v .:? "author"
      <*> v .:? "tags" .!= []
      <*> v .:? "description"

-- | Metadata for poetry
data PoemMetadata = PoemMetadata
  { poemTitle :: Text
  , poemDate :: Day
  , poemAuthor :: Maybe Text
  }
  deriving (Generic, Show, Eq)

instance FromJSON PoemMetadata where
  parseJSON = withObject "PoemMetadata" $ \v ->
    PoemMetadata
      <$> v .: "title"
      <*> v .: "date"
      <*> v .:? "author"

-- | Complete blog post with metadata and content
data BlogPost = BlogPost
  { postMetadata :: PostMetadata
  , postContent :: Text
  }
  deriving (Show, Eq)

-- | Complete poem with metadata and content
data Poem = Poem
  { poemMetadata :: PoemMetadata
  , poemContent :: Text
  }
  deriving (Show, Eq)

-- | Union type for any content
data Content
  = Post BlogPost
  | Poetry Poem
  deriving (Show, Eq)
