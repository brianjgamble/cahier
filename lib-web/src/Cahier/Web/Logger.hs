module Cahier.Web.Logger (
  logStdoutCustom,
) where

import Data.Bits (shiftR, (.&.))
import Data.ByteString.Char8 qualified as BS
import Network.HTTP.Types (statusCode, statusMessage)
import Network.Socket (HostAddress, SockAddr (..))
import Network.Wai (Middleware, Request, rawPathInfo, remoteHost, requestHeaders, requestMethod)
import Network.Wai.Middleware.RequestLogger
import System.Log.FastLogger

-- | Format the IP address from a SockAddr
formatIP :: SockAddr -> String
formatIP (SockAddrInet _ hostAddr) = formatIPv4 hostAddr
formatIP (SockAddrInet6 _ _ hostAddr6 _) = show hostAddr6
formatIP (SockAddrUnix path) = "unix:" ++ path

-- | Extract the real client IP from headers or socket address
getRealIP :: Request -> String
getRealIP req =
  case lookup "X-Forwarded-For" (requestHeaders req) of
    Just xff ->
      let ips = BS.split ',' xff
       in case ips of
            (firstIP : _) -> BS.unpack $ BS.strip firstIP -- Take first IP and strip whitespace
            [] -> formatIP (remoteHost req)
    Nothing -> case lookup "X-Real-IP" (requestHeaders req) of
      Just realIP -> BS.unpack realIP
      Nothing -> formatIP (remoteHost req) -- Fallback to socket address

-- | Convert HostAddress (Word32) to dotted decimal notation
formatIPv4 :: HostAddress -> String
formatIPv4 addr =
  let byte1 = fromIntegral $ addr .&. 0xFF
      byte2 = fromIntegral $ (addr `shiftR` 8) .&. 0xFF
      byte3 = fromIntegral $ (addr `shiftR` 16) .&. 0xFF
      byte4 = fromIntegral $ (addr `shiftR` 24) .&. 0xFF
   in show (byte1 :: Int) ++ "." ++ show (byte2 :: Int) ++ "." ++ show (byte3 :: Int) ++ "." ++ show (byte4 :: Int)

{- | Create a custom development logger that includes IP addresses

Output format:
GET /path
  IP address: 192.168.1.1
  User-Agent: Mozilla/5.0...
  Status: 200 OK 0.001234s
-}
logStdoutCustom :: IO Middleware
logStdoutCustom = do
  loggerSet <- newStdoutLoggerSet defaultBufSize
  mkRequestLogger
    defaultRequestLoggerSettings
      { outputFormat = CustomOutputFormatWithDetails formatWithIP
      , destination = Logger loggerSet
      }
 where
  formatWithIP _date req status _responseSize duration _reqBody _response =
    let ip = getRealIP req
        headers = requestHeaders req
        userAgent = case lookup "User-Agent" headers of
          Just ua -> "  User-Agent: " <> ua
          Nothing -> "  User-Agent: (none)"
        ipLine = "  IP address: " <> BS.pack ip
        statusLine =
          "  Status: "
            <> BS.pack (show $ statusCode status)
            <> " "
            <> statusMessage status
            <> " "
            <> BS.pack (show duration)
            <> "s"
     in toLogStr $
          BS.intercalate
            "\n"
            [ BS.unwords [requestMethod req, rawPathInfo req]
            , ipLine
            , userAgent
            , statusLine
            , "" -- Empty line for spacing between requests
            ]
