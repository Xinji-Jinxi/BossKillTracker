local BossKillTracker = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0")

-- Localized database table
local db
-- Table of manually tracked bosses for older content
local trackedBosses = {
    -- Ragefire Chasm
    ["oggleflint"] = true, -- Ragefire Chasm
    ["taragaman the hungerer"] = true, -- Ragefire Chasm
    ["jergosh the invoker"] = true, -- Ragefire Chasm
    ["bazzalan"] = true, -- Ragefire Chasm

    -- The Deadmines
    ["rhahk'zor"] = true, -- The Deadmines
    ["sneed"] = true, -- The Deadmines
    ["gilnid"] = true, -- The Deadmines
    ["mr. smite"] = true, -- The Deadmines
    ["captain greenskin"] = true, -- The Deadmines
    ["edwin vancleef"] = true, -- The Deadmines
    ["cookie"] = true, -- The Deadmines

    -- Wailing Caverns
    ["lady anacondra"] = true, -- Wailing Caverns
    ["lord cobrahn"] = true, -- Wailing Caverns
    ["kresh"] = true, -- Wailing Caverns
    ["lord pythas"] = true, -- Wailing Caverns
    ["skum"] = true, -- Wailing Caverns
    ["lord serpentis"] = true, -- Wailing Caverns
    ["verdan the everliving"] = true, -- Wailing Caverns
    ["mutanus the devourer"] = true, -- Wailing Caverns

    -- Shadowfang Keep
    ["rethilgore"] = true, -- Shadowfang Keep
    ["razorclaw the butcher"] = true, -- Shadowfang Keep
    ["baron silverlaine"] = true, -- Shadowfang Keep
    ["commander springvale"] = true, -- Shadowfang Keep
    ["odo the blindwatcher"] = true, -- Shadowfang Keep
    ["fenrus the devourer"] = true, -- Shadowfang Keep
    ["arugal's voidwalker"] = true, -- Shadowfang Keep
    ["wolf master nandos"] = true, -- Shadowfang Keep
    ["archmage arugal"] = true, -- Shadowfang Keep

    -- Blackfathom Deeps
    ["ghamoo-ra"] = true, -- Blackfathom Deeps
    ["lady sarevess"] = true, -- Blackfathom Deeps
    ["gelihast"] = true, -- Blackfathom Deeps
    ["lorgus jett"] = true, -- Blackfathom Deeps
    ["baron aquanis"] = true, -- Blackfathom Deeps
    ["twilight lord kelris"] = true, -- Blackfathom Deeps
    ["aku'mai"] = true, -- Blackfathom Deeps

    -- The Stockade
    ["targorr the dread"] = true, -- The Stockade
    ["kam deepfury"] = true, -- The Stockade
    ["hamhock"] = true, -- The Stockade
    ["bazil thredd"] = true, -- The Stockade
    ["dextren ward"] = true, -- The Stockade
    ["bruegal ironknuckle"] = true, -- The Stockade

    -- Gnomeregan
    ["grubbis"] = true, -- Gnomeregan
    ["viscous fallout"] = true, -- Gnomeregan
    ["electrocutioner 6000"] = true, -- Gnomeregan
    ["crowd pummeler 9-60"] = true, -- Gnomeregan
    ["dark iron ambassador"] = true, -- Gnomeregan
    ["mekgineer thermaplugg"] = true, -- Gnomeregan

    -- Razorfen Kraul
    ["roogug"] = true, -- Razorfen Kraul
    ["aggem thorncurse"] = true, -- Razorfen Kraul
    ["death speaker jargba"] = true, -- Razorfen Kraul
    ["overlord ramtusk"] = true, -- Razorfen Kraul
    ["agathelos the raging"] = true, -- Razorfen Kraul
    ["blind hunter"] = true, -- Razorfen Kraul
    ["charlga razorflank"] = true, -- Razorfen Kraul
	
    -- The Crescent Grove
    ["grovetender engryss"] = true, -- The Crescent Grove
    ["keeper ranathos"] = true, -- The Crescent Grove
    ["high priestess a'lathea"] = true, -- The Crescent Grove
    ["fenektis the deceiver"] = true, -- The Crescent Grove
    ["master raxxieth"] = true, -- The Crescent Grove

    -- Scarlet Monastery
    ["interrogator vishas"] = true, -- Scarlet Monastery
    ["bloodmage thalnos"] = true, -- Scarlet Monastery
    ["houndmaster loksey"] = true, -- Scarlet Monastery
    ["arcanist doan"] = true, -- Scarlet Monastery
    ["herod"] = true, -- Scarlet Monastery
    ["high inquisitor fairbanks"] = true, -- Scarlet Monastery
    ["scarlet commander mograine"] = true, -- Scarlet Monastery
    ["high inquisitor whitemane"] = true, -- Scarlet Monastery

    -- Razorfen Downs
    ["tuten'kash"] = true, -- Razorfen Downs
    ["mordresh fire eye"] = true, -- Razorfen Downs
    ["glutton"] = true, -- Razorfen Downs
    ["ragglesnout"] = true, -- Razorfen Downs
    ["amnennar the coldbringer"] = true, -- Razorfen Downs
	
	-- Uldaman
    ["revelosh"] = true, -- Uldaman
    ["ironaya"] = true, -- Uldaman
    ["obsidian sentinel"] = true, -- Uldaman
    ["ancient stone keeper"] = true, -- Uldaman
    ["galgann firehammer"] = true, -- Uldaman
    ["grimlok"] = true, -- Uldaman
    ["archaedas"] = true, -- Uldaman
	
	-- Gilneas City
    ["matthias holtz"] = true, -- Gilneas City
    ["packmaster ragetooth"] = true, -- Gilneas City
    ["judge sutherland"] = true, -- Gilneas City
    ["dustivan blackcowl"] = true, -- Gilneas City
    ["marshal magnus greystone"] = true, -- Gilneas City
    ["horsemaster levvin"] = true, -- Gilneas City
    ["genn greymane"] = true, -- Gilneas City


    -- Zul'Farrak
    ["antu'sul"] = true, -- Zul'Farrak
    ["theka the martyr"] = true, -- Zul'Farrak
    ["witch doctor zum'rah"] = true, -- Zul'Farrak
    ["nekrum gutchewer"] = true, -- Zul'Farrak
    ["shadowpriest sezz'ziz"] = true, -- Zul'Farrak
    ["chief ukorz sandscalp"] = true, -- Zul'Farrak
    ["gahz'rilla"] = true, -- Zul'Farrak
    ["hydromancer velratha"] = true, -- Zul'Farrak
    ["sergeant bly"] = true, -- Zul'Farrak

    -- Maraudon
    ["noxxion"] = true, -- Maraudon
    ["razorlash"] = true, -- Maraudon
    ["tinkerer gizlock"] = true, -- Maraudon
    ["lord vyletongue"] = true, -- Maraudon
    ["celebras the cursed"] = true, -- Maraudon
    ["landslide"] = true, -- Maraudon
    ["rotgrip"] = true, -- Maraudon
    ["princess theradras"] = true, -- Maraudon

    -- Temple of Atal'Hakkar (Sunken Temple)
    ["avatar of hakkar"] = true, -- Temple of Atal'Hakkar
    ["jammal'an the prophet"] = true, -- Temple of Atal'Hakkar
    ["morphaz"] = true, -- Temple of Atal'Hakkar
    ["hazzas"] = true, -- Temple of Atal'Hakkar
    ["shade of eranikus"] = true, -- Temple of Atal'Hakkar
	
    -- Hateforge Quarry
    ["high foreman bargul blackhammer"] = true, -- Hateforge Quarry
    ["engineer figgles"] = true, -- Hateforge Quarry
    ["corrosis"] = true, -- Hateforge Quarry
    ["hatereaver annihilator"] = true, -- Hateforge Quarry
    ["hargesh doomcaller"] = true, -- Hateforge Quarry
	
    -- Karazhan Crypt
    ["marrowspike"] = true, -- Karazhan Crypt
    ["hivaxxis"] = true, -- Karazhan Crypt
    ["corpsemuncher"] = true, -- Karazhan Crypt
    ["guard captain gort"] = true, -- Karazhan Crypt
    ["archlich enkhraz"] = true, -- Karazhan Crypt
    ["commander andreon"] = true, -- Karazhan Crypt
    ["alarus"] = true, -- Karazhan Crypt
	
    -- Caverns of Time: Black Morass
    ["chronar"] = true, -- Black Morass
    ["epidamu"] = true, -- Black Morass
    ["drifting avatar of time"] = true, -- Black Morass
    ["time-lord epochronos"] = true, -- Black Morass
    ["mossheart"] = true, -- Black Morass
    ["rotmaw"] = true, -- Black Morass
    ["antnormi"] = true, -- Black Morass

    -- Blackrock Depths
    ["high interrogator gerstahn"] = true, -- Blackrock Depths
    ["lord roccor"] = true, -- Blackrock Depths
    ["houndmaster grebmar"] = true, -- Blackrock Depths
    ["pyromancer loregrain"] = true, -- Blackrock Depths
    ["lord incendius"] = true, -- Blackrock Depths
    ["fineous darkvire"] = true, -- Blackrock Depths
    ["bael'gar"] = true, -- Blackrock Depths
    ["general angerforge"] = true, -- Blackrock Depths
    ["golem lord argelmach"] = true, -- Blackrock Depths
    ["hurley blackbreath"] = true, -- Blackrock Depths
    ["phalanx"] = true, -- Blackrock Depths
    ["ambassador flamelash"] = true, -- Blackrock Depths
    ["magmus"] = true, -- Blackrock Depths
    ["emperor dagran thaurissan"] = true, -- Blackrock Depths

    -- Lower Blackrock Spire
    ["highlord omokk"] = true, -- Lower Blackrock Spire
    ["shadow hunter vosh'gajin"] = true, -- Lower Blackrock Spire
    ["war master voone"] = true, -- Lower Blackrock Spire
    ["mother smolderweb"] = true, -- Lower Blackrock Spire
    ["quartermaster zigris"] = true, -- Lower Blackrock Spire
    ["halycon"] = true, -- Lower Blackrock Spire
    ["gizrul the slavener"] = true, -- Lower Blackrock Spire
    ["overlord wyrmthalak"] = true, -- Lower Blackrock Spire

    -- Upper Blackrock Spire
    ["pyroguard emberseer"] = true, -- Upper Blackrock Spire
    ["solakar flamewreath"] = true, -- Upper Blackrock Spire
    ["jed runewatcher"] = true, -- Upper Blackrock Spire
    ["goraluk anvilcrack"] = true, -- Upper Blackrock Spire
    ["warchief rend blackhand"] = true, -- Upper Blackrock Spire
    ["the beast"] = true, -- Upper Blackrock Spire
    ["general drakkisath"] = true, -- Upper Blackrock Spire

    -- Dire Maul
    ["zevrim thornhoof"] = true, -- Dire Maul
    ["hydrospawn"] = true, -- Dire Maul
    ["lethtendris"] = true, -- Dire Maul
    ["alzzin the wildshaper"] = true, -- Dire Maul
    ["tendris warpwood"] = true, -- Dire Maul
    ["illyanna ravenoak"] = true, -- Dire Maul
    ["magister kalendris"] = true, -- Dire Maul
    ["immol'thar"] = true, -- Dire Maul
    ["prince tortheldrin"] = true, -- Dire Maul

    -- Stratholme
    ["hearthsinger forresten"] = true, -- Stratholme
    ["timmy the cruel"] = true, -- Stratholme
    ["malor the zealous"] = true, -- Stratholme
    ["cannon master willey"] = true, -- Stratholme
    ["archivist galford"] = true, -- Stratholme
    ["balnazzar"] = true, -- Stratholme
    ["baroness anastari"] = true, -- Stratholme
    ["nerub'enkan"] = true, -- Stratholme
    ["maleki the pallid"] = true, -- Stratholme
    ["ramstein the gorger"] = true, -- Stratholme
    ["lord aurius rivendare"] = true, -- Stratholme

    -- Scholomance
    ["kirtonos the herald"] = true, -- Scholomance
    ["jandice barov"] = true, -- Scholomance
    ["rattlegore"] = true, -- Scholomance
    ["vectus"] = true, -- Scholomance
    ["ras frostwhisper"] = true, -- Scholomance
    ["darkmaster gandling"] = true, -- Scholomance
	
	    -- Molten Core
    ["lucifron"] = true, -- Molten Core
    ["magmadar"] = true, -- Molten Core
    ["gehennas"] = true, -- Molten Core
    ["garr"] = true, -- Molten Core
    ["shazzrah"] = true, -- Molten Core
    ["baron geddon"] = true, -- Molten Core
    ["sulfuron harbinger"] = true, -- Molten Core
    ["golemagg the incinerator"] = true, -- Molten Core
    ["majordomo executus"] = true, -- Molten Core
    ["ragnaros"] = true, -- Molten Core

    -- Onyxia's Lair
    ["onyxia"] = true, -- Onyxia's Lair

    -- Blackwing Lair
    ["razorgore the untamed"] = true, -- Blackwing Lair
    ["vaelastrasz the corrupt"] = true, -- Blackwing Lair
    ["broodlord lashlayer"] = true, -- Blackwing Lair
    ["firemaw"] = true, -- Blackwing Lair
    ["ebonroc"] = true, -- Blackwing Lair
    ["flamegor"] = true, -- Blackwing Lair
    ["chromaggus"] = true, -- Blackwing Lair
    ["nefarian"] = true, -- Blackwing Lair

    -- Zul'Gurub
    ["high priestess jeklik"] = true, -- Zul'Gurub
    ["high priest venoxis"] = true, -- Zul'Gurub
    ["high priestess mar'li"] = true, -- Zul'Gurub
    ["bloodlord mandokir"] = true, -- Zul'Gurub
    ["gahz'ranka"] = true, -- Zul'Gurub
    ["high priest thekal"] = true, -- Zul'Gurub
    ["high priestess arlokk"] = true, -- Zul'Gurub
    ["jin'do the hexxer"] = true, -- Zul'Gurub
    ["hakkar the soulflayer"] = true, -- Zul'Gurub

    -- Ruins of Ahn'Qiraj
    ["kurinnaxx"] = true, -- Ruins of Ahn'Qiraj
    ["general rajaxx"] = true, -- Ruins of Ahn'Qiraj
    ["moam"] = true, -- Ruins of Ahn'Qiraj
    ["buru the gorger"] = true, -- Ruins of Ahn'Qiraj
    ["ayamiss the hunter"] = true, -- Ruins of Ahn'Qiraj
    ["ossirian the unscarred"] = true, -- Ruins of Ahn'Qiraj

    -- Temple of Ahn'Qiraj
    ["the prophet skeram"] = true, -- Temple of Ahn'Qiraj
    ["lord kri"] = true, -- Temple of Ahn'Qiraj
    ["princess yauj"] = true, -- Temple of Ahn'Qiraj
    ["vem"] = true, -- Temple of Ahn'Qiraj
    ["battleguard sartura"] = true, -- Temple of Ahn'Qiraj
    ["fankriss the unyielding"] = true, -- Temple of Ahn'Qiraj
    ["viscidus"] = true, -- Temple of Ahn'Qiraj
    ["princess huhuran"] = true, -- Temple of Ahn'Qiraj
    ["emperor vek'lor"] = true, -- Temple of Ahn'Qiraj
    ["emperor vek'nilash"] = true, -- Temple of Ahn'Qiraj
    ["ouro"] = true, -- Temple of Ahn'Qiraj
    ["c'thun"] = true, -- Temple of Ahn'Qiraj

    -- Naxxramas
    ["anub'rekhan"] = true, -- Naxxramas
    ["grand widow faerlina"] = true, -- Naxxramas
    ["maexxna"] = true, -- Naxxramas
    ["noth the plaguebringer"] = true, -- Naxxramas
    ["heigan the unclean"] = true, -- Naxxramas
    ["loatheb"] = true, -- Naxxramas
    ["instructor razuvious"] = true, -- Naxxramas
    ["gothik the harvester"] = true, -- Naxxramas
    ["thane korth'azz"] = true, -- Naxxramas
    ["lady blaumeux"] = true, -- Naxxramas
    ["sir zeliek"] = true, -- Naxxramas
    ["baron rivendare"] = true, -- Naxxramas
    ["patchwerk"] = true, -- Naxxramas
    ["grobbulus"] = true, -- Naxxramas
    ["gluth"] = true, -- Naxxramas
    ["thaddius"] = true, -- Naxxramas
    ["sapphiron"] = true, -- Naxxramas
    ["kel'thuzad"] = true, -- Naxxramas

    -- Emerald Sanctum (Turtle WoW)
    ["erennius"] = true, -- Emerald Sanctum
    ["solnius"] = true, -- Emerald Sanctum

    -- Lower Karazhan Halls (Turtle WoW)
    ["master blacksmith rolfen"] = true, -- Lower Karazhan Halls
	["brood queen araxxna"] = true, -- Lower Karazhan Halls
	["grizikil"] = true, -- Lower Karazhan Halls
	["clawlord howlfang"] = true, -- Lower Karazhan Halls
	["lord blackwald ii"] = true, -- Lower Karazhan Halls
    ["moroes"] = true, -- Lower Karazhan Halls
}
function BossKillTracker:OnInitialize()
    if not BossKillTrackerDB then
        BossKillTrackerDB = {}
    end
    db = BossKillTrackerDB

    if not db.records then
        db.records = {}
    end

    self:RegisterChatCommand({"/tbk", "/TotalBossKill"}, function(input)
        self:HandleKillCountQuery(input)
    end)
