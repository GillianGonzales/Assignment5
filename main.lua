-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- Created By Gillian Gonzales
-- Created On April 7 2018
--
-- This program will have 3 functions 
-----------------------------------------------------------------------------------------

local kill = 0
local time = 5
local looping 
local YouWin
local win
local looping2
local countdown
local lose



-- Changing Background
display.setDefault("background", 1, 1, 1 )

-- Making audio
local audio1 = audio.loadSound( "./assets/audio1.wav" )	

-- displaying image
local Ninja = display.newImageRect("./assets/sprites/Idle1.png", 200, 400)
Ninja.x = display.contentCenterX
Ninja.y = display.contentCenterY
Ninja.id = "Ninja Boy"

local Ninja2 = display.newImageRect("./assets/sprites/Glide5.png", 400,400)
Ninja2.x = display.contentCenterX - 1200
Ninja2.y = display.contentCenterY - 500 

local Enemy1 = display.newImageRect("./assets/sprites/Enemy.png", 300, 450)
Enemy1.x = display.contentCenterX + 800
Enemy1.y = display.contentCenterY
Enemy1.isVisible = false 
Enemy1.id = "Zombie1"

local Enemy2 = display.newImageRect("./assets/sprites/Enemy.png", 300, 450)
Enemy2.x = display.contentCenterX - 800
Enemy2.y = display.contentCenterY
Enemy2.isVisible = false
Enemy2.id = "Zombie2"

local button = display.newImageRect("./assets/sprites/Button.png", 406, 157)
button.x = display.contentCenterX 
button.y = display.contentCenterY + 400

-- Adding text 
local Instructions = display.newText("Hit the Enemy", 1024, 425, native.systemFont, 75)
Instructions:setFillColor (0,0,0)
Instructions.isVisible = false

local Start = display.newText("Press the button to start", 1024, 1400, native.systemFont, 75)
Start:setFillColor(0,0,0)


--Making Functions
local function HitingEnemy( event )
	-- This function will kill the enemy
	Enemy1.isVisible = false
	Enemy2.isVisible = true	
end

local function HitingEnemy2( event)
	-- This function will kill enemy 
	Enemy2.isVisible = false
	Enemy1.isVisible = true
end

local function Ninjamove( event )
	-- This function will make the second ninja to move 
	for looping = 1,2 do
		if Ninja2.x == 2224 then
			break
		end
		timer.performWithDelay( 1000, Ninjamove)
		Ninja2.x = Ninja2.x + 1
		print(Ninja.x)
	end
end


local function winFunction( event )
	-- This function will tell the user if they won
		kill = kill + 1
		if kill == 5 then
			win = display.newText("You Win", 1024, 425, native.systemFont, 75)
			win:setFillColor (0,0,0)

			Instructions:setFillColor(1,1,1)

			YouWin = audio.play( audio1 )
			lose = display.newText("", 1024, 425, native.systemFont, 75)
			lose:setFillColor(1,1,1)
			Enemy2.isVisible = false
			Enemy1.isVisible = false
			timer.pause(countdown)

		end
	print("kill"..kill.."")
end


local function loseFunction( event )
	-- This function will tell the user if they lost
	-- Sprites appearing  
	Enemy1.isVisible = true
	Instructions.isVisible = true
	button.isVisible = false
	Start.isVisible = false
	-- Making Timer
	time = time - 1
	countdown = timer.performWithDelay( 1000, loseFunction)
	print (time)
	-- Making if timer hits 0 
	if time == 0 then
		lose = display.newText("You Lose", 1024, 425, native.systemFont, 75)
		lose:setFillColor(0,0,0)
		Instructions:setFillColor(1,1,1)
		Enemy2.isVisible = false
		Enemy1.isVisible = false
		timer.pause(countdown)
		-- Making if kils hit 5 before timer hits 0
	elseif kill == 5 then
		lose = display.newText("", 1024, 425, native.systemFont, 75)
		timer.pause(countdown)
	end
end



-- Adding Event Listeners
Enemy1:addEventListener("touch", HitingEnemy)
Enemy2:addEventListener("touch", HitingEnemy2)
Enemy1:addEventListener("touch", winFunction)
Enemy2:addEventListener("touch", winFunction)
button:addEventListener("touch", loseFunction)
button:addEventListener("touch", Ninjamove)


