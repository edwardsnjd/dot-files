#! /usr/bin/env -S dotnet fsi

printfn "Hello from F# script!"

let sum a b = a + b
printfn "Sum of 5 and 3 is: %d" (sum 5 3)
