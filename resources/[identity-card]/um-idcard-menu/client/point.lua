local idCardNpcPoint = lib.points.new(Config.NPC.coords, 2)

function idCardNpcPoint:onEnter()
    lib.showTextUI('[E] - Identity Menu', {position = "left-center",icon = 'id-card'})
end

function idCardNpcPoint:onExit()
    lib.hideTextUI()
end

function idCardNpcPoint:nearby()
    if self.currentDistance < 1 and IsControlJustReleased(0, 38) then
        lib.showContext("identity_menu")
    end
end