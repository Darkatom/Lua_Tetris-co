
function loadImages()

   local folder = "imgs/"
   local Quad = love.graphics.newQuad

   _IMGS = {}
   
   _IMGS.Background = {}
   _IMGS.Background[1] = love.graphics.newImage( folder.."Tetris_back.png" )
   _IMGS.Background["1_Borde"] = love.graphics.newImage( folder.."Tetris_back_borde.png" )

   _IMGS.Piezas = {}
   
   _IMGS.Piezas.Width = 32
   _IMGS.Piezas.Height = 32
   _IMGS.Piezas.Sheet = love.graphics.newImage( folder.."Bloques_Tetris.png" )

                        -- X,   Y,  WQuad,             HQuad,           WSheet, HSheet
   _IMGS.Piezas[1] = Quad( 0,   0,  _IMGS.Piezas.Width, _IMGS.Piezas.Height, 96, 64)
   _IMGS.Piezas[2] = Quad( 0,  32,  _IMGS.Piezas.Width, _IMGS.Piezas.Height, 96, 64)
   _IMGS.Piezas[3] = Quad( 32,  0,  _IMGS.Piezas.Width, _IMGS.Piezas.Height, 96, 64)
   _IMGS.Piezas[4] = Quad( 32, 32,  _IMGS.Piezas.Width, _IMGS.Piezas.Height, 96, 64)
   _IMGS.Piezas[5] = Quad( 64,  0,  _IMGS.Piezas.Width, _IMGS.Piezas.Height, 96, 64)
   _IMGS.Piezas[6] = Quad( 64, 32,  _IMGS.Piezas.Width, _IMGS.Piezas.Height, 96, 64)

end