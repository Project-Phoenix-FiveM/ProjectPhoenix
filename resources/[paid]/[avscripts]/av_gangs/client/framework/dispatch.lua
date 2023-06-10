-- type: "spray" / "rob"
function TriggerDispatch(type)
    if type == "rob" then
        local lucky = math.random(1,100) -- We don't want to send an alert every time someone robs a gang member (?)
        if lucky <= 10 then
            -- Add your own dispatch export/event here:

        end
    else
        -- This one is when a gang member is placing a graffiti
        -- Add your own dispatch export/event here:

    end
end