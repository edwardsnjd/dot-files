local lexers = vis.lexers

local named = {
  ['cursorColor']         =  '#80a4c2',
  ['selectionBackground'] =  '#1d3b53',

  ['background']          =  '#011627',
  ['foreground']          =  '#D6DEEB',

  ['black']               =  '#011627',
  ['blue']                =  '#82AAFF',
  ['cyan']                =  '#21C7A8',
  ['green']               =  '#22DA6E',
  ['purple']              =  '#C792EA',
  ['red']                 =  '#EF5350',
  ['white']               =  '#FFFFFF',
  ['yellow']              =  '#ADDB67',
  ['brightBlack']         =  '#969696',
  ['brightBlue']          =  '#82AAFF',
  ['brightCyan']          =  '#7FDBCA',
  ['brightGreen']         =  '#22DA6E',
  ['brightPurple']        =  '#C792EA',
  ['brightRed']           =  '#EF5350',
  ['brightWhite']         =  '#FFFFFF',
  ['brightYellow']        =  '#FFEB95',
}

local colors = {
	['base00'] = '#011627', -- BG
	['base01'] = '#282a2e', -- BG cursor line
	['base02'] = '#1d3b53', -- FG Whitespace characters
	['base03'] = '#637777', -- FG comment
	['base04'] = '#EEEEEE', -- FG status
	['base05'] = '#D6DEEB', -- FG
	['base06'] = '#e0e0e0', -- ???
	['base07'] = '#ffffff', -- ???
	['base08'] = '#7FDBCA', -- FG identifier, error
	['base09'] = '#EF5350', -- FG constant, number
	['base0A'] = '#ADDB67', -- FG class, type, label
	['base0B'] = '#FFEB95', -- FG string
	['base0C'] = '#82AAFF', -- FG regex
	['base0D'] = '#82AAFF', -- FG function, variable
	['base0E'] = '#C792EA', -- FG keyword
	['base0F'] = '#22DA6E', -- FG embedded
}

lexers.colors = colors

local fg = ',fore:'..colors.base05..','
local bg = ',back:'..colors.base00..','

lexers.STYLE_DEFAULT = bg..fg
lexers.STYLE_NOTHING = bg
lexers.STYLE_CLASS = 'fore:'..colors.base0A
lexers.STYLE_COMMENT = 'fore:'..colors.base03..',italics'
lexers.STYLE_CONSTANT = 'fore:'..colors.base09
lexers.STYLE_DEFINITION = 'fore:'..colors.base0E
lexers.STYLE_ERROR = 'fore:'..colors.base08..',italics'
lexers.STYLE_FUNCTION = 'fore:'..colors.base0D
lexers.STYLE_KEYWORD = 'fore:'..colors.base0E
lexers.STYLE_LABEL = 'fore:'..colors.base0A
lexers.STYLE_NUMBER = 'fore:'..colors.base09
lexers.STYLE_OPERATOR = 'fore:'..colors.base05
lexers.STYLE_REGEX = 'fore:'..colors.base0C
lexers.STYLE_STRING = 'fore:'..colors.base0B
lexers.STYLE_PREPROCESSOR = 'fore:'..colors.base0A
lexers.STYLE_TAG = 'fore:'..colors.base0A
lexers.STYLE_TYPE = 'fore:'..colors.base0A
lexers.STYLE_VARIABLE = 'fore:'..colors.base0D
lexers.STYLE_WHITESPACE = 'fore:'..colors.base02
lexers.STYLE_EMBEDDED = 'fore:'..colors.base0F
lexers.STYLE_IDENTIFIER = 'fore:'..colors.base08

lexers.STYLE_LINENUMBER = 'fore:'..colors.base02..',back:'..colors.base00
lexers.STYLE_CURSOR = 'fore:'..colors.base00..',back:'..colors.base05
lexers.STYLE_CURSOR_PRIMARY = 'fore:'..colors.base00..',back:'..colors.base05
lexers.STYLE_CURSOR_LINE = 'back:'..colors.base01
lexers.STYLE_COLOR_COLUMN = 'back:'..colors.base01
lexers.STYLE_SELECTION = 'back:'..colors.base02
lexers.STYLE_STATUS = 'fore:'..colors.base04..',back:'..colors.base01
lexers.STYLE_STATUS_FOCUSED = 'fore:'..colors.base09..',back:'..colors.base01
lexers.STYLE_SEPARATOR = lexers.STYLE_DEFAULT
lexers.STYLE_INFO = 'fore:default,back:default,bold'
lexers.STYLE_EOF = ''

