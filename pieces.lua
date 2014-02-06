piece = {}
piece = {name = "-", x = 0, y = 0, px = 0, py = 0, numPos = 1, velocidad = 15}
piece.next = {}

Conteo = 0

function CargarPiezas()	
	img_L1 = love.graphics.newImage("textures/L1.png")
	img_J1 = love.graphics.newImage("textures/J1.png")
	img_O  = love.graphics.newImage("textures/O.png")
	img_I1 = love.graphics.newImage("textures/I1.png")
	img_T1 = love.graphics.newImage("textures/T1.png")
	img_Z1 = love.graphics.newImage("textures/Z1.png")	
	img_S1 = love.graphics.newImage("textures/S1.png")
end

function ActualizarVelocidad()
	piece.velocidad = piece.velocidad - 1
end

function CrearSecuencia()
	local n = 0
	for i = 1, 10 do
		n = math.floor(math.random(1,7))
		if n == 1 then 		table.insert(piece.next, "L")
		elseif n == 2 then	table.insert(piece.next, "J")
		elseif n == 3 then	table.insert(piece.next, "O")
		elseif n == 4 then	table.insert(piece.next, "Z")
		elseif n == 5 then	table.insert(piece.next, "S")
		elseif n == 6 then	table.insert(piece.next, "I")
		elseif n == 7 then	table.insert(piece.next, "T")
		end
	end
end

function ActualizarSecuencia()
	local n = math.floor(math.random(1,8))
	if n == 1 then 		table.insert(piece.next, "L")
	elseif n == 2 then	table.insert(piece.next, "J")
	elseif n == 3 then	table.insert(piece.next, "O")
	elseif n == 4 then	table.insert(piece.next, "Z")
	elseif n == 5 then	table.insert(piece.next, "S")
	elseif n == 6 then	table.insert(piece.next, "I")
	elseif n == 7 then	table.insert(piece.next, "T")
	end
end

function CreatePiece(name)
	piece.name = name	
	if name == "I" then	piece.x = 7
	else piece.x = 6 end
	piece.y = 2
	piece.numPos = 1
	DecidirPosicion()
end

function piece:update(dt)
	Conteo = Conteo + 1	
	
	if not ColisionVertical() and Conteo/(16*piece.velocidad) == 1 then
		EscribirPieza()
		CreatePiece(piece.next[1])
		table.remove(piece.next, 1)
		ActualizarSecuencia()
	end
	
	if Conteo/(32*piece.velocidad) == 1 then
		piece.y = piece.y + 1
		Conteo = 0
	end	

end

