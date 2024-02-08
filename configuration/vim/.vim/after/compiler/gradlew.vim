CompilerSet makeprg=./gradlew\ --console=plain

" e: /code/src/test/kotlin/com/edwardsnjd/ParserTest.kt: (20, 26): Expecting ')'
CompilerSet errorformat=%t:\ %f:\ (%l\\,\ %c):\ %m

" e: <ParserTest.kt>: (90): Parses delete space statement() --     com.edwardnjd.parser.ParseException
CompilerSet errorformat+=%t:\ <%o>:\ (%l):\ %m

" ExamIntegrationImagesTest > Thirona > selects useful images in correct order() FAILED
"     java.lang.AssertionError at ExamIntegrationImagesTest.kt:28
CompilerSet errorformat+=%E%o()\ FAILED,%Z%m:%l
