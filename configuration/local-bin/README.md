# `.local/bin/` scripts

Collection of utility scripts for shell, git, Docker, productivity, etc. that I tend to include on my `PATH`.

## Quick Navigation

- [Git Power Tools](#git-power-tools)
- [Productivity & Time](#productivity--time)
- [Text & Data Processing](#text--data-processing)
- [Development Tools](#development-tools)
- [System & Network](#system--network)
- [File & Directory Explorers](#file--directory-explorers)
- [Media & Web](#media--web)
- [Miscellaneous](#miscellaneous)

---

## Git Power Tools

### browse-tags

Interactive git tag browser.

Example: `./browse-tags`

### gh-prs

List GitHub Pull Requests for the current repo.

Example: `./gh-prs`

### gh-prs-to-tsv

Convert GitHub PR list to TSV format.

Example: `./gh-prs | ./gh-prs-to-tsv`

### gh-search-prs

Search through GitHub Pull Requests.

Example: `./gh-search-prs "refactor"`

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

### git-contributor

Show detailed git contributor information.

Example: `./git-contributor "Nicholas Edwards"`

### git-contributors

List all contributors to a git repository.

Example: `./git-contributors`

### git-count-commits

Count the total number of commits in a repo.

Example: `./git-count-commits`

### git-count-contributors

Count the unique contributors to a repo.

Example: `./git-count-contributors`

### git-diff-img

Visual diff tool for images in a git repository.

Example: `./git-diff-img image.png`

### git-exec

Execute commands across a git repository.

Example: `./git-exec "ls -la"`

### git-function-versions

Browse historical versions of a code function.

Example: `./git-function-versions MyFunctionName`

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

Statistics on lines added/removed in git.

Example: `./git-lines`

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

Quickly switch between git worktrees.

Example: `./git-worktree-switch`

### tags-context

Show context around git tags.

Example: `./tags-context v1.2.0`

---

## Productivity & Time

### emojify-cal

Add emojis to calendar output.

Example: `cal | ./emojify-cal`

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

### timerange

Generate sequences of times or ranges.

Example: `./timerange 09:00 17:00`

### timezones

Check the current time across multiple time zones.

Example: `./timezones`

### weather-forecast

Display local weather forecast via wttr.in.

Example: `./weather-forecast "London"`

### workflowy

CLI integration for the Workflowy API.

Example: `./workflowy list`

---

## Text & Data Processing

### body

Print the body of a file or stream.

Example: `cat file.txt | ./body`

### centre

Center text in the terminal window.

Example: `echo "Hello World" | ./centre`

### convert-text

Text conversion and manipulation utility.

Example: `./convert-text --to-upper "hello"`

### count

Lines, words, and bytes counter (wc wrapper).

Example: `./count file.txt`

### count-uniq

Counter for unique lines (total/value).

Example: `cat list.txt | ./count-uniq`

### dated

Date manipulation and formatting.

Example: `./dated "yesterday"`

### daterange

Generate a range of dates.

Example: `./daterange 2023-01-01 2023-01-07`

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

Example: `./define "apple" | ./dict-format`

### highlight-text

Highlight specific text patterns in a file.

Example: `./highlight-text "TODO" main.py`

### loripsum

Generate Lorem Ipsum placeholder text.

Example: `./loripsum 3`

### merge-columns

Merge multiple columns of text into one.

Example: `./merge-columns col1.txt col2.txt`

### partition

Partition input data into multiple files.

Example: `cat large_file.txt | ./partition 100`

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

Format messy text into a clean, tidy table.

Example: `cat data.csv | ./tidy-table`

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

Simple file watcher for command execution.

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

Manage Docker environment variables.

Example: `./dockerenv`

### gradlew

Global stub to invoke local gradlew wrappers.

Example: `./gradlew build`

### gradlew-run

Interactive picker for running gradle tasks.

Example: `./gradlew-run`

### inflate

Utility to inflate (decompress) git objects.

Example: `./inflate .git/objects/ab/cdef...`

### list-keys

List SSH and GPG keys on the system.

Example: `./list-keys`

### npm-run

Interactive picker for running npm scripts.

Example: `./npm-run`

### ollama-chat

Terminal chat interface for Ollama (LLM) with bat.

Example: `./ollama-chat "Explain quantum physics"`

### ollama-chat.mjs

Node.js backend for the Ollama chat utility.

Example: `node ./ollama-chat.mjs`

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

Execute and embed results of internal scripts.

Example: `./transform notes.md`

### vim-session

Helper for managing and loading Vim sessions.

Example: `./vim-session load my_session`

### vimgolf

Interface for submitting VimGolf solutions.

Example: `./vimgolf 5b3a...`

### wraprun

Log and wrap the execution of any command.

Example: `./wraprun "ls -R /"`

### wtc

Watch and repeat command execution (wrapper).

Example: `./wtc "go test ./..."`

---

## System & Network

### as-session

Manage terminal sessions.

Example: `./as-session new-session`

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

Manage and inspect IMAP email sessions.

Example: `./imap-session`

### keepass

Command-line integration for KeePass databases.

Example: `./keepass get "Github"`

### launch

Fast application launcher using fd and fzf.

Example: `./launch`

### ping-plot

Real-time plotting of ping results in terminal.

Example: `./ping-plot google.com`

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

Example: `./wifi status`

---

## File & Directory Explorers

### directory-browser

Interactive terminal directory browser.

Example: `./directory-browser`

### explore-bash-history

Interactive explorer for bash history files.

Example: `./explore-bash-history`

### file-browser

Interactive terminal file browser.

Example: `./file-browser`

### fs-browser

General file system browser.

Example: `./fs-browser`

### lines-of-code

Detailed report of lines of code with visual bars.

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

Search system dictionary using fzf.

Example: `./words "query"`

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

Convert image files to PDF documents.

Example: `./img-to-pdf page1.jpg page2.jpg`

### img-to-text

Perform OCR to convert images to editable text.

Example: `./img-to-text screenshot.png`

### pie-bar

Generate terminal-based pie and bar charts.

Example: `echo "30 70" | ./pie-bar`

### pie-column

Generate column charts for terminal output.

Example: `echo "10 20 30" | ./pie-column`

### pie-footer

Generate footer charts for terminal data.

Example: `./pie-footer`

### preview-gfm

Preview GitHub Flavored Markdown in the browser.

Example: `./preview-gfm README.md`

### preview-markdown

General markdown previewer for the terminal.

Example: `./preview-markdown document.md`

### save-to-pocket

Save a URL to your Pocket account.

Example: `./save-to-pocket "https://example.com"`

---

## Miscellaneous

### abn

ABN lookup utility.

Example: `./abn 51824753556`

### build-slides

Build presentation slides from source.

Example: `./build-slides slides.md`

### cheat-sheet

Quick reference and cheat sheet tool.

Example: `./cheat-sheet bash`

### slow-cat

Cat file output slowly (useful for demonstrations).

Example: `./slow-cat script.sh`

### demand-cat

Concatenate files on demand.

Example: `./demand-cat file1 file2`

### foreach

Execute a command for each input item.

Example: `ls | ./foreach echo`

### foreach-par

Parallel version of the foreach utility.

Example: `ls | ./foreach-par echo`

### happy

A small utility to spread some joy.

Example: `./happy`

### sad

Display text with a sad border and emojis.

Example: `./sad "I am sad"`

### pad-slides

Add padding/margins to presentation slides.

Example: `./pad-slides raw_slides.pdf`
