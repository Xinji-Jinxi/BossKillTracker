local BossKillTracker = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0")

-- Localized database table
local db
local activeEncounters = {} -- Table to track active encounters by name or encounterID

-- Table of manually tracked bosses for older content
local trackedBosses = {
    -- Ragefire Chasm
    ["Oggleflint"] = true, -- Ragefire Chasm
    ["Taragaman the Hungerer"] = true, -- Ragefire Chasm
    ["Jergosh the Invoker"] = true, -- Ragefire Chasm
    ["Bazzalan"] = true, -- Ragefire Chasm

    -- The Deadmines
    ["Rhahk'Zor"] = true, -- The Deadmines
    ["Sneed"] = true, -- The Deadmines
    ["Gilnid"] = true, -- The Deadmines
    ["Mr. Smite"] = true, -- The Deadmines
    ["Captain Greenskin"] = true, -- The Deadmines
    ["Edwin VanCleef"] = true, -- The Deadmines
    ["Cookie"] = true, -- The Deadmines

    -- Wailing Caverns
    ["Lady Anacondra"] = true, -- Wailing Caverns
    ["Lord Cobrahn"] = true, -- Wailing Caverns
    ["Kresh"] = true, -- Wailing Caverns
    ["Lord Pythas"] = true, -- Wailing Caverns
    ["Skum"] = true, -- Wailing Caverns
    ["Lord Serpentis"] = true, -- Wailing Caverns
    ["Verdan the Everliving"] = true, -- Wailing Caverns
    ["Mutanus the Devourer"] = true, -- Wailing Caverns

    -- Shadowfang Keep
    ["Rethilgore"] = true, -- Shadowfang Keep
    ["Razorclaw the Butcher"] = true, -- Shadowfang Keep
    ["Baron Silverlaine"] = true, -- Shadowfang Keep
    ["Commander Springvale"] = true, -- Shadowfang Keep
    ["Odo the Blindwatcher"] = true, -- Shadowfang Keep
    ["Fenrus the Devourer"] = true, -- Shadowfang Keep
    ["Arugal's Voidwalker"] = true, -- Shadowfang Keep
    ["Wolf Master Nandos"] = true, -- Shadowfang Keep
    ["Archmage Arugal"] = true, -- Shadowfang Keep

    -- Blackfathom Deeps
    ["Ghamoo-ra"] = true, -- Blackfathom Deeps
    ["Lady Sarevess"] = true, -- Blackfathom Deeps
    ["Gelihast"] = true, -- Blackfathom Deeps
    ["Lorgus Jett"] = true, -- Blackfathom Deeps
    ["Baron Aquanis"] = true, -- Blackfathom Deeps
    ["Twilight Lord Kelris"] = true, -- Blackfathom Deeps
    ["Aku'mai"] = true, -- Blackfathom Deeps

    -- The Stockade
    ["Targorr the Dread"] = true, -- The Stockade
    ["Kam Deepfury"] = true, -- The Stockade
    ["Hamhock"] = true, -- The Stockade
    ["Bazil Thredd"] = true, -- The Stockade
    ["Dextren Ward"] = true, -- The Stockade
    ["Bruegal Ironknuckle"] = true, -- The Stockade

    -- Gnomeregan
    ["Grubbis"] = true, -- Gnomeregan
    ["Viscous Fallout"] = true, -- Gnomeregan
    ["Electrocutioner 6000"] = true, -- Gnomeregan
    ["Crowd Pummeler 9-60"] = true, -- Gnomeregan
    ["Dark Iron Ambassador"] = true, -- Gnomeregan
    ["Mekgineer Thermaplugg"] = true, -- Gnomeregan

    -- Razorfen Kraul
    ["Roogug"] = true, -- Razorfen Kraul
    ["Aggem Thorncurse"] = true, -- Razorfen Kraul
    ["Death Speaker Jargba"] = true, -- Razorfen Kraul
    ["Overlord Ramtusk"] = true, -- Razorfen Kraul
    ["Agathelos the Raging"] = true, -- Razorfen Kraul
    ["Blind Hunter"] = true, -- Razorfen Kraul
    ["Charlga Razorflank"] = true, -- Razorfen Kraul
	
    -- The Crescent Grove
    ["Grovetender Engryss"] = true, -- The Crescent Grove
    ["Keeper Ranathos"] = true, -- The Crescent Grove
    ["High Priestess A'lathea"] = true, -- The Crescent Grove
    ["Fenektis the Deceiver"] = true, -- The Crescent Grove
    ["Master Raxxieth"] = true, -- The Crescent Grove

    -- Scarlet Monastery
    ["Interrogator Vishas"] = true, -- Scarlet Monastery
    ["Bloodmage Thalnos"] = true, -- Scarlet Monastery
    ["Houndmaster Loksey"] = true, -- Scarlet Monastery
    ["Arcanist Doan"] = true, -- Scarlet Monastery
    ["Herod"] = true, -- Scarlet Monastery
    ["High Inquisitor Fairbanks"] = true, -- Scarlet Monastery
    ["Scarlet Commander Mograine"] = true, -- Scarlet Monastery
    ["High Inquisitor Whitemane"] = true, -- Scarlet Monastery

    -- Razorfen Downs
    ["Tuten'kash"] = true, -- Razorfen Downs
    ["Mordresh Fire Eye"] = true, -- Razorfen Downs
    ["Glutton"] = true, -- Razorfen Downs
    ["Ragglesnout"] = true, -- Razorfen Downs
    ["Amnennar the Coldbringer"] = true, -- Razorfen Downs
	
	-- Uldaman
    ["Revelosh"] = true, -- Uldaman
    ["Ironaya"] = true, -- Uldaman
    ["Obsidian Sentinel"] = true, -- Uldaman
    ["Ancient Stone Keeper"] = true, -- Uldaman
    ["Galgann Firehammer"] = true, -- Uldaman
    ["Grimlok"] = true, -- Uldaman
    ["Archaedas"] = true, -- Uldaman
	
	-- Gilneas City
    ["Matthias Holtz"] = true, -- Gilneas City
    ["Packmaster Ragetooth"] = true, -- Gilneas City
    ["Judge Sutherland"] = true, -- Gilneas City
    ["Dustivan Blackcowl"] = true, -- Gilneas City
    ["Marshal Magnus Greystone"] = true, -- Gilneas City
    ["Horsemaster Levvin"] = true, -- Gilneas City
    ["Genn Greymane"] = true, -- Gilneas City


    -- Zul'Farrak
    ["Antu'sul"] = true, -- Zul'Farrak
    ["Theka the Martyr"] = true, -- Zul'Farrak
    ["Witch Doctor Zum'rah"] = true, -- Zul'Farrak
    ["Nekrum Gutchewer"] = true, -- Zul'Farrak
    ["Shadowpriest Sezz'ziz"] = true, -- Zul'Farrak
    ["Chief Ukorz Sandscalp"] = true, -- Zul'Farrak
    ["Gahz'rilla"] = true, -- Zul'Farrak
    ["Hydromancer Velratha"] = true, -- Zul'Farrak
    ["Sergeant Bly"] = true, -- Zul'Farrak

    -- Maraudon
    ["Noxxion"] = true, -- Maraudon
    ["Razorlash"] = true, -- Maraudon
    ["Tinkerer Gizlock"] = true, -- Maraudon
    ["Lord Vyletongue"] = true, -- Maraudon
    ["Celebras the Cursed"] = true, -- Maraudon
    ["Landslide"] = true, -- Maraudon
    ["Rotgrip"] = true, -- Maraudon
    ["Princess Theradras"] = true, -- Maraudon

    -- Temple of Atal'Hakkar (Sunken Temple)
    ["Avatar of Hakkar"] = true, -- Temple of Atal'Hakkar
    ["Jammal'an the Prophet"] = true, -- Temple of Atal'Hakkar
    ["Morphaz"] = true, -- Temple of Atal'Hakkar
    ["Hazzas"] = true, -- Temple of Atal'Hakkar
    ["Shade of Eranikus"] = true, -- Temple of Atal'Hakkar
	
    -- Hateforge Quarry
    ["High Foreman Bargul Blackhammer"] = true, -- Hateforge Quarry
    ["Engineer Figgles"] = true, -- Hateforge Quarry
    ["Corrosis"] = true, -- Hateforge Quarry
    ["Hatereaver Annihilator"] = true, -- Hateforge Quarry
    ["Hargesh Doomcaller"] = true, -- Hateforge Quarry
	
    -- Karazhan Crypt
    ["Marrowspike"] = true, -- Karazhan Crypt
    ["Hivaxxis"] = true, -- Karazhan Crypt
    ["Corpsemuncher"] = true, -- Karazhan Crypt
    ["Guard Captain Gort"] = true, -- Karazhan Crypt
    ["Archlich Enkhraz"] = true, -- Karazhan Crypt
    ["Commander Andreon"] = true, -- Karazhan Crypt
    ["Alarus"] = true, -- Karazhan Crypt
	
    -- Caverns of Time: Black Morass
    ["Chronar"] = true, -- Black Morass
    ["Epidamu"] = true, -- Black Morass
    ["Drifting Avatar of Time"] = true, -- Black Morass
    ["Time-Lord Epochronos"] = true, -- Black Morass
    ["Mossheart"] = true, -- Black Morass
    ["Rotmaw"] = true, -- Black Morass
    ["Antnormi"] = true, -- Black Morass

    -- Blackrock Depths
    ["High Interrogator Gerstahn"] = true, -- Blackrock Depths
    ["Lord Roccor"] = true, -- Blackrock Depths
    ["Houndmaster Grebmar"] = true, -- Blackrock Depths
    ["Pyromancer Loregrain"] = true, -- Blackrock Depths
    ["Lord Incendius"] = true, -- Blackrock Depths
    ["Fineous Darkvire"] = true, -- Blackrock Depths
    ["Bael'Gar"] = true, -- Blackrock Depths
    ["General Angerforge"] = true, -- Blackrock Depths
    ["Golem Lord Argelmach"] = true, -- Blackrock Depths
    ["Hurley Blackbreath"] = true, -- Blackrock Depths
    ["Phalanx"] = true, -- Blackrock Depths
    ["Ambassador Flamelash"] = true, -- Blackrock Depths
    ["Magmus"] = true, -- Blackrock Depths
    ["Emperor Dagran Thaurissan"] = true, -- Blackrock Depths

    -- Lower Blackrock Spire
    ["Highlord Omokk"] = true, -- Lower Blackrock Spire
    ["Shadow Hunter Vosh'gajin"] = true, -- Lower Blackrock Spire
    ["War Master Voone"] = true, -- Lower Blackrock Spire
    ["Mother Smolderweb"] = true, -- Lower Blackrock Spire
    ["Quartermaster Zigris"] = true, -- Lower Blackrock Spire
    ["Halycon"] = true, -- Lower Blackrock Spire
    ["Gizrul the Slavener"] = true, -- Lower Blackrock Spire
    ["Overlord Wyrmthalak"] = true, -- Lower Blackrock Spire

    -- Upper Blackrock Spire
    ["Pyroguard Emberseer"] = true, -- Upper Blackrock Spire
    ["Solakar Flamewreath"] = true, -- Upper Blackrock Spire
    ["Jed Runewatcher"] = true, -- Upper Blackrock Spire
    ["Goraluk Anvilcrack"] = true, -- Upper Blackrock Spire
    ["Warchief Rend Blackhand"] = true, -- Upper Blackrock Spire
    ["The Beast"] = true, -- Upper Blackrock Spire
    ["General Drakkisath"] = true, -- Upper Blackrock Spire

    -- Dire Maul
    ["Zevrim Thornhoof"] = true, -- Dire Maul
    ["Hydrospawn"] = true, -- Dire Maul
    ["Lethtendris"] = true, -- Dire Maul
    ["Alzzin the Wildshaper"] = true, -- Dire Maul
    ["Tendris Warpwood"] = true, -- Dire Maul
    ["Illyanna Ravenoak"] = true, -- Dire Maul
    ["Magister Kalendris"] = true, -- Dire Maul
    ["Immol'thar"] = true, -- Dire Maul
    ["Prince Tortheldrin"] = true, -- Dire Maul

    -- Stratholme
    ["Hearthsinger Forresten"] = true, -- Stratholme
    ["Timmy the Cruel"] = true, -- Stratholme
    ["Malor the Zealous"] = true, -- Stratholme
    ["Cannon Master Willey"] = true, -- Stratholme
    ["Archivist Galford"] = true, -- Stratholme
    ["Balnazzar"] = true, -- Stratholme
    ["Baroness Anastari"] = true, -- Stratholme
    ["Nerub'enkan"] = true, -- Stratholme
    ["Maleki the Pallid"] = true, -- Stratholme
    ["Ramstein the Gorger"] = true, -- Stratholme
    ["Lord Aurius Rivendare"] = true, -- Stratholme

    -- Scholomance
    ["Kirtonos the Herald"] = true, -- Scholomance
    ["Jandice Barov"] = true, -- Scholomance
    ["Rattlegore"] = true, -- Scholomance
    ["Vectus"] = true, -- Scholomance
    ["Ras Frostwhisper"] = true, -- Scholomance
    ["Darkmaster Gandling"] = true, -- Scholomance
	
	    -- Molten Core
    ["Lucifron"] = true, -- Molten Core
    ["Magmadar"] = true, -- Molten Core
    ["Gehennas"] = true, -- Molten Core
    ["Garr"] = true, -- Molten Core
    ["Shazzrah"] = true, -- Molten Core
    ["Baron Geddon"] = true, -- Molten Core
    ["Sulfuron Harbinger"] = true, -- Molten Core
    ["Golemagg the Incinerator"] = true, -- Molten Core
    ["Majordomo Executus"] = true, -- Molten Core
    ["Ragnaros"] = true, -- Molten Core

    -- Onyxia's Lair
    ["Onyxia"] = true, -- Onyxia's Lair

    -- Blackwing Lair
    ["Razorgore the Untamed"] = true, -- Blackwing Lair
    ["Vaelastrasz the Corrupt"] = true, -- Blackwing Lair
    ["Broodlord Lashlayer"] = true, -- Blackwing Lair
    ["Firemaw"] = true, -- Blackwing Lair
    ["Ebonroc"] = true, -- Blackwing Lair
    ["Flamegor"] = true, -- Blackwing Lair
    ["Chromaggus"] = true, -- Blackwing Lair
    ["Nefarian"] = true, -- Blackwing Lair

    -- Zul'Gurub
    ["High Priestess Jeklik"] = true, -- Zul'Gurub
    ["High Priest Venoxis"] = true, -- Zul'Gurub
    ["High Priestess Mar'li"] = true, -- Zul'Gurub
    ["Bloodlord Mandokir"] = true, -- Zul'Gurub
    ["Gahz'ranka"] = true, -- Zul'Gurub
    ["High Priest Thekal"] = true, -- Zul'Gurub
    ["High Priestess Arlokk"] = true, -- Zul'Gurub
    ["Jin'do the Hexxer"] = true, -- Zul'Gurub
    ["Hakkar the Soulflayer"] = true, -- Zul'Gurub

    -- Ruins of Ahn'Qiraj
    ["Kurinnaxx"] = true, -- Ruins of Ahn'Qiraj
    ["General Rajaxx"] = true, -- Ruins of Ahn'Qiraj
    ["Moam"] = true, -- Ruins of Ahn'Qiraj
    ["Buru the Gorger"] = true, -- Ruins of Ahn'Qiraj
    ["Ayamiss the Hunter"] = true, -- Ruins of Ahn'Qiraj
    ["Ossirian the Unscarred"] = true, -- Ruins of Ahn'Qiraj

    -- Temple of Ahn'Qiraj
    ["The Prophet Skeram"] = true, -- Temple of Ahn'Qiraj
    ["Lord Kri"] = true, -- Temple of Ahn'Qiraj
    ["Princess Yauj"] = true, -- Temple of Ahn'Qiraj
    ["Vem"] = true, -- Temple of Ahn'Qiraj
    ["Battleguard Sartura"] = true, -- Temple of Ahn'Qiraj
    ["Fankriss the Unyielding"] = true, -- Temple of Ahn'Qiraj
    ["Viscidus"] = true, -- Temple of Ahn'Qiraj
    ["Princess Huhuran"] = true, -- Temple of Ahn'Qiraj
    ["Emperor Vek'lor"] = true, -- Temple of Ahn'Qiraj
    ["Emperor Vek'nilash"] = true, -- Temple of Ahn'Qiraj
    ["Ouro"] = true, -- Temple of Ahn'Qiraj
    ["C'Thun"] = true, -- Temple of Ahn'Qiraj

    -- Naxxramas
    ["Anub'Rekhan"] = true, -- Naxxramas
    ["Grand Widow Faerlina"] = true, -- Naxxramas
    ["Maexxna"] = true, -- Naxxramas
    ["Noth the Plaguebringer"] = true, -- Naxxramas
    ["Heigan the Unclean"] = true, -- Naxxramas
    ["Loatheb"] = true, -- Naxxramas
    ["Instructor Razuvious"] = true, -- Naxxramas
    ["Gothik the Harvester"] = true, -- Naxxramas
    ["Thane Korth'azz"] = true, -- Naxxramas
    ["Lady Blaumeux"] = true, -- Naxxramas
    ["Sir Zeliek"] = true, -- Naxxramas
    ["Baron Rivendare"] = true, -- Naxxramas
    ["Patchwerk"] = true, -- Naxxramas
    ["Grobbulus"] = true, -- Naxxramas
    ["Gluth"] = true, -- Naxxramas
    ["Thaddius"] = true, -- Naxxramas
    ["Sapphiron"] = true, -- Naxxramas
    ["Kel'Thuzad"] = true, -- Naxxramas

    -- Emerald Sanctum (Turtle WoW)
    ["Erennius"] = true, -- Emerald Sanctum
    ["Solnius"] = true, -- Emerald Sanctum

    -- Lower Karazhan Halls (Turtle WoW)
	["Master Blacksmith Rolfen"] = true, -- Lower Karazhan Halls
	["Brood Queen Araxxna"] = true, -- Lower Karazhan Halls
	["Grizikil"] = true, -- Lower Karazhan Halls
	["Clawlord Howlfang"] = true, -- Lower Karazhan Halls
	["Lord Blackwald II"] = true, -- Lower Karazhan Halls
    ["Moroes"] = true, -- Lower Karazhan Halls
}

