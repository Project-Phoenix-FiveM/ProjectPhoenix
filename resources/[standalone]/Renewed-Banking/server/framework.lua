local QBCore, Jobs, Gangs = exports['qb-core']:GetCoreObject(), QBCore.Shared.Jobs, QBCore.Shared.Gangs
local deadPlayers = {}

CreateThread(function()
    ExportHandler("qb-management", "GetAccount", GetAccountMoney)
    ExportHandler("qb-management", "GetGangAccount", GetAccountMoney)
    ExportHandler("qb-management", "AddMoney", AddAccountMoney)
    ExportHandler("qb-management", "AddGangMoney", AddAccountMoney)
    ExportHandler("qb-management", "RemoveMoney", RemoveAccountMoney)
    ExportHandler("qb-management", "RemoveGangMoney", RemoveAccountMoney)
end)

function GetSocietyLabel(society)
    return Jobs[society] and Jobs[society].label or QBCore.Shared.Gangs[society] and QBCore.Shared.Gangs[society].label or society
end

function GetPlayerObject(source)
    return QBCore.Functions.GetPlayer(source)
end

function GetPlayerObjectFromID(identifier)
    identifier = identifier:upper()
    return QBCore.Functions.GetPlayerByCitizenId(identifier)
end

function GetCharacterName(Player)
    return ("%s %s"):format(Player.PlayerData.charinfo.firstname, Player.PlayerData.charinfo.lastname)
end

function GetIdentifier(Player)
    return Player.PlayerData.citizenid
end

function GetFunds(Player)
    local funds = {
        cash = Player.PlayerData.money.cash,
        bank = Player.PlayerData.money.bank
    }
    return funds
end

function AddMoney(Player, Amount, Type, comment)
    Player.Functions.AddMoney(Type, Amount, comment)
end

function RemoveMoney(Player, Amount, Type, comment)
    local currentAmount = Player.Functions.GetMoney(Type)
    if currentAmount >= Amount then
        Player.Functions.RemoveMoney(Type, Amount, comment)
        return true
    end
    return false
end

function GetJobs(Player)
    if Config.renewedMultiJob then
        local jobs = exports['qb-phone']:getJobs(Player.PlayerData.citizenid)
        local temp = {}
        for k,v in pairs(jobs) do
            temp[#temp+1] = {
                name = k,
                grade = tostring(v.grade)
            }
        end
        return temp
    else
        return {
            name = Player.PlayerData.job.name,
            grade = tostring(Player.PlayerData.job.grade.level)
        }
    end

end

function GetGang(Player)
     return Player.PlayerData.gang.name
end

function IsJobAuth(job, grade)
    local numGrade = tonumber(grade)
    return Jobs[job].grades[grade] and Jobs[job].grades[grade].bankAuth or Jobs[job].grades[numGrade] and Jobs[job].grades[numGrade].bankAuth
end

function IsGangAuth(Player, gang)
    local grade = tostring(Player.PlayerData.gang.grade.level)
    local gradeNum = tonumber(grade)
    return Gangs[gang].grades[grade] and Gangs[gang].grades[grade].bankAuth or Gangs[gang].grades[gradeNum] and Gangs[gang].grades[gradeNum].bankAuth
end

function Notify(src, settings)
    TriggerClientEvent("ox_lib:notify", src, settings)
end

function IsDead(Player)
    return Player.PlayerData.metadata.isdead
end

--Misc Framework Events

AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    local cid = Player.PlayerData.citizenid
    UpdatePlayerAccount(cid)
end)


AddEventHandler('onResourceStart', function(resourceName)
    Wait(250)
    if resourceName == GetCurrentResourceName() then
        for _, v in ipairs(GetPlayers()) do
            local Player = GetPlayerObject(v)
            if Player then
                local cid = GetIdentifier(Player)
                UpdatePlayerAccount(cid)
            end
        end
    end
end)
