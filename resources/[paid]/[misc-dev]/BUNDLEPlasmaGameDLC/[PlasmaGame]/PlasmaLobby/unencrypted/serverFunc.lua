DEBUG = false
ENABLECOMMAND = false



aff = print
function print(text)
	if DEBUG then
		aff(text)
	end
end

function GetSpecificPlayerName(player)
	local name = ""
	name = GetPlayerName(player)
	return name
end



