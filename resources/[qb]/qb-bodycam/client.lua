local QBCore = exports['qb-core']:GetCoreObject()

local recort = false


RegisterNetEvent("qb-bodycam:use")
AddEventHandler("qb-bodycam:use", function(job, grade, name)
    if not recort then
    recort = true
    SendNUIMessage({
        rec = true,
        type = "record",
        webhook = Config.webhook,
        resolutions = Config.resolutions,
        pName = name,
        jobGrade = grade,
		jobName = job,
        time = Config.timeout
    })
    elseif recort then
    recort = false
    SendNUIMessage({
        rec = false,
        type = "record"
    })
    end
end)

RegisterNetEvent("noItemClose")
AddEventHandler("noItemClose", function()
    SendNUIMessage({
        rec = false,
        type = "record"
    })
end)


RegisterNUICallback("SendNewRecord", function (data)
    TriggerServerEvent('SaveJsonData', data)
end)

RegisterNUICallback("GetUserRecords", function (data,Q)
    QBCore.Functions.TriggerCallback("getUserRecords", function(data) 
        print(data)
            Q(data)
    end, data.citizen)
end)

RegisterNUICallback("NuiFalse", function (data)
    SetNuiFocus(false,false)
end)

RegisterCommand(Config.openui, function()
    TriggerServerEvent('GetRecordData')
    SetNuiFocus(true,true)
end)


RegisterNetEvent("SetRecorData")
AddEventHandler("SetRecorData", function(RecData)
    print("SetRecorData")
    SendNUIMessage({
        type = "data",
        RecData = RecData,
        job_grade = QBCore.Functions.GetPlayerData().job.grade.name,
        boss = Config.boss
    })
end)

RegisterNUICallback("deleteRecords", function (data,Q)
    QBCore.Functions.TriggerCallback("deleteRecords", function(jsdata,islem)
        local qData = {
            islem = islem,
            data = jsdata
        }
        Q(qData)
    end, data.key , data.cid)
end)
