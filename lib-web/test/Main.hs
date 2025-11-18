import Test.Tasty
import Web.LoggerTest qualified

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests =
  testGroup
    "Web tests"
    [Web.LoggerTest.tests]
