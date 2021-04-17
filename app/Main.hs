module Main where

import Data.List

import System.Directory

main :: IO ()
main = do
 text <- readFile "test.tex"
 let l = numItems (lines text) 0 [] []
 removeDirectoryRecursive "qs"
 createDirectory"qs"
 let lz = reverse $ zip (init l) (drop 1 l)
 let t = toWrite (addNewLines $ lines text) 25 25 37 
 writeFile "qs/1.tex" (concat t)
 print lz

 --createTex l
 
 return ()

getPreamble t = elemIndex "\\begin{document}" $ lines t

-- Counts the number of top-level items
numItems (t:ts) n k s
 | "\\begin{enumerate}" `isInfixOf` t = numItems ts (n+1) k (")":s)
 | "\\end{enumerate}" `isInfixOf` t && length s == 1 = numItems ts (n+1) (n:k) $ tail s 
 | "\\end{enumerate}" `isInfixOf` t = numItems ts (n+1) k $ tail s 
 | "\\item" `isInfixOf` t && length s == 1 = numItems ts (n+1) (n:k) s
 | otherwise = numItems ts (n+1) k s

numItems [] _ k _= k

addNewLines = map (++"\n")

toWrite text preamble start end = take preamble text ++ take (end-start) (drop preamble text) ++
                                  ["\\end{enumerate}\n"] ++
                                  ["\\end{document}"]

