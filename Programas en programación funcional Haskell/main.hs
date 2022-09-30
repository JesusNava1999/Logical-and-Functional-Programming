distanciaAyB :: Float -> Float -> Float -> Float -> Float
distanciaAyB a1 a2 b1 b2 = sqrt ((a2-a1)^2) + ((b2-b1)^2)

raicesReales :: Float -> Float -> Float -> [Float]
raicesReales a b c = [(-b + sqrt(b^2 - 4 * a * c))/(2 * a), (-b-sqrt(b^2 - 4 * a * c))/(2 * a)]

cuadrados :: Int->[Int]
cuadrados n = map (^2) [1..n]

fibbo :: Int -> Int
fibbo 0 = 0
fibbo 1 = 1
fibbo n = fibbo (n-1) + fibbo (n-2)

mayor :: Int -> Int -> Int
mayor x y =
    if x > y
    then x
    else y