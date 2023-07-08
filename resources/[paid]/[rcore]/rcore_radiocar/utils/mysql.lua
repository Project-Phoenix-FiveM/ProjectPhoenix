if Config.MysqlType == 0 then
    --------------
    -- sync / async
    function MySQLSyncfetchAll(query, table, cb)
        return {}
    end

    function MySQLAsyncfetchAll(query, table, cb)
        return {}
    end

    ---
    -- sync / async
    function MySQLSyncexecute(query, table, cb)
        return 1
    end

    function MySQLAsyncexecute(query, table, cb)
        return 1
    end

    function MysqlInit(cb)

    end
end

if Config.MysqlType == 1 then
    function MySQLSyncfetchAll(query, table, cb)
        return exports['oxmysql']:executeSync(query, table, cb)
    end

    function MySQLAsyncfetchAll(query, table, cb)
        return exports['oxmysql']:execute(query, table, cb)
    end

    ---
    -- sync / async
    function MySQLSyncexecute(query, table, cb)
        return exports['oxmysql']:executeSync(query, table, cb)
    end

    function MySQLAsyncexecute(query, table, cb)
        return exports['oxmysql']:execute(query, table, cb)
    end

    -- From the topic on "oxmysql" there isnt any need for Mysql.Ready so... This good enough?
    function MysqlInit(cb)
        cb()
    end
end

if Config.MysqlType == 2 then
    --------------
    -- sync / async
    function MySQLSyncfetchAll(query, table, cb)
        return MySQL.Sync.fetchAll(query, table, cb)
    end

    function MySQLAsyncfetchAll(query, table, cb)
        return MySQL.Async.fetchAll(query, table, cb)
    end

    ---
    -- sync / async
    function MySQLSyncexecute(query, table, cb)
        return MySQL.Sync.execute(query, table, cb)
    end

    function MySQLAsyncexecute(query, table, cb)
        return MySQL.Async.execute(query, table, cb)
    end

    function MysqlInit(cb)
        MySQL.ready(cb)
    end
end

if Config.MysqlType == 3 then
    -- ghmattimysql support
    -- By: Yixaoky
    function MySQLSyncfetchAll(query, table, cb)
        return exports['ghmattimysql']:executeSync(query, table, cb)
    end

    function MySQLAsyncfetchAll(query, table, cb)
        return exports['ghmattimysql']:execute(query, table, cb)
    end

    ---
    -- sync / async
    function MySQLSyncexecute(query, table, cb)
        return exports['ghmattimysql']:executeSync(query, table, cb)
    end

    function MySQLAsyncexecute(query, table, cb)
        return exports['ghmattimysql']:execute(query, table, cb)
    end

    -- I have not found any docs at all. So i will leave it like this.
    function MysqlInit(cb)
        cb()
    end
end