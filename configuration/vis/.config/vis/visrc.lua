-- Load standard vis module, providing parts of the Lua API
require('vis')

-- Global configuration options
vis.events.subscribe(vis.events.INIT, function()
    vis:command('set autoindent on')
    vis:command('set expandtab on')
    vis:command('set tabwidth 2')
    vis:command('set theme night-owl-ish')
end)

-- Window configuration options e.g.
vis.events.subscribe(vis.events.WIN_OPEN, function(win)
    vis:command('set cursorline')
    vis:command('set number')
    vis:command('set relativenumbers')
    vis:command('set show-spaces off')
    vis:command('set show-tabs on')
    vis:command('set show-newlines on')
end)
