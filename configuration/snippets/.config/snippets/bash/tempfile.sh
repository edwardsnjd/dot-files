# Write stdin to temp for multiple processing
local tempfile="$(mktemp)"
trap "rm -f \"$tempfile\"" EXIT
cat > "$tempfile"