function EscribirPieza()
	if piece.name == "L" then
		if piece.numPos == 1 then
			for x = 0, 2 do
				pantalla[piece.py][piece.px + x] = 1
			end
			pantalla[piece.py + 1][piece.px] = 1
		elseif piece.numPos == 2 then
			for y = 0, 2 do
				pantalla[piece.py + y][piece.px - 1] = 1
			end
			pantalla[piece.py][piece.px - 2] = 1
		elseif piece.numPos == 3 then
			for x = 0, 2 do
				pantalla[piece.py - 1][piece.px - 3 + x] = 1
			end
			pantalla[piece.py - 2][piece.px - 1] = 1
		elseif piece.numPos == 4 then
			for y = 0, 2 do
				pantalla[piece.py - 3 + y][piece.px] = 1
			end
			pantalla[piece.py - 1][piece.px + 1] = 1
		end
	elseif piece.name == "J" then
		if piece.numPos == 1 then
			for x = 0, 2 do
				pantalla[piece.py][piece.px + x] = 1
			end
			pantalla[piece.py + 1][piece.px + 2] = 1
		elseif piece.numPos == 2 then
			for y = 0, 2 do
				pantalla[piece.py + y][piece.px - 1] = 1
			end
			pantalla[piece.py + 2][piece.px - 2] = 1
		elseif piece.numPos == 3 then
			for x = 0, 2 do
				pantalla[piece.py - 1][piece.px - 3 + x] = 1
			end
			pantalla[piece.py - 2][piece.px - 3] = 1
		elseif piece.numPos == 4 then
			for y = 0, 2 do
				pantalla[piece.py - 3 + y][piece.px] = 1
			end
			pantalla[piece.py - 3][piece.px + 1] = 1
		end
	elseif piece.name == "S" then
		if piece.numPos == 1 or piece.numPos == 3 then
			for x = 0, 1 do
				pantalla[piece.py][piece.px + 1 + x] = 1
			end
			for x = 0, 1 do
				pantalla[piece.py + 1][piece.px + x] = 1
			end
		elseif piece.numPos == 2 or piece.numPos == 4 then
			for y = 0, 1 do
				pantalla[piece.py + y][piece.px - 2] = 1
			end
			for y = 0, 1 do
				pantalla[piece.py + 1 + y][piece.px - 1] = 1
			end
		end
	elseif piece.name == "Z" then
		if piece.numPos == 1 or piece.numPos == 3 then
			for x = 0, 1 do
				pantalla[piece.py][piece.px + x] = 1
			end
			for x = 0, 1 do
				pantalla[piece.py + 1][piece.px + 1 + x] = 1
			end
		elseif piece.numPos == 2 or piece.numPos == 4 then
			for y = 0, 1 do
				pantalla[piece.py + y][piece.px - 1] = 1
			end
			for y = 0, 1 do
				pantalla[piece.py + 1 + y][piece.px - 2] = 1
			end
		end
	elseif piece.name == "O" then
		for x = 0, 1 do
			for y = 0, 1 do
				pantalla[piece.py + y][piece.px + x] = 1
			end
		end
	elseif piece.name == "I" then
		if piece.numPos == 1 or piece.numPos == 3 then
			for y = 0, 3 do
				pantalla[piece.py + y][piece.px] = 1
			end
		elseif piece.numPos == 2 or piece.numPos == 4 then
			for x = 0, 3 do
				pantalla[piece.py][piece.px - 4 + x] = 1
			end
		end
	elseif piece.name == "T" then
		if piece.numPos == 1 then
			for x = 0, 2 do
				pantalla[piece.py][piece.px + x] = 1
			end
			pantalla[piece.py + 1][piece.px + 1] = 1
		elseif piece.numPos == 2 then
			for y = 0, 2 do
				pantalla[piece.py + y][piece.px - 1] = 1
			end
			pantalla[piece.py + 1][piece.px - 2] = 1
		elseif piece.numPos == 3 then
			for x = 0, 2 do
				pantalla[piece.py - 1][piece.px - 3 + x] = 1
			end
			pantalla[piece.py - 2][piece.px - 2] = 1
		elseif piece.numPos == 4 then
			for y = 0, 2 do
				pantalla[piece.py - 3 + y][piece.px] = 1
			end
			pantalla[piece.py - 2][piece.px + 1] = 1
		end
	end
end

function DecidirPosicion()
	if piece.name == "O" then
		piece.px = piece.x
		piece.py = piece.y
	elseif piece.name == "I" then
		if piece.numPos == 1 or piece.numPos == 3 then
			piece.px = piece.x
			piece.py = piece.y
		elseif piece.numPos == 2 or piece.numPos == 4 then
			piece.px = piece.x + 2
			piece.py = piece.y + 1
		end
	elseif piece.name == "L" or piece.name == "J" or piece.name == "T" then
		if piece.numPos == 1 then
			piece.px = piece.x
			piece.py = piece.y
		elseif piece.numPos == 2 then
			piece.px = piece.x + 2
			piece.py = piece.y - 1
		elseif piece.numPos == 3 then
			piece.px = piece.x + 3
			piece.py = piece.y + 1
		elseif piece.numPos == 4 then
			piece.px = piece.x + 1
			piece.py = piece.y + 2
		end
	elseif piece.name == "S" then
		if piece.numPos == 1 or piece.numPos == 3 then
			piece.px = piece.x
			piece.py = piece.y
		elseif piece.numPos == 2 or piece.numPos == 4 then
			piece.px = piece.x + 3
			piece.py = piece.y - 1
		end
	elseif piece.name == "Z" then
		if piece.numPos == 1 or piece.numPos == 3 then
			piece.px = piece.x
			piece.py = piece.y
		elseif piece.numPos == 2 or piece.numPos == 4 then
			piece.px = piece.x + 2
			piece.py = piece.y - 1
		end
	end
