
Tetra = {}
Tetra.__index = Tetra

function Tetra.create( i, j, ty, debug )
   local t = {}
   setmetatable(t, Tetra)

   t.DrawBBox = debug

   t.i = i
   t.j = j

   t.type = ty
   
   t.frame = _FRAMES[ty][1]
   t.currentFrame = 1

   return t
end

function Tetra:Draw( xBoard, yBoard )
   for row = 1, #self.frame do
       for col = 1, #self.frame[row] do
           if self.frame[row][col] ~= 0 then
              love.graphics.draw( _IMGS.Piezas.Sheet, _IMGS.Piezas[self.type],
                                  xBoard + _IMGS.Piezas.Width*(self.i-1) + _IMGS.Piezas.Width*(col-1),
                                  yBoard + _IMGS.Piezas.Height*(self.j-1) + _IMGS.Piezas.Height*(row-1))
           end

           if self.DrawBBox then
               love.graphics.circle('fill',
                                      xBoard + _IMGS.Piezas.Width*(self.i-1) + _IMGS.Piezas.Width*(col-1),
                                      yBoard + _IMGS.Piezas.Height*(self.j-1) + _IMGS.Piezas.Height*(row-1),
                                      5, 8 )
           end
       end
   end

   if self.DrawBBox then
      love.graphics.circle('fill', xBoard + _IMGS.Piezas.Width*(self.i-1),  yBoard + _IMGS.Piezas.Height*(self.j-1),
                           10, 8)
   end
end

function Tetra:DrawInPanel(xBoard, yBoard, iDraw, jDraw)
   for row = 1, #self.frame do
       for col = 1, #self.frame[row] do
           if self.frame[row][col] ~= 0 then
              love.graphics.draw( _IMGS.Piezas.Sheet, _IMGS.Piezas[self.type],
                                  xBoard + _IMGS.Piezas.Width*(iDraw-1) + _IMGS.Piezas.Width*(col-1),
                                  yBoard + _IMGS.Piezas.Height*(jDraw-1) + _IMGS.Piezas.Height*(row-1))
           end

           if self.DrawBBox then
               love.graphics.circle('fill',
                                      xBoard + _IMGS.Piezas.Width*(iDraw-1) + _IMGS.Piezas.Width*(col-1),
                                      yBoard + _IMGS.Piezas.Height*(jDraw-1) + _IMGS.Piezas.Height*(row-1),
                                      5, 8 )
           end
       end
   end

   if self.DrawBBox then
      love.graphics.circle('fill', xBoard + _IMGS.Piezas.Width*(iDraw-1),  yBoard + _IMGS.Piezas.Height*(jDraw-1),
                           10, 8)
   end
end

function Tetra:Update( dt )

end

-- // GETs & SETs // --


function Tetra:getI()
         return self.i
end

function Tetra:getJ()
         return self.j
end

function Tetra:getType()
         return self.type
end                      

function Tetra:getFrame()
         return self.frame
end



-- // MOVEMENT // --

function Tetra:Move( left, right, down )

   local newI = self.i + right - left
   local newJ = self.j + down

   if not self:Collision(newI, newJ) then
      self.i = newI
      self.j = newJ
      return true
   end

   return false
end


function Tetra:NextFrame()
   self.currentFrame = self.currentFrame + 1
   
   if #_FRAMES[self.type] < self.currentFrame then
      self.currentFrame = 1
   end
   
   self.frame = {}
   self.frame = _FRAMES[self.type][self.currentFrame]
end


function Tetra:Collision(newI, newJ)

    if newI < 1 or newI + (#self.frame[1] - 1) > theCanvas:getBoardTileWidth() then
       return true
    end
    
    if newJ > theCanvas:getBoardTileHeight() then
       return true
    end

    local row, col, intersect

    row = 1
    intersect = false
    while ( row <= #self.frame and not intersect ) do
          col = 1
          while ( col <= #self.frame[row] and not intersect ) do
             intersect = (self.frame[row][col] == 1) and (theCanvas:getBoardTile( newI + col - 1, newJ + row - 1 ) ~= 0)
             col = col + 1
          end
          row = row + 1
    end

    return intersect
end