type List<'a> with
    // All pairs, excluding with same item
    member l.allDifferentPairs =
        let len = List.length l
        seq {
            for i in 0 .. len-1 do
                 for j in i+1 .. len-1 do
                      yield l[i], l[j]
        }

    // All pairs, excluding with same item, in both directions
    member l.allDifferentPairs' =
        l.allDifferentPairs
        |> Seq.collect (fun (a,b) -> seq { yield a,b; yield b,a })
