let allPairs values =
    let len = List.length values

    seq {
        for i in [ 0 .. len - 1 ] do
            for j in [ i + 1 .. len - 1 ] do
                yield values[i], values[j]
    }
