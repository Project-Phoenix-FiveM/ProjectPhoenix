# COMMUNITY SERVICE SCRIPT FOR PS-MDT QBCORE

**Commands**

End Community service with /endcomserv [id]

Send Community service with /comserv or use PS-MDT

> **SETUP**

1. ensure qb-community-service

2. Change config to liking (Outfits)

3. Goto - qb-core/server/player.lua

4. Find - Line 88 -- Metadata -- Under the function - paste below. 

```
 PlayerData.metadata["communityservice"] = PlayerData.metadata["communityservice"] ~= nil and PlayerData.metadata["communityservice"] or 0

```
