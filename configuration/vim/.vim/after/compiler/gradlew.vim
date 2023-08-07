CompilerSet makeprg=./gradlew

" e: /code/src/test/kotlin/com/edwardsnjd/ParserTest.kt: (20, 26): Expecting ')'
CompilerSet errorformat=%t:\ %f:\ (%l\\,\ %c):\ %m
" e: <ParserTest.kt>: (90): Parses delete space statement() --     com.edwardnjd.parser.ParseException
CompilerSet errorformat+=%t:\ <%o>:\ (%l):\ %m
" (ignore everything else)
CompilerSet errorformat+=%-G%.%#
