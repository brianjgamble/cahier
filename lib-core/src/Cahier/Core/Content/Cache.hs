module Cahier.Core.Content.Cache (ContentCache, getAllPoems, getAllPosts, getPoem, getPost, initCache) where

import Cahier.Core.Content.Types
import Data.List (sortOn)
import Data.Map.Strict (Map)
import Data.Map.Strict qualified as Map
import Data.Ord (Down (..))
import Data.Text (Text)
import Data.Time.Calendar (Day)

-- | Cache to hold all loaded content
data ContentCache = ContentCache
  { poems :: Map Text Poem -- Keyed by slug
  , posts :: Map Text BlogPost -- Keyed by slug
  , poemsByTitle :: [Poem] -- Sorted by title, ascending
  , postsByDate :: [BlogPost] -- Sorted by date, newest first
  }
  deriving (Show)

-- | Get all poems sorted by year (newest first)
getAllPoems :: ContentCache -> [Poem]
getAllPoems = poemsByTitle

-- | Get all posts sorted by date (newest first)
getAllPosts :: ContentCache -> [BlogPost]
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
    , poemsByTitle = sortedPoems
    , postsByDate = sortedPosts
    }
 where
  poemsMap = Map.fromList poemsList
  postsMap = Map.fromList postsList
  sortedPoems = sortOn (Down . getPoemTitle) (map snd poemsList)
  sortedPosts = sortOn (Down . getPostDate) (map snd postsList)

-- Extract year from poem for sorting (treats Nothing as 0)
getPoemTitle :: Poem -> Text
getPoemTitle (Poem (PoemMetadata title _ _) _) = title

-- Extract date from post for sorting
getPostDate :: BlogPost -> Day
getPostDate (BlogPost (PostMetadata _ date _ _ _) _) = date