end

function DrawPieces()
	SetColor(piece.name)
	DecidirPosicion()
	if piece.name == "L" then
		if piece.numPos == 1 then
			love.graphics.draw(img_L1, (piece.px-1)*32, (piece.py-1)*32, 0, 1 , 1 , 0 , 0)
		elseif piece.numPos == 2 then
			love.graphics.draw(img_L1, (piece.px-1)*32, (piece.py-1)*32, math.pi/2, 1 , 1 , 0 , 0)	
		elseif piece.numPos == 3 then
			love.graphics.draw(img_L1, (piece.px-1)*32, (piece.py-1)*32, math.pi, 1 , 1 , 0 , 0)	
		elseif piece.numPos == 4 then
			love.graphics.draw(img_L1, (piece.px-1)*32, (piece.py-1)*32, (3*math.pi)/2, 1 , 1 , 0 , 0)	
		end
	elseif piece.name == "J" then
		if piece.numPos == 1 then
			love.graphics.draw(img_J1, (piece.px-1)*32, (piece.py-1)*32, 0, 1 , 1 , 0 , 0)
		elseif piece.numPos == 2 then
			love.graphics.draw(img_J1, (piece.px-1)*32, (piece.py-1)*32, math.pi/2, 1 , 1 , 0 , 0)	
		elseif piece.numPos == 3 then
			love.graphics.draw(img_J1, (piece.px-1)*32, (piece.py-1)*32, math.pi, 1 , 1 , 0 , 0)	
		elseif piece.numPos == 4 then
			love.graphics.draw(img_J1, (piece.px-1)*32, (piece.py-1)*32, (3*math.pi)/2, 1 , 1 , 0 , 0)	
		end
	elseif piece.name == "S" then
		if piece.numPos == 1 or piece.numPos == 3 then
			love.graphics.draw(img_S1, (piece.px-1)*32, (piece.py-1)*32, 0, 1 , 1 , 0 , 0)	
		elseif piece.numPos == 2 or piece.numPos == 4 then
			love.graphics.draw(img_S1, (piece.px-1)*32, (piece.py-1)*32, math.pi/2, 1 , 1 , 0 , 0)	
		end
	elseif piece.name == "Z" then
		if piece.numPos == 1 or piece.numPos == 3 then
			love.graphics.draw(img_Z1, (piece.px-1)*32, (piece.py-1)*32, 0, 1 , 1 , 0 , 0)	
		elseif piece.numPos == 2 or piece.numPos == 4 then
			love.graphics.draw(img_Z1, (piece.px-1)*32, (piece.py-1)*32, math.pi/2, 1 , 1 , 0 , 0)	
		end
	elseif piece.name == "O" then
			love.graphics.draw(img_O, (piece.px-1)*32, (piece.py-1)*32, 0, 1 , 1 , 0 , 0)
		
	elseif piece.name == "I" then
		if piece.numPos == 1 or piece.numPos == 3 then
			love.graphics.draw(img_I1, (piece.px-1)*32, (piece.py-1)*32, 0, 1 , 1 , 0 , 0)	
		elseif piece.numPos == 2 or piece.numPos == 4 then
			love.graphics.draw(img_I1, (piece.px-1)*32, (piece.py-1)*32, math.pi/2, 1 , 1 , 0 , 0)		
		end
	elseif piece.name == "T" then
		if piece.numPos == 1 then
			love.graphics.draw(img_T1, (piece.px-1)*32, (piece.py-1)*32, 0, 1 , 1 , 0 , 0)
		elseif piece.numPos == 2 then
			love.graphics.draw(img_T1, (piece.px-1)*32, (piece.py-1)*32, math.pi/2, 1 , 1 , 0 , 0)	
		elseif piece.numPos == 3 then
			love.graphics.draw(img_T1, (piece.px-1)*32, (piece.py-1)*32, math.pi, 1 , 1 , 0 , 0)	
		elseif piece.numPos == 4 then
			love.graphics.draw(img_T1, (piece.px-1)*32, (piece.py-1)*32, (3*math.pi)/2, 1 , 1 , 0 , 0)	
		end
	end
	
	SetColor(piece.next[1])
	if piece.next[1]     == "L" then
		love.graphics.draw(img_L1, 14*32, 4*32, 0, 1 , 1 , 0 , 0)		
	elseif piece.next[1] == "J" then
		love.graphics.draw(img_J1, 14*32, 4*32, 0, 1 , 1 , 0 , 0)			
	elseif piece.next[1] == "S" then
		love.graphics.draw(img_S1, 14*32, 4*32, 0, 1 , 1 , 0 , 0)			
	elseif piece.next[1] == "Z" then		
		love.graphics.draw(img_Z1, 14*32, 4*32, 0, 1 , 1 , 0 , 0)	
	elseif piece.next[1] == "O" then
		love.graphics.draw(img_O,  14*32, 4*32, 0, 1 , 1 , 0 , 0)		
	elseif piece.next[1] == "I" then	
		love.graphics.draw(img_I1, 15*32, 3*32, 0, 1 , 1 , 0 , 0)	
	elseif piece.next[1] == "T" then
		love.graphics.draw(img_T1, 14*32, 4*32, 0, 1 , 1 , 0 , 0)		
	end

