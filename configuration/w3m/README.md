w3m
===

A console based web browser.

Useful invocations to start it include:

```bash
w3m URL  # open the URL
w3m -v   # open and show welcome screen
w3m -B   # open and show bookmarks
```

Once in, `H` shows help.

Some core application key bindings:

- `s` = "s"elect page to view
- `B` = Close current page and go "b"ack
- `q` = "Q"uit

Page key bindings:

- `Tab` = move to next active thing
- `Enter` = select highlighted thing
- `Ctrl-m` = show menu to "m"ove focus to a hyperlink within the page
- `Ctrl-l` = show menu to navigate to a hyper"l"ink on the page

Tab key bindings:

- `T` = Open new "T"ab
- `Ctrl-q` = "Q"uit current tab

## CGI scripting

For simple local dynamic web pages, use a CGI script.

CGI allows parameters to be passed to the script via the query string.  Those are provided to the script in the `$QUERY_STRING` environment variable.

There is a W3m configuration setting specifying where to look for CGI scripts.  That will be pointed at the `cgi-bin` directory in here.

Running the example script is performed as follows: `w3m file:/cgi-bin/print-args.cgi?<qs>`

## Displaying help/bindings

The online help page is rendered via a built-in CGI script.  We can parse that output to find the current key bindings.