function BossKillTracker:OnInitialize()
    -- Initialize saved variables
    if not BossKillTrackerDB then
        BossKillTrackerDB = {}
    end
    db = BossKillTrackerDB

    -- Ensure a default structure exists for saved data
    if not db.records then
        db.records = {}
    end

    -- Register slash commands
    self:RegisterChatCommand({"/tbk", "/TotalBossKill"}, function(input)
        self:HandleKillCountQuery(input)
    end)
end

function BossKillTracker:OnEnable()
    -- Register events
    self:RegisterEvent("ENCOUNTER_END")
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("PLAYER_TARGET_CHANGED")
end

function BossKillTracker:ENCOUNTER_END(encounterID, name, _, _, success)
    if success == 1 then
        self:LogKill(encounterID, name)
    end
end

function BossKillTracker:COMBAT_LOG_EVENT_UNFILTERED(_, event, _, _, _, _, _, destGUID, destName)
    if event == "UNIT_DIED" and destName and trackedBosses[destName] then
        self:LogKill(nil, destName)
    end
end

function BossKillTracker:PLAYER_TARGET_CHANGED()
    local targetName = UnitName("target")
    if not targetName or not trackedBosses[targetName] then return end

    -- Check if the target is dead and the kill has already been logged
    if UnitIsDead("target") and activeEncounters[targetName] then return end

    -- If the target is dead and not logged, log the kill
    if UnitIsDead("target") then
        self:LogKill(nil, targetName)
    end