end

function SetColor(name)
	if name == "L" then
		love.graphics.setColor( 103, 202, 68, 255)		-- Verde
	elseif name == "J" then
		love.graphics.setColor( 152, 53, 187, 255)		-- Morado
	elseif name == "S" then
		love.graphics.setColor( 66, 149, 193, 255)		-- Azul
	elseif name == "Z" then
		love.graphics.setColor( 189, 106, 62, 255)		-- Marrón
	elseif name == "O" then
		love.graphics.setColor( 223, 201, 47, 255)		-- Amarillo
	elseif name == "I" then
		love.graphics.setColor( 233, 68, 27, 255)		-- Rojo
	elseif name == "T" then
		love.graphics.setColor( 225, 81, 182, 255)		-- Rosa
	end
end

function ColisionHorizontal(dir)

	if dir == "left" then	
		if piece.name == "L" then
			if piece.numPos == 1 then
				for y = 0, 1 do
					if pantalla[piece.py + y][piece.px - 1] == 1 then return false end
				end
			elseif piece.numPos == 2 then
				if pantalla[piece.py][piece.px - 3] == 1 then return false
				else 
					for y = 0, 1 do
						if pantalla[(piece.py + 1) + y][piece.px - 2] == 1 then return false end
					end
				end
			elseif piece.numPos == 3 then
				if pantalla[piece.py - 1][piece.px - 4] == 1 then return false
				else
					if pantalla[piece.py - 2][piece.px - 2] == 1 then return false end
				end
			elseif piece.numPos == 4 then
				for y = 0, 2 do
					if pantalla[(piece.py - 3) + y][piece.px - 1] == 1 then return false end
				end
			end
		elseif piece.name == "J" then
			if piece.numPos == 1 then
				if pantalla[piece.py][piece.px - 1] == 1 then return false
				else
					if pantalla[piece.py + 1][piece.px + 1] == 1 then return false end
				end
			elseif piece.numPos == 2 then
				if pantalla[piece.py + 2][piece.px - 3] == 1 then return false
				else 
					for y = 0, 1 do
						if pantalla[piece.py + y][piece.px - 2] == 1 then return false end
					end
				end
			elseif piece.numPos == 3 then
				for y = 0, 1 do
					if pantalla[(piece.py - 2) + y][piece.px - 4] == 1 then return false end
				end
			elseif piece.numPos == 4 then
				for y = 0, 2 do
					if pantalla[(piece.py - 3) + y][piece.px - 1] == 1 then return false end
				end
			end	
		elseif piece.name == "S" then
			if piece.numPos == 1 or piece.numPos == 3 then
				if pantalla[piece.py + 1][piece.px - 1] == 1 then return false
				else
					if pantalla[piece.py][piece.px - 1] == 1 then return false end
				end
			elseif piece.numPos == 2 or piece.numPos == 4 then	
				for y = 0, 1 do
					if pantalla[piece.py + y][piece.px - 3] == 1 then return false end
				end				
				if pantalla[piece.py + 2][piece.px - 2] == 1 then return false end				
			end
		elseif piece.name == "Z" then
			if piece.numPos == 1 or piece.numPos == 3 then
				if pantalla[piece.py][piece.px - 1] == 1 then return false
				else
					if pantalla[piece.py + 1][piece.px] == 1 then return false end
				end
			elseif piece.numPos == 2 or piece.numPos == 4 then
				for y = 0, 1 do
					if pantalla[(piece.py + 1) + y][piece.px - 3] == 1 then return false end
				end				
				if pantalla[piece.py][piece.px - 2] == 1 then return false end				
			end
		elseif piece.name == "O" then
			for y = 0, 2 do
				if pantalla[piece.py + y][piece.px - 1] == 1 then return false end
			end
		elseif piece.name == "I" then
			if piece.numPos == 1 or piece.numPos == 3 then
				for y = 0, 3 do
					if pantalla[piece.py + y][piece.px - 1] == 1 then return false end
				end	
			elseif piece.numPos == 2 or piece.numPos == 4 then
				if pantalla[piece.py][piece.px - 5] == 1 then return false end
			end
		elseif piece.name == "T" then
			if piece.numPos == 1 then
				if pantalla[piece.py][piece.px - 1] == 1 then return false
				elseif pantalla[piece.py + 1][piece.px] == 1 then return false end
			elseif piece.numPos == 2 then
				if pantalla[piece.py][piece.px - 2] == 1 or pantalla[piece.py + 2][piece.px - 2] == 1 then return false
				elseif pantalla[piece.py + 1][piece.px - 3] == 1 then return false end
			elseif piece.numPos == 3 then
				if pantalla[piece.py - 1][piece.px - 4] == 1 then return false
				elseif pantalla[piece.py - 2][piece.px - 3] == 1 then return false end
			elseif piece.numPos == 4 then
				for y = 0, 2 do
					if pantalla[(piece.py - 3) + y][piece.px-1] == 1 then return false end
				end
			end	
		end
	
	elseif dir == "right" then	
		if piece.name == "L" then
			if piece.numPos == 1 then
				if pantalla[piece.py][piece.px + 3] == 1 then return false
				else
					if pantalla[piece.py + 1][piece.px + 1] == 1 then return false end
				end
			elseif piece.numPos == 2 then
				for y = 0, 2 do
					if pantalla[piece.py + y][piece.px] == 1 then return false end
				end			
			elseif piece.numPos == 3 then
				for y = 0, 1 do
					if pantalla[piece.py - 2 + y][piece.px] == 1 then return false end
				end
			elseif piece.numPos == 4 then
				for y = 0, 1 do
					if pantalla[piece.py - 3 + y][piece.px + 1] == 1 then return false end
				end
				if pantalla[piece.py - 1][piece.px + 2] == 1 then return false end
			end	
		elseif piece.name == "J" then
			if piece.numPos == 1 then
				for y = 0, 1 do
					if pantalla[piece.py + y][piece.px + 3] == 1 then return false end
				end
			elseif piece.numPos == 2 then
				for y = 0, 2 do
					if pantalla[piece.py + y][piece.px] == 1 then return false end
				end			
			elseif piece.numPos == 3 then
				if pantalla[piece.py - 1][piece.px] == 1 then return false
				else
					if pantalla[piece.py - 2][piece.px - 2] == 1 then return false end
				end
			elseif piece.numPos == 4 then
				if pantalla[piece.py - 3][piece.px + 2] == 1 then return false
				else 
					for y = 0, 1 do
						if pantalla[(piece.py - 2) + y][piece.px + 1] == 1 then return false end
					end
				end
			end
		elseif piece.name == "S" then
			if piece.numPos == 1 or piece.numPos == 3 then
				if pantalla[piece.py][piece.px + 3] == 1 then return false
				else
					if pantalla[piece.py + 1][piece.px + 2] == 1 then return false end
				end
			elseif piece.numPos == 2 or piece.numPos == 4 then
				for y = 0, 1 do
					if pantalla[piece.py + 1 + y][piece.px] == 1 then return false end
				end				
				if pantalla[piece.py][piece.px - 1] == 1 then return false end				
			end
		elseif piece.name == "Z" then			
			if piece.numPos == 1 or piece.numPos == 3 then
				if pantalla[piece.py + 1][piece.px + 3] == 1 then return false
				else
					if pantalla[piece.py][piece.px + 2] == 1 then return false end
				end
			elseif piece.numPos == 2 or piece.numPos == 4 then	
				for y = 0, 1 do
					if pantalla[piece.py + y][piece.px] == 1 then return false end
				end				
				if pantalla[piece.py + 2][piece.px - 1] == 1 then return false end				
			end
		elseif piece.name == "O" then
			for y = 0, 2 do
				if pantalla[piece.py + y][piece.px + 2] == 1 then return false end
			end
		elseif piece.name == "I" then
			if piece.numPos == 1 or piece.numPos == 3 then
				for y = 0, 3 do
					if pantalla[piece.py + y][piece.px + 1] == 1 then return false end
				end	
			elseif piece.numPos == 2 or piece.numPos == 4 then
				if pantalla[piece.py][piece.px] == 1 then return false end
			end
		elseif piece.name == "T" then
			if piece.numPos == 1 then
				if pantalla[piece.py][piece.px + 3] == 1 then return false
				elseif pantalla[piece.py + 1][piece.px + 2] == 1 then return false end
			elseif piece.numPos == 2 then
				for y = 0, 2 do
					if pantalla[piece.py + y][piece.px] == 1 then return false end
				end
			elseif piece.numPos == 3 then
				if pantalla[piece.py - 1][piece.px] == 1 then return false
				elseif pantalla[piece.py - 2][piece.px - 1] == 1 then return false end
			elseif piece.numPos == 4 then			
				if pantalla[piece.py - 3][piece.px + 1] == 1 or pantalla[piece.py - 1][piece.px + 1] == 1 then return false
				elseif pantalla[piece.py - 2][piece.px + 2] == 1 then return false end
			end	
		end	
	end
	
	return true
	
