
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
              love.graphics.draw( _IMGS.Piezas.Sheet, _IMGS.Piezas[self.frame[row][col]],
                                  xBoard + _IMGS.Piezas.Width*(self.i-1) + _IMGS.Piezas.Width*(col-1),
                                  yBoard + _IMGS.Piezas.Height*(self.j-1) + _IMGS.Piezas.Height*(row-1))
           end
       end
   end


   if self.DrawBBox then
      love.graphics.circle('fill', xBoard + _IMGS.Piezas.Width*(self.i-1),  yBoard + _IMGS.Piezas.Height*(self.j-1)        , 5, 8)
   end
end

function Tetra:Update( dt )

end


-- // MOVEMENT // --

function Tetra:Move( left, right, down )
   
   local move = self.i + right - left

   if move >= 1 and move + (#self.frame[1] - 1) <= theCanvas:getBoardTileWidth() then
      self.i = move
   end

end


function Tetra:NextFrame()
   self.currentFrame = self.currentFrame + 1
   
   if #_FRAMES[self.type] < self.currentFrame then
      self.currentFrame = 1
   end
   
   self.frame = _FRAMES[self.type][self.currentFrame]
end