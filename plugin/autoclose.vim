lua autoclose = require("autoclose")

autocmd CursorMovedI,CursorMoved * :lua autoclose.keyMap()
