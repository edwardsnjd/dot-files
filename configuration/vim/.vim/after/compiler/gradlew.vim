CompilerSet makeprg=gradlew

" w: file:///code/src/main/kotlin/com/icare/screening/services/AdminExportService.kt:30:42 'findByEncounterUid(Str>
CompilerSet errorformat=%t:\ file://%f:%l:%c\ %m

" e: /code/src/test/kotlin/com/edwardsnjd/ParserTest.kt: (20, 26): Expecting ')'
CompilerSet errorformat+=%t:\ %f:\ (%l\\,\ %c):\ %m

" e: <ParserTest.kt>: (90): Parses delete space statement() --     com.edwardnjd.parser.ParseException
CompilerSet errorformat+=%t:\ <%o>:\ (%l):\ %m

" ExamIntegrationImagesTest > Thirona > selects useful images in correct order() FAILED
"     java.lang.AssertionError at ExamIntegrationImagesTest.kt:28
CompilerSet errorformat+=%E%o()\ FAILED,%Z%m:%l

" /Users/nick/repos/icare/screening-service/src/main/kotlin/com/icare/screening/ai/ophtai/Workflow.kt:3:1 Needless blank line(s) (no-consecutive-blank-lines)
CompilerSet errorformat+=%f:%l:%c\ %m
