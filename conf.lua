local constants = require "constants"

function love.conf(t)
    -- Game info.
    t.window.title = constants.TITLE
    t.identity = constants.IDENTITY

    -- Graphics settings.
    t.window.width = constants.SCREEN.x
    t.window.height = constants.SCREEN.y

    -- Debugging for now.
    t.console = constants.DEBUG_MODE
end
