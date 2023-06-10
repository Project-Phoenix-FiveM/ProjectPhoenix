function getClass(vehicle) 
	if not vehicle then return false end
    local fInitialDriveMaxFlatVel = GetVehicleHandlingFloat(vehicle, 'CHandlingData', "fInitialDriveMaxFlatVel")
	local fInitialDriveForce = GetVehicleHandlingFloat(vehicle, 'CHandlingData', "fInitialDriveForce")
	local fDriveBiasFront = GetVehicleHandlingFloat(vehicle, 'CHandlingData', "fDriveBiasFront")
	local fInitialDragCoeff = GetVehicleHandlingFloat(vehicle, 'CHandlingData', "fInitialDragCoeff")
	local fTractionCurveMax = GetVehicleHandlingFloat(vehicle, 'CHandlingData', "fTractionCurveMax")
	local fTractionCurveMin = GetVehicleHandlingFloat(vehicle, 'CHandlingData', "fTractionCurveMin")
	local fSuspensionReboundDamp = GetVehicleHandlingFloat(vehicle, 'CHandlingData', "fSuspensionReboundDamp")
	local fBrakeForce = GetVehicleHandlingFloat(vehicle, 'CHandlingData', "fBrakeForce")
	local force = fInitialDriveForce 
	if fInitialDriveForce > 0 and fInitialDriveForce < 1 then
		force = force * 1.1
	end
	local accel = (fInitialDriveMaxFlatVel * force) / 10
	local speed = ((fInitialDriveMaxFlatVel / fInitialDragCoeff) * (fTractionCurveMax + fTractionCurveMin)) / 40
	if isMotorCycle then
		speed = speed * 2
	end
	local handling = (fTractionCurveMax + fSuspensionReboundDamp) * fTractionCurveMin
	if isMotorCycle then
		handling = handling / 2
	end
	local braking = ((fTractionCurveMin / fInitialDragCoeff) * fBrakeForce) * 7
	local perfRating = ((accel * 5) + speed + handling + braking) * 20
	local vehClass = "D"
	if isMotorCycle then
		vehClass = "M"
	elseif perfRating > 700 then
		vehClass = "S"
	elseif perfRating > 550 then
		vehClass = "A"
	elseif perfRating > 400 then
		vehClass = "B"
	elseif perfRating > 325 then
		vehClass = "C"
	else
		vehClass = "D"
	end
	return vehClass
end