local Menu = require("ui/widget/menu")
local Screen = require("device").screen
local TAGS_TITLE = "Tags"

local TagBrowser = Menu:extend{
    tag_book_map = nil,
    width = Screen:getWidth(),
    height = Screen:getHeight(),
    no_title = false,
    parent = nil,
    is_borderless = true
}

function TagBrowser:setMenuEntries(tag_book_map)
    self.tag_book_map = tag_book_map
    self.paths = {}
    self:_showTagsRoot()
end

function TagBrowser:onReturn()

    local removed = table.remove(self.paths)
    local next = self.paths[#self.paths]

    if (next == nil) then
        self:_showTagsRoot()
        do return end
    end

    self:_onItemClicked(next)
end

function TagBrowser:_showTagsRoot()
    local rows = self:_buildItemRows(self.tag_book_map)
    self:switchItemTable(TAGS_TITLE, rows)
end

local function getTableCount(table)
    if type(table) ~= "table" then do return 0 end end

    local t = table or {}
    local count = 0
    for k, v in pairs(t) do count = count + 1 end
    return count
end

function TagBrowser:_buildItemRows(tag_book_map)
    local rows = {}
    for k, v in pairs(tag_book_map) do
        local children = getTableCount(v)
        local txt = k
        if children > 0 then
            txt = k .. " (" .. children .. ")"
        end

        table.insert(rows, {
            text = txt,
            callback = function() self:_onItemClicked(k) end
        })
    end

    return rows
end

function TagBrowser:_onItemClicked(item)
    -- item is tag string
    if type(item) ~= "string" then error("item must be string") end

    if type(self.tag_book_map[item]) == "table" then
        table.insert(self.paths, item)
        local rows = self:_buildItemRows(self.tag_book_map[item])
        self:switchItemTable(item, rows)
    end
end

return TagBrowser
