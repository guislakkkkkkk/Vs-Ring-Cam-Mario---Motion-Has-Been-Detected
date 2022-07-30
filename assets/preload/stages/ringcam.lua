local oppx = 291;
local oppy = 373;
local camoffs = 50;
local followchars = true;

function onCreate()
    makeLuaSprite('sky', 'stage/ringcam/Skybox', -650,-150);
    makeLuaSprite('ground', 'stage/ringcam/Ground', -650,-150);
    makeLuaSprite('porch', 'stage/ringcam/BackgroundWall', -750,-150);
    makeLuaSprite('wall', 'stage/ringcam/FrontWall', -750,-150);
    makeLuaSprite('border', 'stage/ringcam/RingCam', -150,-60);
    makeLuaSprite('rung', 'stage/ringcam/rung', -50,-25);

    setLuaSpriteScrollFactor('sky', 0, 0);
    setLuaSpriteScrollFactor('ground', 0.6, 0.6);
    setLuaSpriteScrollFactor('porch', 0.8, 0.8);
    setLuaSpriteScrollFactor('wall', 0.95, 0.95);

    scaleObject('border', 0.75, 0.75);

    setObjectCamera('border', 'camHUD');
    setObjectCamera('rung', 'camHUD');

    addLuaSprite('sky', false);
    addLuaSprite('ground', false);
    addLuaSprite('porch', false);
    addLuaSprite('wall', true);
    addLuaSprite('border', false);
    addLuaSprite('rung', false);
    
end

function onCreatePost()

    -- setProperty('dad.visible', false);
    setObjectOrder('sky', 0);
    setObjectOrder('ground', 1);
    setObjectOrder('porch', 2);
    setObjectOrder('dadGroup', 3);
    setObjectOrder('wall', 4);
    setObjectOrder('border', 6);
    setObjectOrder('rung', 7);

    noteTweenX('leftdad', 0, -1000, 0.01, 'linear');
    noteTweenX('downdad', 1, -1000, 0.01, 'linear');
    noteTweenX('updad', 2, -1000, 0.01, 'linear');
    noteTweenX('rightdad', 3, -1000, 0.01, 'linear');
    setPropertyFromGroup('strumLineNotes', 4, 'x', 400 - 250);
    setPropertyFromGroup('strumLineNotes', 5, 'x', 520 - 200);
    setPropertyFromGroup('strumLineNotes', 6, 'x', 640 + 200);
    setPropertyFromGroup('strumLineNotes', 7, 'x', 760 + 250);

    if getPropertyFromClass('ClientPrefs', 'downScroll') == false then
        setProperty('rung.y', getProperty('rung.y') + 600);
    end
end

function onEvent(n)
    if n == 'comein' then
        setProperty('camGame.visible', false);
        setProperty('camHUD.visible', false);
        playSound('liver', 1);
    end

    if n == 'hi' then
        doTweenX('marioleave', 'dad', defaultOpponentX - 100, 2.5, 'cubeOut');
    end
end

function onUpdate()

    if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
        setObjectOrder('dadGroup', 5);
    else
        setObjectOrder('dadGroup', 3);
    end

	-- if keyJustPressed('space') == true then
	-- 	debugPrint(getProperty('camFollow.x'), getProperty('camFollow.y'))
	-- end

	if followchars == true then
			if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
				triggerEvent('Camera Follow Pos',oppx-camoffs,oppy)
			end
			if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
				triggerEvent('Camera Follow Pos',oppx+camoffs,oppy)
			end
			if getProperty('dad.animation.curAnim.name') == 'singUP' then
				triggerEvent('Camera Follow Pos',oppx,oppy-camoffs)
			end
			if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
				triggerEvent('Camera Follow Pos',oppx,oppy+camoffs)
			end
			if getProperty('dad.animation.curAnim.name') == 'idle' then
				triggerEvent('Camera Follow Pos',oppx,oppy);
			end
		else
			triggerEvent('Camera Follow Pos','','');
		end
	
end