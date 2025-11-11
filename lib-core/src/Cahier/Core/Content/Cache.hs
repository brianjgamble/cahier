module Cahier.Core.Content.Cache (ContentDigest, ContentCache, getAllPoems, getAllPosts, getPoem, getPost, initCache) where

import Cahier.Core.Content.Types
import Data.List (sortOn)
import Data.Map.Strict (Map)
import Data.Map.Strict qualified as Map
import Data.Ord (Down (..))
import Data.Text (Text)
import Data.Time.Calendar (Day)

-- | Digest information for content listings
data ContentDigest = ContentDigest
  { title :: Text
  , slug :: Text
  }
  deriving (Show, Eq)

-- | Cache to hold all loaded content
data ContentCache = ContentCache
  { poems :: Map Text Poem -- Keyed by slug
  , posts :: Map Text BlogPost -- Keyed by slug
  , poemsByTitle :: [ContentDigest] -- Sorted by title, ascending
  , postsByDate :: [ContentDigest] -- Sorted by date, newest first
  }
  deriving (Show)

-- | Get all poems sorted by year (newest first)
getAllPoems :: ContentCache -> [ContentDigest]
getAllPoems = poemsByTitle

-- | Get all posts sorted by date (newest first)
getAllPosts :: ContentCache -> [ContentDigest]
getAllPosts = postsByDate

-- | Get a single poem by slug
getPoem :: Text -> ContentCache -> Maybe Poem
getPoem slug cache = Map.lookup slug (poems cache)

-- | Get a single post by slug
getPost :: Text -> ContentCache -> Maybe BlogPost
getPost slug cache = Map.lookup slug (posts cache)

-- | Initialize cache with posts and poems
initCache :: [(Text, BlogPost)] -> [(Text, Poem)] -> ContentCache
initCache postsList poemsList =
  ContentCache
    { poems = poemsMap
    , posts = postsMap
    , poemsByTitle = sortedPoemDigests
    , postsByDate = sortedPostDigests
    }
 where
  poemsMap = Map.fromList poemsList
  postsMap = Map.fromList postsList
  sortedPoems = sortOn (Down . getPoemTitle . snd) poemsList
  sortedPosts = sortOn (Down . getPostDate . snd) postsList
  sortedPoemDigests =
    map
      ( \(slug, Poem (PoemMetadata title _ _) _) ->
          ContentDigest title slug
      )
      sortedPoems
  sortedPostDigests =
    map
      ( \(slug, BlogPost (PostMetadata title _ _ _ _) _) ->
          ContentDigest title slug
      )
      sortedPosts

-- Extract title from poem
getPoemTitle :: Poem -> Text
getPoemTitle (Poem (PoemMetadata title _ _) _) = title

-- Extract date from post for sorting
getPostDate :: BlogPost -> Day
getPostDate (BlogPost (PostMetadata _ date _ _ _) _) = date