end

function BossKillTracker:LogKill(encounterID, name)
    if not name then return end

    -- Deduplicate using activeEncounters
    if activeEncounters[name] then return end

    -- Mark this encounter as logged
    activeEncounters[name] = true

    -- Initialize the record for the boss if it doesn't exist
    if not db.records[name] then
        db.records[name] = {
            name = name,
            killCount = 0
        }
    end

    -- Increment the kill count
    db.records[name].killCount = db.records[name].killCount + 1

    -- Log to chat
    self:SendMessageToChat(name, db.records[name].killCount)
end

function BossKillTracker:SendMessageToChat(name, killCount)
    -- Print kill count to the chat window
    DEFAULT_CHAT_FRAME:AddMessage(string.format("%s: %d kills.", name, killCount), 1.0, 1.0, 0.0)
end

function BossKillTracker:HandleKillCountQuery(input)
    -- Trim and validate the input
    local bossName = input and strtrim(input)
    if not bossName or bossName == "" then
        DEFAULT_CHAT_FRAME:AddMessage("Please specify a boss name.", 1.0, 0.0, 0.0)
        return
    end

    -- Check if the boss is tracked
    if not trackedBosses[bossName] then
        DEFAULT_CHAT_FRAME:AddMessage(string.format("%s is not a recognized boss name.", bossName), 1.0, 0.0, 0.0)
        return
    end

    -- Fetch the kill count
    local record = db.records[bossName]
    local killCount = record and record.killCount or 0
    DEFAULT_CHAT_FRAME:AddMessage(string.format("%s: %d kills.", bossName, killCount), 0.0, 1.0, 0.0)
end