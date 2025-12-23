let memoizeRec (f: ('a -> 'b) -> 'a -> 'b) =
    let cache = System.Collections.Generic.Dictionary<'a, 'b>()

    let rec inner x =
        match cache.TryGetValue x with
        | true, value -> value
        | false, _ ->
            let value = f inner x
            cache.[x] <- value
            value

    inner
