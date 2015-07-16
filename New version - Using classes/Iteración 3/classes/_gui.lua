
GUI = {}
GUI.__index = GUI

function GUI.create()
   local g = {}
   setmetatable(g, GUI)
   
   g.x = 0
   g.y = 0
   g.width = 0
   g.height = 0

   return g
end

function GUI:Draw()
         love.graphics.print(theCanvas:getScore(), 561, 15)
         love.graphics.print(theCanvas:getLines(), 561, 165)
         love.graphics.print(theCanvas:getLevel(), 561, 315)
end