end

function ColisionVertical()
	if piece.name == "L" then
		if piece.numPos == 1 then
			if pantalla[piece.py + 2][piece.px] == 1 then return false end
			for x = 1, 2 do
				if pantalla[piece.py + 1][piece.px + x] == 1 then return false end
			end
		elseif piece.numPos == 2 then
			if pantalla[piece.py + 3][piece.px - 1] == 1 then return false end
			if pantalla[piece.py + 1][piece.px - 2] == 1 then return false end
		elseif piece.numPos == 3 then
			for x = 0, 2 do
				if pantalla[piece.py][piece.px - 3 + x] == 1 then return false end
			end
		elseif piece.numPos == 4 then
			for x = 0, 1 do
				if pantalla[piece.py][piece.px + x] == 1 then return false end
			end
		end
	elseif piece.name == "J" then
		if piece.numPos == 1 then
			if pantalla[piece.py + 2][piece.px + 2] == 1 then return false end
			for x = 0, 1 do
				if pantalla[piece.py + 1][piece.px + x] == 1 then return false end
			end
		elseif piece.numPos == 2 then
			for x = 0, 1 do
				if pantalla[piece.py + 3][piece.px - 2 + x] == 1 then return false end
			end
		elseif piece.numPos == 3 then
			for x = 0, 2 do
				if pantalla[piece.py][piece.px - 3 + x] == 1 then return false end
			end
		elseif piece.numPos == 4 then
			if pantalla[piece.py][piece.px] == 1 then return false end
			if pantalla[piece.py - 2][piece.px + 1] == 1 then return false end
		end	
	elseif piece.name == "S" then
		if piece.numPos == 1 or piece.numPos == 3 then
			for x = 0, 1 do
				if pantalla[piece.py + 2][piece.px + x] == 1 then return false end
			end
			if pantalla[piece.py + 1][piece.px + 2] == 1 then return false end
		elseif piece.numPos == 2 or piece.numPos == 4 then	
			if pantalla[piece.py + 3][piece.px - 1] == 1 then return false end
			if pantalla[piece.py + 2][piece.px - 2] == 1 then return false end		
		end
	elseif piece.name == "Z" then
		if piece.numPos == 1 or piece.numPos == 3 then
			for x = 0, 1 do
				if pantalla[piece.py + 2][piece.px + 1 + x] == 1 then return false end
			end
			if pantalla[piece.py + 1][piece.px] == 1 then return false end
		elseif piece.numPos == 2 or piece.numPos == 4 then
			if pantalla[piece.py + 3][piece.px - 2] == 1 then return false end
			if pantalla[piece.py + 2][piece.px - 1] == 1 then return false end		
		end
	elseif piece.name == "O" then
		for x = 0, 1 do
			if pantalla[piece.py + 2][piece.px + x] == 1 then return false end
		end
	elseif piece.name == "I" then
		if piece.numPos == 1 or piece.numPos == 3 then
			if pantalla[piece.py + 4][piece.px] == 1 then return false end	
		elseif piece.numPos == 2 or piece.numPos == 4 then
			for x = 0, 3 do
				if pantalla[piece.py + 1][piece.px - 4 + x] == 1 then return false end
			end
		end
	elseif piece.name == "T" then
		if piece.numPos == 1 then		
			if pantalla[piece.py + 2][piece.px + 1] == 1 then return false end
			if pantalla[piece.py + 1][piece.px] == 1 or pantalla[piece.py + 1][piece.px + 2] == 1 then return false end
		elseif piece.numPos == 2 then
			if pantalla[piece.py + 3][piece.px - 1] == 1 then return false end
			if pantalla[piece.py + 2][piece.px - 2] == 1 then return false end
		elseif piece.numPos == 3 then
			for x = 0, 2 do
				if pantalla[piece.py][piece.px - 3 + x] == 1 then return false end
			end
		elseif piece.numPos == 4 then
			if pantalla[piece.py][piece.px] == 1 then return false end
			if pantalla[piece.py - 1][piece.px + 1] == 1 then return false end
		end	
	end
	
	return true
