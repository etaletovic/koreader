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


function TagBrowser:_buildItemRows(tag_book_map)
    local rows = {}
    for _, item in pairs(tag_book_map) do
        table.insert(rows, {
            text = item.text or "",
            callback = function() self:_onItemClicked(item) end
        })
    end

    return rows
end

function TagBrowser:_onItemClicked(item)

    print("Item clicked:", item)

    if(type(item) =="table") then
        for k, v in pairs(item) do
            print(k,v)
        end
    end

    if type(self.tag_book_map[item]) == "table" then
        table.insert(self.paths, item)
        local rows = self:_buildItemRows(self.tag_book_map[item])

        for k, v in pairs(rows) do
            print(k,v)
        end


        self:switchItemTable(item, rows)
    end
end

return TagBrowser
