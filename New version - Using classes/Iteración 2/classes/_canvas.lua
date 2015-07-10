
Canvas = {}
Canvas.__index = Canvas

function Canvas.create( x, y, w, h, debug )
   local c = {}
   setmetatable(c, Canvas)

   c.DrawBBox = debug

   c.x = x
   c.y = y
   
   c.tileWidth = w
   c.tileHeight = h

   c.board = {}
   c.falling = {}
   c.next = {}

   c.level = 0
   c.lines = 0
   c.score = 0

   return c
end

function Canvas:Update( dt )
end

function Canvas:Draw()
         love.graphics.draw(_IMGS.Background[1], 0, 0)

         for i = 1, self.tileWidth do
             for j = 1, self.tileHeight do
                 if self.board[i][j] ~= 0 then
                    love.graphics.draw(_IMGS.Piezas.Sheet, _IMGS.Piezas[self.board[i][j]], self.x + _IMGS.Piezas.Width*(j-1), self.y + _IMGS.Piezas.Height*(i-1))
                 end
             end
         end
         
         self.falling:Draw(self.x, self.y)

         love.graphics.draw(_IMGS.Background["1_Borde"], 0, 0)
end

function Canvas:setCanvas()
         self.board = {}

         for i = 1, self.tileWidth do
             self.board[i] = {}
             for j = 1, self.tileHeight do
                 self.board[i][j] = 0
             end
         end

         self.falling = {}
         self.next = {}

         self.level = 0
         self.lines = 0
         self.score = 0
         
         self:NextTetra()
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

function Canvas:getBoardTileWidth()
         return self.tileWidth
end

function Canvas:getBoardTileHeight()
         return self.tileHeight
end


-- // FUNCTIONS // --

function Canvas:NextTetra()
    if #self.next < 1 then
       self.falling = Tetra.create( 5, 1, 1, debug )
    else
        self.falling = self.next[1]
        -- self.next
    end
end

function Canvas:KeyPressed( key )

         if key == 'w' or key == 'up' then
            self.falling:NextFrame()

         elseif key == 'a' or key == 'left' then
            self.falling:Move(1, 0, 0)

         elseif key == 'd' or key == 'right' then
            self.falling:Move(0, 1, 0)

         elseif key == 's' or key == 'down' then
         
         end


end