end

function Colision(pos)
	if pos > 4 then pos = 1 end
	if piece.name == "L" then
		if pos == 1 then
			for x = 0, 2 do
				if pantalla[piece.y][piece.x + x] == 1 then return false end
			end
			if pantalla[piece.y + 1][piece.x] == 1 then return false end
		elseif pos == 2 then
			for y = 0, 2 do
				if pantalla[piece.y - 1 + y][piece.x + 1] == 1 then return false end
			end
			if pantalla[piece.y - 1][piece.x]  == 1 then return false end
		elseif pos == 3 then
			for x = 0, 2 do
				if pantalla[piece.y][piece.x + x]  == 1 then return false end
			end
			if pantalla[piece.y - 1][piece.x + 2] == 1 then return false end
		elseif pos == 4 then
			for y = 0, 2 do
				if pantalla[piece.y - 1 + y][piece.x + 1] == 1 then return false end
			end
			if pantalla[piece.y + 1][piece.x + 2] == 1 then return false end
		end
	elseif piece.name == "J" then
		if pos == 1 then
			for x = 0, 2 do
				if pantalla[piece.y][piece.x + x] == 1 then return false end
			end
			if pantalla[piece.y + 1][piece.x + 2] == 1 then return false end
		elseif pos == 2 then
			for y = 0, 2 do
				if pantalla[piece.y - 1 + y][piece.x + 1] == 1 then return false end
			end
			if pantalla[piece.y + 1][piece.x] == 1 then return false end
		elseif pos == 3 then
			for x = 0, 2 do
				if pantalla[piece.y][piece.x + x] == 1 then return false end
			end
			if pantalla[piece.y - 1][piece.x] == 1 then return false end
		elseif pos == 4 then
			for y = 0, 2 do
				if pantalla[piece.y - 1 + y][piece.x + 1] == 1 then return false end
			end
			if pantalla[piece.y - 1][piece.x + 2] == 1 then return false end
		end
	elseif piece.name == "S" then
		if pos == 1 or pos == 3 then
			for x = 0, 1 do
				if pantalla[piece.y][piece.x + 1 + x] == 1 then return false end
			end
			for x = 0, 1 do
				if pantalla[piece.y + 1][piece.x + x] == 1 then return false end
			end
		elseif pos == 2 or pos == 4 then
			for y = 0, 1 do
				if pantalla[piece.y - 1 + y][piece.x + 1] == 1 then return false end
			end
			for y = 0, 1 do
				if pantalla[piece.y + y][piece.x + 2] == 1 then return false end
			end
		end
	elseif piece.name == "Z" then
		if pos == 1 or pos == 3 then
			for x = 0, 1 do
				if pantalla[piece.y][piece.x + x] == 1 then return false end
			end
			for x = 0, 1 do
				if pantalla[piece.y + 1][piece.x + 1 + x] == 1 then return false end
			end
		elseif pos == 2 or pos == 4 then
			for y = 0, 1 do
				if pantalla[piece.y - 1 + y][piece.x + 1] == 1 then return false end
			end
			for y = 0, 1 do
				if pantalla[piece.y + y][piece.x] == 1 then return false end
			end
		end
	elseif piece.name == "O" then
		for x = 0, 1 do
			for y = 0, 1 do
				if pantalla[piece.py + y][piece.px + x] == 1 then return false end
			end
		end
	elseif piece.name == "I" then
		if pos == 1 or pos == 3 then
			for y = 0, 3 do
				if pantalla[piece.y + y][piece.x] == 1 then return false end
			end
		elseif pos == 2 or pos == 4 then
			for x = 0, 3 do
				if pantalla[piece.y + 1][piece.x - 2 + x] == 1 then return false end
			end
		end
	elseif piece.name == "T" then
		if pos == 1 then
			for x = 0, 2 do
				if pantalla[piece.y][piece.x + x] == 1 then return false end
			end
			if pantalla[piece.y + 1][piece.x + 1] == 1 then return false end
		elseif pos == 2 then
			for y = 0, 2 do
				if pantalla[piece.y - 1 + y][piece.x + 1] == 1 then return false end
			end
			if pantalla[piece.y][piece.x] == 1 then return false end
		elseif pos == 3 then
			for x = 0, 2 do
				if pantalla[piece.y][piece.x + x] == 1 then return false end
			end
			if pantalla[piece.y - 1][piece.x + 1] == 1 then return false end
		elseif pos == 4 then
			for y = 0, 2 do
				if pantalla[piece.y - 1 + y][piece.x + 1] == 1 then return false end
			end
			if pantalla[piece.y][piece.x + 2] == 1 then return false end
		end
	end
	
	return true
end
