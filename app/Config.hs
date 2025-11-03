module Config (scottyOptions) where

import Data.Maybe (fromMaybe)
import Data.String (fromString)
import Data.String.Interpolate (i)
import Network.Wai.Handler.Warp (HostPreference, defaultSettings, setBeforeMainLoop, setHost, setPort)
import System.Environment (lookupEnv)
import Web.Scotty

scottyOptions :: IO Options
scottyOptions = do
  -- Read environment variables
  maybePort <- lookupEnv "PORT"
  maybeHost <- lookupEnv "HOST"

  -- Convert and provide defaults
  let port = maybe 3000 read maybePort
      host = fromString (fromMaybe "127.0.0.1" maybeHost) :: HostPreference

  -- Build Warp settings
  let settings = setPort port $ setHost host defaultSettings

  -- Log when the server starts
  let settings_with_log = setBeforeMainLoop (putStrLn [i|Server running on #{host}:#{port}|]) settings

  -- Scotty options
  pure $ Options 0 settings_with_log
