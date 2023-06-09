function DisplayText(msg,type)
    if type == "close" then
        lib.hideTextUI()
    else
        lib.showTextUI(msg)
    end
end