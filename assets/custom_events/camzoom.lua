function onEvent(name, v1, v2)
    if name == 'camzoom' then
        setProperty('defaultCamZoom', v1);
        doTweenZoom('camzoomtween', 'camGame', getProperty('defaultCamZoom'), v2, 'cubeOut');
    end
end