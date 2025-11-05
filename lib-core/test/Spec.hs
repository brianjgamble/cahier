import Test.Tasty
import Test.Tasty.HUnit
import Cahier.Core.Greetings (greet)

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests = testGroup "Cahier.Core.Greetings"
  [ testCase "returns a proper greeting" $
      greet "Alice" @?= "Hello, Alice!"
  , testCase "handles empty name" $
      greet "" @?= "Hello, !"
  ]
