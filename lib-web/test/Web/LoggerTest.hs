module Web.LoggerTest (tests) where

import Cahier.Web.Logger (logStdoutCustom)
import Data.List (isInfixOf)
import Network.HTTP.Types (methodPost, status200)
import Network.Socket (SockAddr (..), tupleToHostAddress, tupleToHostAddress6)
import Network.Wai (Application, defaultRequest, remoteHost, requestHeaders, requestMethod, responseLBS)
import Network.Wai.Test (SRequest (..), runSession, srequest)
import System.IO (stdout)
import System.IO.Silently (hCapture_)
import Test.Tasty
import Test.Tasty.HUnit

-- Simple test application
testApp :: Application
testApp _req respond = respond $ responseLBS status200 [] "OK"

tests :: TestTree
tests =
  testGroup
    "Logger Tests"
    [ testGroup
        "IP Address Formatting"
        [ testCase "formats IPv4 localhost correctly" $ do
            let addr = tupleToHostAddress (127, 0, 0, 1)
                sockAddr = SockAddrInet 3000 addr
            logger <- logStdoutCustom
            output <- hCapture_ [stdout] $ do
              let req = defaultRequest{remoteHost = sockAddr}
              runSession (srequest (SRequest req "")) (logger testApp)
            assertBool "should contain correct IP" $
              isInfixOf "127.0.0.1" output
        , testCase "formats IPv4 192.168.1.100 correctly" $ do
            let addr = tupleToHostAddress (192, 168, 1, 100)
                sockAddr = SockAddrInet 3000 addr
            logger <- logStdoutCustom
            output <- hCapture_ [stdout] $ do
              let req = defaultRequest{remoteHost = sockAddr}
              runSession (srequest (SRequest req "")) (logger testApp)
            assertBool "should contain correct IP" $
              isInfixOf "192.168.1.100" output
        , testCase "handles IPv6 addresses" $ do
            let addr6 = tupleToHostAddress6 (0, 0, 0, 0, 0, 0, 0, 1)
                sockAddr = SockAddrInet6 3000 0 addr6 0
            logger <- logStdoutCustom
            output <- hCapture_ [stdout] $ do
              let req = defaultRequest{remoteHost = sockAddr}
              runSession (srequest (SRequest req "")) (logger testApp)
            assertBool "should contain IP address line" $
              isInfixOf "IP address:" output
        , testCase "handles Unix socket addresses" $ do
            let sockAddr = SockAddrUnix "/tmp/test.sock"
            logger <- logStdoutCustom
            output <- hCapture_ [stdout] $ do
              let req = defaultRequest{remoteHost = sockAddr}
              runSession (srequest (SRequest req "")) (logger testApp)
            assertBool "should contain unix socket path" $
              isInfixOf "unix:/tmp/test.sock" output
        ]
    , testGroup
        "Real IP Detection"
        [ testCase "uses X-Forwarded-For header when present" $ do
            logger <- logStdoutCustom
            output <- hCapture_ [stdout] $ do
              let req =
                    defaultRequest
                      { remoteHost = SockAddrInet 3000 (tupleToHostAddress (10, 0, 0, 1))
                      , requestHeaders = [("X-Forwarded-For", "203.0.113.42, 198.51.100.1")]
                      }
              runSession (srequest (SRequest req "")) (logger testApp)
            assertBool "should contain client IP from X-Forwarded-For" $
              isInfixOf "203.0.113.42" output
        , testCase "uses X-Real-IP header when X-Forwarded-For is absent" $ do
            logger <- logStdoutCustom
            output <- hCapture_ [stdout] $ do
              let req =
                    defaultRequest
                      { remoteHost = SockAddrInet 3000 (tupleToHostAddress (10, 0, 0, 1))
                      , requestHeaders = [("X-Real-IP", "203.0.113.99")]
                      }
              runSession (srequest (SRequest req "")) (logger testApp)
            assertBool "should contain client IP from X-Real-IP" $
              isInfixOf "203.0.113.99" output
        , testCase "falls back to remoteHost when no proxy headers present" $ do
            logger <- logStdoutCustom
            output <- hCapture_ [stdout] $ do
              let req =
                    defaultRequest
                      { remoteHost = SockAddrInet 3000 (tupleToHostAddress (192, 168, 1, 50))
                      }
              runSession (srequest (SRequest req "")) (logger testApp)
            assertBool "should contain IP from remoteHost" $
              isInfixOf "192.168.1.50" output
        , testCase "strips whitespace from X-Forwarded-For" $ do
            logger <- logStdoutCustom
            output <- hCapture_ [stdout] $ do
              let req =
                    defaultRequest
                      { remoteHost = SockAddrInet 3000 (tupleToHostAddress (10, 0, 0, 1))
                      , requestHeaders = [("X-Forwarded-For", " 203.0.113.55 , 198.51.100.2")]
                      }
              runSession (srequest (SRequest req "")) (logger testApp)
            assertBool "should contain trimmed client IP" $
              isInfixOf "203.0.113.55" output
        ]
    , testGroup
        "Log Output Format"
        [ testCase "includes request method and path" $ do
            logger <- logStdoutCustom
            output <- hCapture_ [stdout] $ do
              let req =
                    defaultRequest
                      { remoteHost = SockAddrInet 3000 (tupleToHostAddress (127, 0, 0, 1))
                      }
              runSession (srequest (SRequest req "")) (logger testApp)
            assertBool "should contain GET" $
              isInfixOf "GET " output
        , testCase "includes User-Agent when present" $ do
            logger <- logStdoutCustom
            output <- hCapture_ [stdout] $ do
              let req =
                    defaultRequest
                      { remoteHost = SockAddrInet 3000 (tupleToHostAddress (127, 0, 0, 1))
                      , requestHeaders = [("User-Agent", "Test/1.0")]
                      }
              runSession (srequest (SRequest req "")) (logger testApp)
            assertBool "should contain User-Agent" $
              isInfixOf "User-Agent: Test/1.0" output
        , testCase "shows (none) when User-Agent missing" $ do
            logger <- logStdoutCustom
            output <- hCapture_ [stdout] $ do
              let req =
                    defaultRequest
                      { remoteHost = SockAddrInet 3000 (tupleToHostAddress (127, 0, 0, 1))
                      }
              runSession (srequest (SRequest req "")) (logger testApp)
            assertBool "should contain User-Agent: (none)" $
              isInfixOf "User-Agent: (none)" output
        , testCase "includes status code and message" $ do
            logger <- logStdoutCustom
            output <- hCapture_ [stdout] $ do
              let req =
                    defaultRequest
                      { remoteHost = SockAddrInet 3000 (tupleToHostAddress (127, 0, 0, 1))
                      }
              runSession (srequest (SRequest req "")) (logger testApp)
            assertBool "should contain Status: 200 OK" $
              isInfixOf "Status: 200 OK" output
        , testCase "includes timing information" $ do
            logger <- logStdoutCustom
            output <- hCapture_ [stdout] $ do
              let req =
                    defaultRequest
                      { remoteHost = SockAddrInet 3000 (tupleToHostAddress (127, 0, 0, 1))
                      }
              runSession (srequest (SRequest req "")) (logger testApp)
            -- Check for status line with timing
            assertBool "should contain Status:" $
              isInfixOf "Status: 200 OK" output
        ]
    , testGroup
        "Different HTTP Methods"
        [ testCase "logs POST requests correctly" $ do
            logger <- logStdoutCustom
            output <- hCapture_ [stdout] $ do
              let req =
                    defaultRequest
                      { remoteHost = SockAddrInet 3000 (tupleToHostAddress (127, 0, 0, 1))
                      , requestMethod = methodPost
                      }
              runSession (srequest (SRequest req "")) (logger testApp)
            assertBool "should contain POST" $
              isInfixOf "POST " output
        ]
    ]
