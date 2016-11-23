
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

   c.timer = 0
   c.timerVel = 5
   c.timerLimit = 5

   return c
end

function Canvas:Update( dt )
         self.timer = self.timer + dt*self.timerVel
         
         if self.DrawBBox then 
            print(self.timer)
         end

         if self.timer > self.timerLimit then
            
            if not self.falling:Move(0, 0, 1) then
               self:NextTetra()
            end

            self.timer = 0
         self:CleanBoard()
         end

end

function Canvas:Draw()
         love.graphics.draw(_IMGS.Background[1], 0, 0)

         for col = 1, self.tileWidth do
             for row = 1, self.tileHeight do
                 if self.board[col][row] ~= 0 then
                    love.graphics.draw(_IMGS.Piezas.Sheet, _IMGS.Piezas[self.board[col][row]], self.x + _IMGS.Piezas.Width*(col-1), self.y + _IMGS.Piezas.Height*(row-1))
                 end

                 if self.DrawBBox then
                    love.graphics.circle('fill', self.x + _IMGS.Piezas.Width*(col-1), self.y + _IMGS.Piezas.Height*(row-1), 8, 8)
                 end
             end
         end

         self.falling:Draw(self.x, self.y)
         self.next:DrawInPanel(16, 64, 2, 2)

         love.graphics.draw(_IMGS.Background["1_Borde"], 0, 0)
end

function Canvas:setCanvas()
         self.board = {}

         for i = 1, self.tileWidth do
             self.board[i] = {}
             for j = 1, self.tileHeight-1 do
                 self.board[i][j] = 0
             end
         end
         for i = 1, self.tileWidth do
             self.board[i][self.tileHeight] = 1
         end

         self.falling = Tetra.create( 5, 1, math.random(1, 6), self.DrawBBox )
         self.next = Tetra.create( 5, 1, math.random(1, 6), self.DrawBBox )

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

function Canvas:getBoardTileWidth()
         return self.tileWidth
end

function Canvas:getBoardTileHeight()
         return self.tileHeight
end

function Canvas:getBoardTile(i, j)
         return self.board[i][j]
end



-- // FUNCTIONS // --

function Canvas:CleanBoard()
   for row = 1, self.tileHeight do
       local col = 1
       while col <= self.tileWidth and self.board[col][row] ~= 0 do
          col = col + 1
       end

       if col > self.tileWidth then

          for aux = 1, self.tileWidth do
              table.remove(self.board[aux], row)
              table.insert(self.board[aux], 1, 0)
          end

          self:printBoard()

          self.lines = self.lines + 1
       end
   end
end


function Canvas:NextTetra()
    local i = self.falling:getI()
    local j = self.falling:getJ()
    local f = self.falling:getFrame()
    local t = self.falling:getType()

    self.falling = self.next
    self.next = Tetra.create( 5, 1, math.random(1, 6), self.DrawBBox )

    for row = 1, #f do
        for col = 1, #f[row] do
            if f[row][col] ~= 0 then
               self.board[ i + col - 1 ][ j + row - 1 ] = t
            end
        end
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


-- // DEBUG // --

function Canvas:printBoard()
    local s = ""
    for row = 1, #self.board[1] do
        s = ""
        for col = 1, #self.board do
            s = s..self.board[col][row]
        end
        print(s.."\n")
    end
end
