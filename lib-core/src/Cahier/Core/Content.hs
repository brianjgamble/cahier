module Cahier.Core.Content (
  loadContentCache,
  ContentLoadException (..),
  module Cahier.Core.Content.Types,
  module Cahier.Core.Content.Cache,
) where

import Cahier.Core.Content.Cache
import Cahier.Core.Content.Files
import Cahier.Core.Content.Types
import Control.Exception (Exception, throwIO)
import System.FilePath ((</>))

data ContentLoadException where
  ContentLoadException :: [String] -> ContentLoadException
  deriving (Show)

instance Exception ContentLoadException

{- | Load content cache from disk.
Throws ContentLoadException if any files fail to load
-}
loadContentCache :: FilePath -> IO ContentCache
loadContentCache contentPath = do
  let postsPath = contentPath </> "posts"
      poemsPath = contentPath </> "poetry"

  -- Load all posts and poems
  (postsList, postErrors) <- loadAllPosts postsPath
  (poemsList, poemErrors) <- loadAllPoems poemsPath

  let allErrors = postErrors ++ poemErrors

  if not (null allErrors)
    then throwIO $ ContentLoadException allErrors
    else return $ initCache postsList poemsList
