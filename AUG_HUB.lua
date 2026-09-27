--[[
                            AUG HUB PROJECT
            This was made by AUG Hub Team
            No Key System — Free Version
            Copyright © 2022-2026 AUG Hub Team - All Rights Reserved.
]]--

local Directory = "https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/Games"
local Scripts = {
    Free = {
        [994732206] = Directory .. "/BloxFruits.lua",
        [9186719164] = Directory .. "/SailorPiece.lua",
        [8191429227] = Directory .. "/CutTrees.lua",
    },
}

local STOCK_LOADER_URL = "https://api.luarmor.net/files/v4/loaders/0ae9fe4cf963e3a13d25eed0e2ce5940.lua"

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local GameId = game.GameId

local function Notify(title, desc, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title or "AUG HUB",
            Text = desc or "",
            Duration = duration or 5,
        })
    end)
end

local function LoadScript()
    local url = Scripts.Free[GameId]
    if url then
        Notify("AUG HUB", "Loading free script...", 3)
        local ok, err = pcall(function()
            loadstring(game:HttpGet(url))()
        end)
        if not ok then
            warn("[AUG HUB] Failed to load free script: " .. tostring(err))
            Notify("AUG HUB", "Script load failed. Trying fallback...", 5)
            pcall(function()
                loadstring(game:HttpGet(STOCK_LOADER_URL))()
            end)
        else
            Notify("AUG HUB", "Script loaded successfully!", 4)
        end
    else
        warn("[AUG HUB] No free script for GameId: " .. tostring(GameId) .. " — using fallback loader")
        Notify("AUG HUB", "No free script for this game. Loading fallback...", 5)
        pcall(function()
            loadstring(game:HttpGet(STOCK_LOADER_URL))()
        end)
    end
end

LoadScript()
