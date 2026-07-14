if SERVER then
    util.AddNetworkString("ZB_SetTitle")
    util.AddNetworkString("ZB_TitleUpdated")

    net.Receive("ZB_SetTitle", function(len, ply)
        if not ply:IsAdmin() then return end
        
        local target = net.ReadEntity()
        local title = net.ReadString():sub(1, 64)
        
        if not IsValid(target) or not target:IsPlayer() then return end
        
        target:SetNWString("ZB_Title", title)
        
        -- Оповещаем всех, что титул обновлён (чтобы панельки обновились)
        net.Start("ZB_TitleUpdated")
            net.WriteEntity(target)
        net.Broadcast()
    end)
end