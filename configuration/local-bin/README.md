# `.local/bin/` scripts

Collection of utility scripts for shell, git, Docker, productivity, etc. that I tend to include on my `PATH`.

## Quick Navigation

- [Git Tools](#git-tools)
- [GitHub Tools](#github-tools)
- [Productivity & Time](#productivity--time)
- [Text & Data Processing](#text--data-processing)
- [Development Tools](#development-tools)
- [System & Network](#system--network)
- [File & Directory Explorers](#file--directory-explorers)
- [Media & Web](#media--web)
- [Miscellaneous](#miscellaneous)

---

## Git Tools

### browse-tags

Interactive fzf browser over a ctags `tags` file.

Example: `./browse-tags`

### git-browse-branches

Interactive git branch browser.

Example: `./git-browse-branches`

### git-browse-diff

Interactive git diff browser.

Example: `./git-browse-diff HEAD~1`

### git-browse-file-diffs

Browse differences for specific files in git.

Example: `./git-browse-file-diffs README.md`

### git-browse-file-versions

Browse historical versions of a file in git.

Example: `./git-browse-file-versions main.go`

### git-browse-log

Powerful interactive git log browser.

Example: `./git-browse-log`

### git-browse-log-files

Browse files associated with git log entries.

Example: `./git-browse-log-files`

### git-browse-log2

Alternative interactive git log explorer.

Example: `./git-browse-log2`

### git-browse-tag-versions

Browse different versions of a git tag.

Example: `./git-browse-tag-versions v1.0.0`

### git-commit-files

List all files changed in git commits.

Example: `./git-commit-files HEAD`

### git-commits

List git commits with customizable arguments.

Example: `./git-commits --author="Nick"`

### git-code-age

Output the author timestamp for every line in every file at a given commit.

Example: `./git-code-age HEAD`

### git-contributor

Interactively select the name and email of a git contributor, optionally pre-filtered by a query.

Example: `./git-contributor "Nicholas Edwards"`

### git-contributors

List all contributors to a git repository.

Example: `./git-contributors`

### git-count-commits

Count commits grouped by date (default YYYY-MM) as a date-tab-count TSV, accepting git log args.

Example: `./git-count-commits`

### git-count-contributors

Count git contributors per date (default YYYY-MM) as a date-tab-contributor-tab-count TSV, accepting git log args.

Example: `./git-count-contributors`

### git-diff-img

Visual diff tool for images in a git repository.

Example: `git config --global diff.driver git-diff-img`
Example: `git diff old.png new.png`

### git-exec

Run an arbitrary command on a specific revision of a repository.

Example: `./git-exec HEAD~3 wc -l README.md`

### git-function-versions

Browse historical versions of a code function.

Example: `./git-function-versions src/file.c MyFunctionName`

### git-function-versions2

List git history of a function using a BFS approach with interactive fzf.

Example: `./git-function-versions2 myFunction src/file.c`

### git-graphviz

Generate Graphviz visualizations of git history.

Example: `./git-graphviz | dot -Tpng -o graph.png`

### git-graphviz-all

Generate Graphviz visualizations for all git refs.

Example: `./git-graphviz-all`

### git-interesting-files

Interactive browser for "interesting" git files.

Example: `./git-interesting-files`

### git-lines

Reformat git blame into one TSV line per modified line for further processing.

Example: `./git-lines`

### git-browse-objects

Interactively browse a commit's tree objects via fzf, with a notes preview and an annotate action.

Example: `./git-browse-objects`

### git-churn

Show churn for specific directories or time ranges in a git repository.

Example: `./git-churn app lib`

Example: `./git-churn --since='1 month ago'`

### git-notes-manager

Interactively browse and manage git notes for the repo.

Example: `./git-notes-manager`

### git-notes-tree

Display file tree annotated with git notes.

Example: `./git-notes-tree`

### git-plot-commits

Plot git commit activity over time.

Example: `./git-plot-commits`

### git-plot-contributors

Plot contributor activity in a git repository.

Example: `./git-plot-contributors`

### git-related-files

Find files related to a specific file via git history.

Example: `./git-related-files main.c`

### git-related-files-chart

Generate a relationship chart for git files.

Example: `./git-related-files-chart`

### git-repo-stats

Comprehensive repository statistics (LOC, authors).

Example: `./git-repo-stats`

### git-sha-on

Find the git SHA active on a specific date.

Example: `./git-sha-on 2023-01-01`

### git-worktree-switch

Interactively switch to a git worktree via fzf (must be sourced so it can change the current shell's directory).

Example: `source git-worktree-switch`

### tags-context

Show the enclosing class/function context for a source-code line (via ctags).

Example: `./tags-context path/to/file.c 42`

### git-file-commits

Opinionated git log to show renames.

Example: `./git-file-commits <path> [<tformat>]`

---

## GitHub Tools

### gh-prs

List GitHub Pull Requests for a given repo, optionally filtered by author.

Example: `./gh-prs owner/repo [author]`

### gh-prs-to-tsv

Convert GitHub PR list to TSV format.

Example: `./gh-prs | ./gh-prs-to-tsv`

### gh-search-prs

Search through GitHub Pull Requests.

Example: `./gh-search-prs "refactor"`

---

## Productivity & Time

### emojify-cal

Emojify the current-date highlight of `cal`/`ncal` output.

Example: `./emojify-cal cal`

### hundredblocks-time

Display time in the "hundred blocks" format.

Example: `./hundredblocks-time`

### laptimer

Simple lap timer for tracking intervals.

Example: `./laptimer`

### new-note

Create a new timestamped markdown note.

Example: `./new-note`

### pomo.sh

Lightweight bash-based Pomodoro timer.

Example: `./pomo.sh`

### simple-pomodoro

Pomodoro timer with desktop notification support.

Example: `./simple-pomodoro`

### stopwatch

Simple terminal-based stopwatch.

Example: `./stopwatch`

### timezones

Check the current time across multiple time zones.

Example: `./timezones`

### weather-forecast

Display local weather forecast via wttr.in.

Example: `./weather-forecast "/London"`

### workflowy

Generic CLI wrapper for Workflowy API operations (list, create, complete).

Example: `./workflowy create "parent-id" "Task title" "Optional note"`

Example: `./workflowy list "parent-id"`

Example: `./workflowy complete "node-id"`

### workflowy-ingestion

Manage pending ingestion items in Workflowy via API.

Example: `./workflowy-ingestion list`

Example: `./workflowy-ingestion log "node-id" failed "Network timeout"`

Example: `./workflowy-ingestion complete "node-id"`

### ingest

Process pending Workflowy ingestion items and take appropriate actions based on their content.

Example: `./ingest`

### workflowy-backup-search

Search Workflowy backups for a query and format results.

Example: `./workflowy-backup-search "project"`

### add-bookmark

Add a bookmark to an nb notebook with optional comment and tags.

Example: `echo "https://example.com" | ./add-bookmark`

Example: `./add-bookmark --comment "Great article" --tags "tech,reading" https://example.com`

### add-todo

Add a task to Workflowy by reading text from stdin or file.

Example: `echo "Buy milk" | ./add-todo`

### docker-ical-to-json

Converts an ICS calendar file into JSON.

Example: `./docker-ical-to-json < cal.ics > cal.json`

## Text & Data Processing

### body

Print the header (first line) and run a command on the rest (the body).

Example: `ps | ./body grep somepattern`

### centre

Center text in the terminal window.

Example: `echo "Hello World" | ./centre`

### convert-text

Convert text to/from different formats.

Example: `./convert-text --format base64`

### count

Lines, words, and bytes counter (wc wrapper).

Example: `./count file.txt`

### count-uniq

Counter for unique lines (total/value).

Example: `cat list.txt | ./count-uniq`

### dated

List files grouped by the date encoded in their filename.

Example: `./dated --list .`

Example: `./dated --interactive --all .`

### daterange

Generate a range of dates.

Example: `./daterange 2023-01-01 2023-01-07`

### timerange

Print hourly datetimes for N days from today (default 1).

Example: `./timerange 3`

### datetime

Current date and time utility.

Example: `./datetime`

### dedup

Deduplicate lines on stdin.

Example: `cat duplicate_lines.txt | ./dedup`

### define

Look up word definitions via dict.org.

Example: `./define "serendipity"`

### dict-format

Format dictionary service output.

Example: `curl "dict://dict.org/define:apple:*" | ./dict-format`

### highlight-text

Render a bat preview of a file, optionally highlighting a given line number.

Example: `./highlight-text main.py 42`

### loripsum

Generate Lorem Ipsum placeholder text.

Example: `./loripsum 3`

### merge-columns

Merge a source column as a prefix of a target column (reads stdin).

Example: `seq 6 | paste - - - | ./merge-columns 3 1 ":"`

### partition

Partition input data into multiple files.

Example: `cat log.txt | ./partition '---'`

### ruler

Horizontal column ruler for the terminal.

Example: `./ruler`

### strip-ansi

Remove ANSI escape sequences from text.

Example: `./strip-ansi < log_with_colors.txt`

### thesaurus

Look up synonyms via dict.org.

Example: `./thesaurus "happy"`

### tidy-table

Fix the column layout of a markdown (pipe-delimited) table.

Example: `cat table.md | ./tidy-table`

### truncate

Truncate files or text output to a fixed length.

Example: `echo "Very long string" | ./truncate 10`

### underline-headers

Automatically underline markdown-style headers.

Example: `cat notes.md | ./underline-headers`

---

## Development Tools

### bash-fix-timing

Fix timing in bash logs (AWK script).

Example: `./bash-fix-timing history.log`

### cheapwatch

Repeatedly clear the screen and re-run a command every 5 seconds.

Example: `./cheapwatch "ls" .`

### docker-asciicast2gif

Convert asciicast recordings to GIF using Docker.

Example: `./docker-asciicast2gif demo.cast`

### docker-elm

Run the Elm compiler within a Docker container.

Example: `./docker-elm make src/Main.elm`

### docker-mmdc

Run Mermaid CLI within Docker to generate diagrams.

Example: `./docker-mmdc -i chart.mmd -o chart.png`

### dockerenv

Start, use, and destroy a companion docker container for the current directory as a dev environment.

Example: `./dockerenv up ruby:alpine`

### gradlew

Global stub to invoke local gradlew wrappers.

Example: `./gradlew build`

### gradlew-run

Interactive picker for running gradle tasks.

Example: `./gradlew-run`

### inflate

Utility to decompress zlib-compressed data (e.g. git objects).

Example: `./inflate .git/objects/ab/cdef...`

### annotate

Display source files with annotations.

Example: `./annotate main.go notes.txt`

Example: `./annotate main.go notes.txt side`

### list-keys

List key bindings from selected applications.

Example: `./list-keys`

### list-fzf-keys

List the default fzf keybindings extracted from the fzf man page.

Example: `./list-fzf-keys`

### list-readline-keys

List all readline keybindings.

Example: `./list-readline-keys`

### npm-run

Interactive picker for running npm scripts.

Example: `./npm-run`

### openrouter

Check OpenRouter API token balance.

Example: `OPENROUTER_API_KEY=sk-... ./openrouter`

### nostr-subscribe

Subscribe to Nostr relay events via WebSocket.

Example: `./nostr-subscribe wss://relay.damus.io`

### ollama-chat

Terminal chat interface for Ollama (LLM) with bat.

Example: `./ollama-chat`

### openai-chat

Terminal chat interface for OpenAI API with markdown rendering.

Example: `./openai-chat`

### pcap-streams

Browse and extract TCP streams from pcap files.

Example: `./pcap-streams traffic.pcap`

### psql-info

Detailed information about PostgreSQL tables/schema.

Example: `./psql-info tables`

### shell-info.sh

Display details about the current shell environment.

Example: `source ./shell-info.sh`

### transform

Execute and embed command output in markdown/html files.

Example: `./transform notes.md`

### vim-session

Interactively start a saved Vim session (optionally filtered by a query).

Example: `./vim-session my_session`

### vimgolf

Interface for submitting VimGolf solutions.

Example: `./vimgolf 5b3a...`

### wraprun

Log and wrap the execution of any command.

Example: `./wraprun "ls -R /"`

### wtc

Repeat a command every N seconds, wrapping each run with success/failure messages.

Example: `./wtc 5 "go test ./..."`

---

## System & Network

### as-session

Create or attach a tmux session for a directory (fzf picker when given no argument).

Example: `./as-session ~/repos`

Example: `./as-session`

### bell

Ring the terminal bell.

Example: `./bell`

### chat-send

Send chat data using ncat.

Example: `./chat-send 127.0.0.1 9999`

### faketty

Execute a command within a pseudo-terminal.

Example: `./faketty ls`

### imap-session

Open an interactive IMAP session over TLS (STARTTLS).

Example: `./imap-session localhost 1143`

### keepass

Command-line integration for KeePass databases.

Example: `./keepass passwords.kdbx`

### launch

Fast application launcher using fd and fzf.

Example: `./launch`

### ping-plot

Real-time plotting of ping results in terminal.

Example: `./ping-stream google.com | ./ping-plot`

### ping-stream

Continuous stream of ping data for monitoring.

Example: `./ping-stream google.com`

### publicip

Quickly find and display your public IP address.

Example: `./publicip`

### show-notification

Trigger system-level desktop notifications.

Example: `./show-notification "Task Complete" "Build finished"`

### speed-test

Run a network speed test from the command line.

Example: `./speed-test`

### ssh-hosts-status

Monitor the availability of various SSH hosts.

Example: `./ssh-hosts-status`

### wifi

CLI utility for managing WiFi connections.

Example: `./wifi list`

### dot-helper

Opinionated `dot` wrapper for converting between .dot and .png.

Example: `./dot-helper png < foo.dot > foo.png`

### command-proxy

Network proxy for dotnet commands, listening on port 9000.

Example: `./command-proxy serve mydotnetcmd arg1 arg2`

---

## File & Directory Explorers

### directory-browser

Interactive terminal directory browser.

Example: `./directory-browser`

### explore-bash-history

Merge split bash history files into one date-annotated dataset.

Example: `./explore-bash-history`

### file-browser

Interactive terminal file browser.

Example: `./file-browser`

### fs-browser

General file system browser.

Example: `./fs-browser`

### lines-of-code

Report lines of code per path and language as a TSV (use --pretty for a table, --type/--files to filter).

Example: `./lines-of-code .`

### lines-of-code-children

Report lines of code for all subdirectories.

Example: `./lines-of-code-children .`

### lines-of-code-types

Report lines of code grouped by language type.

Example: `./lines-of-code-types .`

### pager

A simple stub/wrapper for the `less` pager.

Example: `cat file.txt | ./pager`

### paginate

Paginate files for easier reading in terminal.

Example: `./paginate long_file.txt`

### render

Render selected files or directories for preview.

Example: `./render doc.md`

### search

High-level search wrapper for files and tags.

Example: `./search "config"`

### text-browser

Interactive browser for text-based files.

Example: `./text-browser`

### words

Pick words from a word list: interactive fzf picker or plain list.

Example: `./words --interactive "method"`

Example: `./words --list`

Override the word list with `DICTIONARY_FILE` (default `/usr/share/dict/words`).

Example: `DICTIONARY_FILE=mydict.txt ./words --list`

---

## Media & Web

### brave-cli

Open URL in Brave Browser.

Example: `./brave-cli "https://google.com"`

### chrome-cli

Open URL in Google Chrome.

Example: `./chrome-cli "https://google.com"`

### color-test

Display 24-bit color codes in terminal.

Example: `./color-test`

### img-to-pdf

Convert a single image to a PDF with OCR'd text.

Example: `./img-to-pdf page1.jpg`

### img-to-text

Perform OCR to convert images to editable text.

Example: `./img-to-text screenshot.png`

### pdf-to-text

Convert PDF documents to plain text.

Example: `./pdf-to-text document.pdf`

### pie-bar

Generate terminal-based pie and bar charts.

Example: `./pie-bar 30 70`

### pie-column

Generate column charts for terminal output.

Example: `printf '1\n3\n5\n' | ./pie-column --headers 0 1`

### pie-footer

Add a pie-bar footer with an inline key to a table.

Example: `lines-of-code configuration/snippets | grep -v Total | ./pie-footer --headers 1 2 3`

### preview-gfm

Preview GitHub Flavored Markdown in the browser.

Example: `./preview-gfm README.md`

### preview-markdown

Render markdown to a standalone HTML file and open it in a browser.

Example: `./preview-markdown document.md`

### save-to-pocket

Save a URL to your Pocket account.

Example: `./save-to-pocket "https://example.com"`

### web-search

Perform web searches using the Perplexity API.

Example: `PERPLEXITY_API_KEY=sk-... web-search "what is the capital of France"`

### web-fetch

Opinionated web fetcher that retrieves a URL and outputs markdown, pretty JSON, or raw content.

Example: `./web-fetch https://example.com`

---

## Miscellaneous

### abn

ABN lookup utility.

Example: `./abn 51824753556`

### build-slides

Build presentation slides from source.

Example: `./build-slides --target outDir < slides.md`

### cheat-sheet

Interactive fzf browser for cheat.sh reference sheets (pick a topic and optional subtopic).

Example: `./cheat-sheet`

### slow-cat

Cat file output slowly (useful for demonstrations).

Example: `cat script.sh | ./slow-cat 2`

### demand-cat

Output lines from a file, pausing for user input (Enter) after each line.

Example: `./demand-cat 3<input.txt`

### foreach

Execute a command for each input item.

Example: `ls | ./foreach echo`

### foreach-par

Parallel version of the foreach utility.

Example: `ls | ./foreach-par echo`

### happy

A small utility to spread some joy.

Example: `./happy "I am happy"`

### sad

Display text with a sad border and emojis.

Example: `./sad "I am sad"`

### pad-slides

Add padding/margins to presentation slides.

Example: `./pad-slides < slides.md`

### safeagent

Prepare a sandboxed environment for an agent, setting git author info.

Example: `./safeagent myscript.sh`

### pwd-info

Print info about the current directory.

Example: `./pwd-info`
