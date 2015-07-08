
Canvas = {}
Canvas.__index = Canvas

function Canvas.create( debug )
   local c = {}
   setmetatable(c, Canvas)

   c.DrawBBox = debug
   
   c.falling = {}
   c.next = {}
   c.set = {}

   c.level = 10
   c.lines = 0
   c.score = 0

   return c
end

function Canvas:Update( dt )
end

function Canvas:Draw()
end

function Canvas:setCanvas()
         self.falling = {}
         self.next = {}
         self.set = {}

         self.level = 0
         self.lines = 0
         self.score = 0
end


-- // GETs & SETs // --

function Canvas:getLevel()
         return self.level
end

function Canvas:getLines()
         return self.lines
end

function Canvas:getScore()
         return self.score
end