end

function BossKillTracker:OnEnable()
    self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
    self:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS")
end

function BossKillTracker:CHAT_MSG_COMBAT_HOSTILE_DEATH(msg)
    local bossName = string.match(msg, "^(.-) dies%.$")
    bossName = self:normalize(bossName)
    if bossName and trackedBosses[bossName] then
        self:LogKill(nil, bossName)
    end
end

function BossKillTracker:CHAT_MSG_COMBAT_SELF_HITS(msg)
    local bossName = string.match(msg, "^You have slain (.-)!$")
    bossName = self:normalize(bossName)
    if bossName and trackedBosses[bossName] then
        self:LogKill(nil, bossName)
    end
end

function BossKillTracker:LogKill(encounterID, name)
    name = self:normalize(name)
    if type(db.records[name]) ~= "number" then
        db.records[name] = 0
    end
    db.records[name] = db.records[name] + 1
    local currentKills = db.records[name]
    self:Print(string.format("%s slain! %d kills", self:capitalizeWords(name), currentKills))
end

function BossKillTracker:HandleKillCountQuery(input)
    local bossName = self:trim(input)
    bossName = self:normalize(bossName)

    if bossName == "" then
        self:Print("Usage: /tbk <Boss Name>")
        return
    end

    if not trackedBosses[bossName] then
        self:Print(string.format("'%s' is not a tracked boss.", bossName))
        return
    end

    local count = tonumber(db.records[bossName]) or 0
    local displayName = self:capitalizeWords(bossName)
    self:Print(string.format("You have killed %s %d time(s).", displayName, count))
end

function BossKillTracker:trim(s)
    if type(s) ~= "string" then
        return ""
    end
    return string.gsub(s, "^%s*(.-)%s*$", "%1")
end

function BossKillTracker:normalize(name)
    if type(name) ~= "string" then
        return ""
    end
    return string.lower(self:trim(name))
end

function BossKillTracker:capitalizeWords(name)
    -- Ensure the input is a valid string
    if type(name) ~= "string" or name == "" then
        return "Unknown" -- Fallback for invalid or empty inputs
    end

    -- Split the name manually and capitalize each word
    local words = {}
    for word in string.gfind(name, "[^%s]+") do -- Use string.gfind for WoW 1.12 compatibility
        local first = string.sub(word, 1, 1)
        local rest = string.sub(word, 2)
        local capitalized = (first and string.upper(first) or "") .. (rest and string.lower(rest) or "")
        table.insert(words, capitalized)
    end

    -- Rejoin the words into a single string
    return table.concat(words, " ")
end

