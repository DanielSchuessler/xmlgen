import Criterion.Main
import qualified Data.ByteString.Lazy as BSL
import System.Environment

import Text.XML.Generator

gen :: Int -> IO ()
gen numberOfElems = BSL.writeFile "/tmp/test.xml" (xrender doc)
      where doc = xelem "root" $ xelems $ map (\s -> xelem "foo" (xattr "key" s, xtext s)) (map show [1..numberOfElems])

main =
    do args <- getArgs
       case args of
         "--standalone":s:[] -> gen (read s)
         _ -> defaultMain (map (\i -> bench ("gen " ++ show i) (gen i)) [1000, 10000, 100000])
