mainPOfilename   = "../../data/scripts/languages/polish.po"
selectedLanguage = "pl"

LoadPOFile(mainPOfilename, selectedLanguage)

io      = GLOBAL.io
assert  = GLOBAL.assert
require = GLOBAL.require

-------------------------------------------------------------------------------

-- Kopiowanie czcionek z polskimi znakami
function ApplyPolishFontsRewrite()
    local PlFontFiles = {
        "belisaplumilla100__pl.zip",
        "buttonfont__pl.zip",
        "opensans50__pl.zip",
        "stint-ucr20__pl.zip",
    }
    local PlFontFilesWithIcons = {
        "belisaplumilla50__pl.zip",        -- zmodyfikowana czcionka = dodane ikonki przyciskow Xboxa/PlayStation
        "stint-ucr50__pl.zip",
        "talkingfont__pl.zip",
        "talkingfont_wathgrithr__pl.zip",
    }

    local function copyfile(source,dest)
        local f = assert(io.open(source,"rb"))
        local content = f:read("*all")
        f:close()
        f = assert(io.open(dest,"w"))
        f:write(content)
        f:close()
    end

    for _,FileName in ipairs(PlFontFiles) do
        local orig =  FileName:gsub("__pl", "")
        copyfile(MODROOT.."fonts/common/"..FileName, "fonts/"..orig)
    end

    CONTROLLER = GetModConfigData("CONTROLLER") or "xbox"
    for _,FileName in ipairs(PlFontFilesWithIcons) do
        local orig =  FileName:gsub("__pl", "")
        copyfile(MODROOT.."fonts/"..CONTROLLER.."/"..FileName, "fonts/"..orig)
    end
end
ApplyPolishFontsRewrite()

-------------------------------------------------------------------------------

local STRINGS_NEW = GLOBAL.LanguageTranslator.languages[selectedLanguage] or {}

-- TEST czy znaczki dzialaja, tekst wyswietlany zaraz po odpaleniu gry
STRINGS_NEW["STRINGS.UI.MAINSCREEN.MODDETAIL"] = "Ą Ć Ę Ł Ń Ó Ś Ź Ż ą ć ę ł ń ó ś ź ż ".."\n\n"
--                                                 .."\127 \128 \129 \130 \131 \132 \133 \134 \135 \136 \137 \138 \139".."\n"
--                                                 .."\140 \141 \142 \143 \144 \145 \146 \147 \148 \149 \150 \254 \255".."\n\n"
                                                 ..STRINGS_NEW["STRINGS.UI.MAINSCREEN.MODDETAIL"]

local from = {"Ą", "Ć", "Ę", "Ł", "Ń", "Ó", "Ś", "Ź", "Ż",
              "ą", "ć", "ę", "ł", "ń", "ó", "ś", "ź", "ż",
              "–", "„", "”"}
local to   = { "\193", "\199", "\201", "\204", "\209", "\211", "\200", "\210", "\192",
               "\225", "\231", "\233", "\236", "\241", "\243", "\232", "\242", "\224",
               "-", "\"", "\"" }
assert(#from == #to)

function fixPolishLetters(s)
    for i=1,#from do
        s = s:gsub(from[i], to[i])
    end
    return s
end

-- Dostosowanie kodowania polskich znakow pod przygotowana czcionke
function fixPolishPhrases()
    for i,v in pairs(STRINGS_NEW) do
        STRINGS_NEW[i] = fixPolishLetters(v)
    end
end
fixPolishPhrases()
