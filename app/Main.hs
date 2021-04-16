module Main where

import Data.List

main :: IO ()
main = do
 text <- readFile "test.tex"
 let l = numItems (lines text) 0 [] in
  print l
 return ()

getPreamble t = elemIndex "\\begin{document}" $ lines t


-- Counts the number of top-level items
numItems (t:ts) n s
 | "\\begin{enumerate}" `isInfixOf` t = numItems ts n (")":s)
 | "\\end{enumerate}" `isInfixOf` t = numItems ts n $ tail s 
 | "\\item" `isInfixOf` t && length s == 1 = numItems ts (n+1) s
 | otherwise = numItems ts n s

numItems [] n _ = n


