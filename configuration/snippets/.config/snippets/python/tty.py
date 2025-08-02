import sys

if sys.stdin.isatty():
    <+ interactive stdin +>
else:
    <+ piped stdin +>
