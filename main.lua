function love.load()	
	require("pieces")
	CargarPiezas()
	imgModulo = love.graphics.newImage("textures/modulo.png")
	nivel = 1
	scoreNivel = 1000
	score = 0
	filasEliminadas = 0
	pantalla = {
		{ 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 }, -- 1
		{ 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 1 , 1 , 1 , 1 , 1 }, -- 2
		{ 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 1 }, -- 3
		{ 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 1 }, -- 4
		{ 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 1 }, -- 5
		{ 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 1 }, -- 6
		{ 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 1 }, -- 7
		{ 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 1 }, -- 8
		{ 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 1 , 1 , 1 , 1 , 1 }, -- 9
		{ 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 1 , 1 , 1 , 1 , 1 }, -- 10
		{ 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 1 , 1 , 1 , 1 , 1 }, -- 11
		{ 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 1 }, -- 12
		{ 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 1 }, -- 13
		{ 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 1 }, -- 14
		{ 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0 , 1 }, -- 15
		{ 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 1 , 1 , 1 , 1 , 1 }, -- 16
		{ 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 1 , 1 , 1 , 1 , 1 }, -- 17
		{ 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 1 , 1 , 1 , 1 , 1 }, -- 18
		{ 1 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 0 , 0 , 0 , 0 , 1 }, -- 19
		{ 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 }  -- 20
	}	
	
	CreatePiece("L")
	CrearSecuencia()
	
end

function love.update(dt)
	piece:update(dt)
	if not Colision(piece.numPos) then love.event.push("quit")  end
	ComprobarFilas()
	ComprobarNivel()
end

function love.draw()	
	DrawPieces()
	for y = 1, #pantalla do
		for x = 1, #pantalla[y] do
			if pantalla[y][x] == 1 then
				love.graphics.setColor(255, 255, 255, 255)
				love.graphics.draw(imgModulo, (x-1)*32, (y-1)*32, 0, 1 , 1 , 0 , 0)
			end
		end
	end
	love.graphics.print( "Nivel : " .. nivel, (32*13) + 5, (32*11) + 8, 0, 1, 1)
	love.graphics.print( "Siguiente nivel: " .. scoreNivel, (32*13) + 5, (32*12) + 8, 0, 1, 1)
	love.graphics.print( "Score: " .. score, (32*13) + 5, (32*13) + 8, 0, 1, 1)	
	love.graphics.print( "Filas Eliminadas: " .. filasEliminadas, (32*13) + 5, (32*14) + 8, 0, 1, 1)
	love.graphics.print( "TETRIS ~ Darkatom", (32*14) + 5, (32*18) + 8, 0, 1, 1)	
end

function love.keypressed(key, unicode)
   if key == "escape" then
      love.event.push("quit")   -- actually causes the app to quit
   end
 
	if love.keyboard.isDown("left") then
		if ColisionHorizontal("left", piece.numPos) then
			piece.x = piece.x - 1
		end
	elseif love.keyboard.isDown("right", piece.numPos) then
		if ColisionHorizontal("right") then
			piece.x = piece.x + 1
		end
	elseif love.keyboard.isDown("up", piece.numPos) then	
		if Colision(piece.numPos + 1) then
			piece.numPos = piece.numPos + 1
			if piece.numPos > 4 then piece.numPos = 1 end	
			DecidirPosicion()
		end
	end
end

function love.keyreleased(key)
end

function siguienteNivel()
	nivel = nivel + 1
	for i = 1, nivel do
		scoreNivel = scoreNivel + i*1000
	end
end

function ComprobarFilas()
	local lleno = 0
	local filasQuit = 0
	
	for y = 19, 2, -1 do
		for x = 2, 12 do
			if pantalla[y][x] == 1 then lleno = lleno + 1 end
		end	
		
		if lleno == 11 then
			EliminarFila(y)
			filasQuit = filasQuit + 1
			addScore(filasQuit*1000)
			lleno = 0
		else lleno = 0 end		
	end
end

function ComprobarNivel()
	if (scoreNivel - score) <= 0 then
		siguienteNivel()
		ActualizarVelocidad()
	end
end

function EliminarFila(y)
	for x = 2, 12 do
		for cy = y, 3, -1 do
			pantalla[cy][x] = 0
			pantalla[cy][x] = pantalla[cy-1][x]
		end
	end
	
	filasEliminadas = filasEliminadas + 1
end

function addScore(n)
	score = score + n
end

function love.quit()
end