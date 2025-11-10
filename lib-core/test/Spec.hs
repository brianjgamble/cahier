import Core.Content.UtilTest qualified
import Test.Tasty

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests =
  testGroup
    "Core tests"
    [Core.Content.UtilTest.tests]
