function love.load()
         require("classes/_gui")
         require("classes/_canvas")
         
         theCanvas = Canvas.create(false)
         theGUI = GUI.create()
end

function love.update(dt)
end

function love.draw()
         theCanvas:Draw()
         theGUI:Draw()
end

function love.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
end

function love.keypressed(key, unicode)
         if key == 'r' then
            theCanvas:setCanvas()
         end
end

function love.keyreleased(key, unicode)
end

function love.focus(f)
end

function love.quit()
end


-- UTILS --

function insideBox (px, py, x, y, wx, wy)
	if px > x and px < x + wx then
		if py > y and py < y + wy then
			return true
		end
	end
	return false
end

function getDistance( x1, y1, x2, y2 )
   xDiff = x2 - x1
   yDiff = y2 - y1
   return math.sqrt( (xDiff*xDiff) + (yDiff*yDiff) )
end

function getAngle( x1, y1, x2, y2 )
   xDiff = x2 - x1
   yDiff = y2 - y1
   return math.atan2(yDiff, xDiff)
end

function degree2Radian( n )
   return n * (math.pi/180)
end