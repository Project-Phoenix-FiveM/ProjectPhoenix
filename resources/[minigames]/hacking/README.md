# Hack minigame FiveM build
Because of our great contributors there is now a FiveM version.

## ⚠ STILL IN ALPHA ⚠  
This version has just recently been released and is still being worked on. Excpect bugs!  
Do you have knowledge with FiveM? Improve the code and your changes will happily be added.  



## Getting started
1. Download the folder `hacking` trough git or [here](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/Jesper-Hustad/NoPixel-minigame/tree/main/fivem-script/hacking)  
2. Drop it into your FiveM server in `server\resources\`
3. Implement the hack in your client-side lua file using the `open:minigame` trigger.


## Example implementation
Use the Success boolean variable.  
In this example implementation the outcome is "1" if succesful and "2" if failure.
```lua
exports['hacking']:OpenHackingGame(20, 5, 5, function(Success)
        print(Success)
        if Success then
            print("1")
        else
            print("2")
        end
end)
```


## FiveM documentation
Read about scripts in FiveM from the [FiveM Docs](https://docs.fivem.net/docs/scripting-manual/introduction/introduction-to-resources/).
