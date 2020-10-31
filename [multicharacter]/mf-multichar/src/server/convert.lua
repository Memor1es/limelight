RegisterCommand('multichar:convert',function()
  local characters = {}

  local NewSlot = function(identifier,prev_id)
    if not characters[identifier] then
      characters[identifier] = {}
    end

    for i=1,100,1 do
      if not characters[identifier][i] then
        characters[identifier][i] = prev_id
        return i
      end
    end
  end

  local GetSlot = function(identifier,prev_id)
    if not characters[identifier] then
      return NewSlot(identifier,prev_id)
    else
      for i=1,100,1 do
        if characters[identifier][i] and characters[identifier][i] == prev_id then
          return i
        end
      end
      return 1
    end
  end

  local user_table = {table = 'users', column = 'identifier'}
  local other_tables = {    
    {table = 'user_accounts',               column = 'identifier'},
    {table = 'owned_vehicles',              column = 'owner'},
    --{table = 'addon_account_data',          column = 'owner'},
    --{table = 'addon_inventory_items',       column = 'owner'},
    --{table = 'billing',                     column = 'identifier'},
    --{table = 'characters',                  column = 'identifier'}, 
    --{table = 'user_inventory',              column = 'identifier'},
    --{table = 'playermotels',                column = 'owner'},
    --{table = 'playermotels_homeinventory',  column = 'owner'},
    --{table = 'allhousing',                  column = 'owner'},
    --{table = 'donors',                      column = 'identifier'},
    --{table = 'drug_statuses',               column = 'identifier'},
    --{table = 'owned_shops',                 column = 'identifier'},
    --{table = 'phone_users_contacts',        column = 'identifier'},
    --{table = 'shipments',                   column = 'identifier'},
    --{table = 'sim',                         column = 'identifier'},
    --{table = 'user_documents',              column = 'owner'},
    --{table = 'user_licenses',               column = 'owner'},
    --{table = 'vehicle_shops',               column = 'owner'},
    --{table = 'datastore_data',              column = 'owner'},
  }

  local GetSql = function(query,params)
    local res,ret
    MySQL.Async.fetchAll(query,params,function(r)
      ret = r
      res = true
    end)
    while not res do Wait(0); end
    return ret
  end

  local ExecuteSql = function(query,params)
    local res
    MySQL.Async.execute(query,params,function()
      res = true
    end)
    while not res do Wait(0); end
  end

  print("Starting multichar conversion. No players should join during this time, and you should not shut down your server until the completion prompt has been displayed.")

  local users = GetSql(string.format("SELECT * FROM %s",user_table.table),{})
  for _,user in ipairs(users) do
    local identifier = user[user_table.column]
    local user_id

    if identifier then
      local st,fn = identifier:find(":")
      if st and fn then
        local pre = identifier:sub(1,st-1)
        local suf = identifier:sub(fn+1)

        if Config.RemovePrefix then
          user_id = suf
        else
          if pre:find("Char") then
            pre = Config.IdentifierPrefix
          end

          if not pre:find(Config.IdentifierPrefix) then
            pre = Config.IdentifierPrefix
          end

          user_id = pre..":"..suf
        end
      else
        if not Config.RemovePrefix then
          user_id = Config.IdentifierPrefix..":"..identifier
        end
      end

      local slot = NewSlot(user_id,identifier)
      local multi_id = slot..":"..user_id

      ExecuteSql("INSERT INTO multichar SET identifier=@identifier,slot=@slot,firstname=@firstname,lastname=@lastname,nationality=@nationality,dob=@dob,gender=@gender",{
        ['@identifier']   = user_id,
        ['@slot']         = slot,
        ['@firstname']    = user.firstname,
        ['@lastname']     = user.lastname,
        ['@nationality']  = "UNKNOWN",
        ['@dob']          = user.dateofbirth,
        ['@gender']       = (user.sex == "m" and "Male" or "Female")
      })

      ExecuteSql(string.format("UPDATE %s SET %s=@set WHERE %s=@was",user_table.table,user_table.column,user_table.column),{
        ['@set'] = multi_id,
        ['@was'] = identifier
      })
    end
  end

  print("Registered "..#users.." multicharacters from old user data.")

  for _,query in ipairs(other_tables) do
    print("Converting "..query.table.." sql table.")
    local data = GetSql(string.format("SELECT * FROM %s",query.table),{})
    for i,user in ipairs(data) do
      local identifier = user[query.column]
      local user_id

      if identifier then
        local st,fn = identifier:find(":")
        if st and fn then
          local pre = identifier:sub(1,st-1)
          local suf = identifier:sub(fn+1)

          if Config.RemovePrefix then
            user_id = suf
          else
            if pre:find("Char") then
              pre = Config.IdentifierPrefix
            end

            if not pre:find(Config.IdentifierPrefix) then
              pre = Config.IdentifierPrefix
            end

            user_id = pre..":"..suf
          end
        else
          if not Config.RemovePrefix then
            user_id = Config.IdentifierPrefix..":"..identifier
          end
        end

        local slot = GetSlot(user_id,identifier)
        local multi_id = slot..":"..user_id       

        ExecuteSql(string.format("UPDATE %s SET %s=@set WHERE %s=@was",query.table,query.column,query.column),{
          ['@set'] = multi_id,
          ['@was'] = identifier
        })
      end
    end
    print("Conversion for "..query.table.." sql table complete ("..#data.." rows effected).")
  end

  print("Multichar conversion complete. It is now safe to restart your server.")
end,true)