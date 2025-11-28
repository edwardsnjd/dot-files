[<StructuredFormatDisplay("({X},{Y})")>]
type Coordinate =
    { X: int
      Y: int }

    member s.add(dx, dy) : Coordinate = { X = s.X + dx; Y = s.Y + dy }

    member s.neighbours: Coordinate list =
        [ for dx in [ -1 .. 1 ] do
              for dy in [ -1 .. 1 ] do
                  if dx <> 0 || dx <> dy then
                      yield dx, dy ]
        |> List.map s.add
