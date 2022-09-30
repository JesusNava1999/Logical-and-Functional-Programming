cribaOriginal :: Int -> [Int]
cribaOriginal n = cribaPrima [x | x <- [2..n]] 0

cribaPrima :: [Int] -> Int -> [Int]
cribaPrima arreglo n |
    n == length arreglo-1 = arreglo |
    otherwise = cribaPrima [x | x <- arreglo, (x `mod` arreglo!!n)/=0||x==arreglo!!n] (n+1)
