import Test.Tasty
import Web.UrlTest qualified

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests =
  testGroup
    "Web tests"
    [Web.UrlTest.tests]
