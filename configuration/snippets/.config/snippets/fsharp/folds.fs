let withItem folder =
    fun acc item -> item, folder (snd acc) item
