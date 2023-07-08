HelpNotification = function(msg)
  AddTextEntry('mLibsHelp', msg)
  BeginTextCommandDisplayHelp('mLibsHelp')
  EndTextCommandDisplayHelp(0, false, true, -1)
end

ShowNotification = function(msg)
  AddTextEntry('mLibsNotify', msg)
  SetNotificationTextEntry('mLibsNotify')
  DrawNotification(false, true)
end

exports('ShowNotification',ShowNotification)
exports('HelpNotification',HelpNotification)