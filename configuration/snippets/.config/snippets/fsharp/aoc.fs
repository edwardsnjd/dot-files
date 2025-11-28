open System.Text.RegularExpressions

let lines =
  Seq.initInfinite (fun _ -> System.Console.ReadLine())
  |> Seq.takeWhile (fun line -> line <> null)
  |> Seq.toList

let words (line: string) =
  line.Split(',', System.StringSplitOptions.RemoveEmptyEntries)

let (|Ints|) (line: string) =
  Regex.Matches(line, @"-?\d+")
  |> Seq.cast<Match>
  |> Seq.map (fun m -> int m.Value)
  |> Seq.toList

let (|Words|) (line: string) =
  Regex.Matches(line, @"\w+")
  |> Seq.cast<Match>
  |> Seq.map (fun m -> m.Value)
  |> Seq.toList

let fooRegex = Regex @"...(.)..(.)."
let (|Foo|_|) (s: string) =
  let m = fooRegex.Match s
  if m.Success then Some (int m.Groups.[1].Value, m.Groups.[2].Value) else None

let parse line =
  match line with
  | Ints ints -> printfn "%d ints found" (List.length ints)
  | Words ws -> printfn "%d words found" (List.length ws)
  | Foo (a,b) -> printfn "%A values found" [a; b]

let part1 = id
let part2 = id

lines |> part1 |> printfn "Part1: %A"
lines |> part2 |> printfn "Part2: %A"
