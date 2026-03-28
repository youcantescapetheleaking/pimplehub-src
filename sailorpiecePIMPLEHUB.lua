local _dead = false
local _hs = game:GetService('HttpService');
local Lighting = game:GetService('Lighting');
local WS = game:GetService('Workspace');
local HttpService = game:GetService('HttpService');
local TweenService = game:GetService('TweenService');
local RS = game:GetService('ReplicatedStorage');
local VirtualUser = game:GetService('VirtualUser');
local UserInputService = game:GetService('UserInputService');
local RunService = game:GetService('RunService');
local Players = game:GetService('Players');
local _hs2 = game:GetService('HttpService');
local _TS = game:GetService('TweenService');

local LP = Players.LocalPlayer

local _writefile = writefile
local _readfile = readfile
local CONFIG_FILE = "celina_sailorpiece.json"
local CONFIG_VERSION = "3.0"
local AutoSaveInterval, LastAutoSave = 10, 0
local S = {}
local fn = {}
local _lastFire = {}
local _fireMin = 0.1
fn.SafeFire = function(remote, ...)
	if _dead or not remote then
		return
	end
	local id = tostring(remote)
	local now = tick()
	if _lastFire[id] and now - _lastFire[id] < _fireMin then
		return
	end
	_lastFire[id] = now
	pcall(remote.FireServer, remote, ...)
end
local R = {
	TP = { "Remotes", "TeleportToPortal" },
	QuestAccept = { "RemoteEvents", "QuestAccept" },
	QuestAbandon = { "RemoteEvents", "QuestAbandon" },
	UseItem = { "Remotes", "UseItem" },
	Hit = { "CombatSystem", "Remotes", "RequestHit" },
	Ability = { "AbilitySystem", "Remotes", "RequestAbility" },
	Merchant = { "Remotes", "MerchantRemotes", "PurchaseMerchantItem" },
	Settings = { "RemoteEvents", "SettingsToggle" },
	QuestRepeat = { "RemoteEvents", "QuestRepeat" },
	SummonBoss = { "Remotes", "RequestSummonBoss" },
	AtomicSpawn = { "RemoteEvents", "RequestSpawnAtomic" },
	AutoSpawnAtomic = { "RemoteEvents", "RequestAutoSpawnAtomic" },
	AnosBoss = { "Remotes", "RequestSpawnAnosBoss" },
	StrongestBoss = { "Remotes", "RequestSpawnStrongestBoss" },
	AutoSpawnBoss = { "Remotes", "RequestAutoSpawn" },
	AutoSpawnAnos = { "Remotes", "RequestAutoSpawnAnos" },
	AutoSpawnStrongest = { "Remotes", "RequestAutoSpawnStrongest" },
	SlimeCraft = { "Remotes", "RequestSlimeCraft" },
	RimuruSpawn = { "RemoteEvents", "RequestSpawnRimuru" },
	AutoSpawnRimuru = { "RemoteEvents", "RequestAutoSpawnRimuru" },
	TrueAizenSpawn = { "RemoteEvents", "RequestSpawnTrueAizen" },
	AutoSpawnTrueAizen = { "RemoteEvents", "RequestAutoSpawnTrueAizen" },
	DungeonVote = { "Remotes", "DungeonWaveVote" },
	DungeonPortal = { "Remotes", "RequestDungeonPortal" },
	AllocateStat = { "RemoteEvents", "AllocateStat" },
	SkillTreeUpgrade = { "RemoteEvents", "SkillTreeUpgrade" },
}
local F = {
	AutoFarmLevel = false,
	AutoDungeon = false,
	AutoBossRush = false,
	AutoInfiniteTower = false,
	HeightOffset = 15,
	TweenSpeed = 100,
	RuneHeight = 10,
	RuneSpeed = 50,
	RuneMove = "Teleport",
	RuneDiff = "Normal",
	CidHeight = 10,
	CidSpeed = 50,
	CidMove = "Teleport",
	CidDiff = "Normal",
	DoubleHeight = 10,
	DoubleSpeed = 50,
	DoubleMove = "Teleport",
	DoubleDiff = "Normal",
	BossRushTweenSpeed = 50,
	TowerHeightOffset = 10,
	TowerTweenSpeed = 50,
	TowerFarmMode = "Behind",
	TowerMoveMode = "Teleport",
	TowerFollowStyle = "Dodge",
	AntiAFK = true,
	AutoEquip = true,
	AutoEquipWeapon = "",
	AutoQuest = true,
	AutoSpawn = false,
	SelectedIsland = "Auto",
	SkillZ = false,
	SkillX = false,
	SkillC = false,
	SkillV = false,
	SkillF = false,
	SkillCooldown = 3.0,
	SkillMode = "Normal",
	BossEnabled = false,
	GilgameshDiff = "Normal",
	BlessedMaidenDiff = "Normal",
	SaberAlterDiff = "Normal",
	RimuruDiff = "Normal",
	AnosDiff = "Normal",
	StrongestTodayDiff = "Normal",
	TrueAizenDiff = "Normal",
	StrongestHistoryDiff = "Normal",
	AutoChest = false,
	FarmMode = "Behind",
	BossRushFarmMode = "Behind",
	BossRushMoveMode = "Teleport",
	MoveMode = "Tween",
	OffsetDist = 15,
	AutoMerchant = false,
	MerchNotify = true,
	DungeonQuest = false,
	HogyokuQuest = false,
	DungeonType = "Rune",
	BossNotify = true,
	FollowStyle = "Dodge",
	AutoSaveEnabled = true,
	BossRushDiff = "Medium",
	AutoArmHaki = false,
	AutoObsHaki = false,
	AutoConqHaki = false,
	AtomicDiff = "Normal",
	FollowPlayer = false,
	FollowPlayerName = "",
	FollowPlayerMode = "Behind",
	FollowPlayerMove = "Tween",
	FollowPlayerDist = 10,
	FollowPlayerSpeed = 100,
	AutoStats = false,
	StatMelee = 0,
	StatDefense = 0,
	StatSword = 0,
	StatPower = 0,
	StatInterval = 1,
	SmartStats = false,
	SmartStatBuild = "Sword Build",
	SmartStatBatch = 1,
	SmartStatInterval = 1,
	CustomMelee = 25,
	CustomDefense = 25,
	CustomSword = 25,
	CustomPower = 25,
	Optimize = false,
	RemoveTrees = false,
	RemoveCrops = false,
	AutoSkillTree = false,
	SkillTreeDamage = true,
	SkillTreeHP = true,
	SkillTreeCritCh = true,
	SkillTreeCritDmg = true,
	SkillTreeLuck = true,
	SkillTreeInterval = 0.5,
	SkillTreePriority = "Balanced",
	AutoBRShop = false,
	AutoTowerShop = false,
	BRShop_Damage = true,
	BRShop_HP = true,
	BRShop_CritChance = true,
	BRShop_CritDamage = true,
	BRShop_Luck = true,
	ITShop_Damage = true,
	ITShop_HP = true,
	ITShop_CritChance = true,
	ITShop_CritDamage = true,
	ITShop_Luck = true,
	BRLvl_Damage = 0,
	BRLvl_HP = 0,
	BRLvl_CritChance = 0,
	BRLvl_CritDamage = 0,
	BRLvl_Luck = 0,
	ITLvl_Damage = 0,
	ITLvl_HP = 0,
	ITLvl_CritChance = 0,
	ITLvl_CritDamage = 0,
	ITLvl_Luck = 0,
	KillAura = false,
	KillAuraCD = 0.12,
	KillAuraRange = 200,
	KillAuraHP = 50,
	AntiKnockback = false,
	CustomWalkSpeed = false,
	WalkSpeedValue = 16,
	CustomJumpPower = false,
	JumpPowerValue = 50,
	Noclip = false,
	FPSBoost = false,
	FPSBoostAF = false,
	LimitFPS = false,
	LimitFPSValue = 60,
	AutoTitle = false,
	AutoTitleMode = "Best EXP",
	AutoTitleBoss = "Best DMG",
	AutoTitleGamemode = "Best DMG",
	AutoRune = false,
	AutoRuneMob = "None",
	AutoRuneBoss = "None",
	AutoRuneGamemode = "None",
	AutoAura = false,
	AutoAuraMob = "None",
	AutoAuraBoss = "None",
	AutoAuraGamemode = "None",
	AutoCosmetic = false,
	AutoCosmeticMob = "None",
	AutoCosmeticBoss = "None",
	AutoCosmeticGamemode = "None",
	AutoAccessory = false,
	AutoAccessoryMob = "None",
	AutoAccessoryBoss = "None",
	AutoAccessoryGamemode = "None",
	AutoReplay = false,
	PityBossEnabled = false,
	PityUseDiff = "Normal",
}
local SaveableKeys = {
	"AutoFarmLevel",
	"AutoDungeon",
	"AutoBossRush",
	"AutoInfiniteTower",
	"HeightOffset",
	"TweenSpeed",
	"AntiAFK",
	"AutoEquip",
	"AutoEquipWeapon",
	"AutoQuest",
	"AutoSpawn",
	"SelectedIsland",
	"SkillZ",
	"SkillX",
	"SkillC",
	"SkillV",
	"SkillF",
	"SkillCooldown",
	"SkillMode",
	"BossEnabled",
	"GilgameshDiff",
	"BlessedMaidenDiff",
	"SaberAlterDiff",
	"RimuruDiff",
	"AnosDiff",
	"StrongestTodayDiff",
	"TrueAizenDiff",
	"StrongestHistoryDiff",
	"AutoChest",
	"FarmMode",
	"BossRushFarmMode",
	"BossRushMoveMode",
	"MoveMode",
	"OffsetDist",
	"AutoMerchant",
	"MerchNotify",
	"DungeonQuest",
	"HogyokuQuest",
	"DungeonType",
	"BossNotify",
	"FollowStyle",
	"RuneDiff",
	"CidDiff",
	"DoubleDiff",
	"RuneHeight",
	"RuneSpeed",
	"RuneMove",
	"CidHeight",
	"CidSpeed",
	"CidMove",
	"DoubleHeight",
	"DoubleSpeed",
	"DoubleMove",
	"BossRushTweenSpeed",
	"BossRushDiff",
	"AutoArmHaki",
	"AutoObsHaki",
	"AutoConqHaki",
	"AtomicDiff",
	"TowerHeightOffset",
	"TowerTweenSpeed",
	"TowerFarmMode",
	"TowerMoveMode",
	"TowerFollowStyle",
	"AutoSaveEnabled",
	"FollowPlayer",
	"FollowPlayerName",
	"FollowPlayerMode",
	"FollowPlayerMove",
	"FollowPlayerDist",
	"FollowPlayerSpeed",
	"AutoStats",
	"StatMelee",
	"StatDefense",
	"StatSword",
	"StatPower",
	"StatInterval",
	"SmartStats",
	"SmartStatBuild",
	"SmartStatBatch",
	"SmartStatInterval",
	"CustomMelee",
	"CustomDefense",
	"CustomSword",
	"CustomPower",
	"Optimize",
	"RemoveTrees",
	"RemoveCrops",
	"AutoSkillTree",
	"SkillTreeDamage",
	"SkillTreeHP",
	"SkillTreeCritCh",
	"SkillTreeCritDmg",
	"SkillTreeLuck",
	"SkillTreeInterval",
	"SkillTreePriority",
	"AutoBRShop",
	"AutoTowerShop",
	"BRShop_Damage",
	"BRShop_HP",
	"BRShop_CritChance",
	"BRShop_CritDamage",
	"BRShop_Luck",
	"ITShop_Damage",
	"ITShop_HP",
	"ITShop_CritChance",
	"ITShop_CritDamage",
	"ITShop_Luck",
	"BRLvl_Damage",
	"BRLvl_HP",
	"BRLvl_CritChance",
	"BRLvl_CritDamage",
	"BRLvl_Luck",
	"ITLvl_Damage",
	"ITLvl_HP",
	"ITLvl_CritChance",
	"ITLvl_CritDamage",
	"ITLvl_Luck",
	"KillAura",
	"KillAuraCD",
	"KillAuraRange",
	"KillAuraHP",
	"AntiKnockback",
	"CustomWalkSpeed",
	"WalkSpeedValue",
	"CustomJumpPower",
	"JumpPowerValue",
	"Noclip",
	"FPSBoost",
	"FPSBoostAF",
	"LimitFPS",
	"LimitFPSValue",
	"AutoTitle",
	"AutoTitleMode",
	"AutoTitleBoss",
	"AutoTitleGamemode",
	"AutoRune",
	"AutoRuneMob",
	"AutoRuneBoss",
	"AutoRuneGamemode",
	"AutoAura",
	"AutoAuraMob",
	"AutoAuraBoss",
	"AutoAuraGamemode",
	"AutoCosmetic",
	"AutoCosmeticMob",
	"AutoCosmeticBoss",
	"AutoCosmeticGamemode",
	"AutoAccessory",
	"AutoAccessoryMob",
	"AutoAccessoryBoss",
	"AutoAccessoryGamemode",
	"AutoReplay",
	"PityBossEnabled",
	"PityUseDiff",
	"PityBuildBosses",
	"PityUseBoss",
}

local function SaveConfig()
	if not _writefile then
		return false
	end
	local data = { version = CONFIG_VERSION, timestamp = os.time(), settings = {} }
	for _, k in ipairs(SaveableKeys) do
		local v = F[k]
		if v ~= nil then
			data.settings[k] = v
		end
	end
	return pcall(function()
		_writefile(CONFIG_FILE, HttpService:JSONEncode(data))
	end)
end

local function LoadConfig()
	if not _readfile then
		return false
	end
	local s, r = pcall(function()
		return HttpService:JSONDecode(_readfile(CONFIG_FILE))
	end)
	if not s or not r or not r.settings then
		return false
	end
	for k, v in pairs(r.settings or {}) do
		if F[k] ~= nil and type(v) == type(F[k]) then
			F[k] = v
		end
	end
	if F.AutoFarmLevel and F.FollowPlayer then
		F.FollowPlayer = false
	end
	return true
end
S.ICON = "rbxthumb://type=AvatarHeadShot&id=583572860&w=420&h=420"
S.DISCORD = "https://discord.gg/vsEjjqvpK5"
S.NPC_FOLDER = "NPCs"
S.BOSS_ISLAND_PORTAL = "Boss"
S.ANOS_ISLAND = "Academy"
S.FARM_MAX_DIST_FROM_PLAYER = 900
S.FARM_MAX_DIST_FROM_ORIGIN = 1200
S.GENERIC_HOSTILE_MAX_DIST = 900
S.Islands = {
	{ Portal = "Starter", FarmUntil = 250, Enemies = { "Thief" }, QuestNPC = "QuestNPC1" },
	{ Portal = "Jungle", FarmUntil = 750, Enemies = { "Monkey" }, QuestNPC = "QuestNPC3" },
	{ Portal = "Desert", FarmUntil = 1500, Enemies = { "DesertBandit" }, QuestNPC = "QuestNPC5" },
	{ Portal = "Snow", FarmUntil = 3000, Enemies = { "Swordsman", "FrostRogue" }, QuestNPC = "QuestNPC7" },
	{ Portal = "Shibuya", FarmUntil = 5000, Enemies = { "Sorcerer", "Curse" }, QuestNPC = "QuestNPC9" },
	{ Portal = "HollowIsland", FarmUntil = 6250, Enemies = { "Hollow", "Quincy" }, QuestNPC = "QuestNPC11" },
	{ Portal = "Shinjuku", FarmUntil = 8000, Enemies = { "StrongSorcerer" }, QuestNPC = "QuestNPC12" },
	{ Portal = "Slime", FarmUntil = 9000, Enemies = { "Slime" }, QuestNPC = "QuestNPC14" },
	{ Portal = "Academy", FarmUntil = 10000, Enemies = { "AcademyTeacher" }, QuestNPC = "QuestNPC15" },
	{ Portal = "Judgement", FarmUntil = 10750, Enemies = { "Swordsman" }, QuestNPC = "QuestNPC16" },
	{
		Portal = "SoulSociety",
		FarmUntil = 11500,
		Enemies = { "Quincy1", "Quincy2", "Quincy3", "Quincy4", "Quincy5" },
		QuestNPC = "QuestNPC17",
	},
	{
		Portal = "Ninja",
		FarmUntil = 12000,
		Enemies = { "Ninja1", "Ninja2", "Ninja3", "Ninja4", "Ninja5" },
		QuestNPC = "QuestNPC18",
	},
	{
		Portal = "Lawless",
		FarmUntil = 999999,
		Enemies = { "ArenaFighter1", "ArenaFighter2", "ArenaFighter3", "ArenaFighter4", "ArenaFighter5" },
		QuestNPC = "QuestNPC19",
	},
}
for _, isl in ipairs(S.Islands) do
	isl._enemyLo = {}
	isl._enemyLoNorm = {}
	for _, e in ipairs(isl.Enemies) do
		local el = (e or ""):lower()
		table.insert(isl._enemyLo, el)
		table.insert(isl._enemyLoNorm, (el:gsub("[%s%p_]", "")))
	end
end
S.TpIslands = {
	"Starter",
	"Jungle",
	"Desert",
	"Snow",
	"Sailor",
	"Shibuya",
	"HollowIsland",
	"Boss",
	"Dungeon",
	"Shinjuku",
	"Slime",
	"Academy",
	"Judgement",
	"SoulSociety",
	"Ninja",
	"Lawless",
	"Tower",
}
S.PortalDisplayNames = {
	HollowIsland = "Hallow Island",
	SoulSociety = "Soul Dominion",
	Ninja = "Ninja Island",
	Lawless = "Lawless",
	Tower = "Tower Island",
}
S.Bosses = {
	{ Name = "AizenBoss", Display = "Aizen", Island = "HollowIsland" },
	{ Name = "AlucardBoss", Display = "Alucard", Island = "Sailor" },
	{ Name = "GojoBoss", Display = "Gojo", Island = "Shibuya", RenderNear = "YujiBoss" },
	{ Name = "JinwooBoss", Display = "Jinwoo", Island = "Sailor" },
	{ Name = "StrongestShinobiBoss", Display = "Strongest Shinobi", Island = "Ninja" },
	{ Name = "SukunaBoss", Display = "Sukuna", Island = "Shibuya" },
	{ Name = "YamatoBoss", Display = "Yamato", Island = "Judgement" },
	{ Name = "YujiBoss", Display = "Yuji", Island = "Shibuya" },
}
S.SummonBosses = {
	{ Name = "IchigoBoss", Display = "Ichigo" },
	{ Name = "QinShiBoss", Display = "Qin Shi" },
	{ Name = "SaberBoss", Display = "Saber" },
	{
		Name = "AtomicBoss",
		Display = "Atomic",
		Island = "Lawless",
		Difficulties = { "Normal", "Medium", "Hard", "Extreme" },
	},
	{
		Name = "AnosBoss",
		Display = "Anos",
		Island = "Academy",
		Difficulties = { "Normal", "Medium", "Hard", "Extreme" },
	},
	{
		Name = "BlessedMaidenBoss",
		Display = "Blessed Maiden",
		Difficulties = { "Normal", "Medium", "Hard", "Extreme" },
	},
	{ Name = "GilgameshBoss", Display = "Gilgamesh", Difficulties = { "Normal", "Medium", "Hard", "Extreme" } },
	{
		Name = "RimuruBoss",
		Display = "Rimuru",
		Island = "Slime",
		Difficulties = { "Normal", "Medium", "Hard", "Extreme" },
	},
	{ Name = "SaberAlterBoss", Display = "Saber Alter", Difficulties = { "Normal", "Medium", "Hard", "Extreme" } },
	{
		Name = "StrongestHistoryBoss",
		Display = "Strongest in History",
		Island = "Shinjuku",
		Difficulties = { "Normal", "Medium", "Hard", "Extreme" },
	},
	{
		Name = "StrongestTodayBoss",
		Display = "Strongest Today",
		Island = "Shinjuku",
		Difficulties = { "Normal", "Medium", "Hard", "Extreme" },
	},
	{
		Name = "TrueAizenBoss",
		Display = "True Aizen",
		Island = "SoulSociety",
		Difficulties = { "Normal", "Medium", "Hard", "Extreme" },
	},
}
S.DungeonEnemyNames = { "DungeonNPC1", "DungeonNPC2", "DungeonNPC3", "DungeonNPC4", "DungeonNPC5" }
S.TowerEnemyNames = {
	"DungeonNPC1",
	"DungeonNPC2",
	"DungeonNPC3",
	"DungeonNPC4",
	"DungeonNPC5",
	"DungeonNPC6",
	"DungeonNPC7",
	"DungeonNPC8",
	"DungeonNPC9",
	"DungeonNPC10",
	"DungeonNPC11",
	"DungeonNPC12",
}
S.DungeonEnemySet = {}
for _, n in ipairs(S.DungeonEnemyNames) do
	S.DungeonEnemySet[(n or ""):lower()] = true
end
S.TowerEnemySet = {}
for _, n in ipairs(S.TowerEnemyNames) do
	S.TowerEnemySet[(n or ""):lower()] = true
end
S.DungeonTypes = { "Double", "Rune", "Cid" }
S.DungeonBossMap =
	{ Rune = {}, Cid = { ["shadowboss"] = true }, Double = { ["shadowmonarchboss"] = true, ["shadowboss"] = true } }
S.DungeonDifficulties = { "Easy", "Normal", "Hard", "Extreme" }
S.DungeonPortalNames = { Double = "DoubleDungeon", Rune = "RuneDungeon", Cid = "CidDungeon" }
S.AutoJoinDungeon = {}
S.AutoJoinFired = {}
S.AutoJoinBossRush = false
S.AutoJoinBossRushFired = false
S.WasInGamemode = false
S.LastAutoStart = 0
S.IgnoreList = {
	"groupreward",
	"katana",
	"buyer",
	"madoka",
	"training",
	"dummy",
	"merchant",
	"shop",
	"vendor",
	"shadow questline",
	"shadowmonarch",
	"obshakilsinhead",
	"buff",
	"questnpc",
}
S.ChestNames = {
	"Common Chest",
	"Rare Chest",
	"Epic Chest",
	"Legendary Chest",
	"Mythical Chest",
	"Secret Chest",
	"Aura Crate",
	"Cosmetic Crate",
}
S.MerchantItems =
	{ "Boss Key", "Clan Reroll", "Dungeon Key", "Haki Color Reroll", "Race Reroll", "Rush Key", "Trait Reroll" }
S.BossIsland = {}
S.AllBossNames = {}
S.BossDisplay = {}
S.BossRenderNear = {}
for _, b in ipairs(S.Bosses) do
	S.BossIsland[b.Name] = b.Island
	S.AllBossNames[b.Name] = true
	S.BossDisplay[b.Name] = b.Display
	if b.RenderNear then
		S.BossRenderNear[b.Name] = b.RenderNear
	end
end
S.BossSharedSpawn = { AlucardBoss = "Sailor_Shared", JinwooBoss = "Sailor_Shared" }
S.BF = {}
for _, b in ipairs(S.Bosses) do
	S.BF[b.Name] = false
end
S.BSF = {}
S.BSFToggle = {}
for _, b in ipairs(S.SummonBosses) do
	S.BSF[b.Name] = false
end
S.SummonBossDisplay = {}
for _, b in ipairs(S.SummonBosses) do
	S.SummonBossDisplay[b.Name] = b.Display
end
S.FM = {}
for _, item in ipairs(S.MerchantItems) do
	S.FM[item] = false
end
S.FC = {}
for _, chest in ipairs(S.ChestNames) do
	S.FC[chest] = true
end
do
	local allBR = {}
	for _, b in ipairs(S.Bosses) do
		allBR[b.Name:lower()] = true
	end
	for _, b in ipairs(S.SummonBosses) do
		allBR[b.Name:lower()] = true
	end
	allBR["ragnaboss"] = true
	allBR["trueaizenboss"] = true
	allBR["madokaboss"] = true
	allBR["escanorboss"] = true
	allBR["strongestoftoday"] = true
	allBR["strongestinhistory"] = true
	allBR["strongesttoday"] = true
	allBR["strongesthistory"] = true
	S.BossRushEnemySet = allBR
end
S.Hub = nil
S.Notify = nil
S.Win = nil
S.CfgMgr = nil
S.FarmToggle = nil
S.BossToggle = nil
S.FarmKeybind = nil
S.BossKeybind = nil
S.DungeonKeybind = nil
S.TowerKeybind = nil
S.BossRushKeybind = nil
S.SkillToggles = {}
S.SkillKeys = { "SkillZ", "SkillX", "SkillC", "SkillV", "SkillF" }
S.AllSkillsToggle = nil
S.Running = true
shared._CELINA_S = S
S.CurIsland = nil
S.CurTarget = nil
S.Conns = {}
S.LastEquip = 0
S.LastTP = 0
S.LastEnemy = 0
S.LastSkill = 0
S.LastAbilityUse = 0
S.SkillRotation = 0
S.LastChest = 0
S.LastQuestAccept = 0
S.LastMerchant = 0
S.LastStatAllocate = 0
S.CachedAbilityRemote = nil
S.CachedHitRemote = nil
S.TPCount = 0
S.TPReset = tick()
S.ConfLevel = 0
S.LastLevelScanTick = 0
S.ATween = nil
S.ATweenConn = nil
S.TweenOn = false
S.TweenTarget = nil
S.TweenPointGoal = nil
S.HumCache = setmetatable({}, { __mode = "k" })
S.CharHum = nil
S.CachedQuestAbandon = nil
S.CachedUseItem = nil
S.IslandTPd = false
S.SpawnDone = false
S.FarmOrigin = nil
S.FarmGenericMode = false
S.LockTarget = nil
S.HoverPos = nil
S.QState = "NONE"
S.BossFight = false
S.BossTargetName = nil
S.BossDeathTimes = {}
S.BossInfoP = nil
S.BossTimerCache = {}
S.BossTPDone = false
S.LastBossTP = 0
S.BossTPRetries = 0
S.BossCurrentIsland = nil
S.BossPosCache = {}
S.SummonBossFight = false
S.SummonBossTarget = nil
S.SummonBossTPDone = false
S.LastSummonBossTP = 0
S.SummonBossCommitted = {}
S.SummonBossCurrentIsland = nil
S.SummonBossOrder = 0
S.SummonBossFailCount = {}
S.SummonBossFireTime = {}
S.SummonBossLockedDiff = {}
S.AutoSpawnActive = {}
S.PityBuildBosses = {}
S.PityUseBoss = nil
S.PityLabel = nil
S._pityCached = 0
S._pityMaxCached = 25
S._pityActiveBoss = nil
S._pityLastBuild = nil
S._pitySpawnActive = nil
S._pitySummonIds = {}
do
	local ok, cfg = pcall(function()
		local mod = RS:FindFirstChild("Modules") and RS.Modules:FindFirstChild("SummonableBossConfig")
		if mod and mod:IsA("ModuleScript") then return require(mod) end
		return nil
	end)
	if ok and cfg and cfg.Bosses then
		for _, data in pairs(cfg.Bosses) do
			if data.bossId then
				S._pitySummonIds[data.bossId .. "Boss"] = data.bossId
				S._pitySummonIds[data.bossId] = data.bossId
			end
		end
	end
end
S.DungeonStep = 0
S.DungeonCollected = {}
S.LastDungeonSwitch = 0
S.BossRushAutoToggle = nil
S.LastBossRushSwitch = 0
S.LastDungeonVote = 0
S.LastBossRushVote = 0
S.DungeonPieceIslands = { "Starter", "Jungle", "Desert", "Snow", "Shibuya", "HollowIsland" }
S.HogyokuStep = 0
S.HogyokuCollected = {}
S.HogyokuFragmentIslands = { "Snow", "Shibuya", "HollowIsland", "Shinjuku", "Slime", "Judgement" }
S.RayParams = RaycastParams.new()
S.RayParams.FilterType = Enum.RaycastFilterType.Exclude
S.OverlapParams = OverlapParams.new()
S.OverlapParams.FilterType = Enum.RaycastFilterType.Exclude
S.DungeonWSCache = false
S.DungeonWSCacheTick = 0
S.LastDodge = 0
S.DodgeDir = 1
S.SummonBossIslandMap = {}
for _, b in ipairs(S.SummonBosses) do
	S.SummonBossIslandMap[b.Name] = b.Island or S.BOSS_ISLAND_PORTAL
end
fn.PortalDisplayName = function(p)
	return S.PortalDisplayNames[p] or p
end
fn.Conn = function(c)
	table.insert(S.Conns, c)
	return c
end
fn.Typing = function()
	return UserInputService:GetFocusedTextBox() ~= nil
end
fn.Jit = function(b, v)
	return b + (math.random() * v * 2 - v)
end
fn.StopTw = function()
	if S.ATweenConn then
		pcall(function()
			S.ATweenConn:Disconnect()
		end)
		S.ATweenConn = nil
	end
	if S.ATween then
		pcall(function()
			S.ATween:Cancel()
		end)
		S.ATween = nil
	end
	S.TweenOn = false
	S.TweenTarget = nil
	S.TweenPointGoal = nil
end
fn.ClearTgt = function()
	S.CurTarget = nil
	S.LockTarget = nil
	fn.StopTw()
end
fn.GetHum = function(e)
	if not e then
		return nil
	end
	local cached = S.HumCache[e]
	if cached and cached.Parent then
		return cached
	end
	if cached then
		S.HumCache[e] = nil
	end
	local h = e:FindFirstChildOfClass("Humanoid")
	if h then
		S.HumCache[e] = h
		return h
	end
	for _, d in ipairs(e:GetDescendants()) do
		if d:IsA("Humanoid") then
			S.HumCache[e] = d
			return d
		end
	end
	return nil
end
do
	local _rootCache = setmetatable({}, { __mode = "k" })
	fn.Root = function(e)
		if not e then
			return nil
		end
		local cached = _rootCache[e]
		if cached and cached.Parent then
			return cached
		end
		local h = fn.GetHum(e)
		if h and h.RootPart and h.RootPart:IsA("BasePart") then
			_rootCache[e] = h.RootPart
			return h.RootPart
		end
		local r = e:FindFirstChild("HumanoidRootPart") or e:FindFirstChild("Torso") or e:FindFirstChild("UpperTorso")
		if r and r:IsA("BasePart") then
			_rootCache[e] = r
			return r
		end
		if e:IsA("Model") and e.PrimaryPart then
			_rootCache[e] = e.PrimaryPart
			return e.PrimaryPart
		end
		for _, d in ipairs(e:GetDescendants()) do
			if d:IsA("BasePart") then
				_rootCache[e] = d
				return d
			end
		end
		return nil
	end
end
fn.ModelPos = function(e)
	if not e then
		return nil
	end
	local r = fn.Root(e)
	if r then
		return r.Position
	end
	local ok, cf = pcall(function()
		return e:GetPivot()
	end)
	if ok and cf then
		return cf.Position
	end
	if e:IsA("Model") then
		local ok2, bb = pcall(function()
			return e:GetBoundingBox()
		end)
		if ok2 and bb then
			return bb.Position
		end
	end
	return nil
end
fn.ModelCF = function(e)
	if not e then
		return nil
	end
	local r = fn.Root(e)
	if r then
		return r.CFrame
	end
	local ok, cf = pcall(function()
		return e:GetPivot()
	end)
	if ok and cf then
		return cf
	end
	return nil
end
fn.PlayerHRP = function()
	local c = LP.Character
	return c and c:FindFirstChild("HumanoidRootPart")
end
fn.DistTo = function(pos)
	if not pos then
		return 99999
	end
	local hrp = fn.PlayerHRP()
	if not hrp then
		return 99999
	end
	return (hrp.Position - pos).Magnitude
end
fn.IsAnosModel = function(name)
	return name and name:find("AnosBoss") ~= nil
end
fn.IsRimuruModel = function(name)
	return name and (name:find("RimuruBoss") ~= nil or name:find("Rimuru") ~= nil)
end
fn.IsStrongestTodayModel = function(name)
	return name and name:find("StrongestofTodayBoss") ~= nil
end
fn.IsStrongestHistoryModel = function(name)
	return name and name:find("StrongestinHistoryBoss") ~= nil
end
fn.IsTrueAizenModel = function(name)
	return name and name:find("TrueAizenBoss") ~= nil
end
fn.IsStrongestModel = function(name)
	return fn.IsStrongestTodayModel(name) or fn.IsStrongestHistoryModel(name)
end
fn.IsBoss = function(n)
	return S.AllBossNames[n] == true or fn.IsAnosModel(n) or fn.IsRimuruModel(n) or fn.IsStrongestModel(n)
end
fn.GetBossIsland = function(name)
	if S.BossIsland[name] then
		return S.BossIsland[name]
	end
	if S.SummonBossIslandMap[name] then
		return S.SummonBossIslandMap[name]
	end
	if fn.IsAnosModel(name) then
		return S.ANOS_ISLAND
	end
	return nil
end
fn.GetBossDisplay = function(name)
	if S.BossDisplay[name] then
		return S.BossDisplay[name]
	end
	if fn.IsAnosModel(name) then
		local diff = name:match("AnosBoss_(.+)")
		if diff then
			return "Anos (" .. diff .. ")"
		end
		return "Anos"
	end
	if S.SummonBossDisplay[name] then
		return S.SummonBossDisplay[name]
	end
	return name
end
fn.WalkPathWait = function(base, t, ...)
	local cur = base
	for _, seg in ipairs({ ... }) do
		if not cur then
			return nil
		end
		cur = cur:WaitForChild(seg, t)
	end
	return cur
end
fn.GetLevel = function()
	local lv = 0
	pcall(function()
		local ls = LP:FindFirstChild("leaderstats")
		if ls then
			local v = ls:FindFirstChild("Level") or ls:FindFirstChild("Lvl") or ls:FindFirstChild("LVL")
			if v then
				lv = tonumber(v.Value) or 0
			end
		end
	end)
	if lv > 0 then
		S.ConfLevel = lv
		S.LastLevelScanTick = tick()
		return lv
	end
	if S.ConfLevel > 0 and tick() - S.LastLevelScanTick < 3 then
		return S.ConfLevel
	end
	S.LastLevelScanTick = tick()
	pcall(function()
		for _, c in ipairs(LP:GetDescendants()) do
			if c:IsA("IntValue") or c:IsA("NumberValue") or c:IsA("StringValue") then
				local n = c.Name:lower()
				if n == "level" or n == "lvl" or n:find("level", 1, true) or n:find("lvl", 1, true) then
					local val = tonumber(c.Value)
					if val and val > lv then
						lv = val
					end
				end
			end
		end
	end)
	if lv > 0 then
		S.ConfLevel = lv
		return lv
	end
	pcall(function()
		local pg = LP:FindFirstChild("PlayerGui")
		if pg then
			for _, d in ipairs(pg:GetDescendants()) do
				if d:IsA("TextLabel") or d:IsA("TextButton") then
					local m = (d.Text or ""):match("Lv%.%s*(%d[%d,%.]*)")
					if m then
						m = m:gsub(",", "")
						local val = tonumber(m)
						if val and val > lv then
							lv = val
						end
					end
				end
			end
		end
	end)
	if lv > 0 then
		S.ConfLevel = lv
		return lv
	end
	return S.ConfLevel
end
fn.IslandForLevel = function(lvl)
	for _, i in ipairs(S.Islands) do
		if lvl < i.FarmUntil then
			return i
		end
	end
	return S.Islands[#S.Islands]
end
fn.IslandByName = function(n)
	for _, i in ipairs(S.Islands) do
		if i.Portal == n then
			return i
		end
	end
	return nil
end
fn.GetFarmIsland = function()
	if F.SelectedIsland ~= "Auto" then
		local isl = fn.IslandByName(F.SelectedIsland)
		if isl then
			return isl
		end
	end
	local lvl = fn.GetLevel()
	if lvl == 0 and S.ConfLevel > 0 then
		lvl = S.ConfLevel
	end
	if lvl == 0 then
		task.wait(0.5)
		lvl = fn.GetLevel()
		if lvl == 0 then
			task.wait(1)
			lvl = fn.GetLevel()
		end
		if lvl == 0 then
			return nil
		end
	end
	return fn.IslandForLevel(lvl)
end
fn.IsAlive = function()
	local c = LP.Character
	if not c then
		return false
	end
	local h = c:FindFirstChild("HumanoidRootPart")
	local hm = c:FindFirstChildOfClass("Humanoid")
	return h ~= nil and hm ~= nil and hm.Health > 0
end
fn.WaitChar = function()
	if fn.IsAlive() then
		return true
	end
	local t = tick()
	while tick() - t < 20 do
		if fn.IsAlive() then
			task.wait(0.5)
			return true
		end
		task.wait(0.15)
	end
	return false
end
do
	local _playerChars = {}
	local function _rebuildPlayerChars()
		local t = {}
		for _, p in ipairs(Players:GetPlayers()) do
			if p.Character then
				t[p.Character] = true
			end
		end
		_playerChars = t
	end
	_rebuildPlayerChars()
	Players.PlayerAdded:Connect(_rebuildPlayerChars)
	Players.PlayerRemoving:Connect(_rebuildPlayerChars)
	for _, p in ipairs(Players:GetPlayers()) do
		p.CharacterAdded:Connect(_rebuildPlayerChars)
	end
	Players.PlayerAdded:Connect(function(p)
		p.CharacterAdded:Connect(_rebuildPlayerChars)
	end)
	fn.IsPlayer = function(m)
		return _playerChars[m] == true
	end
end
fn.ShouldIgnore = function(n)
	local lo = n:lower()
	for _, ig in ipairs(S.IgnoreList) do
		if lo:find(ig, 1, true) then
			return true
		end
	end
	if lo:match("boss$") then
		return true
	end
	return false
end
fn.MatchEnemy = function(name, island)
	if not island or not island._enemyLo then
		return false
	end
	local lo = (name or ""):lower()
	for i, el in ipairs(island._enemyLo) do
		if lo:sub(1, #el) == el then
			return true
		end
		local elNorm = island._enemyLoNorm[i]
		if elNorm ~= "" then
			local loNorm = lo:gsub("[%s%p_]", "")
			if loNorm:sub(1, #elNorm) == elNorm then
				return true
			end
		end
	end
	return false
end
fn.AbandonAllQuests = function()
	S.QState = "NONE"
	if not S.CachedQuestAbandon then
		pcall(function()
			local f = RS:FindFirstChild(R.QuestAbandon[1])
			if f then
				S.CachedQuestAbandon = f:FindFirstChild(R.QuestAbandon[2])
			end
		end)
		if not S.CachedQuestAbandon then
			pcall(function()
				S.CachedQuestAbandon = fn.WalkPathWait(RS, 1, unpack(R.QuestAbandon))
			end)
		end
	end
	local ab = S.CachedQuestAbandon
	if ab then
		pcall(function()
			ab:FireServer("repeatable")
		end)
		pcall(function()
			ab:FireServer()
		end)
		for _, n in ipairs({
			"HogyokuUnlock",
			"HogyokuQuestNPC",
			"Hogyoku",
			"HogyokuFragment",
			"HogyokuQuest",
			"SoulSocietyUnlock",
			"SoulSociety",
		}) do
			pcall(function()
				ab:FireServer(n)
			end)
		end
		for _, isl in ipairs(S.Islands) do
			pcall(function()
				ab:FireServer(isl.QuestNPC)
			end)
		end
	end
end
fn.ResetAboveMode = function()
	pcall(function()
		local c = LP.Character
		if not c then
			return
		end
		local hum = c:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.PlatformStand = false
			hum.AutoRotate = true
		end
	end)
	if S._aboveBodyVel then
		pcall(function()
			S._aboveBodyVel:Destroy()
		end)
		S._aboveBodyVel = nil
	end
	S._aboveLastPos = nil
end
fn.FullReset = function()
	fn.RestoreWalkSpeed()
	fn.StopTw()
	fn.ClearTgt()
	S.HoverPos = nil
	S.LockTarget = nil
	fn.ResetAboveMode()
	S.CurIsland = nil
	S.IslandTPd = false
	S.SpawnDone = false
	S.FarmOrigin = nil
	S.LastEnemy = 0
	S.LastTP = 0
	S.TPCount = 0
	S.FarmGenericMode = false
	fn.AbandonAllQuests()
	S.LastQuestAccept = 0
	S.BossTargetName = nil
	S.BossFight = false
	S.BossTPDone = false
	S.LastBossTP = 0
	S.BossTPRetries = 0
	S.BossCurrentIsland = nil
	S.SummonBossFight = false
	S.SummonBossTarget = nil
	S.SummonBossTPDone = false
	S.LastSummonBossTP = 0
	S.SummonBossCommitted = {}
	S.SummonBossCurrentIsland = nil
	S.SummonBossOrder = 0
	S.SummonBossFailCount = {}
	S.SummonBossLockedDiff = {}
	S.HogyokuStep = 0
	S.HogyokuCollected = {}
	pcall(function()
		local c = LP.Character
		if c then
			local hm = c:FindFirstChildOfClass("Humanoid")
			if hm then
				hm.PlatformStand = false
			end
		end
	end)
end
fn.DoTP = function(portal)
	if tick() - S.LastTP < 3 then
		return false
	end
	if tick() - S.TPReset > 120 then
		S.TPCount = 0
		S.TPReset = tick()
	end
	if S.TPCount >= 10 then
		return false
	end
	S.LastTP = tick()
	S.TPCount = S.TPCount + 1
	local ok = false
	pcall(function()
		fn.WalkPathWait(RS, 3, unpack(R.TP)):FireServer(portal)
		ok = true
	end)
	return ok
end
fn.ForceTP = function(portal)
	S.LastTP = 0
	S.TPCount = 0
	S.TPReset = tick()
	S.HoverPos = nil
	S.LockTarget = nil
	S._aboveLastPos = nil
	fn.StopTw()
	if S._aboveBodyVel then
		pcall(function()
			S._aboveBodyVel:Destroy()
		end)
		S._aboveBodyVel = nil
	end
	pcall(function()
		local c = LP.Character
		if c then
			local hrp = c:FindFirstChild("HumanoidRootPart")
			local hum = c:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.PlatformStand = false
			end
			if hrp then
				hrp.Anchored = false
			end
		end
	end)
	local ok = false
	pcall(function()
		fn.WalkPathWait(RS, 5, unpack(R.TP)):FireServer(portal)
		ok = true
	end)
	if not ok then
		task.wait(1)
		pcall(function()
			fn.WalkPathWait(RS, 5, unpack(R.TP)):FireServer(portal)
			ok = true
		end)
	end
	S.LastTP = tick()
	S.TPCount = 1
	return ok
end
fn.EnableGameQuestRepeat = function()
	pcall(function()
		local r = fn.WalkPathWait(RS, 3, unpack(R.Settings))
		if not r then
			return
		end
		r:FireServer("EnableQuestRepeat", true)
		task.wait(0.05)
		r:FireServer("AutoQuestRepeat", true)
	end)
end
fn.QuestAccept = function(island)
	if not island or not island.QuestNPC then
		return
	end
	pcall(function()
		fn.WalkPathWait(RS, 3, unpack(R.QuestAccept)):FireServer(island.QuestNPC)
	end)
	S.LastQuestAccept = tick()
	S.QState = "ACTIVE"
	task.spawn(fn.EnableGameQuestRepeat)
end
fn.QuestRepeatFire = function(island)
	if not island or not island.QuestNPC then
		return
	end
	pcall(function()
		fn.WalkPathWait(RS, 3, unpack(R.QuestRepeat)):FireServer(island.QuestNPC)
	end)
	S.LastQuestAccept = tick()
	S.QState = "ACTIVE"
end
fn.QuestCompletionScan = function()
	if S.QState ~= "ACTIVE" then
		return
	end
	if tick() - S.LastQuestAccept > 60 then
		S.QState = "NONE"
		return
	end
	if tick() - S.LastQuestAccept < 8 then
		return
	end
	local pg = LP:FindFirstChild("PlayerGui")
	if not pg then
		return
	end
	local hasQuestUI = false
	for _, d in ipairs(pg:GetDescendants()) do
		if d:IsA("TextLabel") or d:IsA("TextButton") then
			local t = (d.Text or ""):lower()
			if t:find("quest complet") or t:find("abandon") then
				S.QState = "NONE"
				return
			end
			if
				t:find("%d+%s*/%s*%d+")
				or t:find("kill")
				or t:find("collect")
				or t:find("objective")
				or t:find("quest")
			then
				hasQuestUI = true
			end
		end
	end
	if not hasQuestUI and tick() - S.LastQuestAccept > 20 then
		S.QState = "NONE"
	end
end
fn.ClickYes = function()
	local pg = LP:FindFirstChild("PlayerGui")
	if not pg then
		return
	end
	for _, desc in ipairs(pg:GetDescendants()) do
		if desc:IsA("TextButton") or desc:IsA("ImageButton") then
			local txt = ""
			pcall(function()
				txt = (desc.Text or ""):lower()
			end)
			local nm = (desc.Name or ""):lower()
			if txt == "yes" or nm == "yes" or nm == "confirm" or txt == "confirm" then
				pcall(function()
					for _, conn in ipairs(getconnections(desc.Activated)) do
						conn:Fire()
					end
				end)
				pcall(function()
					for _, conn in ipairs(getconnections(desc.MouseButton1Click)) do
						conn:Fire()
					end
				end)
			end
		end
	end
end
fn.PlayerHasChest = function(name)
	local found = LP:FindFirstChild(name, true)
	if found then
		if found:IsA("IntValue") or found:IsA("NumberValue") then
			return (tonumber(found.Value) or 0) > 0
		end
		return true
	end
	local pg = LP:FindFirstChild("PlayerGui")
	if pg then
		local inv = pg:FindFirstChild("InventoryPanelUI")
		if inv then
			for _, desc in ipairs(inv:GetDescendants()) do
				if desc:IsA("ImageButton") and desc.Name == "Item_" .. name then
					return true
				end
			end
		end
	end
	return false
end
fn.SafeInvoke = function(remote, timeout, ...)
	local args = { ... }
	local done, ok, result = false, false, nil
	task.spawn(function()
		local s, r = pcall(function()
			return remote:InvokeServer(table.unpack(args))
		end)
		ok, result, done = s, r, true
	end)
	local t = tick()
	while not done and tick() - t < (timeout or 3) do
		task.wait(0.05)
	end
	return ok, result
end
fn.SuppressHasItemError = function()
	pcall(function()
		local pg = LP:FindFirstChild("PlayerGui")
		if not pg then
			return
		end
		for _, d in ipairs(pg:GetDescendants()) do
			if d:IsA("TextLabel") or d:IsA("TextButton") then
				local txt = (d.Text or ""):lower()
				if (txt:find("don") or txt:find("doesn")) and txt:find("have") then
					local p = d
					while p and not p:IsA("ScreenGui") do
						p = p.Parent
					end
					if p then
						pcall(function()
							p.Enabled = false
						end)
					end
					pcall(function()
						d.Visible = false
					end)
				end
			end
		end
	end)
end
fn.OpenAllChests = function()
	if not F.AutoChest then
		return
	end
	if not S.CachedUseItem then
		pcall(function()
			local f = RS:FindFirstChild(R.UseItem[1])
			if f then
				S.CachedUseItem = f:FindFirstChild(R.UseItem[2])
			end
		end)
		if not S.CachedUseItem then
			pcall(function()
				S.CachedUseItem = fn.WalkPathWait(RS, 1, unpack(R.UseItem))
			end)
		end
	end
	local useItem = S.CachedUseItem
	if not useItem then
		return
	end
	local isEvent = false
	pcall(function()
		isEvent = useItem:IsA("RemoteEvent")
	end)
	for _, name in ipairs(S.ChestNames) do
		if S.FC[name] and fn.PlayerHasChest(name) then
			if isEvent then
				pcall(function()
					useItem:FireServer("Use", name, 10000, false)
				end)
			else
				fn.SafeInvoke(useItem, 0.5, "Use", name, 10000, false)
			end
			task.wait(0.1)
			fn.ClickYes()
			fn.SuppressHasItemError()
		end
	end
end
fn.BuyMerchantItems = function()
	if not F.AutoMerchant then
		return
	end
	if tick() - S.LastMerchant < 1800 then
		return
	end
	S.LastMerchant = tick()
	local remote
	pcall(function()
		remote = fn.WalkPathWait(RS, 2, unpack(R.Merchant))
	end)
	if not remote then
		return
	end
	for _, item in ipairs(S.MerchantItems) do
		if S.FM[item] then
			for _ = 1, 15 do
				local ok, result = fn.SafeInvoke(remote, 0.75, item, 1)
				if not ok or result == false then
					break
				end
				if type(result) == "table" and result.success == false then
					break
				end
				if F.MerchNotify then
					S.Notify.new({
						Title = "Auto Merchant",
						Content = "Purchased " .. item,
						Duration = 4,
						Icon = S.ICON,
					})
				end
				task.wait(0.05)
			end
		end
	end
end
S.SmartStatBuilds = {
	["Sword Build"] = { Sword = 0.5, Defense = 0.3, Melee = 0.2 },
	["Melee Build"] = { Melee = 0.5, Defense = 0.3, Sword = 0.2 },
	["Power Build"] = { Power = 0.45, Defense = 0.3, Sword = 0.25 },
}
fn.GetStatPoints = function()
	local data = LP:FindFirstChild("Data")
	if data then
		local sp = data:FindFirstChild("StatPoints")
		if sp then
			return sp.Value
		end
	end
	return 0
end
S._smartStatAccum = {}
fn.AllocateSmartStats = function()
	if not F.SmartStats then
		return
	end
	local available = fn.GetStatPoints()
	if available <= 0 then
		return
	end
	local build
	if F.SmartStatBuild == "Manual Build" then
		local m = tonumber(F.CustomMelee) or 0
		local d = tonumber(F.CustomDefense) or 0
		local s = tonumber(F.CustomSword) or 0
		local p = tonumber(F.CustomPower) or 0
		local total = m + d + s + p
		if total <= 0 then
			return
		end
		build = { Melee = m / total, Defense = d / total, Sword = s / total, Power = p / total }
	else
		build = S.SmartStatBuilds[F.SmartStatBuild]
	end
	if not build then
		return
	end
	local batchSize = tonumber(F.SmartStatBatch) or 1
	local batch = math.min(available, batchSize)
	if batch <= 0 then
		return
	end
	local accum = S._smartStatAccum
	for stat, ratio in pairs(build) do
		accum[stat] = (accum[stat] or 0) + batch * ratio
	end
	for stat in pairs(build) do
		local pts = math.floor(accum[stat] or 0)
		if pts > 0 then
			accum[stat] = accum[stat] - pts
			pcall(function()
				fn.WalkPathWait(RS, 3, unpack(R.AllocateStat)):FireServer(stat, pts)
			end)
			task.wait(0.1)
		end
	end
end
fn.SpawnCrystal = function(island)
	if not island or not F.AutoSpawn then
		return
	end
	local cn = "SpawnPointCrystal_" .. island.Portal
	for _, desc in ipairs(workspace:GetDescendants()) do
		if desc.Name == cn then
			local pr
			if desc:IsA("Model") then
				for _, ch in ipairs(desc:GetDescendants()) do
					if ch:IsA("ProximityPrompt") then
						pr = ch
						break
					end
				end
			elseif desc:IsA("BasePart") then
				pr = desc:FindFirstChildOfClass("ProximityPrompt")
				if not pr and desc.Parent then
					for _, ch in ipairs(desc.Parent:GetDescendants()) do
						if ch:IsA("ProximityPrompt") then
							pr = ch
							break
						end
					end
				end
			end
			if pr then
				local hrp = fn.PlayerHRP()
				local cp
				if desc:IsA("BasePart") then
					cp = desc.Position
				elseif desc:IsA("Model") then
					local pm = desc.PrimaryPart or desc:FindFirstChildWhichIsA("BasePart")
					if pm then
						cp = pm.Position
					end
				end
				if hrp and cp then
					if (hrp.Position - cp).Magnitude > 15 then
						hrp.CFrame = CFrame.new(cp + Vector3.new(0, 3, 3))
						task.wait(0.2)
					end
					pcall(function()
						fireproximityprompt(pr)
					end)
					task.wait(0.2)
					pcall(function()
						fireproximityprompt(pr)
					end)
				end
				return
			end
		end
	end
end
fn.GetNPCFolder = function()
	if S._npcFolderCache and S._npcFolderCache.Parent then
		return S._npcFolderCache
	end
	local direct = workspace:FindFirstChild(S.NPC_FOLDER)
	if direct then
		S._npcFolderCache = direct
		return direct
	end
	for _, desc in ipairs(workspace:GetChildren()) do
		if desc:IsA("Folder") then
			local n = (desc.Name or ""):lower()
			if n == "npcs" or n == "npc" or n:find("npc", 1, true) then
				S._npcFolderCache = desc
				return desc
			end
		end
	end
	return nil
end
fn.FindEnemies = function(island)
	local nf = fn.GetNPCFolder()
	if not island then
		return {}
	end
	local hrp = fn.PlayerHRP()
	local origin = S.FarmOrigin
	local out = {}
	local function checkModel(m)
		if m:IsA("Model") and not fn.IsPlayer(m) and not fn.IsBoss(m.Name) then
			local hm = fn.GetHum(m)
			if hm and hm.Health > 0 and not fn.ShouldIgnore(m.Name) then
				if fn.MatchEnemy(m.Name, island) then
					local p = fn.ModelPos(m)
					if p then
						if hrp and (p - hrp.Position).Magnitude > S.FARM_MAX_DIST_FROM_PLAYER then
							return
						end
						if origin and (p - origin).Magnitude > S.FARM_MAX_DIST_FROM_ORIGIN then
							return
						end
					end
					table.insert(out, m)
				end
			end
		end
	end
	if nf then
		for _, desc in ipairs(nf:GetChildren()) do
			if desc:IsA("Model") then
				checkModel(desc)
			elseif desc:IsA("Folder") then
				for _, m in ipairs(desc:GetChildren()) do
					if m:IsA("Model") then
						checkModel(m)
					end
				end
			end
		end
	end
	return out
end
fn.FindDungeonEnemiesKnown = function(maxDist)
	local hrp = fn.PlayerHRP()
	if not hrp then
		return {}
	end
	local maxD = maxDist or S.GENERIC_HOSTILE_MAX_DIST
	local myY = hrp.Position.Y
	local out = {}
	local function isDungeonBossLike(m)
		local name = (m and m.Name) or ""
		local lo = name:lower()
		if not lo:find("boss", 1, true) then
			return false
		end
		if fn.IsBoss(name) then
			return false
		end
		if fn.IsBossRushEnemy(m) then
			return false
		end
		if
			lo:find("quest", 1, true)
			or lo:find("merchant", 1, true)
			or lo:find("shop", 1, true)
			or lo:find("vendor", 1, true)
			or lo:find("dummy", 1, true)
			or lo:find("training", 1, true)
		then
			return false
		end
		local hm = fn.GetHum(m)
		if not hm or hm.Health <= 0 then
			return false
		end
		local rp = fn.Root(m)
		if not rp then
			return false
		end
		local moving = (rp.AssemblyLinearVelocity.Magnitude > 0.5)
		local md
		pcall(function()
			md = hm.MoveDirection
		end)
		if md and md.Magnitude > 0.05 then
			moving = true
		end
		local ws = 0
		pcall(function()
			ws = hm.WalkSpeed or 0
		end)
		if ws > 0 then
			moving = true
		end
		return moving
	end
	local function isKnownDungeonName(n)
		local lo = (n or ""):lower()
		local eSet = F.AutoInfiniteTower and S.TowerEnemySet or S.DungeonEnemySet
		local eNames = F.AutoInfiniteTower and S.TowerEnemyNames or S.DungeonEnemyNames
		if eSet[lo] then
			return true
		end
		for _, base in ipairs(eNames) do
			local bl = (base or ""):lower()
			if lo:sub(1, #bl) == bl then
				return true
			end
		end
		local bossMap = S.DungeonBossMap[F.DungeonType]
		if bossMap then
			if bossMap[lo] then
				return true
			end
			for name in pairs(bossMap) do
				if lo:sub(1, #name) == name then
					return true
				end
			end
		end
		return false
	end
	local function addIfMatch(m)
		if not m:IsA("Model") then
			return
		end
		if fn.IsPlayer(m) then
			return
		end
		if not isKnownDungeonName(m.Name) and not isDungeonBossLike(m) then
			return
		end
		local hm = fn.GetHum(m)
		if not hm or hm.Health <= 0 then
			return
		end
		local p = fn.ModelPos(m)
		if not p then
			return
		end
		if math.abs(p.Y - myY) > 150 then
			return
		end
		if (p - hrp.Position).Magnitude > maxD then
			return
		end
		table.insert(out, m)
	end
	local nf = fn.GetNPCFolder()
	if nf then
		for _, desc in ipairs(nf:GetChildren()) do
			if desc:IsA("Model") then
				addIfMatch(desc)
			elseif desc:IsA("Folder") then
				for _, m in ipairs(desc:GetChildren()) do
					if m:IsA("Model") then
						addIfMatch(m)
					end
				end
			end
		end
	end
	return out
end
fn.IsKnownDungeonEnemy = function(model)
	if not model or not model:IsA("Model") then
		return false
	end
	local lo = ((model.Name or ""):lower())
	local eSet = F.AutoInfiniteTower and S.TowerEnemySet or S.DungeonEnemySet
	local eNames = F.AutoInfiniteTower and S.TowerEnemyNames or S.DungeonEnemyNames
	if eSet[lo] then
		return true
	end
	for _, base in ipairs(eNames) do
		local bl = (base or ""):lower()
		if lo:sub(1, #bl) == bl then
			return true
		end
	end
	local bossMap = S.DungeonBossMap[F.DungeonType]
	if bossMap then
		if bossMap[lo] then
			return true
		end
		for name in pairs(bossMap) do
			if lo:sub(1, #name) == name then
				return true
			end
		end
	end
	return false
end
fn.HasDungeonEnemiesInWorkspace = function()
	if tick() - S.DungeonWSCacheTick < 0.5 then
		return S.DungeonWSCache
	end
	S.DungeonWSCacheTick = tick()
	local checkFn = F.AutoInfiniteTower and fn.IsTowerEnemy
		or F.AutoBossRush and fn.IsBossRushEnemy
		or fn.IsKnownDungeonEnemy
	local nf = fn.GetNPCFolder()
	if nf then
		for _, m in ipairs(nf:GetChildren()) do
			if m:IsA("Model") and checkFn(m) and not fn.IsPlayer(m) then
				local hm = fn.GetHum(m)
				if hm and hm.Health > 0 then
					S.DungeonWSCache = true
					return true
				end
			end
		end
	end
	S.DungeonWSCache = false
	return false
end
fn.NearestFrom = function(list)
	local hrp = fn.PlayerHRP()
	if not hrp then
		return nil
	end
	local myY = hrp.Position.Y
	local best, bd = nil, math.huge
	for _, e in ipairs(list) do
		local p = fn.ModelPos(e)
		if p and math.abs(p.Y - myY) < 150 then
			local d = (p - hrp.Position).Magnitude
			if d < bd then
				bd = d
				best = e
			end
		end
	end
	return best
end
fn.FreshBoss = function(name)
	local nf = fn.GetNPCFolder()
	if not nf then
		return nil
	end
	for _, ch in ipairs(nf:GetChildren()) do
		if ch:IsA("Model") and ch.Name == name then
			local hm = fn.GetHum(ch)
			if hm and hm.Health > 0 then
				return ch
			end
		end
		if ch:IsA("Folder") then
			for _, m in ipairs(ch:GetChildren()) do
				if m:IsA("Model") and m.Name == name then
					local hm = fn.GetHum(m)
					if hm and hm.Health > 0 then
						return m
					end
				end
			end
		end
	end
	return nil
end
fn.FindAnyAnosAlive = function()
	local nf = fn.GetNPCFolder()
	if not nf then
		return nil
	end
	for _, ch in ipairs(nf:GetChildren()) do
		if ch:IsA("Model") and fn.IsAnosModel(ch.Name) then
			local hm = fn.GetHum(ch)
			if hm and hm.Health > 0 then
				return ch
			end
		end
		if ch:IsA("Folder") then
			for _, m in ipairs(ch:GetChildren()) do
				if m:IsA("Model") and fn.IsAnosModel(m.Name) then
					local hm = fn.GetHum(m)
					if hm and hm.Health > 0 then
						return m
					end
				end
			end
		end
	end
	return nil
end
fn.CheckBoss = function(name)
	local m = fn.FreshBoss(name)
	if m then
		local p = fn.ModelPos(m)
		if p then
			S.BossPosCache[name] = p
		end
		return m
	end
	if fn.IsAnosModel(name) then
		local a = fn.FindAnyAnosAlive()
		if a then
			local p = fn.ModelPos(a)
			if p then
				S.BossPosCache[name] = p
			end
			return a
		end
	end
	if not S.AllBossNames[name] and fn.CheckSummonBoss then
		local sb = fn.CheckSummonBoss(name)
		if sb then
			local p = fn.ModelPos(sb)
			if p then
				S.BossPosCache[name] = p
			end
			return sb
		end
	end
	return nil
end
fn.CacheBossPositions = function()
	local nf = fn.GetNPCFolder()
	if not nf then
		return
	end
	local function cache(m)
		if m:IsA("Model") and fn.IsBoss(m.Name) then
			local p = fn.ModelPos(m)
			if p then
				S.BossPosCache[m.Name] = p
			end
		end
	end
	for _, ch in ipairs(nf:GetChildren()) do
		cache(ch)
		if ch:IsA("Folder") then
			for _, m in ipairs(ch:GetChildren()) do
				cache(m)
			end
		end
	end
end
fn.GetRenderPos = function(name)
	if S.BossPosCache[name] then
		return S.BossPosCache[name]
	end
	local ref = S.BossRenderNear[name]
	if ref then
		if S.BossPosCache[ref] then
			return S.BossPosCache[ref]
		end
		local nf = fn.GetNPCFolder()
		if nf then
			for _, m in ipairs(nf:GetChildren()) do
				if m:IsA("Model") and m.Name == ref then
					local p = fn.ModelPos(m)
					if p then
						return p
					end
				end
			end
		end
	end
	return nil
end
fn.AllBossesOnIsland = function(island)
	local nf = fn.GetNPCFolder()
	if not nf then
		return {}
	end
	local out = {}
	local function check(m)
		if m:IsA("Model") then
			local hm = fn.GetHum(m)
			if hm and hm.Health > 0 then
				if
					S.AllBossNames[m.Name]
					and S.BF[m.Name]
					and S.BossIsland[m.Name] == island
					and not fn.IsBossOnCooldown(m.Name)
				then
					table.insert(out, m.Name)
				end
			end
		end
	end
	for _, ch in ipairs(nf:GetChildren()) do
		check(ch)
		if ch:IsA("Folder") then
			for _, m in ipairs(ch:GetChildren()) do
				check(m)
			end
		end
	end
	return out
end
fn.PickNextBossName = function()
	local nf = fn.GetNPCFolder()
	if not nf then
		return nil
	end
	if S.BossCurrentIsland then
		local sameIsland = fn.AllBossesOnIsland(S.BossCurrentIsland)
		if #sameIsland > 0 then
			local hrp = fn.PlayerHRP()
			if hrp and #sameIsland > 1 then
				local cl, cd = nil, math.huge
				for _, bn in ipairs(sameIsland) do
					local bp = fn.ModelPos(fn.CheckBoss(bn))
					if bp then
						local d = (hrp.Position - bp).Magnitude
						if d < cd then
							cd = d
							cl = bn
						end
					elseif not cl then
						cl = bn
					end
				end
				if cl then
					return cl
				end
			end
			return sameIsland[1]
		end
	end
	local alive = {}
	local function addAlive(m)
		if m:IsA("Model") then
			local hm = fn.GetHum(m)
			if hm and hm.Health > 0 then
				if S.AllBossNames[m.Name] and S.BF[m.Name] and not fn.IsBossOnCooldown(m.Name) then
					table.insert(alive, m.Name)
				end
			end
		end
	end
	for _, ch in ipairs(nf:GetChildren()) do
		addAlive(ch)
		if ch:IsA("Folder") then
			for _, m in ipairs(ch:GetChildren()) do
				addAlive(m)
			end
		end
	end
	if #alive == 0 then
		return nil
	end
	if #alive == 1 then
		return alive[1]
	end
	local byIsland = {}
	for _, bn in ipairs(alive) do
		local bi = fn.GetBossIsland(bn) or "?"
		if not byIsland[bi] then
			byIsland[bi] = {}
		end
		table.insert(byIsland[bi], bn)
	end
	local bestIsland, bestCount = nil, 0
	for isl, list in pairs(byIsland) do
		if #list > bestCount then
			bestCount = #list
			bestIsland = isl
		end
	end
	if bestIsland and byIsland[bestIsland] then
		local pick = byIsland[bestIsland]
		local hrp = fn.PlayerHRP()
		if hrp and #pick > 1 then
			local cl, cd = nil, math.huge
			for _, bn in ipairs(pick) do
				local bp = fn.ModelPos(fn.CheckBoss(bn))
				if bp then
					local d = (hrp.Position - bp).Magnitude
					if d < cd then
						cd = d
						cl = bn
					end
				elseif not cl then
					cl = bn
				end
			end
			if cl then
				return cl
			end
		end
		return pick[1]
	end
	return alive[1]
end
fn.RecordBossDeath = function(name)
	S.BossDeathTimes[name] = tick()
	local group = S.BossSharedSpawn[name]
	if group then
		for _, b in ipairs(S.Bosses) do
			if S.BossSharedSpawn[b.Name] == group and b.Name ~= name then
				S.BossDeathTimes[b.Name] = tick()
			end
		end
	end
end
fn.IsBossOnCooldown = function(name)
	local dt = S.BossDeathTimes[name]
	if dt and tick() - dt < 30 then
		return true
	end
	local tc = S.BossTimerCache[name]
	if tc and (tick() - (tc.t or 0)) < 5 and not tc.alive then
		return true
	end
	return false
end
fn.ScanAllBossTimers = function()
	fn.CacheBossPositions()
	local results = {}
	local nf = fn.GetNPCFolder()
	if nf then
		for _, m in ipairs(nf:GetChildren()) do
			if m:IsA("Model") and S.AllBossNames[m.Name] and not results[m.Name] then
				local hm = fn.GetHum(m)
				if hm and hm.Health > 0 then
					results[m.Name] = { alive = true }
				end
			end
		end
	end
	for _, bDef in ipairs(S.Bosses) do
		if not results[bDef.Name] then
			local container = workspace:FindFirstChild("TimedBossSpawn_" .. bDef.Name .. "_Container")
			if not container then
				local short = bDef.Name:gsub("Boss$", "")
				container = workspace:FindFirstChild("TimedBossSpawn_" .. short .. "_Container")
			end
			if container then
				local timer = container:FindFirstChild("BossTimerBillboard", true)
					or container:FindFirstChild("Timer", true)
				if not timer then
					for _, d in ipairs(container:GetDescendants()) do
						if d:IsA("TextLabel") then
							local mn, sc = (d.Text or ""):match("(%d+):(%d+)")
							if mn and sc then
								results[bDef.Name] = { m = tonumber(mn), s = tonumber(sc) }
								break
							end
						end
					end
				else
					local lbl = timer:IsA("TextLabel") and timer or timer:FindFirstChild("Frame") and timer.Frame:FindFirstChild("Timer")
					if not lbl then
						for _, d in ipairs(timer:GetDescendants()) do
							if d:IsA("TextLabel") then
								lbl = d
								break
							end
						end
					end
					if lbl and lbl:IsA("TextLabel") then
						local mn, sc = (lbl.Text or ""):match("(%d+):(%d+)")
						if mn and sc then
							results[bDef.Name] = { m = tonumber(mn), s = tonumber(sc) }
						end
					end
				end
			end
		end
	end
	for k, v in pairs(results) do
		S.BossTimerCache[k] = v
		S.BossTimerCache[k].t = tick()
	end
	return results
end
fn.GetBossTimerText = function()
	local lines = {}
	for _, bDef in ipairs(S.Bosses) do
		local info = S.BossTimerCache[bDef.Name]
		local status = ""
		if info and (tick() - (info.t or 0)) < 5 then
			if info.alive then
				status = "ALIVE"
			elseif info.m and info.s then
				local total = info.m * 60 + info.s
				if total == 0 then
					status = "ALIVE"
				elseif total <= 15 then
					status = info.m .. ":" .. string.format("%02d", info.s)
				else
					status = info.m .. ":" .. string.format("%02d", info.s)
				end
			else
				status = "Loading..."
			end
		else
			local dt = S.BossDeathTimes[bDef.Name]
			if dt then
				local remain = math.max(0, 300 - (tick() - dt))
				if remain > 0 then
					local mn = math.floor(remain / 60)
					local sc = math.floor(remain % 60)
					status = mn .. ":" .. string.format("%02d", sc)
				else
					status = "Ready!"
				end
			else
				status = "Loading..."
			end
		end
		table.insert(lines, bDef.Display .. " (" .. bDef.Island .. ") - " .. status)
	end
	return table.concat(lines, "\n")
end
fn.GetAllTools = function()
	local c = LP.Character
	if not c then
		return {}
	end
	local t = {}
	for _, ch in ipairs(c:GetChildren()) do
		if ch:IsA("Tool") then
			table.insert(t, ch)
		end
	end
	return t
end
fn.GetActiveWeapon = function()
	local preferred = F.AutoEquipWeapon
	local bp = LP:FindFirstChild("Backpack")
	local c = LP.Character
	if preferred and preferred ~= "" then
		local tool = (bp and bp:FindFirstChild(preferred)) or (c and c:FindFirstChild(preferred))
		if tool and tool:IsA("Tool") then
			return tool
		end
	end
	if bp then
		for _, t in ipairs(bp:GetChildren()) do
			if t:IsA("Tool") and t.Name:lower() ~= "combat" then
				return t
			end
		end
	end
	if c then
		for _, t in ipairs(c:GetChildren()) do
			if t:IsA("Tool") and t.Name:lower() ~= "combat" then
				return t
			end
		end
	end
	return nil
end
fn.EquipBothWeapons = function()
	local c = LP.Character
	if not c then
		return
	end
	local hm = c:FindFirstChildOfClass("Humanoid")
	if not hm then
		return
	end
	local tool = fn.GetActiveWeapon()
	if not tool then
		return
	end
	if tool.Parent == c then
		return
	end
	pcall(function()
		hm:EquipTool(tool)
	end)
end
fn.GetGoalForEnemy = function(enemy)
	local pos = fn.ModelPos(enemy)
	if not pos then
		return nil, nil
	end
	local cf = fn.ModelCF(enemy)
	if not cf then
		return Vector3.new(pos.X, pos.Y, pos.Z + F.OffsetDist), pos
	end
	local lookFlat = Vector3.new(cf.LookVector.X, 0, cf.LookVector.Z)
	if lookFlat.Magnitude > 0.01 then
		lookFlat = lookFlat.Unit
	else
		lookFlat = Vector3.new(0, 0, 1)
	end
	local rightFlat = Vector3.new(-lookFlat.Z, 0, lookFlat.X)
	local fm = F.FarmMode or "Behind"
	if fm == "Above" then
		return Vector3.new(pos.X, pos.Y + F.OffsetDist, pos.Z), pos
	end
	local primary
	if fm == "In Front" then
		primary = lookFlat
	elseif fm == "Left Side" then
		primary = F.FollowPlayer and -rightFlat or rightFlat
	elseif fm == "Right Side" then
		primary = F.FollowPlayer and rightFlat or -rightFlat
	else
		primary = -lookFlat
	end
	local perp = Vector3.new(-primary.Z, 0, primary.X)
	local dirs = { primary, perp, -perp, -primary }
	for _, dir in ipairs(dirs) do
		if dir.Magnitude > 0.1 then
			dir = Vector3.new(dir.X, 0, dir.Z).Unit
			local goal = pos + dir * F.OffsetDist
			local ray = workspace:Raycast(pos, dir * F.OffsetDist, S.RayParams)
			if not ray then
				return Vector3.new(goal.X, pos.Y, goal.Z), pos
			end
		end
	end
	return Vector3.new(pos.X, pos.Y, pos.Z + 2), pos
end
fn.DungeonHeight = function()
	return F[F.DungeonType .. "Height"] or 10
end
fn.DungeonSpeed = function()
	return F[F.DungeonType .. "Speed"] or 70
end
fn.DungeonMove = function()
	return F[F.DungeonType .. "Move"] or "Teleport"
end
fn.DungeonDiff = function()
	return F[F.DungeonType .. "Diff"] or "Normal"
end
fn.FireDungeonVote = function()
	pcall(function()
		local r = fn.WalkPathWait(RS, 2, unpack(R.DungeonVote))
		if r then
			r:FireServer(fn.DungeonDiff())
		end
	end)
end
fn.FireBossRushVote = function()
	pcall(function()
		local r = fn.WalkPathWait(RS, 2, unpack(R.DungeonVote))
		if r then
			r:FireServer(F.BossRushDiff or "Medium")
		end
	end)
end
fn.FireDungeonPortal = function(dtype)
	local portalName = S.DungeonPortalNames[dtype]
	if not portalName then
		return false
	end
	local ok = false
	pcall(function()
		local r = fn.WalkPathWait(RS, 3, unpack(R.DungeonPortal))
		if r then
			r:FireServer(portalName)
			ok = true
		end
	end)
	return ok
end
fn.IsInDungeon = function()
	local nf = fn.GetNPCFolder()
	if not nf then
		return false
	end
	for _, m in ipairs(nf:GetChildren()) do
		if m:IsA("Model") and fn.IsKnownDungeonEnemy(m) and not fn.IsPlayer(m) then
			local hm = fn.GetHum(m)
			if hm and hm.Health > 0 then
				return true
			end
		end
	end
	return false
end
fn.IsInDungeonLobby = function()
	if S._lobbyCache and tick() - S._lobbyCacheTick < 1 then
		return S._lobbyCache
	end
	S._lobbyCacheTick = tick()
	local pg = LP:FindFirstChild("PlayerGui")
	if not pg then
		S._lobbyCache = false
		return false
	end
	for _, d in ipairs(pg:GetDescendants()) do
		if d:IsA("TextButton") then
			local txt = (d.Text or ""):lower()
			if txt == "leave portal" then
				S._lobbyCache = true
				return true
			end
		end
	end
	S._lobbyCache = false
	return false
end
fn.GetGoalForDungeonEnemy = function(enemy)
	return fn.GetGoalForEnemy(enemy)
end
fn.GetGoalForBossRushEnemy = function(enemy)
	return fn.GetGoalForEnemy(enemy)
end
fn.HoldDungeonIdleHover = function() end
S.OrigWalkSpeed = nil
fn.RestoreWalkSpeed = function()
	if S.OrigWalkSpeed then
		pcall(function()
			local c = LP.Character
			if not c then
				return
			end
			local hum = c:FindFirstChildOfClass("Humanoid")
			if not hum then
				return
			end
			hum.WalkSpeed = S.OrigWalkSpeed
		end)
		S.OrigWalkSpeed = nil
	end
end
fn.TweenTo = function(enemy)
	if not enemy then
		return
	end
	local effectiveStyle = (F.FarmMode == "Behind") and (F.FollowStyle or "Dodge") or "Static"
	if S.LockTarget == enemy and effectiveStyle ~= "Dodge" then
		local ep = fn.ModelPos(enemy)
		local hrp2 = fn.PlayerHRP()
		if ep and hrp2 then
			local dEnemy = (hrp2.Position - ep).Magnitude
			if dEnemy <= F.OffsetDist + 25 then
				return
			end
			S.LockTarget = nil
		else
			return
		end
	end
	local goal, look = fn.GetGoalForEnemy(enemy)
	if not goal then
		return
	end
	local hrp = fn.PlayerHRP()
	if not hrp then
		return
	end
	local d = (hrp.Position - goal).Magnitude
	if d > 600 then
		if F.MoveMode == "Teleport" then
			fn.StopTw()
			hrp.CFrame = CFrame.new(goal, look or goal)
			S.LockTarget = enemy
			S.TweenOn = false
			S.TweenTarget = nil
		end
		return
	end
	if d < 3 then
		S.LockTarget = enemy
		S.TweenOn = false
		S.TweenTarget = nil
		return
	end
	if F.MoveMode == "Teleport" then
		fn.StopTw()
		local hrpRef = fn.PlayerHRP()
		if hrpRef then
			hrpRef.CFrame = CFrame.new(goal, look or goal)
		end
		S.LockTarget = enemy
		S.TweenOn = false
		S.TweenTarget = nil
		return
	end
	if S.TweenOn and S.TweenTarget == enemy then
		return
	end
	fn.StopTw()
	S.TweenOn = true
	S.TweenTarget = enemy
	S.LockTarget = nil
	local stepDist = math.min(d, 80)
	local dir = (goal - hrp.Position).Unit
	local stepGoal = hrp.Position + (dir * stepDist)
	local cf = CFrame.new(stepGoal, look or goal)
	local dur = math.clamp(stepDist / math.max(F.TweenSpeed, 1), 0.06, 3.0)
	S.ATween = TweenService:Create(hrp, TweenInfo.new(dur, Enum.EasingStyle.Linear), { CFrame = cf })
	S.ATweenConn = S.ATween.Completed:Connect(function()
		S.ATween = nil
		S.ATweenConn = nil
		S.TweenOn = false
		S.TweenTarget = nil
		S.LockTarget = enemy
	end)
	S.ATween:Play()
end
fn.TweenWithSettings = function(enemy, moveMode, speed, farmMode, offsetDist)
	local sMM, sTS, sFM, sOD = F.MoveMode, F.TweenSpeed, F.FarmMode, F.OffsetDist
	if moveMode then
		F.MoveMode = moveMode
	end
	if speed then
		F.TweenSpeed = speed
	end
	if farmMode then
		F.FarmMode = farmMode
	end
	if offsetDist then
		F.OffsetDist = offsetDist
	end
	fn.TweenTo(enemy)
	F.MoveMode, F.TweenSpeed, F.FarmMode, F.OffsetDist = sMM, sTS, sFM, sOD
end
fn.TweenToDungeon = function(enemy)
	fn.TweenWithSettings(enemy, fn.DungeonMove(), fn.DungeonSpeed(), nil, nil)
end
fn.TweenToBossRush = function(enemy)
	fn.TweenWithSettings(enemy, F.BossRushMoveMode, F.BossRushTweenSpeed, F.BossRushFarmMode, nil)
end
fn.TweenToPoint = function(goal)
	if S.TweenOn and S.TweenPointGoal and (S.TweenPointGoal - goal).Magnitude < 40 then
		return
	end
	local hrp = fn.PlayerHRP()
	if not hrp then
		return
	end
	local d = (hrp.Position - goal).Magnitude
	if d > 1500 or d < 5 then
		return
	end
	fn.StopTw()
	S.TweenOn = true
	S.TweenPointGoal = goal
	S.LockTarget = nil
	local stepDist = math.min(d, 80)
	local dir = (goal - hrp.Position).Unit
	local stepGoal = hrp.Position + (dir * stepDist)
	local lookAt = Vector3.new(goal.X, stepGoal.Y, goal.Z)
	local cf = CFrame.new(stepGoal, lookAt)
	local dur = math.clamp(stepDist / math.max(F.TweenSpeed, 1), 0.06, 3.0)
	S.ATween = TweenService:Create(hrp, TweenInfo.new(dur, Enum.EasingStyle.Linear), { CFrame = cf })
	S.ATweenConn = S.ATween.Completed:Connect(function()
		S.ATween = nil
		S.ATweenConn = nil
		S.TweenOn = false
		S.TweenPointGoal = nil
	end)
	S.ATween:Play()
end
fn.IsSkillReady = function(slot)
	local ok, ready = pcall(function()
		local pg = LP:FindFirstChild("PlayerGui")
		if not pg then
			return true
		end
		local cdUI = pg:FindFirstChild("CooldownUI")
		if not cdUI then
			return true
		end
		local mf = cdUI:FindFirstChild("MainFrame")
		if not mf then
			return true
		end
		local slotMap = { "skill 1", "skill 2", "skill 3", "skill 4", "skill 5" }
		local keyMap = { "_z", "_x", "_c", "_v", "_f" }
		local slotStr = slotMap[slot]
		local keyStr = keyMap[slot]
		if not slotStr then
			return true
		end
		for _, frame in ipairs(mf:GetChildren()) do
			if frame:IsA("Frame") then
				local fname = frame.Name:lower()
				if fname:find("cooldown") and (fname:find(slotStr) or fname:find(keyStr)) then
					local cdLabel = frame:FindFirstChild("WeaponNameAndCooldown", true)
					if cdLabel and cdLabel:IsA("TextLabel") then
						return cdLabel.Text:find("Ready") ~= nil
					end
					return false
				end
			end
		end
		return true
	end)
	if not ok then
		return true
	end
	return ready
end
fn.FireAbilities = function()
	local skills = {}
	if F.SkillZ then
		table.insert(skills, 1)
	end
	if F.SkillX then
		table.insert(skills, 2)
	end
	if F.SkillC then
		table.insert(skills, 3)
	end
	if F.SkillV then
		table.insert(skills, 4)
	end
	if F.SkillF then
		table.insert(skills, 5)
	end
	if #skills == 0 then
		return
	end
	local now = tick()
	if F.SkillMode == "Instant" then
		if now - S.LastAbilityUse < F.SkillCooldown then
			return
		end
	end
	if not S.CachedAbilityRemote or not S.CachedAbilityRemote.Parent then
		S.CachedAbilityRemote = nil
		pcall(function()
			S.CachedAbilityRemote = fn.WalkPathWait(RS, 2, unpack(R.Ability))
		end)
	end
	local r = S.CachedAbilityRemote
	if not r then
		return
	end
	if F.SkillMode == "Normal" then
		S.SkillRotation = S.SkillRotation or 0
		for i = 1, #skills do
			local idx = ((S.SkillRotation + i - 1) % #skills) + 1
			local id = skills[idx]
			if fn.IsSkillReady(id) then
				pcall(r.FireServer, r, id)
				S.SkillRotation = idx
				return
			end
		end
	else
		S.SkillRotation = (S.SkillRotation % #skills) + 1
		local id = skills[S.SkillRotation]
		pcall(r.FireServer, r, id)
		S.LastAbilityUse = now
		S.LastSkill = now
	end
end
fn.Attack = function(tgt)
	if not S.CachedHitRemote or not S.CachedHitRemote.Parent then
		S.CachedHitRemote = nil
		pcall(function()
			S.CachedHitRemote = fn.WalkPathWait(RS, 2, unpack(R.Hit))
		end)
	end
	if S.CachedHitRemote then
		pcall(function()
			S.CachedHitRemote:FireServer(tgt)
		end)
	end
	fn.FireAbilities()
end
fn.ToggleFarm = function()
	if S.FarmToggle then
		pcall(function()
			S.FarmToggle:SetValue(not S.FarmToggle:GetValue())
		end)
	else
		F.AutoFarmLevel = not F.AutoFarmLevel
		if not F.AutoFarmLevel then
			fn.FullReset()
		end
	end
end
fn.ToggleBoss = function()
	if S.BossToggle then
		pcall(function()
			S.BossToggle:SetValue(not S.BossToggle:GetValue())
		end)
	else
		F.BossEnabled = not F.BossEnabled
		if not F.BossEnabled and S.BossFight then
			fn.ExitBossMode(S.BossTargetName)
		end
	end
end
fn.ToggleSummonBoss = function()
	if fn.HasAnySummonBossEnabled() then
		for _, b in ipairs(S.SummonBosses) do
			S.BSF[b.Name] = false
			if S.BSFToggle[b.Name] then
				pcall(function()
					S.BSFToggle[b.Name]:SetValue(false)
				end)
			end
		end
		fn.ExitSummonBossMode()
	end
end
fn.SetupAntiAFK = function()
	local function disableIdled()
		pcall(function()
			for _, c in ipairs(getconnections(LP.Idled)) do
				c:Disable()
			end
		end)
	end
	local function pulse()
		pcall(function()
			VirtualUser:CaptureController()
			VirtualUser:ClickButton2(Vector2.new())
		end)
		pcall(function()
			VirtualUser:Button2Down(Vector2.new())
			task.defer(function()
				pcall(function()
					VirtualUser:Button2Up(Vector2.new())
				end)
			end)
		end)
	end
	disableIdled()
	pcall(function()
		fn.Conn(LP.Idled:Connect(function()
			if F.AntiAFK then
				disableIdled()
				pulse()
			end
		end))
	end)
	local _afkHeartbeat = nil
	pcall(function()
		_afkHeartbeat = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("AntiAFKHeartbeat")
	end)
	task.spawn(function()
		while S.Running do
			task.wait(fn.Jit(30, 10))
			if F.AntiAFK then
				disableIdled()
				pulse()
				pcall(function()
					keypress(0x20)
					task.wait(0.05)
					keyrelease(0x20)
				end)
				if _afkHeartbeat then
					pcall(function()
						_afkHeartbeat:FireServer()
					end)
				end
			end
		end
	end)
	task.spawn(function()
		while S.Running do
			task.wait(fn.Jit(60, 15))
			if F.AntiAFK then
				pulse()
				pcall(function()
					mousemoverel(1, 0)
					task.wait(0.05)
					mousemoverel(-1, 0)
				end)
				pcall(function()
					keypress(0x57)
					task.wait(0.08)
					keyrelease(0x57)
				end)
			end
		end
	end)
	task.spawn(function()
		while S.Running do
			task.wait(fn.Jit(120, 20))
			if F.AntiAFK then
				disableIdled()
				pulse()
				pcall(function()
					keypress(0x41)
					task.wait(0.08)
					keyrelease(0x41)
				end)
			end
		end
	end)
	task.spawn(function()
		local r
		pcall(function()
			r = RS:WaitForChild("Remotes", 10):WaitForChild("AntiAFKHeartbeat", 10)
		end)
		while S.Running do
			task.wait(fn.Jit(25, 5))
			if F.AntiAFK and r then
				pcall(function()
					r:FireServer()
				end)
			end
		end
	end)
end
fn.OnCharAdded = function(char)
	S.CharHum = nil
	char:WaitForChild("Humanoid", 10)
	S.CharHum = char:FindFirstChildOfClass("Humanoid")
	S.LockTarget = nil
	S.TweenOn = false
	S.TweenTarget = nil
	S.HoverPos = nil
	if F.AutoEquip then
		task.spawn(function()
			task.wait(0.5)
			for _ = 1, 10 do
				task.wait(0.3)
				fn.EquipBothWeapons()
				local tools = fn.GetAllTools()
				if #tools >= 2 then
					break
				end
				if #tools >= 1 then
					local hasSword = false
					for _, t in ipairs(tools) do
						if t.Name:lower() ~= "combat" then
							hasSword = true
						end
					end
					if hasSword then
						break
					end
				end
			end
		end)
	end
end
if LP.Character then
	task.spawn(function()
		fn.OnCharAdded(LP.Character)
	end)
end
fn.Conn(LP.CharacterAdded:Connect(fn.OnCharAdded))
fn.GetIslandNames = function()
	local n = { "Auto" }
	for _, i in ipairs(S.Islands) do
		if i.Enemies and #i.Enemies > 0 then
			table.insert(n, fn.PortalDisplayName(i.Portal))
		end
	end
	return n
end
fn.DisplayToPortal = function(display)
	for _, i in ipairs(S.Islands) do
		if fn.PortalDisplayName(i.Portal) == display then
			return i.Portal
		end
	end
	return display
end
fn.WaitForMapLoad = function(island, timeout)
	local start = tick()
	local deadline = start + (timeout or 15)
	while tick() < deadline do
		if not fn.IsAlive() then
			task.wait(0.2)
			if not fn.IsAlive() then
				return false
			end
		end
		local hrp = fn.PlayerHRP()
		if hrp then
			if island then
				local nf = fn.GetNPCFolder()
				if nf then
					local function chkMatch(m)
						if m:IsA("Model") and not fn.IsPlayer(m) and fn.MatchEnemy(m.Name, island) then
							local hm = fn.GetHum(m)
							if hm and hm.Health > 0 then
								return true
							end
						end
						return false
					end
					for _, ch in ipairs(nf:GetChildren()) do
						if chkMatch(ch) then
							return true
						elseif ch:IsA("Folder") then
							for _, m in ipairs(ch:GetChildren()) do
								if chkMatch(m) then
									return true
								end
							end
						end
					end
				end
			end
			if tick() - start > 3 then
				local hit =
					workspace:Raycast(hrp.Position + Vector3.new(0, 10, 0), Vector3.new(0, -200, 0), S.RayParams)
				if hit then
					local nf = fn.GetNPCFolder()
					if nf then
						for _, m in ipairs(nf:GetChildren()) do
							if m:IsA("Model") and not fn.IsPlayer(m) and not fn.IsBoss(m.Name) then
								local hm = fn.GetHum(m)
								if hm and hm.Health > 0 then
									local p = fn.ModelPos(m)
									if p and (p - hrp.Position).Magnitude < 400 then
										return true
									end
								end
							end
						end
					end
				end
			end
		end
		task.wait(0.3)
	end
	return false
end
fn.Conn(RunService.Heartbeat:Connect(function()
	local anyActive = F.AutoFarmLevel
		or F.AutoDungeon
		or F.AutoBossRush
		or F.AutoInfiniteTower
		or S.SummonBossFight
		or S.BossFight
		or F.DungeonQuest
		or F.HogyokuQuest
		or F.FollowPlayer
	if not anyActive then
		return
	end
	if S.LastTP and tick() - S.LastTP < 2.5 then
		return
	end
	local c = LP.Character
	if not c then
		return
	end
	local hrp = c:FindFirstChild("HumanoidRootPart")
	if not hrp then
		return
	end
	local hum = S.CharHum or c:FindFirstChildOfClass("Humanoid")
	if not hum then
		return
	end
	local _activeFarmMode, _activeOffset
	if F.AutoInfiniteTower then
		_activeFarmMode = F.TowerFarmMode or "Behind"
		_activeOffset = F.TowerHeightOffset or 10
	elseif F.AutoBossRush then
		_activeFarmMode = F.BossRushFarmMode or "Behind"
		_activeOffset = F.OffsetDist
	elseif F.AutoDungeon then
		_activeFarmMode = F.FarmMode or "Behind"
		_activeOffset = F.OffsetDist
	else
		_activeFarmMode = (F.FollowPlayer and F.FollowPlayerMode) or F.FarmMode or "Behind"
		_activeOffset = (F.FollowPlayer and F.FollowPlayerDist) or F.OffsetDist
	end
	local _aboveMode = _activeFarmMode == "Above"
	if _aboveMode then
		hum.PlatformStand = true
		hum.AutoRotate = false
		hrp.AssemblyLinearVelocity = Vector3.zero
		hrp.AssemblyAngularVelocity = Vector3.zero
		if not S._aboveBodyVel then
			local bv = Instance.new("BodyVelocity")
			bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			bv.Velocity = Vector3.zero
			bv.Parent = hrp
			S._aboveBodyVel = bv
		end
	elseif S._aboveBodyVel then
		pcall(function()
			S._aboveBodyVel:Destroy()
		end)
		S._aboveBodyVel = nil
	end
	if S.TweenOn and not _aboveMode then
		return
	end
	if S.LockTarget then
		local valid = true
		local hm = fn.GetHum(S.LockTarget)
		if not hm or hm.Health <= 0 or not S.LockTarget.Parent then
			valid = false
		end
		if valid then
			local tp = fn.ModelPos(S.LockTarget)
			if not tp or tp.Y < -30 or (hrp.Position - tp).Magnitude > 600 then
				valid = false
			end
		end
		if not valid then
			S.LockTarget = nil
		end
	end
	if S.LockTarget then
		local enemyPos = fn.ModelPos(S.LockTarget)
		if enemyPos then
			local now = tick()
			local enemyCF = fn.ModelCF(S.LockTarget)
			local enemyLook = enemyCF and Vector3.new(enemyCF.LookVector.X, 0, enemyCF.LookVector.Z) or nil
			if enemyLook and enemyLook.Magnitude > 0.01 then
				enemyLook = enemyLook.Unit
			else
				local fallback = (hrp.Position - enemyPos)
				fallback = Vector3.new(fallback.X, 0, fallback.Z)
				enemyLook = fallback.Magnitude > 0.1 and -fallback.Unit or Vector3.new(0, 0, 1)
			end
			local enemyRight = Vector3.new(-enemyLook.Z, 0, enemyLook.X)
			local farmMode = _activeFarmMode
			local offsetDist = _activeOffset
			if farmMode == "Above" then
				local aboveGoal = Vector3.new(enemyPos.X, enemyPos.Y + offsetDist, enemyPos.Z)
				hrp.CFrame = CFrame.new(aboveGoal)
				S.HoverPos = aboveGoal
				S._aboveLastPos = aboveGoal
				return
			end
			local baseDir
			if farmMode == "In Front" then
				baseDir = enemyLook
			elseif farmMode == "Left Side" then
				baseDir = F.FollowPlayer and -enemyRight or enemyRight
			elseif farmMode == "Right Side" then
				baseDir = F.FollowPlayer and enemyRight or -enemyRight
			else
				baseDir = -enemyLook
			end
			local style = (farmMode == "Behind") and (F.FollowStyle or "Dodge") or "Static"
			local rightDir = Vector3.new(-baseDir.Z, 0, baseDir.X)
			local goal
			if style == "Orbit" then
				local angle = now * 0.8
				local orbitDir = Vector3.new(math.cos(angle), 0, math.sin(angle))
				goal = enemyPos + (orbitDir * offsetDist)
			elseif style == "Strafe" then
				if now - S.LastDodge > 0.55 then
					S.LastDodge = now
					S.DodgeDir = -S.DodgeDir
				end
				goal = enemyPos + (baseDir * offsetDist) + (rightDir * S.DodgeDir * 6)
			elseif style == "Dodge" then
				if not S._lastThreatScan or (now - S._lastThreatScan > 0.15) then
					S._lastThreatScan = now
					S._lastThreatResult = false
					local myPos = hrp.Position
					local scanCF = CFrame.new(myPos)
					local scanSize = Vector3.new(120, 120, 120)
					local nearby = workspace:GetPartBoundsInBox(scanCF, scanSize, S.OverlapParams)
					for _, obj in ipairs(nearby) do
						if obj ~= hrp then
							local vel = obj.AssemblyLinearVelocity
							if vel.Magnitude > 40 then
								local toMe = myPos - obj.Position
								if toMe.Magnitude < 60 and vel.Unit:Dot(toMe.Unit) > 0.7 then
									S._lastThreatResult = true
									break
								end
							end
						end
					end
				end
				local threatDetected = S._lastThreatResult
				if threatDetected and now - S.LastDodge > 0.4 then
					S.LastDodge = now
					S.DodgeDir = -S.DodgeDir
				end
				local dodgeOffset = threatDetected and (rightDir * S.DodgeDir * 4) or Vector3.new(0, 0, 0)
				goal = enemyPos + (baseDir * offsetDist) + dodgeOffset
			else
				goal = enemyPos + (baseDir * offsetDist)
			end
			goal = Vector3.new(goal.X, enemyPos.Y, goal.Z)
			if not S._lastRayCheck or (now - S._lastRayCheck > 0.2) then
				S._lastRayCheck = now
				local toGoal = (goal - enemyPos)
				local rayDir = toGoal.Magnitude > 0.1 and toGoal.Unit or baseDir
				local ray = workspace:Raycast(enemyPos, rayDir * offsetDist, S.RayParams)
				S._lastRayHit = ray and true or false
			end
			if S._lastRayHit then
				goal = enemyPos + baseDir * math.max(1, offsetDist * 0.5)
				goal = Vector3.new(goal.X, enemyPos.Y, goal.Z)
			end
			local lookAt = Vector3.new(enemyPos.X, hrp.Position.Y, enemyPos.Z)
			if style == "Dodge" then
				local dist = (Vector3.new(hrp.Position.X, 0, hrp.Position.Z) - Vector3.new(goal.X, 0, goal.Z)).Magnitude
				if dist > 1 then
					hum:MoveTo(goal)
				end
				hrp.CFrame = CFrame.new(hrp.Position, lookAt)
			else
				local dGoal = (hrp.Position - goal).Magnitude
				if dGoal > 0.3 then
					local spd = math.max(F.TweenSpeed or 100, 20) / 60
					local newPos = hrp.Position + (goal - hrp.Position).Unit * math.min(dGoal, spd)
					hrp.CFrame = CFrame.new(newPos, Vector3.new(lookAt.X, newPos.Y, lookAt.Z))
				else
					hrp.CFrame = CFrame.new(goal, lookAt)
				end
			end
		end
	end
end))
fn.ExitBossMode = function(lastBossName)
	local bi = lastBossName and fn.GetBossIsland(lastBossName)
	local savedHover = S.HoverPos
	S.BossFight = false
	S.BossTargetName = nil
	S.BossTPDone = false
	S.BossCurrentIsland = nil
	fn.ClearTgt()
	S.HoverPos = nil
	S.LastBossTP = 0
	S.BossTPRetries = 0
	S.LastEnemy = 0
	S.LastTP = 0
	local farmIsland = fn.GetFarmIsland()
	if bi and farmIsland and farmIsland.Portal == bi then
		S.CurIsland = farmIsland
		S.IslandTPd = true
		S.SpawnDone = true
		S.LastEnemy = tick()
		if savedHover then
			S.HoverPos = savedHover
		end
		if F.AutoQuest and S.QState ~= "ACTIVE" then
			task.delay(0.15, function()
				fn.QuestAccept(S.CurIsland)
			end)
		end
		if not F.PityBossEnabled then
			S.Notify.new({
				Title = "Bosses Clear!",
				Content = "Already on " .. bi .. ", resuming farm",
				Duration = 3,
				Icon = S.ICON,
			})
		end
	else
		S.CurIsland = nil
		S.IslandTPd = false
		S.SpawnDone = false
		if not F.PityBossEnabled then
			local msg = F.AutoFarmLevel and "Returning to farming..." or "All bosses cleared!"
			S.Notify.new({ Title = "Bosses Clear!", Content = msg, Duration = 3, Icon = S.ICON })
		end
	end
end
fn.DoFarmTick = function()
	local tgtIsland = fn.GetFarmIsland()
	if not tgtIsland then
		if S.ConfLevel == 0 then
			S.Notify.new({
				Title = "Waiting for Level",
				Content = "Level not detected yet — retrying",
				Duration = 2,
				Icon = S.ICON,
			})
		end
		task.wait(1)
		return
	end
	if not S.CurIsland or S.CurIsland.Portal ~= tgtIsland.Portal then
		fn.StopTw()
		S.CurIsland = tgtIsland
		S.IslandTPd = false
		S.SpawnDone = false
		S.FarmOrigin = nil
		S.QState = "NONE"
		S.CurTarget = nil
		S.LockTarget = nil
		S.HoverPos = nil
		S.LastEnemy = 0
		S.LastQuestAccept = tick()
		fn.AbandonAllQuests()
		S.Notify.new({
			Title = "Teleporting to " .. fn.PortalDisplayName(tgtIsland.Portal),
			Content = "Lv." .. fn.GetLevel() .. (tgtIsland.QuestNPC and (" | " .. tgtIsland.QuestNPC) or ""),
			Duration = 3,
			Icon = S.ICON,
		})
	end
	if not S.IslandTPd then
		if not S.CurIsland then
			return
		end
		local tpPortal = S.CurIsland.Portal
		local alreadyOnIsland = false
		do
			local nf = fn.GetNPCFolder()
			local hrp = fn.PlayerHRP()
			if nf and hrp then
				local function chkIsland(m)
					if alreadyOnIsland then
						return
					end
					if m:IsA("Model") and not fn.IsPlayer(m) and fn.MatchEnemy(m.Name, S.CurIsland) then
						local p = fn.ModelPos(m)
						if p and (p - hrp.Position).Magnitude <= 350 then
							alreadyOnIsland = true
						end
					end
				end
				for _, ch in ipairs(nf:GetChildren()) do
					if ch:IsA("Model") then
						chkIsland(ch)
					elseif ch:IsA("Folder") then
						for _, m in ipairs(ch:GetChildren()) do
							chkIsland(m)
						end
					end
					if alreadyOnIsland then
						break
					end
				end
			end
		end
		if alreadyOnIsland then
			S.IslandTPd = true
			S.FarmOrigin = nil
			S.LastEnemy = tick()
		else
			local hrpBefore = fn.PlayerHRP()
			local posBefore = hrpBefore and hrpBefore.Position
			local tpSuccess = false
			for _attempt = 1, 3 do
				fn.ForceTP(tpPortal)
				task.wait(0.5 + (_attempt - 1) * 0.3)
				local hrpAfter = fn.PlayerHRP()
				if posBefore and hrpAfter and (posBefore - hrpAfter.Position).Magnitude > 30 then
					tpSuccess = true
					break
				end
				if not posBefore then
					tpSuccess = true
					break
				end
			end
			if not tpSuccess then
				task.wait(1)
				return
			end
			S.IslandTPd = true
			S.FarmOrigin = nil
			local snapIsland = S.CurIsland
			fn.WaitForMapLoad(snapIsland, 12)
			if S.CurIsland ~= snapIsland then
				return
			end
			local hrpNow = fn.PlayerHRP()
			do
				local nf = fn.GetNPCFolder()
				local bestPos = nil
				local bestDist = math.huge
				if nf and hrpNow then
					local function tryAnchor(m)
						if m:IsA("Model") and not fn.IsPlayer(m) and fn.MatchEnemy(m.Name, snapIsland) then
							local hm = fn.GetHum(m)
							if hm and hm.Health > 0 then
								local p = fn.ModelPos(m)
								if p then
									local d = (p - hrpNow.Position).Magnitude
									if d < bestDist then
										bestDist = d
										bestPos = p
									end
								end
							end
						end
					end
					for _, ch in ipairs(nf:GetChildren()) do
						if ch:IsA("Model") then
							tryAnchor(ch)
						elseif ch:IsA("Folder") then
							for _, m in ipairs(ch:GetChildren()) do
								tryAnchor(m)
							end
						end
					end
				end
				if bestPos then
					S.FarmOrigin = bestPos
				elseif hrpNow then
					S.FarmOrigin = hrpNow.Position
				end
			end
			S.LastEnemy = tick()
			if F.AutoSpawn and not S.SpawnDone then
				fn.SpawnCrystal(S.CurIsland)
				S.SpawnDone = true
				task.wait(0.2)
			end
			if S.CurIsland ~= snapIsland then
				return
			end
			if F.AutoQuest and S.QState == "NONE" then
				task.wait(0.1)
				fn.QuestAccept(S.CurIsland)
			end
		end
		return
	end
	if F.AutoQuest and S.QState == "NONE" then
		if tick() - S.LastQuestAccept > 5 then
			fn.QuestRepeatFire(S.CurIsland)
		end
	end
	if F.BossEnabled and S.CurIsland and S.IslandTPd then
		for _, bDef in ipairs(S.Bosses) do
			if S.BF[bDef.Name] and S.BossIsland[bDef.Name] == S.CurIsland.Portal then
				local bModel = fn.CheckBoss(bDef.Name)
				if bModel then
					S.BossFight = true
					S.BossTargetName = bDef.Name
					S.BossTPDone = true
					S.BossCurrentIsland = S.CurIsland.Portal
					S.CurTarget = bModel
					fn.StopTw()
					S.HoverPos = nil
					if F.BossNotify then
						S.Notify.new({
							Title = fn.GetBossDisplay(bDef.Name) .. " Detected!",
							Content = "Boss spawned on current island — engaging",
							Duration = 3,
							Icon = S.ICON,
						})
					end
					return
				end
			end
		end
	end
	local enemies = fn.FindEnemies(S.CurIsland)
	S.FarmGenericMode = false
	if #enemies > 0 then
		S.LastEnemy = tick()
		if S.CurTarget then
			local hm = fn.GetHum(S.CurTarget)
			if not hm or hm.Health <= 0 or not S.CurTarget.Parent then
				S.CurTarget = nil
				S.LockTarget = nil
			elseif not fn.MatchEnemy(S.CurTarget.Name, S.CurIsland) then
				S.CurTarget = nil
				S.LockTarget = nil
			else
				local cp = fn.ModelPos(S.CurTarget)
				if cp and fn.DistTo(cp) > 400 then
					S.CurTarget = nil
					S.LockTarget = nil
				end
			end
		end
		if not S.CurTarget then
			S.CurTarget = fn.NearestFrom(enemies)
		end
		if S.CurTarget then
			fn.TweenTo(S.CurTarget)
			fn.Attack(S.CurTarget)
		end
	else
		S.FarmGenericMode = false
		S.CurTarget = nil
		S.LockTarget = nil
		if tick() - S.LastEnemy > 20 then
			S.IslandTPd = false
			S.SpawnDone = false
			S.FarmOrigin = nil
			S.LastEnemy = 0
			S.HoverPos = nil
		end
		task.wait(0.15)
	end
	if F.AutoEquip and tick() - S.LastEquip > 3 then
		S.LastEquip = tick()
		fn.EquipBothWeapons()
	end
end
fn.DoBossTick = function()
	if not S.BossTargetName then
		local nextName = fn.PickNextBossName()
		if nextName then
			S.BossTargetName = nextName
			S.BossTPDone = false
			S.LastBossTP = 0
			fn.ClearTgt()
			S.HoverPos = nil
			local nextBossIsland = fn.GetBossIsland(nextName)
			if S.BossCurrentIsland ~= nextBossIsland then
				S.BossCurrentIsland = nil
			end
			if F.BossNotify then
				S.Notify.new({
					Title = "Next: " .. fn.GetBossDisplay(nextName),
					Content = "Locating at " .. fn.PortalDisplayName(nextBossIsland or "?"),
					Duration = 3,
					Icon = S.ICON,
				})
			end
		else
			fn.ExitBossMode(nil)
		end
		return
	end
	if not S.BossTPDone then
		local bi = fn.GetBossIsland(S.BossTargetName)
		if not bi then
			S.BossTargetName = nil
			return
		end
		if tick() - S.LastBossTP < 2 then
			task.wait(0.1)
			return
		end
		fn.ClearTgt()
		S.HoverPos = nil
		S.LastBossTP = tick()
		S.Notify.new({
			Title = "Teleporting to " .. fn.PortalDisplayName(bi),
			Content = fn.GetBossDisplay(S.BossTargetName or "?"),
			Duration = 2,
			Icon = S.ICON,
		})
		fn.ForceTP(bi)
		task.wait(0.8)
		S.BossCurrentIsland = bi
		local m2 = fn.CheckBoss(S.BossTargetName)
		if m2 then
			local bp2 = fn.ModelPos(m2)
			if bp2 and fn.DistTo(bp2) < 500 then
				S.BossTPDone = true
				S.BossTPRetries = 0
				return
			end
			if bp2 then
				S.BossTPDone = true
				S.BossTPRetries = 0
				return
			end
		end
		local renderPos = fn.GetRenderPos(S.BossTargetName)
		if renderPos then
			local rpGoal = Vector3.new(renderPos.X, renderPos.Y + F.HeightOffset, renderPos.Z)
			if F.MoveMode == "Tween" then
				fn.TweenToPoint(rpGoal)
			else
				fn.StopTw()
				local hrp = fn.PlayerHRP()
				if hrp then
					hrp.CFrame = CFrame.new(rpGoal)
				end
			end
		end
		for _ = 1, 6 do
			local m = fn.CheckBoss(S.BossTargetName)
			if m then
				local mp = fn.ModelPos(m)
				if mp then
					S.BossTPDone = true
					S.BossTPRetries = 0
					return
				end
			end
			task.wait(0.15)
		end
		local m3 = fn.CheckBoss(S.BossTargetName)
		local m3Close = m3 and fn.ModelPos(m3) and fn.DistTo(fn.ModelPos(m3)) < 500
		if m3 and not m3Close then
			S.BossTPDone = true
			S.BossTPRetries = 0
			return
		end
		if not m3 then
			S.BossTPRetries = (S.BossTPRetries or 0) + 1
			if S.BossTPRetries < 3 then
				S.Notify.new({
					Title = "Retrying TP",
					Content = fn.GetBossDisplay(S.BossTargetName or "?") .. " not found (" .. S.BossTPRetries .. "/3)",
					Duration = 2,
					Icon = S.ICON,
				})
				S.BossCurrentIsland = nil
				S.LastBossTP = 0
				return
			end
			S.BossTPRetries = 0
			fn.RecordBossDeath(S.BossTargetName)
			S.Notify.new({
				Title = "Skipping " .. fn.GetBossDisplay(S.BossTargetName or "?"),
				Content = "Not found after 3 TP attempts",
				Duration = 3,
				Icon = S.ICON,
			})
			local skippedName = S.BossTargetName
			S.BossTargetName = nil
			S.BossTPDone = false
			fn.ClearTgt()
			S.HoverPos = nil
			task.wait(0.15)
			local nextName = fn.PickNextBossName()
			if nextName then
				S.BossTargetName = nextName
				local nextIsland = fn.GetBossIsland(nextName)
				if nextIsland == S.BossCurrentIsland then
					S.BossTPDone = true
				else
					S.BossTPDone = false
					S.LastBossTP = 0
					S.HoverPos = nil
				end
				if F.BossNotify then
					S.Notify.new({
						Title = "Next: " .. fn.GetBossDisplay(nextName),
						Content = "Locating at " .. fn.PortalDisplayName(nextIsland or "?"),
						Duration = 3,
						Icon = S.ICON,
					})
				end
			else
				fn.ExitBossMode(skippedName)
			end
		else
			S.BossTPDone = true
			S.BossTPRetries = 0
		end
		return
	end
	local model = fn.CheckBoss(S.BossTargetName)
	if model and fn.IsAnosModel(S.BossTargetName) and model.Name ~= S.BossTargetName then
		S.BossTargetName = model.Name
	end
	if not model then
		local deadName = S.BossTargetName
		local deadIsland = fn.GetBossIsland(deadName)
		fn.RecordBossDeath(deadName)
		if F.BossNotify and not F.PityBossEnabled then
			S.Notify.new({
				Title = "Defeated " .. fn.GetBossDisplay(deadName or "?"),
				Content = "Successfully defeated " .. fn.GetBossDisplay(deadName or "?"),
				Duration = 4,
				Icon = S.ICON,
			})
		end
		local savedHover = S.HoverPos
		if not savedHover then
			local hrp = fn.PlayerHRP()
			if hrp then
				savedHover = Vector3.new(hrp.Position.X, hrp.Position.Y + F.HeightOffset, hrp.Position.Z)
			end
		end
		S.BossTargetName = nil
		S.BossTPDone = false
		fn.ClearTgt()
		S.HoverPos = savedHover
		local nextName = fn.PickNextBossName()
		if nextName then
			S.BossTargetName = nextName
			local nextIsland = fn.GetBossIsland(nextName)
			if nextIsland == S.BossCurrentIsland then
				S.BossTPDone = true
				S.HoverPos = savedHover
			else
				S.BossTPDone = false
				S.LastBossTP = 0
				S.HoverPos = nil
			end
			if F.BossNotify then
				S.Notify.new({
					Title = "Next: " .. fn.GetBossDisplay(nextName),
					Content = "Locating at " .. fn.PortalDisplayName(nextIsland or "?"),
					Duration = 3,
					Icon = S.ICON,
				})
			end
		else
			fn.ExitBossMode(deadName)
		end
		return
	end
	local bossP = fn.ModelPos(model)
	if not bossP then
		task.wait(0.3)
		return
	end
	local bDist = fn.DistTo(bossP)
	if bDist > 1500 then
		S.BossTPDone = false
		return
	end
	if bDist > 500 then
		local goal = Vector3.new(bossP.X, bossP.Y + F.HeightOffset, bossP.Z)
		local hrp = fn.PlayerHRP()
		if hrp then
			if F.MoveMode == "Teleport" then
				fn.StopTw()
				hrp.CFrame = CFrame.new(goal)
			else
				if S.TweenOn and S.ATween and S.TweenPointGoal then
					local drift = (S.TweenPointGoal - goal).Magnitude
					if drift < 300 then
						return
					end
				end
				local d = (hrp.Position - goal).Magnitude
				local spd = math.max(F.TweenSpeed or 100, 20)
				fn.StopTw()
				S.TweenOn = true
				S.TweenPointGoal = goal
				local dur = math.clamp(d / spd, 0.06, 8.0)
				S.ATween = TweenService:Create(hrp, TweenInfo.new(dur, Enum.EasingStyle.Linear), { CFrame = CFrame.new(goal) })
				S.ATweenConn = S.ATween.Completed:Connect(function()
					S.ATween = nil
					S.ATweenConn = nil
					S.TweenOn = false
					S.TweenPointGoal = nil
				end)
				S.ATween:Play()
			end
		end
		return
	end
	if S.TweenOn and S.TweenPointGoal then
		local drift = (S.TweenPointGoal - bossP).Magnitude
		if drift < 80 then
			fn.Attack(model)
			return
		end
	end
	S.CurTarget = model
	fn.TweenTo(model)
	fn.Attack(model)
	if F.AutoEquip and tick() - S.LastEquip > 3 then
		S.LastEquip = tick()
		fn.EquipBothWeapons()
	end
end
fn.GetSummonBossDiff = function(name)
	if name == "GilgameshBoss" then
		return F.GilgameshDiff
	end
	if name == "BlessedMaidenBoss" then
		return F.BlessedMaidenDiff
	end
	if name == "SaberAlterBoss" then
		return F.SaberAlterDiff
	end
	if name == "RimuruBoss" then
		return F.RimuruDiff
	end
	if name == "AnosBoss" then
		return F.AnosDiff
	end
	if name == "StrongestTodayBoss" then
		return F.StrongestTodayDiff
	end
	if name == "StrongestHistoryBoss" then
		return F.StrongestHistoryDiff
	end
	if name == "TrueAizenBoss" then
		return F.TrueAizenDiff
	end
	if name == "AtomicBoss" then
		return F.AtomicDiff
	end
	return nil
end
fn.GetItemCount = function(itemName)
	local best = 0
	local target = (itemName or ""):lower()
	local targetNorm = target:gsub("[%s_%-]", "")
	pcall(function()
		local direct = LP:FindFirstChild(itemName, true)
		if direct and (direct:IsA("IntValue") or direct:IsA("NumberValue") or direct:IsA("StringValue")) then
			best = tonumber(direct.Value) or best
		end
	end)
	pcall(function()
		for _, d in ipairs(LP:GetDescendants()) do
			if d:IsA("IntValue") or d:IsA("NumberValue") or d:IsA("StringValue") then
				local n = (d.Name or ""):lower()
				local nNorm = n:gsub("[%s_%-]", "")
				if n == target or nNorm == targetNorm or n:find(target, 1, true) then
					local v = tonumber(d.Value)
					if v and v > best then
						best = v
					end
				end
			end
		end
	end)
	return best
end
fn.TryCraftSlimeKey = function(craftMax)
	local ok, remote = pcall(function()
		return fn.WalkPathWait(RS, 2, unpack(R.SlimeCraft))
	end)
	if not ok or not remote then
		return false
	end
	local keyNames = { "Slime Key", "SlimeKey" }
	local function keyCount()
		local best = 0
		for _, nm in ipairs(keyNames) do
			best = math.max(best, fn.GetItemCount(nm))
		end
		return best
	end
	local qty = 999
	if craftMax and craftMax > 0 then
		qty = math.max(1, math.floor(craftMax))
	end
	local startKeys = keyCount()
	local argSets = {
		{ "SlimeKey", qty },
		{ "Slime Key", qty },
		{ "SlimeKey" },
		{ "Slime Key" },
		{ qty },
		{},
	}
	local did = false
	for _, args in ipairs(argSets) do
		local fired = false
		pcall(function()
			if remote:IsA("RemoteFunction") then
				remote:InvokeServer(table.unpack(args))
				fired = true
			elseif remote:IsA("RemoteEvent") then
				remote:FireServer(table.unpack(args))
				fired = true
			end
		end)
		if fired then
			did = true
		end
		task.wait(0.08)
		if keyCount() > startKeys then
			return true
		end
	end
	return did
end
fn.TrySpawnRimuru = function(diff)
	pcall(function()
		local r = fn.WalkPathWait(RS, 2, unpack(R.RimuruSpawn))
		if r then
			r:FireServer(diff or "Normal")
		end
	end)
end
fn.DetectSummonError = function()
	local found = false
	pcall(function()
		local pg = LP:FindFirstChild("PlayerGui")
		if not pg then
			return
		end
		for _, d in ipairs(pg:GetDescendants()) do
			if d:IsA("TextLabel") or d:IsA("TextButton") then
				local txt = (d.Text or ""):lower()
				if
					(
						(
							txt:find("don't have")
							or txt:find("doesn't have")
							or txt:find("don%'t have")
							or txt:find("not enough")
						)
						and (txt:find("material") or txt:find("item") or txt:find("summon") or txt:find("spawn"))
					)
					or txt:find("cannot summon")
					or txt:find("can't summon")
					or txt:find("can%'t summon")
				then
					found = true
					local p = d
					while p and not p:IsA("ScreenGui") do
						p = p.Parent
					end
					if p then
						pcall(function()
							p.Enabled = false
						end)
					end
					pcall(function()
						d.Visible = false
					end)
				end
			end
		end
	end)
	return found
end
fn.FireAutoSpawn = function(name)
	if not S.BSF[name] then
		return
	end
	if S.AutoSpawnActive[name] then
		return
	end
	local existing = fn.CheckSummonBoss(name)
	if existing and fn.SummonBossPosValid(existing) then
		S.AutoSpawnActive[name] = "passive"
		return
	end
	if not S.SummonBossLockedDiff[name] then
		S.SummonBossLockedDiff[name] = fn.GetSummonBossDiff(name) or "Normal"
	end
	local diff = S.SummonBossLockedDiff[name]
	pcall(function()
		if name == "AtomicBoss" then
			local r = fn.WalkPathWait(RS, 3, unpack(R.AutoSpawnAtomic))
			if r then
				r:FireServer(diff)
				S.AutoSpawnActive[name] = "fired"
			end
		elseif name == "AnosBoss" then
			local r = fn.WalkPathWait(RS, 3, unpack(R.AutoSpawnAnos))
			if r then
				r:FireServer("Anos", diff)
				S.AutoSpawnActive[name] = "fired"
			end
		elseif name == "RimuruBoss" then
			fn.TryCraftSlimeKey()
			fn.TrySpawnRimuru(diff)
			local r = fn.WalkPathWait(RS, 3, unpack(R.AutoSpawnRimuru))
			if r then
				r:FireServer(diff)
				S.AutoSpawnActive[name] = "fired"
			end
		elseif name == "StrongestTodayBoss" then
			local r = fn.WalkPathWait(RS, 3, unpack(R.AutoSpawnStrongest))
			if r then
				r:FireServer("StrongestToday", diff)
				S.AutoSpawnActive[name] = "fired"
			end
		elseif name == "StrongestHistoryBoss" then
			local r = fn.WalkPathWait(RS, 3, unpack(R.AutoSpawnStrongest))
			if r then
				r:FireServer("StrongestHistory", diff)
				S.AutoSpawnActive[name] = "fired"
			end
		elseif name == "TrueAizenBoss" then
			local r = fn.WalkPathWait(RS, 3, unpack(R.AutoSpawnTrueAizen))
			if r then
				r:FireServer(diff)
				S.AutoSpawnActive[name] = "fired"
			end
		else
			local r = fn.WalkPathWait(RS, 3, unpack(R.AutoSpawnBoss))
			if r then
				r:FireServer(name, diff)
				S.AutoSpawnActive[name] = "fired"
			end
		end
	end)
end
fn.DisableAutoSpawn = function(name)
	if S.AutoSpawnActive[name] == "fired" then
		local diff = S.SummonBossLockedDiff[name] or fn.GetSummonBossDiff(name) or "Normal"
		pcall(function()
			if name == "AtomicBoss" then
				local r = fn.WalkPathWait(RS, 3, unpack(R.AutoSpawnAtomic))
				if r then
					r:FireServer(diff)
				end
			elseif name == "AnosBoss" then
				local r = fn.WalkPathWait(RS, 3, unpack(R.AutoSpawnAnos))
				if r then
					r:FireServer("Anos", diff)
				end
			elseif name == "RimuruBoss" then
				local r = fn.WalkPathWait(RS, 3, unpack(R.AutoSpawnRimuru))
				if r then
					r:FireServer(diff)
				end
			elseif name == "StrongestTodayBoss" then
				local r = fn.WalkPathWait(RS, 3, unpack(R.AutoSpawnStrongest))
				if r then
					r:FireServer("StrongestToday", diff)
				end
			elseif name == "StrongestHistoryBoss" then
				local r = fn.WalkPathWait(RS, 3, unpack(R.AutoSpawnStrongest))
				if r then
					r:FireServer("StrongestHistory", diff)
				end
			elseif name == "TrueAizenBoss" then
				local r = fn.WalkPathWait(RS, 3, unpack(R.AutoSpawnTrueAizen))
				if r then
					r:FireServer(diff)
				end
			else
				local r = fn.WalkPathWait(RS, 3, unpack(R.AutoSpawnBoss))
				if r then
					r:FireServer(name, diff)
				end
			end
		end)
	end
	S.AutoSpawnActive[name] = nil
end
fn.DisableAllAutoSpawn = function()
	for _, b in ipairs(S.SummonBosses) do
		if S.AutoSpawnActive[b.Name] then
			fn.DisableAutoSpawn(b.Name)
		end
	end
	S.AutoSpawnActive = {}
end
fn.FireSummonBoss = function(name)
	fn.FireAutoSpawn(name)
end
fn.GetSummonBossIsland = function(name)
	return S.SummonBossIslandMap[name] or S.BOSS_ISLAND_PORTAL
end
fn.CheckSummonBoss = function(name)
	if not name then
		return nil
	end
	local nf = fn.GetNPCFolder()
	if not nf then
		return nil
	end
	if name == "AnosBoss" then
		for _, m in ipairs(nf:GetChildren()) do
			if m:IsA("Model") and fn.IsAnosModel(m.Name) then
				local hm = fn.GetHum(m)
				if hm and hm.Health > 0 then
					return m
				end
			end
		end
		return nil
	end
	if name == "RimuruBoss" then
		for _, m in ipairs(nf:GetChildren()) do
			if m:IsA("Model") and fn.IsRimuruModel(m.Name) then
				local hm = fn.GetHum(m)
				if hm and hm.Health > 0 then
					return m
				end
			end
		end
		return nil
	end
	if name == "StrongestTodayBoss" then
		for _, m in ipairs(nf:GetChildren()) do
			if m:IsA("Model") and fn.IsStrongestTodayModel(m.Name) then
				local hm = fn.GetHum(m)
				if hm and hm.Health > 0 then
					return m
				end
			end
		end
		return nil
	end
	if name == "StrongestHistoryBoss" then
		for _, m in ipairs(nf:GetChildren()) do
			if m:IsA("Model") and fn.IsStrongestHistoryModel(m.Name) then
				local hm = fn.GetHum(m)
				if hm and hm.Health > 0 then
					return m
				end
			end
		end
		return nil
	end
	if name == "TrueAizenBoss" then
		for _, m in ipairs(nf:GetChildren()) do
			if m:IsA("Model") and fn.IsTrueAizenModel(m.Name) then
				local hm = fn.GetHum(m)
				if hm and hm.Health > 0 then
					return m
				end
			end
		end
		return nil
	end
	local nameLo = name:lower()
	for _, m in ipairs(nf:GetChildren()) do
		if m:IsA("Model") then
			local mLo = (m.Name or ""):lower()
			if mLo == nameLo or mLo:sub(1, #nameLo) == nameLo then
				local hm = fn.GetHum(m)
				if hm and hm.Health > 0 then
					return m
				end
			end
		end
	end
	return nil
end
fn.HasAnySummonBossEnabled = function()
	for _, b in ipairs(S.SummonBosses) do
		if S.BSF[b.Name] then
			return true
		end
	end
	return false
end
fn.ExitSummonBossMode = function()
	fn.DisableAllAutoSpawn()
	local prevIsland = S.SummonBossCurrentIsland
	S.SummonBossFight = false
	S.SummonBossTarget = nil
	S.SummonBossTPDone = false
	S.LastSummonBossTP = 0
	S.SummonBossCommitted = {}
	S.SummonBossCurrentIsland = nil
	S.SummonBossOrder = 0
	S.SummonBossFailCount = {}
	S.SummonBossFireTime = {}
	S.SummonBossLockedDiff = {}
	fn.ClearTgt()
	S.HoverPos = nil
	S.LastEnemy = 0
	S.LastTP = 0
	local farmIsland = F.AutoFarmLevel and fn.GetFarmIsland() or nil
	if farmIsland and prevIsland and farmIsland.Portal == prevIsland then
		S.CurIsland = farmIsland
		S.IslandTPd = true
		S.SpawnDone = true
		S.LastEnemy = tick()
		if F.AutoQuest and S.QState ~= "ACTIVE" then
			task.delay(0.1, function()
				fn.QuestAccept(S.CurIsland)
			end)
		end
	else
		S.CurIsland = nil
		S.IslandTPd = false
		S.SpawnDone = false
	end
end
fn.GetCurrentPity = function()
	local ok, current, max = pcall(function()
		local pg = LP:FindFirstChild("PlayerGui")
		if not pg then return nil end
		local bossUI = pg:FindFirstChild("BossUI")
		if not bossUI then return nil end
		local mf = bossUI:FindFirstChild("MainFrame")
		if not mf then return nil end
		local hpBar = mf:FindFirstChild("BossHPBar")
		if not hpBar then return nil end
		local pityLabel = hpBar:FindFirstChild("Pity")
		if not pityLabel then return nil end
		local c, m = pityLabel.Text:match("Pity: (%d+)/(%d+)")
		if c and m then
			return tonumber(c), tonumber(m)
		end
		return nil
	end)
	if ok and current ~= nil then
		S._pityCached = current
		S._pityMaxCached = max
		return current, max
	end
	return S._pityCached or 0, S._pityMaxCached or 25
end
fn.IsPityReady = function()
	if not F.PityBossEnabled then return false end
	if not S.PityUseBoss then return false end
	local current, max = fn.GetCurrentPity()
	return current >= (max - 1)
end
fn.PitySummonDirect = function(name, diff)
	if not name then return end
	diff = diff or "Normal"
	local existing = fn.CheckSummonBoss(name)
	if existing and fn.SummonBossPosValid(existing) then return end
	local isSummonable = false
	for _, b in ipairs(S.SummonBosses) do
		if b.Name == name then isSummonable = true break end
	end
	if not isSummonable then return end
	pcall(function()
		if name == "RimuruBoss" then
			fn.TryCraftSlimeKey()
			fn.TrySpawnRimuru(diff)
		elseif name == "AnosBoss" then
			local r = fn.WalkPathWait(RS, 3, unpack(R.AnosBoss))
			if r then r:FireServer("Anos", diff) end
		elseif name == "StrongestTodayBoss" then
			local r = fn.WalkPathWait(RS, 3, unpack(R.StrongestBoss))
			if r then r:FireServer("StrongestToday", diff) end
		elseif name == "StrongestHistoryBoss" then
			local r = fn.WalkPathWait(RS, 3, unpack(R.StrongestBoss))
			if r then r:FireServer("StrongestHistory", diff) end
		elseif name == "TrueAizenBoss" then
			local r = fn.WalkPathWait(RS, 3, unpack(R.TrueAizenSpawn))
			if r then r:FireServer(diff) end
		elseif name == "AtomicBoss" then
			local r = fn.WalkPathWait(RS, 3, unpack(R.AtomicSpawn))
			if r then r:FireServer(diff) end
		else
			local summonId = S._pitySummonIds[name]
			if summonId then
				local r = fn.WalkPathWait(RS, 3, unpack(R.SummonBoss))
				if r then r:FireServer(summonId, diff) end
			end
		end
	end)
end
fn.SummonBossPosValid = function(model)
	local p = fn.ModelPos(model)
	if not p then
		return false
	end
	if p.Y < -30 then
		return false
	end
	return true
end
fn.AcquireSummonBossFast = function(preferredName, timeout)
	local deadline = tick() + (timeout or 1.2)
	while tick() < deadline do
		if preferredName then
			local preferred = fn.CheckSummonBoss(preferredName)
			if preferred and fn.SummonBossPosValid(preferred) then
				return preferredName, preferred
			end
		end
		for _, b in ipairs(S.SummonBosses) do
			if S.BSF[b.Name] or S.SummonBossCommitted[b.Name] then
				local m = fn.CheckSummonBoss(b.Name)
				if m and fn.SummonBossPosValid(m) then
					return b.Name, m
				end
			end
		end
		task.wait(0.05)
	end
	return nil, nil
end
fn.DoSummonBossTick = function()
	local function PickBestTarget()
		local bestName, bestOrder = nil, math.huge
		local hrp = fn.PlayerHRP()
		for _, b in ipairs(S.SummonBosses) do
			if S.SummonBossCommitted[b.Name] then
				local m = fn.CheckSummonBoss(b.Name)
				if m and fn.SummonBossPosValid(m) then
					local ord = S.SummonBossCommitted[b.Name]
					if type(ord) == "number" and ord < bestOrder then
						bestOrder = ord
						bestName = b.Name
					end
				end
			end
		end
		if bestName then
			return bestName
		end
		local bestDist = math.huge
		for _, b in ipairs(S.SummonBosses) do
			if S.BSF[b.Name] or S.SummonBossCommitted[b.Name] then
				local m = fn.CheckSummonBoss(b.Name)
				if m and fn.SummonBossPosValid(m) then
					if not hrp then
						return b.Name
					end
					local p = fn.ModelPos(m)
					local d = p and (hrp.Position - p).Magnitude or math.huge
					if d < bestDist then
						bestDist = d
						bestName = b.Name
					end
				end
			end
		end
		return bestName
	end
	local function SummonAllEnabled()
		for _, b in ipairs(S.SummonBosses) do
			if S.BSF[b.Name] and fn.GetSummonBossIsland(b.Name) == S.SummonBossCurrentIsland then
				fn.FireAutoSpawn(b.Name)
				if not S.SummonBossCommitted[b.Name] then
					S.SummonBossFireTime[b.Name] = tick()
					S.SummonBossOrder = S.SummonBossOrder + 1
					S.SummonBossCommitted[b.Name] = S.SummonBossOrder
				end
				task.wait(0.15)
			end
		end
	end
	if not S.SummonBossTPDone then
		if tick() - S.LastSummonBossTP < 2 then
			task.wait(0.2)
			return
		end
		local targetIsland = S.BOSS_ISLAND_PORTAL
		local bestOrd = math.huge
		for _, b in ipairs(S.SummonBosses) do
			if S.BSF[b.Name] then
				local isl = fn.GetSummonBossIsland(b.Name)
				local ord = S.SummonBossCommitted[b.Name]
				if type(ord) == "number" and ord < bestOrd then
					bestOrd = ord
					targetIsland = isl
				end
			end
		end
		if bestOrd == math.huge then
			local hasBossIsland, hasOther = false, false
			for _, b in ipairs(S.SummonBosses) do
				if S.BSF[b.Name] then
					if fn.GetSummonBossIsland(b.Name) == S.BOSS_ISLAND_PORTAL then
						hasBossIsland = true
					else
						hasOther = true
					end
				end
			end
			if hasBossIsland then
				targetIsland = S.BOSS_ISLAND_PORTAL
			elseif hasOther then
				for _, b in ipairs(S.SummonBosses) do
					if S.BSF[b.Name] then
						targetIsland = fn.GetSummonBossIsland(b.Name)
						break
					end
				end
			end
		end
		S.LastSummonBossTP = tick()
		local bossDisp = ""
		for _, b in ipairs(S.SummonBosses) do
			if S.BSF[b.Name] then
				bossDisp = b.Display
				break
			end
		end
		local alreadyOnIsland = S.CurIsland and S.IslandTPd and S.CurIsland.Portal == targetIsland
		if not alreadyOnIsland then
			fn.ForceTP(targetIsland)
			S.SummonBossCurrentIsland = targetIsland
			SummonAllEnabled()
			task.wait(0.8)
		else
			S.SummonBossCurrentIsland = targetIsland
			SummonAllEnabled()
		end
		local _hrp = fn.PlayerHRP()
		if _hrp then
			S.HoverPos = _hrp.Position
		end
		local nextName, nextModel = fn.AcquireSummonBossFast(nil, 2.0)
		if not nextName then
			task.wait(0.3)
			nextName, nextModel = fn.AcquireSummonBossFast(nil, 2.0)
		end
		if nextModel then
			local bp = fn.ModelPos(nextModel)
			if bp then
				local goal = Vector3.new(bp.X, bp.Y + F.HeightOffset, bp.Z)
				local hrp = fn.PlayerHRP()
				local d = hrp and (hrp.Position - goal).Magnitude or math.huge
				if d <= 1500 then
					fn.TweenToPoint(goal)
					S.HoverPos = goal
				end
			end
		end
		S.SummonBossTPDone = true
		S.SummonBossTarget = nextName
		if nextModel then
			S.CurTarget = nextModel
		end
		return
	end
	if not S.SummonBossTarget then
		S.SummonBossTarget = PickBestTarget()
		if not S.SummonBossTarget then
			local anyGrace = false
			for _, b in ipairs(S.SummonBosses) do
				if
					S.SummonBossCommitted[b.Name]
					and fn.GetSummonBossIsland(b.Name) == S.SummonBossCurrentIsland
					and not fn.CheckSummonBoss(b.Name)
				then
					local fireT = S.SummonBossFireTime[b.Name] or 0
					if tick() - fireT < 4 then
						anyGrace = true
					else
						S.SummonBossFailCount[b.Name] = (S.SummonBossFailCount[b.Name] or 0) + 1
						if (S.SummonBossFailCount[b.Name] or 0) >= 3 then
							fn.DisableAutoSpawn(b.Name)
							S.SummonBossCommitted[b.Name] = nil
							S.BSF[b.Name] = false
							local tgl = S.BSFToggle[b.Name]
							if tgl then
								pcall(function()
									tgl:SetValue(false)
								end)
							end
							local dsp = S.SummonBossDisplay[b.Name] or b.Name
							S.Notify.new({
								Title = "Summon Failed",
								Content = dsp .. " disabled — no materials?",
								Duration = 5,
								Icon = S.ICON,
							})
						else
							fn.FireSummonBoss(b.Name)
							S.SummonBossFireTime[b.Name] = tick()
							anyGrace = true
						end
					end
				end
			end
			if anyGrace then
				task.wait(0.2)
				return
			end
			if not fn.HasAnySummonBossEnabled() then
				fn.ExitSummonBossMode()
				return
			end
			SummonAllEnabled()
			local nextName, _ = fn.AcquireSummonBossFast(nil, 3.0)
			S.SummonBossTarget = nextName
			if not S.SummonBossTarget then
				for _, b in ipairs(S.SummonBosses) do
					if S.BSF[b.Name] and fn.GetSummonBossIsland(b.Name) ~= S.SummonBossCurrentIsland then
						S.SummonBossTPDone = false
						S.LastSummonBossTP = 0
						fn.ClearTgt()
						return
					end
				end
				task.wait(0.3)
			end
			return
		end
		S.Notify.new({
			Title = "Summon Boss: " .. (S.SummonBossDisplay[S.SummonBossTarget] or S.SummonBossTarget),
			Content = "Attacking!",
			Duration = 2,
			Icon = S.ICON,
		})
	end
	local targetIsland = fn.GetSummonBossIsland(S.SummonBossTarget)
	if targetIsland ~= S.SummonBossCurrentIsland then
		S.SummonBossTPDone = false
		S.LastSummonBossTP = 0
		fn.ClearTgt()
		return
	end
	local model = fn.CheckSummonBoss(S.SummonBossTarget)
	if not model then
		local deadName = S.SummonBossTarget
		local deadDisplay = S.SummonBossDisplay[deadName] or deadName
		S.Notify.new({
			Title = "Boss Notification",
			Content = "Successfully defeated " .. deadDisplay .. "!",
			Duration = 4,
			Icon = S.ICON,
		})
		S.SummonBossCommitted[deadName] = nil
		S.SummonBossFailCount[deadName] = 0
		S.SummonBossTarget = nil
		fn.ClearTgt()
		if S.BSF[deadName] and fn.GetSummonBossIsland(deadName) == S.SummonBossCurrentIsland then
			S.SummonBossFireTime[deadName] = tick()
			S.SummonBossOrder = S.SummonBossOrder + 1
			S.SummonBossCommitted[deadName] = S.SummonBossOrder
		end
		local nextName, nextModel = fn.AcquireSummonBossFast(deadName, 2)
		S.SummonBossTarget = nextName
		if nextModel then
			S.CurTarget = nextModel
		end
		return
	end
	local bossPos = fn.ModelPos(model)
	if not bossPos or bossPos.Y < -30 then
		task.wait(0.15)
		return
	end
	local dist = fn.DistTo(bossPos)
	if dist > 1500 then
		S.SummonBossTPDone = false
		S.LastSummonBossTP = 0
		fn.ClearTgt()
		return
	end
	S.CurTarget = model
	local goal = Vector3.new(bossPos.X, bossPos.Y + F.HeightOffset, bossPos.Z)
	local hrpNow = fn.PlayerHRP()
	local hDist = hrpNow and Vector3.new(hrpNow.Position.X - bossPos.X, 0, hrpNow.Position.Z - bossPos.Z).Magnitude
		or dist
	if hDist > 80 then
		fn.TweenToPoint(goal)
	elseif hDist > 15 then
		fn.TweenTo(model)
	end
	S.HoverPos = goal
	S.LockTarget = model
	fn.Attack(model)
	if F.AutoEquip and tick() - S.LastEquip > 3 then
		S.LastEquip = tick()
		fn.EquipBothWeapons()
	end
end
fn.ClickButton = function(btn)
	if not btn or not btn.Visible then
		return false
	end
	pcall(function()
		for _, conn in ipairs(getconnections(btn.Activated)) do
			conn:Fire()
		end
	end)
	pcall(function()
		for _, conn in ipairs(getconnections(btn.MouseButton1Click)) do
			conn:Fire()
		end
	end)
	return true
end
fn.FireAutoStart = function()
	if tick() - S.LastAutoStart < 3 then
		return
	end
	S.LastAutoStart = tick()
	local pg = LP:FindFirstChild("PlayerGui")
	if not pg then
		return
	end
	local dui = pg:FindFirstChild("DungeonUI")
	if not dui then
		return
	end
	local replayFrame = dui:FindFirstChild("ReplayDungeonFrameVisibleOnlyWhenClearingDungeon")
	if replayFrame and replayFrame.Visible then
		local btn = replayFrame:FindFirstChild("Holder")
			and replayFrame.Holder:FindFirstChild("Button")
			and replayFrame.Holder.Button:FindFirstChild("ReplayDungeonButton")
		if btn then
			fn.ClickButton(btn)
		end
		return
	end
	local cf = dui:FindFirstChild("ContentFrame")
	if cf and cf.Visible then
		local pv = cf:FindFirstChild("PeopleVoted")
		local btn = pv and pv:FindFirstChild("ButtonFrame") and pv.ButtonFrame:FindFirstChild("StartButton")
		if btn then
			fn.ClickButton(btn)
		end
		pcall(function()
			local r = fn.WalkPathWait(RS, 2, unpack(R.DungeonVote))
			if r then
				r:FireServer("start")
			end
		end)
	end
end
fn.DoAutoDungeonTick = function()
	if tick() - S.LastDungeonVote > 10 then
		S.LastDungeonVote = tick()
		fn.FireDungeonVote()
	end
	local prevTarget = S.CurTarget
	local enemies = fn.FindDungeonEnemiesKnown(S.GENERIC_HOSTILE_MAX_DIST)
	if F.AutoEquip and tick() - S.LastEquip > 3 then
		S.LastEquip = tick()
		fn.EquipBothWeapons()
	end
	if #enemies == 0 then
		S.CurTarget = nil
		S.LockTarget = nil
		fn.FireAutoStart()
		fn.HoldDungeonIdleHover()
		task.wait(0.12)
		return
	end
	local best, bestDist = nil, math.huge
	for _, e in ipairs(enemies) do
		local p = fn.ModelPos(e)
		if p then
			local d = fn.DistTo(p)
			if d < bestDist then
				best = e
				bestDist = d
			end
		end
	end
	if S.CurTarget then
		local hm = fn.GetHum(S.CurTarget)
		if
			not fn.IsKnownDungeonEnemy(S.CurTarget)
			or not hm
			or hm.Health <= 0
			or not S.CurTarget.Parent
			or fn.IsPlayer(S.CurTarget)
		then
			S.CurTarget = nil
			S.LockTarget = nil
			S.HoverPos = nil
		else
			local cp = fn.ModelPos(S.CurTarget)
			if cp and fn.DistTo(cp) > 900 then
				S.CurTarget = nil
				S.LockTarget = nil
				S.HoverPos = nil
			end
		end
	end
	if not S.CurTarget then
		S.CurTarget = best
		if S.CurTarget then
			S.LastDungeonSwitch = tick()
		end
	end
	if S.CurTarget and prevTarget and S.CurTarget ~= prevTarget then
		fn.StopTw()
		S.LockTarget = nil
		S.HoverPos = nil
	end
	if not S.CurTarget then
		S.LockTarget = nil
		if not S.HoverPos then
			fn.HoldDungeonIdleHover()
		end
		task.wait(0.12)
		return
	end
	if S.CurTarget then
		fn.TweenToDungeon(S.CurTarget)
		fn.Attack(S.CurTarget)
	end
end
fn.IsBossRushEnemy = function(model)
	if not model or not model:IsA("Model") then
		return false
	end
	local lo = (model.Name or ""):lower()
	if S.BossRushEnemySet[lo] then
		return true
	end
	for name in pairs(S.BossRushEnemySet) do
		if lo:sub(1, #name) == name then
			return true
		end
	end
	return false
end
fn.HasBossRushEnemiesInWorkspace = function()
	local nf = fn.GetNPCFolder()
	if nf then
		for _, m in ipairs(nf:GetChildren()) do
			if m:IsA("Model") and fn.IsBossRushEnemy(m) and not fn.IsPlayer(m) then
				local hm = fn.GetHum(m)
				if hm and hm.Health > 0 then
					return true
				end
			end
		end
	end
	return false
end
fn.FindBossRushEnemies = function(maxDist)
	local hrp = fn.PlayerHRP()
	if not hrp then
		return {}
	end
	local maxD = maxDist or S.GENERIC_HOSTILE_MAX_DIST
	local out = {}
	local function addIfMatch(m)
		if not m:IsA("Model") then
			return
		end
		if fn.IsPlayer(m) then
			return
		end
		if not fn.IsBossRushEnemy(m) then
			return
		end
		local hm = fn.GetHum(m)
		if not hm or hm.Health <= 0 then
			return
		end
		local p = fn.ModelPos(m)
		if not p then
			return
		end
		if (p - hrp.Position).Magnitude > maxD then
			return
		end
		table.insert(out, m)
	end
	local nf = fn.GetNPCFolder()
	if nf then
		for _, desc in ipairs(nf:GetChildren()) do
			if desc:IsA("Model") then
				addIfMatch(desc)
			end
		end
	end
	return out
end
fn.DoBossRushTick = function()
	if F.AutoEquip and tick() - S.LastEquip > 3 then
		S.LastEquip = tick()
		fn.EquipBothWeapons()
	end
	local prevTarget = S.CurTarget
	local enemies = fn.FindBossRushEnemies(S.GENERIC_HOSTILE_MAX_DIST)
	if #enemies == 0 then
		S.CurTarget = nil
		S.LockTarget = nil
		if tick() - S.LastBossRushVote > 10 then
			S.LastBossRushVote = tick()
			task.spawn(fn.FireBossRushVote)
		end
		fn.FireAutoStart()
		fn.HoldDungeonIdleHover()
		task.wait(0.12)
		return
	end
	local best, bestDist = nil, math.huge
	for _, e in ipairs(enemies) do
		local p = fn.ModelPos(e)
		if p then
			local d = fn.DistTo(p)
			if d < bestDist then
				best = e
				bestDist = d
			end
		end
	end
	if S.CurTarget then
		local hm = fn.GetHum(S.CurTarget)
		if
			not fn.IsBossRushEnemy(S.CurTarget)
			or not hm
			or hm.Health <= 0
			or not S.CurTarget.Parent
			or fn.IsPlayer(S.CurTarget)
		then
			S.CurTarget = nil
			S.LockTarget = nil
			S.HoverPos = nil
		else
			local cp = fn.ModelPos(S.CurTarget)
			if cp and fn.DistTo(cp) > 900 then
				S.CurTarget = nil
				S.LockTarget = nil
				S.HoverPos = nil
			end
		end
	end
	if not S.CurTarget then
		S.CurTarget = best
		if S.CurTarget then
			S.LastBossRushSwitch = tick()
		end
	end
	if S.CurTarget and prevTarget and S.CurTarget ~= prevTarget then
		fn.StopTw()
		S.LockTarget = nil
		S.HoverPos = nil
	end
	if not S.CurTarget then
		S.LockTarget = nil
		if not S.HoverPos then
			fn.HoldDungeonIdleHover()
		end
		task.wait(0.12)
		return
	end
	fn.TweenToBossRush(S.CurTarget)
	fn.Attack(S.CurTarget)
end
fn.IsTowerEnemy = function(model)
	if not model or not model:IsA("Model") then
		return false
	end
	if fn.IsKnownDungeonEnemy(model) then
		return true
	end
	if fn.IsBossRushEnemy(model) then
		return true
	end
	local lo = (model.Name or ""):lower()
	if lo:find("boss", 1, true) then
		local hm = fn.GetHum(model)
		if hm and hm.Health > 0 then
			return true
		end
	end
	return false
end
fn.FindTowerEnemies = function(maxDist)
	local hrp = fn.PlayerHRP()
	if not hrp then
		return {}
	end
	local maxD = maxDist or S.GENERIC_HOSTILE_MAX_DIST
	local out = {}
	local nf = fn.GetNPCFolder()
	if nf then
		for _, desc in ipairs(nf:GetChildren()) do
			if desc:IsA("Model") and not fn.IsPlayer(desc) and fn.IsTowerEnemy(desc) then
				local hm = fn.GetHum(desc)
				if hm and hm.Health > 0 then
					local p = fn.ModelPos(desc)
					if p and (p - hrp.Position).Magnitude <= maxD then
						table.insert(out, desc)
					end
				end
			end
			if desc:IsA("Folder") then
				for _, m in ipairs(desc:GetChildren()) do
					if m:IsA("Model") and not fn.IsPlayer(m) and fn.IsTowerEnemy(m) then
						local hm = fn.GetHum(m)
						if hm and hm.Health > 0 then
							local p = fn.ModelPos(m)
							if p and (p - hrp.Position).Magnitude <= maxD then
								table.insert(out, m)
							end
						end
					end
				end
			end
		end
	end
	return out
end
fn.DoInfiniteTowerTick = function()
	if F.AutoEquip and tick() - S.LastEquip > 3 then
		S.LastEquip = tick()
		fn.EquipBothWeapons()
	end
	local prevTarget = S.CurTarget
	local enemies = fn.FindTowerEnemies(S.GENERIC_HOSTILE_MAX_DIST)
	if #enemies == 0 then
		S.CurTarget = nil
		S.LockTarget = nil
		fn.FireAutoStart()
		fn.HoldDungeonIdleHover()
		task.wait(0.12)
		return
	end
	local best, bestDist = nil, math.huge
	for _, e in ipairs(enemies) do
		local p = fn.ModelPos(e)
		if p then
			local d = fn.DistTo(p)
			if d < bestDist then
				best = e
				bestDist = d
			end
		end
	end
	if S.CurTarget then
		local hm = fn.GetHum(S.CurTarget)
		if
			not fn.IsTowerEnemy(S.CurTarget)
			or not hm
			or hm.Health <= 0
			or not S.CurTarget.Parent
			or fn.IsPlayer(S.CurTarget)
		then
			S.CurTarget = nil
			S.LockTarget = nil
			S.HoverPos = nil
		else
			local cp = fn.ModelPos(S.CurTarget)
			if cp and fn.DistTo(cp) > 900 then
				S.CurTarget = nil
				S.LockTarget = nil
				S.HoverPos = nil
			end
		end
	end
	if not S.CurTarget then
		S.CurTarget = best
		if S.CurTarget then
			S.LastDungeonSwitch = tick()
		end
	end
	if S.CurTarget and prevTarget and S.CurTarget ~= prevTarget then
		fn.StopTw()
		S.LockTarget = nil
		S.HoverPos = nil
	end
	if not S.CurTarget then
		S.LockTarget = nil
		if not S.HoverPos then
			fn.HoldDungeonIdleHover()
		end
		task.wait(0.12)
		return
	end
	fn.TweenWithSettings(S.CurTarget, F.TowerMoveMode, F.TowerTweenSpeed, F.TowerFarmMode, F.TowerHeightOffset)
	fn.Attack(S.CurTarget)
end
fn.GetFollowTarget = function()
	if not F.FollowPlayerName or F.FollowPlayerName == "" then
		return nil
	end
	local target = F.FollowPlayerName:lower()
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LP and (p.Name:lower() == target or (p.DisplayName and p.DisplayName:lower() == target)) then
			return p
		end
	end
	for _, p in ipairs(Players:GetPlayers()) do
		if
			p ~= LP
			and (
				p.Name:lower():find(target, 1, true) or (p.DisplayName and p.DisplayName:lower():find(target, 1, true))
			)
		then
			return p
		end
	end
	return nil
end
fn.GetPlayerIsland = function(player)
	if not player or not player.Character then
		return nil
	end
	local rp = player.Character:FindFirstChild("HumanoidRootPart")
	if not rp then
		return nil
	end
	local pos = rp.Position
	local nf = fn.GetNPCFolder()
	if not nf then
		return nil
	end
	local bestIsland, bestDist = nil, math.huge
	for _, isl in ipairs(S.Islands) do
		for _, ch in ipairs(nf:GetChildren()) do
			local function chk(m)
				if m:IsA("Model") and fn.MatchEnemy(m.Name, isl) then
					local mp = fn.ModelPos(m)
					if mp then
						local d = (mp - pos).Magnitude
						if d < bestDist then
							bestDist = d
							bestIsland = isl
						end
					end
				end
			end
			if ch:IsA("Model") then
				chk(ch)
			elseif ch:IsA("Folder") then
				for _, m in ipairs(ch:GetChildren()) do
					chk(m)
				end
			end
		end
	end
	return bestIsland
end
S.LastFollowTP = 0
fn.DoFollowPlayerTick = function()
	local player = fn.GetFollowTarget()
	if not player then
		task.wait(0.5)
		return
	end
	local char = player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then
		task.wait(0.3)
		return
	end
	local playerPos = fn.ModelPos(char)
	if not playerPos then
		task.wait(0.2)
		return
	end
	local hrp = fn.PlayerHRP()
	if not hrp then
		task.wait(0.2)
		return
	end
	local dist = (hrp.Position - playerPos).Magnitude
	if dist > 100 then
		fn.StopTw()
		S.LockTarget = nil
		if dist > 500 and tick() - S.LastFollowTP > 2 then
			S.LastFollowTP = tick()
			local pIsland = fn.GetPlayerIsland(player)
			if pIsland then
				fn.ForceTP(pIsland.Portal)
				task.wait(0.8)
			end
		end
		local hrp2 = fn.PlayerHRP()
		if hrp2 then
			local freshPos = fn.ModelPos(char)
			if freshPos then
				hrp2.CFrame = CFrame.new(freshPos + Vector3.new(0, F.HeightOffset or 15, 0))
			end
		end
		task.wait(0.2)
		return
	end
	local saveFM = F.FarmMode
	local saveOD = F.OffsetDist
	local saveMM = F.MoveMode
	local saveTS = F.TweenSpeed
	local saveFS = F.FollowStyle
	F.FarmMode = F.FollowPlayerMode or "Behind"
	F.OffsetDist = F.FollowPlayerDist or 10
	F.MoveMode = F.FollowPlayerMove or "Tween"
	F.TweenSpeed = F.FollowPlayerSpeed or 100
	F.FollowStyle = "Static"
	fn.TweenTo(char)
	F.FarmMode = saveFM
	F.OffsetDist = saveOD
	F.MoveMode = saveMM
	F.TweenSpeed = saveTS
	F.FollowStyle = saveFS
	fn.FireAbilities()
	if F.AutoEquip and tick() - S.LastEquip > 3 then
		S.LastEquip = tick()
		fn.EquipBothWeapons()
	end
end
fn.DisableGameAutoSkills = function()
	pcall(function()
		local r = fn.WalkPathWait(RS, 3, unpack(R.Settings))
		if not r then
			return
		end
		for _, skill in ipairs({ "AutoSkillZ", "AutoSkillX", "AutoSkillC", "AutoSkillV", "AutoSkillF" }) do
			pcall(function()
				r:FireServer(skill, false)
			end)
			task.wait(0.05)
		end
	end)
end
fn.AbandonDungeonQuest = function()
	pcall(function()
		local ab = fn.WalkPathWait(RS, 2, unpack(R.QuestAbandon))
		if ab then
			ab:FireServer("DungeonUnlock")
		end
	end)
end
fn.AcceptDungeonQuest = function()
	pcall(function()
		fn.WalkPathWait(RS, 2, "Remotes", "DungeonQuestAccept"):FireServer()
	end)
	task.wait(0.3)
	fn.ClickYes()
	task.wait(0.3)
	pcall(function()
		fn.WalkPathWait(RS, 2, unpack(R.QuestAccept)):FireServer("DungeonUnlock")
	end)
	task.wait(0.3)
	fn.ClickYes()
end
fn.FindDungeonPiece = function(island)
	local islandLow = island:lower()
	for _, desc in ipairs(workspace:GetDescendants()) do
		if desc.Name == "DungeonPuzzlePiece" and desc:IsA("BasePart") then
			local anc = desc.Parent
			while anc and anc ~= workspace do
				if anc.Name:lower():find(islandLow, 1, true) then
					return desc
				end
				anc = anc.Parent
			end
		end
	end
	return nil
end
fn.DungeonClear = function()
	fn.StopTw()
	fn.ClearTgt()
	S.HoverPos = nil
	S.LockTarget = nil
end
fn.DungeonCollectPiece = function(piece)
	fn.DungeonClear()
	local hrp = fn.PlayerHRP()
	if hrp then
		hrp.CFrame = CFrame.new(piece.Position + Vector3.new(0, 2, 0))
	end
	task.wait(0.15)
	local pp = piece:FindFirstChild("PuzzlePrompt") or piece:FindFirstChildOfClass("ProximityPrompt")
	if not pp then
		for _, ch in ipairs(piece:GetDescendants()) do
			if ch:IsA("ProximityPrompt") then
				pp = ch
				break
			end
		end
	end
	if pp then
		pcall(function()
			fireproximityprompt(pp)
		end)
		task.wait(0.2)
		pcall(function()
			fireproximityprompt(pp)
		end)
	end
end
fn.DungeonPieceHasPrompt = function(piece)
	if not piece then
		return false
	end
	local pp = piece:FindFirstChild("PuzzlePrompt") or piece:FindFirstChildOfClass("ProximityPrompt")
	if pp then
		return true
	end
	for _, ch in ipairs(piece:GetDescendants()) do
		if ch:IsA("ProximityPrompt") then
			return true
		end
	end
	return false
end
fn.DoDungeonQuestTick = function()
	if not F.DungeonQuest then
		return
	end
	local step = S.DungeonStep
	if step < 1 then
		fn.DungeonClear()
		local anyUncollected = false
		for _, isl in ipairs(S.DungeonPieceIslands) do
			local p = fn.FindDungeonPiece(isl)
			if p and fn.DungeonPieceHasPrompt(p) then
				anyUncollected = true
				break
			end
		end
		if not anyUncollected then
			fn.ForceTP(S.DungeonPieceIslands[1])
			task.wait(1)
			fn.WaitChar()
			task.wait(0.5)
			local p = fn.FindDungeonPiece(S.DungeonPieceIslands[1])
			if not p or not fn.DungeonPieceHasPrompt(p) then
				S.Notify.new({
					Title = "Dungeon Pieces",
					Content = "All pieces already collected!",
					Duration = 4,
					Icon = S.ICON,
				})
				F.DungeonQuest = false
				S.DungeonStep = 0
				S.DungeonCollected = {}
				if S.DungeonToggle then
					pcall(function()
						S.DungeonToggle:SetValue(false)
					end)
				end
				return
			end
		end
		fn.AcceptDungeonQuest()
		S.DungeonStep = 1
		S.DungeonCollected = {}
		return
	end
	if step > 6 then
		fn.DungeonClear()
		fn.ForceTP("Dungeon")
		task.wait(1)
		fn.WaitChar()
		task.wait(1)
		fn.AcceptDungeonQuest()
		F.DungeonQuest = false
		S.DungeonStep = 0
		S.DungeonCollected = {}
		if S.DungeonToggle then
			pcall(function()
				S.DungeonToggle:SetValue(false)
			end)
		end
		S.Notify.new({
			Title = "Dungeon Pieces",
			Content = "Complete! All pieces collected.",
			Duration = 4,
			Icon = S.ICON,
		})
		return
	end
	local island = S.DungeonPieceIslands[step]
	if not island then
		S.DungeonStep = step + 1
		return
	end
	if S.DungeonCollected and S.DungeonCollected[step] then
		S.DungeonStep = step + 1
		return
	end
	fn.DungeonClear()
	S.Notify.new({
		Title = "DUNGEON PIECES NOTIFIER",
		Content = "Piece #" .. step .. " located at " .. fn.PortalDisplayName(island),
		Duration = 2,
		Icon = S.ICON,
	})
	fn.ForceTP(island)
	task.wait(0.5)
	fn.WaitChar()
	task.wait(0.5)
	local piece = fn.FindDungeonPiece(island)
	if not piece then
		task.wait(1)
		piece = fn.FindDungeonPiece(island)
	end
	if not piece then
		task.wait(1)
		piece = fn.FindDungeonPiece(island)
	end
	if not piece or not fn.DungeonPieceHasPrompt(piece) then
		S.Notify.new({
			Title = "Dungeon",
			Content = "Piece #" .. step .. " already collected or not found",
			Duration = 2,
			Icon = S.ICON,
		})
	else
		fn.DungeonCollectPiece(piece)
	end
	if not S.DungeonCollected then
		S.DungeonCollected = {}
	end
	S.DungeonCollected[step] = true
	S.DungeonStep = step + 1
end
fn.AbandonHogyokuQuest = function()
	pcall(function()
		local ab = fn.WalkPathWait(RS, 2, unpack(R.QuestAbandon))
		if ab then
			for _, n in ipairs({
				"HogyokuUnlock",
				"HogyokuQuestNPC",
				"Hogyoku",
				"HogyokuFragment",
				"HogyokuQuest",
				"SoulSociety",
			}) do
				pcall(function()
					ab:FireServer(n)
				end)
			end
		end
	end)
end
fn.FindHogyokuFragment = function(stepNum)
	local target = "hogyoku fragment #" .. stepNum
	for _, desc in ipairs(workspace:GetDescendants()) do
		if desc:IsA("ProximityPrompt") and (desc.ObjectText or ""):lower() == target then
			return desc
		end
	end
	return nil
end
fn.DoHogyokuQuestTick = function()
	if not F.HogyokuQuest then
		return
	end
	local step = S.HogyokuStep
	if step == 0 then
		fn.StopTw()
		fn.ClearTgt()
		fn.ForceTP("HollowIsland")
		S.HogyokuStep = 0.5
		return
	end
	if step == 0.5 then
		task.wait(1)
		fn.WaitChar()
		task.wait(0.5)
		local npc = workspace:FindFirstChild("HogyokuQuestNPC", true)
		if not npc then
			task.wait(2)
			npc = workspace:FindFirstChild("HogyokuQuestNPC", true)
		end
		if not npc then
			S.Notify.new({ Title = "Hogyoku", Content = "NPC not found, retrying...", Duration = 2, Icon = S.ICON })
			S.HogyokuStep = 0
			return
		end
		local npcPos
		if npc:IsA("BasePart") then
			npcPos = npc.Position
		end
		if not npcPos then
			local p = npc:FindFirstChild("HumanoidRootPart", true) or npc:FindFirstChild("Head", true)
			if p and p:IsA("BasePart") then
				npcPos = p.Position
			end
		end
		if not npcPos then
			for _, d in ipairs(npc:GetDescendants()) do
				if d:IsA("BasePart") then
					npcPos = d.Position
					break
				end
			end
		end
		if not npcPos then
			pcall(function()
				npcPos = npc:GetPivot().Position
			end)
		end
		if not npcPos then
			S.HogyokuStep = 0
			return
		end
		local hrp = fn.PlayerHRP()
		if hrp then
			hrp.CFrame = CFrame.new(npcPos + Vector3.new(0, 0, 3))
		end
		task.wait(0.3)
		for _, desc in ipairs(npc:GetDescendants()) do
			if desc:IsA("ProximityPrompt") then
				pcall(function()
					fireproximityprompt(desc)
				end)
			end
			if desc:IsA("ClickDetector") then
				pcall(function()
					fireclickdetector(desc)
				end)
			end
		end
		task.wait(0.5)
		fn.ClickYes()
		task.wait(0.3)
		fn.ClickYes()
		for _, desc in ipairs(npc:GetDescendants()) do
			if desc:IsA("ProximityPrompt") then
				pcall(function()
					fireproximityprompt(desc)
				end)
			end
		end
		task.wait(0.3)
		fn.ClickYes()
		task.wait(0.3)
		fn.ClickYes()
		S.HogyokuStep = 1
		S.HogyokuCollected = {}
		F.HogyokuQuest = true
		task.wait(1)
		S.Notify.new({
			Title = "Hogyoku",
			Content = "Quest accepted! Collecting fragments...",
			Duration = 2,
			Icon = S.ICON,
		})
		return
	end
	if step > 6 then
		fn.StopTw()
		fn.ClearTgt()
		fn.ForceTP("HollowIsland")
		task.wait(1)
		fn.WaitChar()
		task.wait(0.5)
		local npc = workspace:FindFirstChild("HogyokuQuestNPC", true)
		if npc then
			local npcPos
			local p = npc:FindFirstChild("HumanoidRootPart", true) or npc:FindFirstChild("Head", true)
			if p and p:IsA("BasePart") then
				npcPos = p.Position
			end
			if not npcPos then
				for _, d in ipairs(npc:GetDescendants()) do
					if d:IsA("BasePart") then
						npcPos = d.Position
						break
					end
				end
			end
			if npcPos then
				local hrp = fn.PlayerHRP()
				if hrp then
					hrp.CFrame = CFrame.new(npcPos + Vector3.new(0, 0, 3))
				end
			end
			task.wait(0.3)
			for _, desc in ipairs(npc:GetDescendants()) do
				if desc:IsA("ProximityPrompt") then
					pcall(function()
						fireproximityprompt(desc)
					end)
				end
			end
			task.wait(0.3)
			fn.ClickYes()
			task.wait(0.3)
			fn.ClickYes()
		end
		F.HogyokuQuest = false
		S.HogyokuStep = 0
		S.HogyokuCollected = {}
		if S.HogyokuToggle then
			pcall(function()
				S.HogyokuToggle:SetValue(false)
			end)
		end
		S.Notify.new({ Title = "Hogyoku", Content = "Complete! Soul Dominion unlocked!", Duration = 4, Icon = S.ICON })
		return
	end
	local island = S.HogyokuFragmentIslands[step]
	if not island then
		S.HogyokuStep = step + 1
		return
	end
	if S.HogyokuCollected and S.HogyokuCollected[step] then
		S.HogyokuStep = step + 1
		return
	end
	fn.StopTw()
	fn.ClearTgt()
	fn.ForceTP(island)
	task.wait(0.5)
	fn.WaitChar()
	task.wait(0.5)
	local prompt = fn.FindHogyokuFragment(step)
	if not prompt then
		task.wait(1)
		prompt = fn.FindHogyokuFragment(step)
	end
	if not prompt then
		task.wait(1)
		prompt = fn.FindHogyokuFragment(step)
	end
	if prompt then
		local hrp = fn.PlayerHRP()
		local par = prompt.Parent
		if par and hrp then
			local pos = par:IsA("BasePart") and par.Position or par:IsA("Model") and fn.ModelPos(par) or nil
			if pos then
				hrp.CFrame = CFrame.new(pos + Vector3.new(0, 2, 0))
			end
		end
		task.wait(0.1)
		pcall(function()
			fireproximityprompt(prompt)
		end)
		task.wait(0.15)
		pcall(function()
			fireproximityprompt(prompt)
		end)
		if not S.HogyokuCollected then
			S.HogyokuCollected = {}
		end
		S.HogyokuCollected[step] = true
		S.HogyokuStep = step + 1
	else
		S.Notify.new({
			Title = "Hogyoku",
			Content = "Fragment #" .. step .. " not found — retrying",
			Duration = 2,
			Icon = S.ICON,
		})
	end
end
fn.ScanDungeonDebug = function()
	local lines = {}
	table.insert(lines, "== QUEST STATE ==")
	local collectedStr = ""
	for k in pairs(S.DungeonCollected or {}) do
		collectedStr = collectedStr .. k .. ","
	end
	table.insert(
		lines,
		"Step: " .. S.DungeonStep .. " | Collected: {" .. collectedStr .. "} | Flag: " .. tostring(F.DungeonQuest)
	)
	table.insert(lines, "== DUNGEON PIECES (detail) ==")
	local ct = 0
	for _, desc in ipairs(workspace:GetDescendants()) do
		if desc.Name == "DungeonPuzzlePiece" and ct < 10 then
			ct = ct + 1
			local info = desc.Name .. " [" .. desc.ClassName .. "] in " .. (desc.Parent and desc.Parent.Name or "?")
			pcall(function()
				info = info .. " Trans=" .. desc.Transparency
			end)
			pcall(function()
				info = info .. " CC=" .. tostring(desc.CanCollide)
			end)
			pcall(function()
				info = info .. " Anch=" .. tostring(desc.Anchored)
			end)
			pcall(function()
				if desc:IsA("BasePart") then
					info = info
						.. " Pos="
						.. math.floor(desc.Position.X)
						.. ","
						.. math.floor(desc.Position.Y)
						.. ","
						.. math.floor(desc.Position.Z)
				end
			end)
			local kids = {}
			for _, ch in ipairs(desc:GetChildren()) do
				table.insert(kids, ch.Name .. "[" .. ch.ClassName .. "]")
			end
			info = info .. " Children={" .. table.concat(kids, ",") .. "}"
			local touchConns = 0
			pcall(function()
				touchConns = #getconnections(desc.Touched)
			end)
			info = info .. " TouchConns=" .. touchConns
			table.insert(lines, info)
		end
	end
	if ct == 0 then
		table.insert(lines, "(no DungeonPuzzlePiece found)")
	end
	table.insert(lines, "== ALL DUNGEON/PUZZLE OBJECTS ==")
	local ct2 = 0
	for _, desc in ipairs(workspace:GetDescendants()) do
		local nm = (desc.Name or ""):lower()
		if (nm:find("dungeon") or nm:find("puzzle")) and not (desc.Name == "DungeonPuzzlePiece") and ct2 < 20 then
			ct2 = ct2 + 1
			local info = desc.Name .. " [" .. desc.ClassName .. "]"
			if desc.Parent then
				info = info .. " in " .. desc.Parent.Name
			end
			if desc:IsA("ProximityPrompt") then
				info = info .. " Action=" .. (desc.ActionText or "") .. " Obj=" .. (desc.ObjectText or "")
			end
			table.insert(lines, info)
		end
	end
	if ct2 == 0 then
		table.insert(lines, "(none)")
	end
	table.insert(lines, "== NEARBY PROMPTS (<200 studs) ==")
	local hrp = fn.PlayerHRP()
	local pc = 0
	if hrp then
		for _, desc in ipairs(workspace:GetDescendants()) do
			if desc:IsA("ProximityPrompt") and pc < 20 then
				local par = desc.Parent
				local pos = nil
				if par and par:IsA("BasePart") then
					pos = par.Position
				elseif par and par:IsA("Model") then
					pos = fn.ModelPos(par)
				end
				if pos and (hrp.Position - pos).Magnitude < 200 then
					pc = pc + 1
					table.insert(
						lines,
						(par and par.Name or "?")
							.. " Action="
							.. (desc.ActionText or "")
							.. " Obj="
							.. (desc.ObjectText or "")
							.. " d="
							.. math.floor((hrp.Position - pos).Magnitude)
					)
				end
			end
		end
	end
	if pc == 0 then
		table.insert(lines, "(none)")
	end
	table.insert(lines, "== ALL REMOTES (dungeon/puzzle/quest) ==")
	local rc = 0
	pcall(function()
		for _, desc in ipairs(RS:GetDescendants()) do
			local nm = (desc.Name or ""):lower()
			if
				(nm:find("quest") or nm:find("dungeon") or nm:find("puzzle") or nm:find("piece") or nm:find("collect"))
				and (desc:IsA("RemoteEvent") or desc:IsA("RemoteFunction"))
			then
				rc = rc + 1
				table.insert(
					lines,
					desc.Name .. " [" .. desc.ClassName .. "] in " .. (desc.Parent and desc.Parent.Name or "?")
				)
			end
		end
	end)
	if rc == 0 then
		table.insert(lines, "(none)")
	end
	table.insert(lines, "== QUEST UI (PlayerGui) ==")
	local uc = 0
	pcall(function()
		local pg = LP:FindFirstChild("PlayerGui")
		if not pg then
			return
		end
		for _, desc in ipairs(pg:GetDescendants()) do
			if (desc:IsA("TextLabel") or desc:IsA("TextButton")) and uc < 15 then
				local txt = (desc.Text or ""):lower()
				if
					txt:find("dungeon")
					or txt:find("quest")
					or txt:find("piece")
					or txt:find("collect")
					or txt:find("puzzle")
				then
					uc = uc + 1
					table.insert(lines, desc.Name .. ": " .. (desc.Text or ""):sub(1, 80))
				end
			end
		end
	end)
	if uc == 0 then
		table.insert(lines, "(none)")
	end
	return table.concat(lines, "\n")
end
fn.ScanHogyokuDebug = function()
	local lines = {}
	table.insert(lines, "========== HOGYOKU MEGA DEBUG ==========")
	table.insert(lines, "== QUEST STATE ==")
	local collectedStr = ""
	for k in pairs(S.HogyokuCollected or {}) do
		collectedStr = collectedStr .. k .. ","
	end
	table.insert(
		lines,
		"Step: " .. S.HogyokuStep .. " | Collected: {" .. collectedStr .. "} | Flag: " .. tostring(F.HogyokuQuest)
	)
	table.insert(lines, "Islands: " .. table.concat(S.HogyokuFragmentIslands, ", "))
	table.insert(lines, "")
	table.insert(lines, "== WORKSPACE TOP-LEVEL CHILDREN ==")
	pcall(function()
		for _, ch in ipairs(workspace:GetChildren()) do
			table.insert(lines, ch.Name .. " [" .. ch.ClassName .. "]")
		end
	end)
	table.insert(lines, "")
	table.insert(lines, "== KEYWORD SEARCH (hogyoku/fragment/orb/shard/piece/puzzle/soul/unlock) ==")
	local ct = 0
	for _, desc in ipairs(workspace:GetDescendants()) do
		local nm = (desc.Name or ""):lower()
		if
			(
				nm:find("hogyoku")
				or nm:find("fragment")
				or nm:find("orb")
				or nm:find("shard")
				or nm:find("puzzle") and not nm:find("dungeonpuzzle")
			) and ct < 60
		then
			ct = ct + 1
			local info = ct .. ") " .. desc.Name .. " [" .. desc.ClassName .. "]"
			if desc.Parent then
				info = info .. " in " .. desc.Parent.Name
			end
			if desc:IsA("BasePart") then
				pcall(function()
					info = info
						.. " Pos="
						.. math.floor(desc.Position.X)
						.. ","
						.. math.floor(desc.Position.Y)
						.. ","
						.. math.floor(desc.Position.Z)
				end)
				pcall(function()
					info = info .. " Trans=" .. desc.Transparency
				end)
			elseif desc:IsA("Model") then
				pcall(function()
					local p = fn.ModelPos(desc)
					if p then
						info = info .. " Pos=" .. math.floor(p.X) .. "," .. math.floor(p.Y) .. "," .. math.floor(p.Z)
					end
				end)
			end
			local kids = {}
			for _, ch in ipairs(desc:GetChildren()) do
				table.insert(kids, ch.Name .. "[" .. ch.ClassName .. "]")
			end
			if #kids > 0 then
				info = info .. " Children={" .. table.concat(kids, ",") .. "}"
			end
			local hasPrompt = false
			pcall(function()
				for _, ch in ipairs(desc:GetDescendants()) do
					if ch:IsA("ProximityPrompt") then
						hasPrompt = true
						break
					end
				end
			end)
			pcall(function()
				if desc:FindFirstChildOfClass("ProximityPrompt") then
					hasPrompt = true
				end
			end)
			info = info .. " Prompt=" .. tostring(hasPrompt)
			local path = {}
			local anc = desc.Parent
			while anc and anc ~= workspace do
				table.insert(path, 1, anc.Name)
				anc = anc.Parent
			end
			info = info .. " Path=" .. table.concat(path, "/")
			table.insert(lines, info)
		end
	end
	if ct == 0 then
		table.insert(lines, "(NOTHING found with these keywords)")
	end
	table.insert(lines, "")
	table.insert(lines, "== EVERY PROXIMITYPROMPT IN WORKSPACE ==")
	local pc = 0
	for _, desc in ipairs(workspace:GetDescendants()) do
		if desc:IsA("ProximityPrompt") and pc < 80 then
			pc = pc + 1
			local par = desc.Parent
			local info = pc
				.. ") Parent="
				.. ((par and par.Name) or "?")
				.. " ["
				.. ((par and par.ClassName) or "?")
				.. "]"
			info = info .. " Action=" .. (desc.ActionText or "") .. " Obj=" .. (desc.ObjectText or "")
			local pos = nil
			if par and par:IsA("BasePart") then
				pos = par.Position
			elseif par and par:IsA("Model") then
				pos = fn.ModelPos(par)
			end
			if pos then
				info = info .. " Pos=" .. math.floor(pos.X) .. "," .. math.floor(pos.Y) .. "," .. math.floor(pos.Z)
			end
			local path = {}
			local anc = par
			while anc and anc ~= workspace do
				table.insert(path, 1, anc.Name)
				anc = anc.Parent
			end
			info = info .. " Path=" .. table.concat(path, "/")
			table.insert(lines, info)
		end
	end
	if pc == 0 then
		table.insert(lines, "(no ProximityPrompts in workspace)")
	end
	table.insert(lines, "")
	table.insert(lines, "== PLAYER DATA (leaderstats/QuestData/values) ==")
	pcall(function()
		for _, ch in ipairs(LP:GetChildren()) do
			if
				ch:IsA("Folder")
				or ch:IsA("StringValue")
				or ch:IsA("IntValue")
				or ch:IsA("NumberValue")
				or ch:IsA("BoolValue")
				or ch:IsA("ObjectValue")
			then
				local info = ch.Name .. " [" .. ch.ClassName .. "]"
				pcall(function()
					info = info .. " Val=" .. tostring(ch.Value)
				end)
				table.insert(lines, info)
				if ch:IsA("Folder") then
					for _, sub in ipairs(ch:GetChildren()) do
						local si = "  " .. sub.Name .. " [" .. sub.ClassName .. "]"
						pcall(function()
							si = si .. " Val=" .. tostring(sub.Value)
						end)
						table.insert(lines, si)
					end
				end
			end
		end
	end)
	table.insert(lines, "")
	table.insert(lines, "== ALL REMOTES IN REPLICATEDSTORAGE ==")
	local rc = 0
	pcall(function()
		for _, desc in ipairs(RS:GetDescendants()) do
			if desc:IsA("RemoteEvent") or desc:IsA("RemoteFunction") then
				rc = rc + 1
				table.insert(
					lines,
					rc
						.. ") "
						.. desc.Name
						.. " ["
						.. desc.ClassName
						.. "] in "
						.. (desc.Parent and desc.Parent.Name or "?")
				)
			end
		end
	end)
	if rc == 0 then
		table.insert(lines, "(none)")
	end
	table.insert(lines, "")
	table.insert(lines, "== NPCs NEAR PLAYER (<500 studs) ==")
	local nc = 0
	pcall(function()
		local hrp = fn.PlayerHRP()
		if hrp then
			for _, desc in ipairs(workspace:GetDescendants()) do
				if
					desc:IsA("Model")
					and desc:FindFirstChildOfClass("Humanoid")
					and desc ~= LP.Character
					and nc < 30
				then
					local pos = fn.ModelPos(desc)
					if pos and (hrp.Position - pos).Magnitude < 500 then
						nc = nc + 1
						local d = math.floor((hrp.Position - pos).Magnitude)
						local hasPrompt = false
						for _, ch in ipairs(desc:GetDescendants()) do
							if ch:IsA("ProximityPrompt") then
								hasPrompt = true
								break
							end
						end
						table.insert(lines, nc .. ") " .. desc.Name .. " d=" .. d .. " Prompt=" .. tostring(hasPrompt))
					end
				end
			end
		end
	end)
	if nc == 0 then
		table.insert(lines, "(none)")
	end
	table.insert(lines, "")
	table.insert(lines, "== QUEST UI (PlayerGui — hogyoku/fragment/quest/unlock/soul/collect) ==")
	local uc = 0
	pcall(function()
		local pg = LP:FindFirstChild("PlayerGui")
		if not pg then
			return
		end
		for _, desc in ipairs(pg:GetDescendants()) do
			if
				(desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("Frame") or desc:IsA("ImageLabel"))
				and uc < 30
			then
				local txt = ""
				pcall(function()
					txt = (desc.Text or ""):lower()
				end)
				local nm = (desc.Name or ""):lower()
				if
					txt:find("hogyoku")
					or txt:find("fragment")
					or txt:find("quest")
					or txt:find("unlock")
					or txt:find("soul")
					or txt:find("collect")
					or txt:find("orb")
					or nm:find("hogyoku")
					or nm:find("fragment")
					or nm:find("quest")
					or nm:find("unlock")
					or nm:find("soul")
					or nm:find("collect")
					or nm:find("orb")
				then
					uc = uc + 1
					local info = desc.Name .. " [" .. desc.ClassName .. "]"
					pcall(function()
						if desc.Text and #desc.Text > 0 then
							info = info .. ' Text="' .. (desc.Text):sub(1, 120) .. '"'
						end
					end)
					pcall(function()
						if desc.Visible ~= nil then
							info = info .. " Vis=" .. tostring(desc.Visible)
						end
					end)
					table.insert(lines, uc .. ") " .. info)
				end
			end
		end
	end)
	if uc == 0 then
		table.insert(lines, "(none)")
	end
	return table.concat(lines, "\n")
end
do
	local _CELINA_Source = game:HttpGet("https://raw.githubusercontent.com/youcantescapetheleaking/pimplehub-src/refs/heads/main/pimpleUI.lua")
	local _CELINA_Func, _CELINA_Err = loadstring(_CELINA_Source)
	if not _CELINA_Func then
		warn("[CELINA_UI] loadstring failed: " .. tostring(_CELINA_Err))
		return
	end
	local _CELINA_Ok, Setup = pcall(_CELINA_Func)
	if not _CELINA_Ok then
		warn("[CELINA_UI] execution failed: " .. tostring(Setup))
		return
	end
	if type(Setup) ~= "function" then
		warn("[CELINA_UI] Setup is " .. type(Setup) .. ", expected function")
		return
	end
    local Hub = Setup({
		Version = "3.0",
		Icon = S.ICON,
		Discord = S.DISCORD,
		Keybind = "LeftAlt",
		Info = "Left Alt = Toggle UI | V = Farm | B = Boss\nN = Summon\nStand Position: Behind/In Front/Left/Right\nMove Mode: Tween (smooth) or Teleport (instant)\nBoss: Portal TP first, cached positions\nAnos: separate summon remote, detects any difficulty\nChest: batch open all at once",
		ConfigDir = "pimpleHUB",
		ConfigName = "Pimple-Configs",
		OnDestroy = function()
			S.Running = false
			F.AutoFarmLevel = false
			F.AutoDungeon = false
			F.AutoBossRush = false
			F.AutoInfiniteTower = false
			F.BossEnabled = false
			F.AutoChest = false
			F.AutoMerchant = false
			F.DungeonQuest = false
			F.HogyokuQuest = false
			for _, k in ipairs(S.SkillKeys) do
				F[k] = false
			end
			pcall(function()
				local c = LP.Character
				if c then
					local hm = c:FindFirstChildOfClass("Humanoid")
					if hm then
						hm.PlatformStand = false
					end
					for _, p in ipairs(c:GetDescendants()) do
						if p:IsA("BasePart") then
							p.CanCollide = true
						end
					end
				end
			end)
			pcall(fn.StopTw)
			pcall(fn.ClearTgt)
			S.HoverPos = nil
			pcall(fn.DisableAllAutoSpawn)
			for _, c in ipairs(S.Conns) do
				pcall(function()
					c:Disconnect()
				end)
			end
			S.Conns = {}
		end,
	})
	S.Hub = Hub.Lib
	S.Win = Hub.Window
	S.Notify = Hub.Notify
	S.CfgMgr = Hub.ConfigManager
	local _glowButton = Hub.GlowButton
	LoadConfig()
	if F.Optimize then
		task.spawn(function()
			pcall(function()
				local r = fn.WalkPathWait(RS, 3, unpack(R.Settings))
				if not r then
					return
				end
				for _, s in ipairs({
					"DisableVFX",
					"DisableCutscene",
					"DisableOtherVFX",
					"DisableScreenShake",
					"RemoveTexture",
					"RemoveShadows",
				}) do
					r:FireServer(s, true)
					task.wait(0.05)
				end
			end)
		end)
	end
	S.Hub = Hub.Lib
	S.Win = Hub.Window
	S.Notify = Hub.Notify
	S.CfgMgr = Hub.ConfigManager
	local _glowButton = Hub.GlowButton
	LoadConfig()
	if F.Optimize then
		task.spawn(function()
			pcall(function()
				local r = fn.WalkPathWait(RS, 3, unpack(R.Settings))
				if not r then
					return
				end
				for _, s in ipairs({
					"DisableVFX",
					"DisableCutscene",
					"DisableOtherVFX",
					"DisableScreenShake",
					"RemoveTexture",
					"RemoveShadows",
				}) do
					r:FireServer(s, true)
					task.wait(0.05)
				end
			end)
		end)
	end
	if F.RemoveTrees or F.RemoveCrops then
		task.spawn(function()
			task.wait(3)
			local targets = {}
			if F.RemoveTrees then
				table.insert(targets, "Trees")
			end
			if F.RemoveCrops then
				table.insert(targets, "Crops")
			end
			for _, parentName in ipairs(targets) do
				local found = {}
				for _, obj in ipairs(WS:GetDescendants()) do
					if obj.Name == parentName then
						table.insert(found, obj)
					end
				end
				for _, container in ipairs(found) do
					for _, child in ipairs(container:GetDescendants()) do
						pcall(function()
							if child:IsA("BasePart") then
								child.Transparency = 1
								child.CanCollide = false
								child:Destroy()
							elseif
								child:IsA("Decal")
								or child:IsA("Texture")
								or child:IsA("ParticleEmitter")
								or child:IsA("BillboardGui")
							then
								child:Destroy()
							end
						end)
					end
					for _, child in ipairs(container:GetChildren()) do
						pcall(function()
							child:Destroy()
						end)
					end
				end
			end
		end)
	end
	S.Win:DrawCategory({ Name = "AUTO FARM" })
	local FTab = S.Win:DrawTab({ Name = "Main", Icon = "sword", EnableScrolling = true })
	local BTab = S.Win:DrawTab({ Name = "Farm Bosses", Icon = "axe", EnableScrolling = true })
	local TPTab = S.Win:DrawTab({ Name = "Quick Teleport", Icon = "map-pin", EnableScrolling = true })
	S.Win:DrawCategory({ Name = "AUTO LOADOUT" })
	local LTab = S.Win:DrawTab({ Name = "Loadout", Icon = "layers", EnableScrolling = true })
	S.Win:DrawCategory({ Name = "AUTO GAMEMODES" })
	local DTab = S.Win:DrawTab({ Name = "Gamemodes", Icon = "gamepad-2", EnableScrolling = true })
	S.Win:DrawCategory({ Name = "PROGRESSION" })
	local STab = S.Win:DrawTab({ Name = "Abilities", Icon = "flame", EnableScrolling = true })
	local SkillTreeTab = S.Win:DrawTab({ Name = "Skill Tree", Icon = "git-branch", EnableScrolling = true })
	local StatTab = S.Win:DrawTab({ Name = "Stats", Icon = "bar-chart", EnableScrolling = true })
	S.Win:DrawCategory({ Name = "AUTO SHOP" })
	local ShopTab = S.Win:DrawTab({ Name = "Shops", Icon = "shopping-cart", EnableScrolling = true })
	S.Win:DrawCategory({ Name = "AUTO QUESTS" })
	local QTab = S.Win:DrawTab({ Name = "Quests", Icon = "bookmark", EnableScrolling = true })
	local QSec = QTab:DrawSection({ Name = "Unlock Quests", Position = "left" })
	S.DungeonToggle = QSec:AddToggle({
		Name = "Dungeon Pieces Info",
		Flag = "DungeonQuest",
		Default = F.DungeonQuest,
		Callback = function(v)
			F.DungeonQuest = v
			if v then
				if F.HogyokuQuest then
					F.HogyokuQuest = false
					S.HogyokuStep = 0
					S.HogyokuCollected = {}
					fn.AbandonHogyokuQuest()
					if S.HogyokuToggle then
						pcall(function()
							S.HogyokuToggle:SetValue(false)
						end)
					end
					S.Notify.new({
						Title = "Hogyoku Quest",
						Content = "Disabled — only one quest at a time",
						Duration = 3,
						Icon = S.ICON,
					})
				end
				S.DungeonStep = 0
				S.DungeonCollected = {}
				fn.StopTw()
				fn.ClearTgt()
				S.HoverPos = nil
				S.LockTarget = nil
				S.LastTP = 0
				S.TPCount = 0
				S.TPReset = tick()
				if S.SummonBossFight then
					fn.ExitSummonBossMode()
				end
				if S.BossFight then
					S.BossFight = false
					S.BossTargetName = nil
					S.BossTPDone = false
				end
				fn.ClearTgt()
				S.HoverPos = nil
				S.Notify.new({
					Title = "Dungeon Quest",
					Content = "Starting dungeon unlock quest",
					Duration = 3,
					Icon = S.ICON,
				})
			else
				S.DungeonStep = 0
				S.DungeonCollected = {}
				fn.StopTw()
				fn.ClearTgt()
				S.HoverPos = nil
				S.LockTarget = nil
				S.LastTP = 0
				S.TPCount = 0
				S.TPReset = tick()
				fn.AbandonDungeonQuest()
				fn.ClearTgt()
				S.HoverPos = nil
				S.Notify.new({ Title = "Dungeon Quest", Content = "Quest abandoned", Duration = 3, Icon = S.ICON })
			end
		end,
	})
	S.DungeonToggle.Link:AddHelper({ Text = "Collect 6 puzzle pieces across islands" })
	QSec:AddParagraph({
		Title = "Info",
		Content = "1). Accepts quest remotely\n\n2). Collects 6 pieces (Starter→Jungle→Desert→Snow→Shibuya→Hueco Mundo)\n\n3). Returns to Dungeon Master\n\nPriority: overrides all other modes",
	})
	S.HogyokuToggle = QSec:AddToggle({
		Name = "Hogyoku Fragments Info",
		Flag = "HogyokuQuest",
		Default = F.HogyokuQuest,
		Callback = function(v)
			F.HogyokuQuest = v
			if v then
				if F.DungeonQuest then
					F.DungeonQuest = false
					S.DungeonStep = 0
					S.DungeonCollected = {}
					fn.AbandonDungeonQuest()
					if S.DungeonToggle then
						pcall(function()
							S.DungeonToggle:SetValue(false)
						end)
					end
					S.Notify.new({
						Title = "Dungeon Quest",
						Content = "Disabled — only one quest at a time",
						Duration = 3,
						Icon = S.ICON,
					})
				end
				S.HogyokuStep = 0
				S.HogyokuCollected = {}
				fn.StopTw()
				fn.ClearTgt()
				S.HoverPos = nil
				S.LockTarget = nil
				S.LastTP = 0
				S.TPCount = 0
				S.TPReset = tick()
				if S.SummonBossFight then
					fn.ExitSummonBossMode()
				end
				if S.BossFight then
					S.BossFight = false
					S.BossTargetName = nil
					S.BossTPDone = false
				end
				fn.ClearTgt()
				S.HoverPos = nil
				S.Notify.new({
					Title = "Hogyoku Quest",
					Content = "Starting Hogyoku fragment quest",
					Duration = 3,
					Icon = S.ICON,
				})
			else
				S.HogyokuStep = 0
				S.HogyokuCollected = {}
				fn.StopTw()
				fn.ClearTgt()
				S.HoverPos = nil
				S.LockTarget = nil
				S.LastTP = 0
				S.TPCount = 0
				S.TPReset = tick()
				fn.AbandonHogyokuQuest()
				fn.ClearTgt()
				S.HoverPos = nil
				S.Notify.new({ Title = "Hogyoku Quest", Content = "Quest abandoned", Duration = 3, Icon = S.ICON })
			end
		end,
	})
	S.HogyokuToggle.Link:AddHelper({ Text = "Collect 6 Hogyoku fragments to unlock Soul Dominion" })
	QSec:AddParagraph({
		Title = "Hogyoku Info",
		Content = "1). Accepts quest remotely\n\n2). Collects 6 fragments (Snow→Shibuya→Hueco Mundo→Shinjuku→Slime→Judgement)\n\n3). Returns to Gin (Hueco Mundo)\n\nPriority: overrides all other modes",
	})
	local QDbgSec = QTab:DrawSection({ Name = "Quest Debug", Position = "right" })
	_glowButton(QDbgSec, "Scan Dungeon Debug", function()
		local result = fn.ScanDungeonDebug()
		S.Notify.new({ Title = "DUNGEON DEBUG", Content = result:sub(1, 500), Duration = 20, Icon = S.ICON })
	end)
	_glowButton(QDbgSec, "Scan Hogyoku Debug", function()
		local result = fn.ScanHogyokuDebug()
		S.Notify.new({ Title = "HOGYOKU DEBUG", Content = result:sub(1, 500), Duration = 20, Icon = S.ICON })
	end)
	task.wait()
	local FSec = FTab:DrawSection({ Name = "Auto Farm", Position = "left" })
	S.FarmToggle = FSec:AddToggle({
		Name = "Enable Auto Farm",
		Flag = "AutoFarmLevel",
		Default = F.AutoFarmLevel,
		Guard = function(v)
			if v and (F.AutoDungeon or F.AutoBossRush or F.AutoInfiniteTower) then
				S.Notify.new({ Title = "Auto Farm", Content = "Disable Gamemodes first", Duration = 3, Icon = S.ICON })
				return false
			end
			if v and fn.HasDungeonEnemiesInWorkspace() then
				S.Notify.new({
					Title = "Auto Farm",
					Content = "Can't farm while in a dungeon",
					Duration = 3,
					Icon = S.ICON,
				})
				return false
			end
			return true
		end,
		Callback = function(v)
			F.AutoFarmLevel = v
			if v then
				F.FollowPlayer = false
				if S.FollowToggle then
					pcall(function()
						S.FollowToggle:SetValue(false)
					end)
				end
				if F.AutoDungeon then
					F.AutoDungeon = false
					for _, dt in ipairs(S.DungeonTypes) do
						if S.DungeonToggles[dt] then
							pcall(function()
								S.DungeonToggles[dt]:SetValue(false)
							end)
						end
					end
				end
				S.LastDungeonSwitch = 0
				fn.StopTw()
				fn.ClearTgt()
				S.CurIsland = nil
				S.IslandTPd = false
				S.SpawnDone = false
				S.FarmOrigin = nil
				S.FarmGenericMode = false
				S.QState = "NONE"
				S.CurTarget = nil
				S.LockTarget = nil
				S.HoverPos = nil
				S.LastEnemy = 0
			else
				fn.FullReset()
			end
		end,
	})
	S.FarmKeybind =
		S.FarmToggle.Link:AddKeybind({ Default = "V", Flag = "FarmLevelKeybind", Callback = function() end })
	S.FarmToggle.Link:AddHelper({ Text = "Plank above enemies & attack" })
	FSec:AddToggle({
		Name = "Auto Equip Weapon",
		Flag = "AutoEquip",
		Default = F.AutoEquip,
		Callback = function(v)
			F.AutoEquip = v
		end,
	})
	local _weaponList = {}
	local function _rebuildWeaponList()
		local newList = {}
		local seen = {}
		local bp = LP:FindFirstChild("Backpack")
		local ch = LP.Character
		for _, container in ipairs({ bp, ch }) do
			if container then
				for _, t in ipairs(container:GetChildren()) do
					if t:IsA("Tool") and not seen[t.Name] then
						seen[t.Name] = true
						table.insert(newList, t.Name)
					end
				end
			end
		end
		table.sort(newList, function(a, b)
			return a < b
		end)
		_weaponList = newList
		if (F.AutoEquipWeapon == "" or F.AutoEquipWeapon == "Auto") and #newList > 0 then
			local pick = newList[1]
			for _, n in ipairs(newList) do
				if n:lower() ~= "combat" then
					pick = n
					break
				end
			end
			F.AutoEquipWeapon = pick
		end
		pcall(function()
			if S._weaponDrop then
				S._weaponDrop:SetValues(_weaponList)
				if F.AutoEquipWeapon and F.AutoEquipWeapon ~= "" then
					pcall(function()
						S._weaponDrop:SetValue(F.AutoEquipWeapon)
					end)
				end
			end
		end)
	end
	local function _hookContainer(container)
		if not container then
			return
		end
		container.ChildAdded:Connect(function()
			task.wait(0.2)
			_rebuildWeaponList()
		end)
		container.ChildRemoved:Connect(function()
			task.wait(0.2)
			_rebuildWeaponList()
		end)
	end
	task.spawn(function()
		task.wait(0.5)
		_rebuildWeaponList()
		_hookContainer(LP:FindFirstChild("Backpack"))
		_hookContainer(LP.Character)
		LP.CharacterAdded:Connect(function(char)
			task.wait(1)
			_rebuildWeaponList()
			_hookContainer(LP:FindFirstChild("Backpack"))
			_hookContainer(char)
		end)
	end)
	S._weaponDrop = FSec:AddDropdown({
		Name = "Weapon",
		Default = F.AutoEquipWeapon,
		Values = _weaponList,
		Flag = "AutoEquipWeapon",
		Callback = function(v)
			F.AutoEquipWeapon = v
			if F.AutoEquip then
				task.spawn(fn.EquipBothWeapons)
			end
		end,
	})
	FSec:AddToggle({
		Name = "Auto Quest",
		Flag = "AutoQuest",
		Default = F.AutoQuest,
		Callback = function(v)
			F.AutoQuest = v
			if v and F.AutoFarmLevel then
				task.spawn(fn.EnableGameQuestRepeat)
			end
		end,
	})
	FSec:AddDropdown({
		Name = "Farm Zone",
		Default = fn.PortalDisplayName(F.SelectedIsland),
		Values = fn.GetIslandNames(),
		Flag = "SelectedIsland",
		Callback = function(v)
			local portal = fn.DisplayToPortal(v)
			F.SelectedIsland = portal
			fn.StopTw()
			fn.ClearTgt()
			S.HoverPos = nil
			S.LockTarget = nil
			S.CurIsland = nil
			S.IslandTPd = false
			S.SpawnDone = false
			S.FarmOrigin = nil
			S.FarmGenericMode = false
			S.LastEnemy = 0
			S.CurTarget = nil
			S.LastTP = 0
			S.TPCount = 0
			S.TPReset = tick()
			S.QState = "NONE"
			fn.AbandonAllQuests()
			S.Notify.new({ Title = "Island Changed", Content = "Now farming: " .. v, Duration = 2, Icon = S.ICON })
		end,
	})
	FSec:AddDropdown({
		Name = "Stand Position",
		Default = F.FarmMode,
		Values = { "Above", "Behind", "In Front", "Left Side", "Right Side" },
		Flag = "FarmMode",
		Callback = function(v)
			F.FarmMode = v
			fn.ClearTgt()
			S.HoverPos = nil
		end,
	}).Link
		:AddHelper({
			Text = "Behind = follow + Follow Style | In Front / Left Side / Right Side = fixed position (Static only, Follow Style ignored)",
		})
	FSec:AddDropdown({
		Name = "Combat Style",
		Default = F.FollowStyle,
		Values = { "Dodge", "Static", "Orbit", "Strafe" },
		Flag = "FollowStyle",
		Callback = function(v)
			F.FollowStyle = v

		end,
	}).Link
		:AddHelper({
			Text = "Dodge = strafe on threat | Static = fixed behind | Orbit = circle around enemy | Strafe = constant side-step",
		})
	FSec:AddDropdown({
		Name = "Travel Mode",
		Default = F.MoveMode,
		Values = { "Tween", "Teleport" },
		Flag = "MoveMode",
		Callback = function(v)
			F.MoveMode = v
			fn.ClearTgt()
			S.HoverPos = nil
			if v ~= "Walk" then
				fn.RestoreWalkSpeed()
			end
		end,
	}).Link
		:AddHelper({ Text = "Tween = smooth glide | Walk = natural movement" })
	FSec:AddSlider({
		Name = "Offset Distance",
		Min = 5,
		Max = 50,
		Default = F.OffsetDist,
		Round = 0,
		Flag = "OffsetDist",
		Callback = function(v)
			F.OffsetDist = v
		end,
	})
	FSec:AddSlider({
		Name = "Movement Speed",
		Min = 15,
		Max = 200,
		Default = F.TweenSpeed,
		Round = 0,
		Flag = "TweenSpeed",
		Callback = function(v)
			F.TweenSpeed = v
			fn.StopTw()
		end,
	})
	local KASec = FTab:DrawSection({ Name = "Kill Aura", Position = "right" })
	S.KillAuraToggle = KASec:AddToggle({
		Name = "Enable Kill Aura",
		Flag = "KillAura",
		Default = F.KillAura,
		Callback = function(v)
			F.KillAura = v
		end,
	})
	S.KillAuraKeybind = S.KillAuraToggle.Link:AddKeybind({ Flag = "KillAuraKeybind", Callback = function() end })
	S.KillAuraToggle.Link:AddHelper({ Text = "Attacks all nearby NPCs within range" })
	KASec:AddSlider({
		Name = "Range",
		Min = 50,
		Max = 250,
		Default = F.KillAuraRange,
		Round = 0,
		Flag = "KillAuraRange",
		Callback = function(v)
			F.KillAuraRange = v
		end,
	})
	KASec:AddSlider({
		Name = "Cooldown (s)",
		Min = 0.05,
		Max = 1,
		Default = F.KillAuraCD,
		Round = 2,
		Flag = "KillAuraCD",
		Callback = function(v)
			F.KillAuraCD = v
		end,
	})
	KASec:AddSlider({
		Name = "Health Threshold (%)",
		Min = 0,
		Max = 100,
		Default = F.KillAuraHP,
		Round = 0,
		Flag = "KillAuraHP",
		Callback = function(v)
			F.KillAuraHP = v
		end,
	})
	KASec:AddToggle({
		Name = "Set Spawn Crystal",
		Flag = "AutoSpawn",
		Default = F.AutoSpawn,
		Callback = function(v)
			F.AutoSpawn = v
			S.SpawnDone = false
		end,
	}).Link
		:AddHelper({ Text = "TP to crystal on arrival" })
	local _killAuraRemote = nil
	pcall(function()
		_killAuraRemote = RS:WaitForChild("CombatSystem", 10)
			and RS.CombatSystem:WaitForChild("Remotes", 5)
			and RS.CombatSystem.Remotes:WaitForChild("RequestHit", 5)
	end)
	task.spawn(function()
		while S.Running do
			task.wait(F.KillAuraCD or 0.12)
			if F.KillAura and not _dead and _killAuraRemote then
				local c = LP.Character
				local hrp = c and c:FindFirstChild("HumanoidRootPart")
				if hrp then
					local maxRange = F.KillAuraRange or 200
					local nf = fn.GetNPCFolder()
					if nf then
						for _, m in ipairs(nf:GetChildren()) do
							if m:IsA("Model") then
								local hum = m:FindFirstChildOfClass("Humanoid")
								if hum and hum.Health > 0 then
									local hpPct = (hum.Health / hum.MaxHealth) * 100
									local threshold = F.KillAuraHP or 50
									if hpPct <= threshold then
										pcall(function()
											local pos = m:GetPivot().Position
											if (hrp.Position - pos).Magnitude <= maxRange then
												_killAuraRemote:FireServer(pos)
											end
										end)
									end
								end
							end
						end
					end
				end
			end
		end
	end)
	S._antiKBConns = {}
	local function _applyAntiKB(character)
		if not character then
			return
		end
		local root = character:WaitForChild("HumanoidRootPart", 10)
		if root then
			local conn = root.ChildAdded:Connect(function(child)
				if not F.AntiKnockback then
					return
				end
				if child:IsA("BodyVelocity") and child.MaxForce == Vector3.new(40000, 40000, 40000) then
					child:Destroy()
				end
			end)
			table.insert(S._antiKBConns, conn)
		end
	end
	_applyAntiKB(LP.Character)
	LP.CharacterAdded:Connect(function(c)
		_applyAntiKB(c)
	end)
	local PMSec = FTab:DrawSection({ Name = "Player Modifications", Position = "right" })
	PMSec:AddToggle({
		Name = "Custom WalkSpeed",
		Flag = "CustomWalkSpeed",
		Default = F.CustomWalkSpeed,
		Callback = function(v)
			F.CustomWalkSpeed = v
			if not v then
				pcall(function()
					local c = LP.Character
					local hum = c and c:FindFirstChildOfClass("Humanoid")
					if hum then
						hum.WalkSpeed = 16
					end
				end)
			end
		end,
	})
	PMSec:AddSlider({
		Name = "WalkSpeed Value",
		Min = 16,
		Max = 250,
		Default = F.WalkSpeedValue,
		Increment = 1,
		Flag = "WalkSpeedValue",
		Callback = function(v)
			F.WalkSpeedValue = v
		end,
	})
	PMSec:AddToggle({
		Name = "Custom JumpPower",
		Flag = "CustomJumpPower",
		Default = F.CustomJumpPower,
		Callback = function(v)
			F.CustomJumpPower = v
			if not v then
				pcall(function()
					local c = LP.Character
					local hum = c and c:FindFirstChildOfClass("Humanoid")
					if hum then
						hum.JumpPower = 50
						hum.UseJumpPower = true
					end
				end)
			end
		end,
	})
	PMSec:AddSlider({
		Name = "JumpPower Value",
		Min = 0,
		Max = 500,
		Default = F.JumpPowerValue,
		Increment = 1,
		Flag = "JumpPowerValue",
		Callback = function(v)
			F.JumpPowerValue = v
		end,
	})
	PMSec:AddToggle({
		Name = "Noclip",
		Flag = "Noclip",
		Default = F.Noclip,
		Callback = function(v)
			F.Noclip = v
			if not v then
				pcall(function()
					local c = LP.Character
					if c then
						for _, p in ipairs(c:GetDescendants()) do
							if p:IsA("BasePart") then
								p.CanCollide = true
							end
						end
					end
				end)
			end
		end,
	}).Link
		:AddHelper({ Text = "Walk through walls" })
	PMSec:AddToggle({
		Name = "Anti-Knockback",
		Flag = "AntiKnockback",
		Default = F.AntiKnockback,
		Callback = function(v)
			F.AntiKnockback = v
		end,
	}).Link
		:AddHelper({ Text = "Blocks knockback BodyVelocity from enemies" })
	RunService.Stepped:Connect(function()
		local c = LP.Character
		if not c then
			return
		end
		local hum = c:FindFirstChildOfClass("Humanoid")
		if hum then
			if F.CustomWalkSpeed then
				hum.WalkSpeed = F.WalkSpeedValue
			end
			if F.CustomJumpPower then
				hum.JumpPower = F.JumpPowerValue
				hum.UseJumpPower = true
			end
		end
		if F.Noclip then
			for _, p in ipairs(c:GetDescendants()) do
				if p:IsA("BasePart") and p.CanCollide then
					p.CanCollide = false
				end
			end
		end
	end)
	task.wait()
	local _titleStatMap = {
		["Best EXP"] = "XPPercent",
		["Best Money & Gem"] = "MoneyPercent",
		["Best Luck"] = "LuckPercent",
		["Best DMG"] = "DamagePercent",
	}
	local _titleModule, _titleEquipRE = nil, nil
	local _unlockedTitles = {}
	local _currentTitle = nil
	task.spawn(function()
		pcall(function()
			_titleModule = require(RS:WaitForChild("Modules", 5):WaitForChild("TitlesConfig", 5))
		end)
		pcall(function()
			_titleEquipRE = RS:WaitForChild("RemoteEvents", 5):WaitForChild("TitleEquip", 5)
		end)
		pcall(function()
			local syncRE = RS:WaitForChild("RemoteEvents", 5):WaitForChild("TitleDataSync", 5)
			if syncRE then
				syncRE.OnClientEvent:Connect(function(data)
					if data and data.unlocked then
						_unlockedTitles = data.unlocked
					end
				end)
			end
		end)
		pcall(function()
			local dataRF = RS:WaitForChild("Remotes", 5):WaitForChild("GetTitlesData", 5)
			if dataRF then
				local data = dataRF:InvokeServer()
				if data and data.unlocked then
					_unlockedTitles = data.unlocked
					_currentTitle = data.equipped
				end
			end
		end)
	end)
	local function _getBestTitle(category)
		if #_unlockedTitles == 0 or not _titleModule then
			return nil
		end
		local targetStat = _titleStatMap[category]
		if not targetStat then
			return nil
		end
		local titles = _titleModule.Titles or _titleModule
		local bestId, bestVal = nil, -1
		for _, id in ipairs(_unlockedTitles) do
			local info = titles[id]
			if info and info.statBonuses and info.statBonuses[targetStat] then
				if info.statBonuses[targetStat] > bestVal then
					bestVal = info.statBonuses[targetStat]
					bestId = id
				end
			end
		end
		return bestId
	end
	local function _applyTitle()
		if not F.AutoTitle or _dead or not _titleEquipRE then
			return
		end
		pcall(function()
			local mode = F.AutoTitleMode
			if S.BossFight or S.SummonBossFight then
				mode = F.AutoTitleBoss or mode
			elseif F.AutoDungeon or F.AutoBossRush or F.AutoInfiniteTower then
				mode = F.AutoTitleGamemode or mode
			end
			if mode == "None" then
				return
			end
			local bestId = _getBestTitle(mode)
			if bestId and bestId ~= _currentTitle then
				_titleEquipRE:FireServer(bestId)
				_currentTitle = bestId
			end
		end)
	end
	task.spawn(function()
		while S.Running do
			task.wait(3)
			_applyTitle()
		end
	end)
	local TitleSec = LTab:DrawSection({ Name = "Auto Title", Position = "left" })
	S.AutoTitleToggle = TitleSec:AddToggle({
		Name = "Auto Switch Title",
		Flag = "AutoTitle",
		Default = F.AutoTitle,
		Callback = function(v)
			F.AutoTitle = v
		end,
	})
	S.AutoTitleKeybind = S.AutoTitleToggle.Link:AddKeybind({ Flag = "AutoTitleKeybind", Callback = function() end })
	S.AutoTitleToggle.Link:AddHelper({ Text = "Switches title based on what you're doing" })
	TitleSec:AddDropdown({
		Name = "Farming Enemies",
		Default = F.AutoTitleMode,
		Values = { "None", "Best DMG", "Best EXP", "Best Luck", "Best Money & Gem" },
		Flag = "AutoTitleMode",
		Callback = function(v)
			F.AutoTitleMode = v
			_currentTitle = nil
			task.spawn(_applyTitle)
		end,
	}).Link
		:AddHelper({ Text = "Title used when farming regular enemies" })
	TitleSec:AddDropdown({
		Name = "Farming Bosses",
		Default = F.AutoTitleBoss or "Best DMG",
		Values = { "None", "Best DMG", "Best EXP", "Best Luck", "Best Money & Gem" },
		Flag = "AutoTitleBoss",
		Callback = function(v)
			F.AutoTitleBoss = v
			_currentTitle = nil
			task.spawn(_applyTitle)
		end,
	}).Link
		:AddHelper({ Text = "Title used when fighting bosses" })
	TitleSec:AddDropdown({
		Name = "Farming Gamemodes",
		Default = F.AutoTitleGamemode or "Best DMG",
		Values = { "None", "Best DMG", "Best EXP", "Best Luck", "Best Money & Gem" },
		Flag = "AutoTitleGamemode",
		Callback = function(v)
			F.AutoTitleGamemode = v
			_currentTitle = nil
			task.spawn(_applyTitle)
		end,
	}).Link
		:AddHelper({ Text = "Title used in Dungeon/Boss Rush/Tower" })
	local AccessorySec = LTab:DrawSection({ Name = "Auto Accessory", Position = "right" })
	local _accessoryRemote = nil
	local _accessoryList = { "None" }
	local _currentAccessory = nil
	task.spawn(function()
		pcall(function()
			local r = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("GetAccessoryEquipped")
			if r then
				local data = r:InvokeServer()
				if type(data) == "table" and type(data.Stats) == "string" and data.Stats ~= "" then
					_currentAccessory = data.Stats
				end
			end
		end)
	end)
	local function _updateAccessoryDropdowns()
		table.sort(_accessoryList, function(a, b)
			if a == "None" then
				return true
			end
			if b == "None" then
				return false
			end
			return a < b
		end)
		pcall(function()
			if S._accDropMob then
				local cur = F.AutoAccessoryMob
				S._accDropMob:SetValues(_accessoryList)
				if cur and cur ~= "" then
					pcall(function()
						S._accDropMob:SetValue(cur)
					end)
				end
			end
			if S._accDropBoss then
				local cur = F.AutoAccessoryBoss
				S._accDropBoss:SetValues(_accessoryList)
				if cur and cur ~= "" then
					pcall(function()
						S._accDropBoss:SetValue(cur)
					end)
				end
			end
			if S._accDropGM then
				local cur = F.AutoAccessoryGamemode
				S._accDropGM:SetValues(_accessoryList)
				if cur and cur ~= "" then
					pcall(function()
						S._accDropGM:SetValue(cur)
					end)
				end
			end
		end)
	end
	task.spawn(function()
		pcall(function()
			_accessoryRemote = RS:WaitForChild("Remotes", 5):WaitForChild("EquipAccessory", 5)
		end)
		pcall(function()
			local remotes = RS:FindFirstChild("Remotes")
			if not remotes then
				return
			end
			local upInv = remotes:FindFirstChild("UpdateInventory")
			if upInv and upInv:IsA("RemoteEvent") then
				upInv.OnClientEvent:Connect(function(category, data)
					if category == "Accessories" and type(data) == "table" then
						_accessoryList = { "None" }
						for _, item in ipairs(data) do
							if type(item) == "table" and type(item.name) == "string" then
								table.insert(_accessoryList, item.name)
							end
						end
						_updateAccessoryDropdowns()
					end
				end)
			end
			local reqInv = remotes:FindFirstChild("RequestInventory")
			if reqInv then
				reqInv:FireServer()
			end
		end)
	end)
	local function _getAccessoryContext()
		local tgt = S.CurTarget
		if not tgt or not tgt.Parent then
			return "None"
		end
		local inGamemode = F.AutoDungeon or F.AutoBossRush or F.AutoInfiniteTower
		if inGamemode and (fn.IsTowerEnemy(tgt) or fn.IsBossRushEnemy(tgt) or fn.IsKnownDungeonEnemy(tgt)) then
			return "Gamemode"
		end
		if S.BossFight or S.SummonBossFight then
			return "Boss"
		end
		local tname = (tgt.Name or ""):lower()
		if tname:find("boss") then
			return "Boss"
		end
		return "Mob"
	end
	local function _applyAccessory()
		if not F.AutoAccessory or _dead then
			return
		end
		pcall(function()
			if not _accessoryRemote then
				_accessoryRemote = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("EquipAccessory")
			end
			if not _accessoryRemote then
				return
			end
			local acc = F.AutoAccessoryMob
			if S.BossFight or S.SummonBossFight then
				acc = F.AutoAccessoryBoss
			elseif F.AutoDungeon or F.AutoBossRush or F.AutoInfiniteTower then
				acc = F.AutoAccessoryGamemode
			end
			if not acc or acc == "None" then
				return
			end
			local needsRefresh = acc ~= _currentAccessory
			if not needsRefresh then
				local r = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("GetAccessoryEquipped")
				if r then
					local ok, data = pcall(function() return r:InvokeServer() end)
					if ok and type(data) == "table" then
						if type(data.Stats) ~= "string" or data.Stats == "" or data.Stats ~= acc then
							needsRefresh = true
						end
					end
				end
			end
			if needsRefresh then
				_accessoryRemote:FireServer("EquipStats", acc)
				_currentAccessory = acc
			end
		end)
	end
	task.spawn(function()
		while S.Running do
			task.wait(3)
			_applyAccessory()
		end
	end)
	S.AutoAccessoryToggle = AccessorySec:AddToggle({
		Name = "Auto Switch Accessory",
		Flag = "AutoAccessory",
		Default = F.AutoAccessory,
		Callback = function(v)
			F.AutoAccessory = v
		end,
	})
	S.AutoAccessoryKeybind = S.AutoAccessoryToggle.Link:AddKeybind({ Flag = "AutoAccessoryKeybind", Callback = function() end })
	S.AutoAccessoryToggle.Link:AddHelper({ Text = "Switches accessory based on enemy type" })
	S._accDropMob = AccessorySec:AddDropdown({
		Name = "Farming Enemies",
		Default = F.AutoAccessoryMob,
		Values = _accessoryList,
		Flag = "AutoAccessoryMob",
		Callback = function(v)
			F.AutoAccessoryMob = v
			if not S.BossFight and not S.SummonBossFight and not F.AutoDungeon and not F.AutoBossRush and not F.AutoInfiniteTower then
				_currentAccessory = nil
				task.spawn(_applyAccessory)
			end
		end,
	})
	S._accDropMob.Link:AddHelper({ Text = "Accessory used when farming regular enemies" })
	S._accDropBoss = AccessorySec:AddDropdown({
		Name = "Farming Bosses",
		Default = F.AutoAccessoryBoss,
		Values = _accessoryList,
		Flag = "AutoAccessoryBoss",
		Callback = function(v)
			F.AutoAccessoryBoss = v
			if S.BossFight or S.SummonBossFight then
				_currentAccessory = nil
				task.spawn(_applyAccessory)
			end
		end,
	})
	S._accDropBoss.Link:AddHelper({ Text = "Accessory used when fighting bosses" })
	S._accDropGM = AccessorySec:AddDropdown({
		Name = "Farming Gamemodes",
		Default = F.AutoAccessoryGamemode,
		Values = _accessoryList,
		Flag = "AutoAccessoryGamemode",
		Callback = function(v)
			F.AutoAccessoryGamemode = v
			if F.AutoDungeon or F.AutoBossRush or F.AutoInfiniteTower then
				_currentAccessory = nil
				task.spawn(_applyAccessory)
			end
		end,
	})
	S._accDropGM.Link:AddHelper({ Text = "Accessory used in Dungeon/Boss Rush/Tower" })
	local RuneSec = LTab:DrawSection({ Name = "Auto Rune", Position = "left" })
	local _runeRemote = nil
	local _runeList = { "None" }
	local _currentRune = nil
	task.spawn(function()
		pcall(function()
			local r = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("GetRuneData")
			if r then
				local data = r:InvokeServer()
				if type(data) == "table" and type(data.equipped) == "string" and data.equipped ~= "" then
					_currentRune = data.equipped
				end
			end
		end)
	end)
	local function _updateRuneDropdowns()
		table.sort(_runeList, function(a, b)
			if a == "None" then
				return true
			end
			if b == "None" then
				return false
			end
			return a < b
		end)
		pcall(function()
			if S._runeDropMob then
				local cur = F.AutoRuneMob
				S._runeDropMob:SetValues(_runeList)
				if cur and cur ~= "" then
					pcall(function()
						S._runeDropMob:SetValue(cur)
					end)
				end
			end
			if S._runeDropBoss then
				local cur = F.AutoRuneBoss
				S._runeDropBoss:SetValues(_runeList)
				if cur and cur ~= "" then
					pcall(function()
						S._runeDropBoss:SetValue(cur)
					end)
				end
			end
			if S._runeDropGM then
				local cur = F.AutoRuneGamemode
				S._runeDropGM:SetValues(_runeList)
				if cur and cur ~= "" then
					pcall(function()
						S._runeDropGM:SetValue(cur)
					end)
				end
			end
		end)
	end
	task.spawn(function()
		pcall(function()
			_runeRemote = RS:WaitForChild("Remotes", 5):WaitForChild("EquipRune", 5)
		end)
		pcall(function()
			local remotes = RS:FindFirstChild("Remotes")
			if not remotes then
				return
			end
			local upInv = remotes:FindFirstChild("UpdateInventory")
			if upInv and upInv:IsA("RemoteEvent") then
				upInv.OnClientEvent:Connect(function(category, data)
					if category == "Runes" and type(data) == "table" then
						_runeList = { "None" }
						for name, _ in pairs(data) do
							if type(name) == "string" then
								table.insert(_runeList, name)
							end
						end
						_updateRuneDropdowns()
					end
				end)
			end
			local reqInv = remotes:FindFirstChild("RequestInventory")
			if reqInv then
				reqInv:FireServer()
			end
		end)
	end)
	local function _getRuneContext()
		local tgt = S.CurTarget
		if not tgt or not tgt.Parent then
			return "None"
		end
		local inGamemode = F.AutoDungeon or F.AutoBossRush or F.AutoInfiniteTower
		if inGamemode and (fn.IsTowerEnemy(tgt) or fn.IsBossRushEnemy(tgt) or fn.IsKnownDungeonEnemy(tgt)) then
			return "Gamemode"
		end
		if S.BossFight or S.SummonBossFight then
			return "Boss"
		end
		local tname = (tgt.Name or ""):lower()
		if tname:find("boss") then
			return "Boss"
		end
		return "Mob"
	end
	local function _applyRune()
		if not F.AutoRune or _dead then
			return
		end
		pcall(function()
			if not _runeRemote then
				_runeRemote = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("EquipRune")
			end
			if not _runeRemote then
				return
			end
			local ctx = _getRuneContext()
			if ctx == "None" then
				return
			end
			local rune
			if ctx == "Boss" then
				rune = F.AutoRuneBoss
			elseif ctx == "Gamemode" then
				rune = F.AutoRuneGamemode
			else
				rune = F.AutoRuneMob
			end
			if not rune or rune == "None" then
				return
			end
			if rune ~= _currentRune then
				local ok = pcall(function()
					_runeRemote:FireServer("Equip", rune)
				end)
				if ok then
					_currentRune = rune
				end
			end
		end)
	end
	task.spawn(function()
		while S.Running do
			task.wait(3)
			_applyRune()
		end
	end)
	S.AutoRuneToggle = RuneSec:AddToggle({
		Name = "Auto Switch Rune",
		Flag = "AutoRune",
		Default = F.AutoRune,
		Callback = function(v)
			F.AutoRune = v
		end,
	})
	S.AutoRuneKeybind = S.AutoRuneToggle.Link:AddKeybind({ Flag = "AutoRuneKeybind", Callback = function() end })
	S.AutoRuneToggle.Link:AddHelper({ Text = "Switches rune based on enemy type" })
	S._runeDropMob = RuneSec:AddDropdown({
		Name = "Farming Enemies",
		Default = F.AutoRuneMob,
		Values = _runeList,
		Flag = "AutoRuneMob",
		Callback = function(v)
			F.AutoRuneMob = v
			task.spawn(_applyRune)
		end,
	})
	S._runeDropMob.Link:AddHelper({ Text = "Rune used when farming regular enemies" })
	S._runeDropBoss = RuneSec:AddDropdown({
		Name = "Farming Bosses",
		Default = F.AutoRuneBoss,
		Values = _runeList,
		Flag = "AutoRuneBoss",
		Callback = function(v)
			F.AutoRuneBoss = v
			task.spawn(_applyRune)
		end,
	})
	S._runeDropBoss.Link:AddHelper({ Text = "Rune used when fighting bosses" })
	S._runeDropGM = RuneSec:AddDropdown({
		Name = "Farming Gamemodes",
		Default = F.AutoRuneGamemode,
		Values = _runeList,
		Flag = "AutoRuneGamemode",
		Callback = function(v)
			F.AutoRuneGamemode = v
			task.spawn(_applyRune)
		end,
	})
	S._runeDropGM.Link:AddHelper({ Text = "Rune used in Dungeon/Boss Rush/Tower" })
	local AuraSec = LTab:DrawSection({ Name = "Auto Aura", Position = "left" })
	local _auraList = { "None" }
	local _currentAura = nil
	local function _updateAuraDropdowns()
		table.sort(_auraList, function(a, b)
			if a == "None" then
				return true
			end
			if b == "None" then
				return false
			end
			return a < b
		end)
		pcall(function()
			if S._auraDropMob then
				local cur = F.AutoAuraMob
				S._auraDropMob:SetValues(_auraList)
				if cur and cur ~= "" then
					pcall(function()
						S._auraDropMob:SetValue(cur)
					end)
				end
			end
			if S._auraDropBoss then
				local cur = F.AutoAuraBoss
				S._auraDropBoss:SetValues(_auraList)
				if cur and cur ~= "" then
					pcall(function()
						S._auraDropBoss:SetValue(cur)
					end)
				end
			end
			if S._auraDropGM then
				local cur = F.AutoAuraGamemode
				S._auraDropGM:SetValues(_auraList)
				if cur and cur ~= "" then
					pcall(function()
						S._auraDropGM:SetValue(cur)
					end)
				end
			end
		end)
	end
	local function _handleAuraInventory(data)
		if not data or type(data) ~= "table" then
			return
		end
		_auraList = { "None" }
		for name, _ in pairs(data) do
			if type(name) == "string" then
				table.insert(_auraList, name)
			end
		end
		_updateAuraDropdowns()
	end
	task.spawn(function()
		pcall(function()
			local remotes = RS:FindFirstChild("Remotes")
			if not remotes then
				return
			end
			local upInv = remotes:FindFirstChild("UpdateInventory")
			if upInv and upInv:IsA("RemoteEvent") then
				upInv.OnClientEvent:Connect(function(category, data)
					if category == "Auras" or category == "Aura" then
						_handleAuraInventory(data)
					end
				end)
			end
			local reqInv = remotes:FindFirstChild("RequestInventory")
			if reqInv then
				reqInv:FireServer()
			end
		end)
		pcall(function()
			local rf = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("GetEquippedAura")
			if rf then
				local eq = rf:InvokeServer()
				if eq and type(eq) == "string" then
					_currentAura = eq
				end
			end
		end)
	end)
	local _equipAuraRemote = nil
	local function _getEquipAura()
		if _equipAuraRemote then
			return _equipAuraRemote
		end
		pcall(function()
			_equipAuraRemote = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("EquipAura")
		end)
		return _equipAuraRemote
	end
	local function _applyAura()
		if not F.AutoAura or _dead then
			return
		end
		pcall(function()
			local aura = F.AutoAuraMob
			if S.BossFight or S.SummonBossFight then
				aura = F.AutoAuraBoss
			elseif F.AutoDungeon or F.AutoBossRush or F.AutoInfiniteTower then
				aura = F.AutoAuraGamemode
			end
			if not aura or aura == "None" then
				return
			end
			if aura ~= _currentAura then
				local re = _getEquipAura()
				if re then
					re:FireServer("EquipStats", aura)
					_currentAura = aura
				end
			end
		end)
	end
	task.spawn(function()
		while S.Running do
			task.wait(3)
			_applyAura()
		end
	end)
	S.AutoAuraToggle = AuraSec:AddToggle({
		Name = "Auto Switch Aura",
		Flag = "AutoAura",
		Default = F.AutoAura,
		Callback = function(v)
			F.AutoAura = v
		end,
	})
	S.AutoAuraKeybind = S.AutoAuraToggle.Link:AddKeybind({ Flag = "AutoAuraKeybind", Callback = function() end })
	S.AutoAuraToggle.Link:AddHelper({ Text = "Switches aura based on enemy type" })
	S._auraDropMob = AuraSec:AddDropdown({
		Name = "Farming Enemies",
		Default = F.AutoAuraMob,
		Values = _auraList,
		Flag = "AutoAuraMob",
		Callback = function(v)
			F.AutoAuraMob = v
			_currentAura = nil
			task.spawn(_applyAura)
		end,
	})
	S._auraDropMob.Link:AddHelper({ Text = "Aura used when farming regular enemies" })
	S._auraDropBoss = AuraSec:AddDropdown({
		Name = "Farming Bosses",
		Default = F.AutoAuraBoss,
		Values = _auraList,
		Flag = "AutoAuraBoss",
		Callback = function(v)
			F.AutoAuraBoss = v
			_currentAura = nil
			task.spawn(_applyAura)
		end,
	})
	S._auraDropBoss.Link:AddHelper({ Text = "Aura used when fighting bosses" })
	S._auraDropGM = AuraSec:AddDropdown({
		Name = "Farming Gamemodes",
		Default = F.AutoAuraGamemode,
		Values = _auraList,
		Flag = "AutoAuraGamemode",
		Callback = function(v)
			F.AutoAuraGamemode = v
			_currentAura = nil
			task.spawn(_applyAura)
		end,
	})
	S._auraDropGM.Link:AddHelper({ Text = "Aura used in Dungeon/Boss Rush/Tower" })
	local CosmeticSec = LTab:DrawSection({ Name = "Auto Cosmetic", Position = "right" })
	local _cosmeticRemote = nil
	local _cosmeticList = { "None" }
	local _currentCosmetic = nil
	task.spawn(function()
		pcall(function()
			local r = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("GetEquippedCosmetic")
			if r then
				local data = r:InvokeServer()
				if type(data) == "table" and type(data.Stats) == "string" and data.Stats ~= "" then
					_currentCosmetic = data.Stats
				end
			end
		end)
	end)
	local function _updateCosmeticDropdowns()
		table.sort(_cosmeticList, function(a, b)
			if a == "None" then
				return true
			end
			if b == "None" then
				return false
			end
			return a < b
		end)
		pcall(function()
			if S._cosmDropMob then
				local cur = F.AutoCosmeticMob
				S._cosmDropMob:SetValues(_cosmeticList)
				if cur and cur ~= "" then
					pcall(function()
						S._cosmDropMob:SetValue(cur)
					end)
				end
			end
			if S._cosmDropBoss then
				local cur = F.AutoCosmeticBoss
				S._cosmDropBoss:SetValues(_cosmeticList)
				if cur and cur ~= "" then
					pcall(function()
						S._cosmDropBoss:SetValue(cur)
					end)
				end
			end
			if S._cosmDropGM then
				local cur = F.AutoCosmeticGamemode
				S._cosmDropGM:SetValues(_cosmeticList)
				if cur and cur ~= "" then
					pcall(function()
						S._cosmDropGM:SetValue(cur)
					end)
				end
			end
		end)
	end
	task.spawn(function()
		pcall(function()
			_cosmeticRemote = RS:WaitForChild("Remotes", 5):WaitForChild("EquipCosmetic", 5)
		end)
		pcall(function()
			local remotes = RS:FindFirstChild("Remotes")
			if not remotes then
				return
			end
			local upInv = remotes:FindFirstChild("UpdateInventory")
			if upInv and upInv:IsA("RemoteEvent") then
				upInv.OnClientEvent:Connect(function(category, data)
					if category == "Cosmetics" and type(data) == "table" then
						_cosmeticList = { "None" }
						for _, item in ipairs(data) do
							if type(item) == "table" and type(item.name) == "string" then
								table.insert(_cosmeticList, item.name)
							end
						end
						_updateCosmeticDropdowns()
					end
				end)
			end
			local reqInv = remotes:FindFirstChild("RequestInventory")
			if reqInv then
				reqInv:FireServer()
			end
		end)
	end)
	local function _getCosmeticContext()
		local tgt = S.CurTarget
		if not tgt or not tgt.Parent then
			return "None"
		end
		local inGamemode = F.AutoDungeon or F.AutoBossRush or F.AutoInfiniteTower
		if inGamemode and (fn.IsTowerEnemy(tgt) or fn.IsBossRushEnemy(tgt) or fn.IsKnownDungeonEnemy(tgt)) then
			return "Gamemode"
		end
		if S.BossFight or S.SummonBossFight then
			return "Boss"
		end
		local tname = (tgt.Name or ""):lower()
		if tname:find("boss") then
			return "Boss"
		end
		return "Mob"
	end
	local function _applyCosmetic()
		if not F.AutoCosmetic or _dead then
			return
		end
		pcall(function()
			if not _cosmeticRemote then
				_cosmeticRemote = RS:FindFirstChild("Remotes") and RS.Remotes:FindFirstChild("EquipCosmetic")
			end
			if not _cosmeticRemote then
				return
			end
			local ctx = _getCosmeticContext()
			if ctx == "None" then
				return
			end
			local cosm
			if ctx == "Boss" then
				cosm = F.AutoCosmeticBoss
			elseif ctx == "Gamemode" then
				cosm = F.AutoCosmeticGamemode
			else
				cosm = F.AutoCosmeticMob
			end
			if not cosm or cosm == "None" then
				return
			end
			if cosm ~= _currentCosmetic then
				local ok = pcall(function()
					_cosmeticRemote:FireServer("EquipStats", cosm)
				end)
				if ok then
					_currentCosmetic = cosm
				end
			end
		end)
	end
	task.spawn(function()
		while S.Running do
			task.wait(3)
			_applyCosmetic()
		end
	end)
	S.AutoCosmeticToggle = CosmeticSec:AddToggle({
		Name = "Auto Switch Cosmetic",
		Flag = "AutoCosmetic",
		Default = F.AutoCosmetic,
		Callback = function(v)
			F.AutoCosmetic = v
		end,
	})
	S.AutoCosmeticKeybind = S.AutoCosmeticToggle.Link:AddKeybind({ Flag = "AutoCosmeticKeybind", Callback = function() end })
	S.AutoCosmeticToggle.Link:AddHelper({ Text = "Switches cosmetic (stats) based on enemy type" })
	S._cosmDropMob = CosmeticSec:AddDropdown({
		Name = "Farming Enemies",
		Default = F.AutoCosmeticMob,
		Values = _cosmeticList,
		Flag = "AutoCosmeticMob",
		Callback = function(v)
			F.AutoCosmeticMob = v
			if F.AutoCosmetic and v and v ~= "None" and _cosmeticRemote then
				task.spawn(function()
					pcall(function()
						_cosmeticRemote:FireServer("EquipStats", v)
					end)
					_currentCosmetic = v
				end)
			end
		end,
	})
	S._cosmDropMob.Link:AddHelper({ Text = "Cosmetic used when farming regular enemies" })
	S._cosmDropBoss = CosmeticSec:AddDropdown({
		Name = "Farming Bosses",
		Default = F.AutoCosmeticBoss,
		Values = _cosmeticList,
		Flag = "AutoCosmeticBoss",
		Callback = function(v)
			F.AutoCosmeticBoss = v
			if F.AutoCosmetic and v and v ~= "None" and _cosmeticRemote then
				task.spawn(function()
					pcall(function()
						_cosmeticRemote:FireServer("EquipStats", v)
					end)
					_currentCosmetic = v
				end)
			end
		end,
	})
	S._cosmDropBoss.Link:AddHelper({ Text = "Cosmetic used when fighting bosses" })
	S._cosmDropGM = CosmeticSec:AddDropdown({
		Name = "Farming Gamemodes",
		Default = F.AutoCosmeticGamemode,
		Values = _cosmeticList,
		Flag = "AutoCosmeticGamemode",
		Callback = function(v)
			F.AutoCosmeticGamemode = v
			if F.AutoCosmetic and v and v ~= "None" and _cosmeticRemote then
				task.spawn(function()
					pcall(function()
						_cosmeticRemote:FireServer("EquipStats", v)
					end)
					_currentCosmetic = v
				end)
			end
		end,
	})
	S._cosmDropGM.Link:AddHelper({ Text = "Cosmetic used in Dungeon/Boss Rush/Tower" })
	task.wait()
	local FPSec = FTab:DrawSection({ Name = "Follow Player", Position = "left" })
	S.FollowToggle = FPSec:AddToggle({
		Name = "Enable Follow Player",
		Flag = "FollowPlayer",
		Default = F.FollowPlayer,
		Guard = function(v)
			if v and (F.AutoDungeon or F.AutoBossRush or F.AutoInfiniteTower) then
				S.Notify.new({
					Title = "Follow Player",
					Content = "Disable Gamemodes first",
					Duration = 3,
					Icon = S.ICON,
				})
				return false
			end
			return true
		end,
		Callback = function(v)
			F.FollowPlayer = v
			if v then
				if F.AutoFarmLevel then
					F.AutoFarmLevel = false
					if S.FarmToggle then
						pcall(function()
							S.FarmToggle:SetValue(false)
						end)
					end
				end
				fn.StopTw()
				fn.ClearTgt()
				S.HoverPos = nil
				S.LockTarget = nil
				S.CurTarget = nil
			else
				fn.StopTw()
				fn.ClearTgt()
				S.HoverPos = nil
				S.LockTarget = nil
				fn.ResetAboveMode()
			end
		end,
	})
	S.FollowKeybind =
		S.FollowToggle.Link:AddKeybind({ Default = "H", Flag = "FollowPlayerKeybind", Callback = function() end })
	S.FollowToggle.Link:AddHelper({ Text = "Follow a player around — auto-detects their island" })
	do
		local function getPlayerNames()
			local names = {}
			for _, p in ipairs(Players:GetPlayers()) do
				if p ~= LP then
					table.insert(names, p.Name)
				end
			end
			if #names == 0 then
				table.insert(names, "")
			end
			return names
		end
		S.FollowPlayerDropdown = FPSec:AddDropdown({
			Name = "Player",
			Default = F.FollowPlayerName ~= "" and F.FollowPlayerName or getPlayerNames()[1],
			Values = getPlayerNames(),
			Flag = "FollowPlayerName",
			Callback = function(v)
				F.FollowPlayerName = v
				local found = fn.GetFollowTarget()
				if found then
					S.Notify.new({
						Title = "Follow Player",
						Content = "Locked onto " .. found.Name,
						Duration = 2,
						Icon = S.ICON,
					})
				end
			end,
		})
		local function refreshPlayers()
			pcall(function()
				S.FollowPlayerDropdown:SetValues(getPlayerNames())
			end)
		end
		Players.PlayerAdded:Connect(refreshPlayers)
		Players.PlayerRemoving:Connect(function()
			task.delay(0.1, refreshPlayers)
		end)
	end
	FPSec:AddDropdown({
		Name = "Stand Position",
		Default = F.FollowPlayerMode,
		Values = { "Above", "Behind", "In Front", "Left Side", "Right Side" },
		Flag = "FollowPlayerMode",
		Callback = function(v)
			F.FollowPlayerMode = v
		end,
	})
	FPSec:AddDropdown({
		Name = "Combat Style",
		Default = F.FollowStyle,
		Values = { "Dodge", "Static", "Orbit", "Strafe" },
		Callback = function(v)
			F.FollowStyle = v

		end,
	}).Link
		:AddHelper({ Text = "Dodge = strafe on threat | Static = fixed | Orbit = circle | Strafe = side-step" })
	FPSec:AddDropdown({
		Name = "Travel Mode",
		Default = F.FollowPlayerMove,
		Values = { "Tween", "Teleport" },
		Flag = "FollowPlayerMove",
		Callback = function(v)
			F.FollowPlayerMove = v
		end,
	})
	FPSec:AddSlider({
		Name = "Follow Offset",
		Min = 3,
		Max = 50,
		Default = F.FollowPlayerDist,
		Round = 0,
		Flag = "FollowPlayerDist",
		Callback = function(v)
			F.FollowPlayerDist = v
		end,
	})
	FPSec:AddSlider({
		Name = "Follow Speed",
		Min = 15,
		Max = 200,
		Default = F.FollowPlayerSpeed,
		Round = 0,
		Flag = "FollowPlayerSpeed",
		Callback = function(v)
			F.FollowPlayerSpeed = v
		end,
	})
	FPSec:AddToggle({
		Name = "Anti-AFK",
		Flag = "AntiAFK",
		Default = F.AntiAFK,
		Callback = function(v)
			F.AntiAFK = v
		end,
	}).Link
		:AddHelper({ Text = "Prevents disconnect" })
	_glowButton(FPSec, "Scan All NPCs", function()
		local isl = S.CurIsland or fn.IslandForLevel(fn.GetLevel())
		local en = fn.FindEnemies(isl)
		local nf = fn.GetNPCFolder()
		local all = {}
		if nf then
			local ct = {}
			local function addModel(m)
				if m:IsA("Model") then
					ct[m.Name] = (ct[m.Name] or 0) + 1
				end
			end
			for _, child in ipairs(nf:GetChildren()) do
				if child:IsA("Folder") then
					for _, m in ipairs(child:GetChildren()) do
						addModel(m)
					end
				else
					addModel(child)
				end
			end
			for n, c in pairs(ct) do
				table.insert(all, n .. " x" .. c)
			end
			table.sort(all)
		end
		S.Notify.new({
			Title = "Matched: " .. #en .. " (" .. isl.Portal .. ")",
			Content = "All NPCs:\n" .. table.concat(all, "\n"),
			Duration = 15,
			Icon = S.ICON,
		})
	end)
	task.wait()
	local TpSec = TPTab:DrawSection({ Name = "Teleport to Island", Position = "left" })
	for _, name in ipairs(S.TpIslands) do
		local displayName = fn.PortalDisplayName(name)
		_glowButton(TpSec, displayName, function()
			if F.AutoFarmLevel then
				S.Notify.new({
					Title = "Auto Farm is ON",
					Content = "Disable Auto Farm before teleporting manually",
					Duration = 3,
					Icon = S.ICON,
				})
				return
			end
			local ok = fn.ForceTP(name)
			S.Notify.new({
				Title = ok and ("Teleporting to " .. displayName) or "Teleport Failed",
				Content = ok and "Successfully teleported!" or "Could not find teleport remote",
				Duration = 4,
				Icon = S.ICON,
			})
		end)
	end
	local function _tpToNPC(npcName, island, display)
		if F.AutoFarmLevel or F.BossEnabled or S.BossFight or S.SummonBossFight then
			S.Notify.new({ Title = "Teleport", Content = "Disable farming/bosses first", Duration = 3, Icon = S.ICON })
			return
		end
		S.Notify.new({
			Title = "Teleporting",
			Content = display .. " (" .. fn.PortalDisplayName(island) .. ")",
			Duration = 2,
			Icon = S.ICON,
		})
		fn.ForceTP(island)
		task.wait(2)
		local npc = workspace:FindFirstChild("ServiceNPCs") and workspace.ServiceNPCs:FindFirstChild(npcName)
		if npc then
			local part = nil
			for _ = 1, 10 do
				part = npc:FindFirstChild("HumanoidRootPart")
					or npc:FindFirstChild("Torso")
					or npc:FindFirstChild("Head")
				if not part then
					for _, p in ipairs(npc:GetDescendants()) do
						if p:IsA("BasePart") then
							part = p
							break
						end
					end
				end
				if part then
					break
				end
				task.wait(0.3)
			end
			if part then
				local myHrp = fn.PlayerHRP()
				if myHrp then
					myHrp.CFrame = CFrame.new(part.Position + Vector3.new(0, 15, 0))
					S.Notify.new({ Title = "Teleported", Content = display, Duration = 2, Icon = S.ICON })
				end
			end
		else
			S.Notify.new({ Title = "Not Found", Content = npcName .. " not in workspace", Duration = 3, Icon = S.ICON })
		end
	end
	local function _addNpcButton(sec, npcName, island)
		local display = npcName:gsub("NPC$", ""):gsub("(%u)", " %1"):gsub("^ ", ""):gsub("  ", " ")
		_glowButton(sec, display, function()
			task.spawn(_tpToNPC, npcName, island, display)
		end)
	end
	local NpcBuyerSec = TPTab:DrawSection({ Name = "Buyers", Position = "right" })
	_addNpcButton(NpcBuyerSec, "AlucardBuyer", "Sailor")
	_addNpcButton(NpcBuyerSec, "AnosBuyerNPC", "Academy")
	_addNpcButton(NpcBuyerSec, "AtomicBuyer", "Lawless")
	_addNpcButton(NpcBuyerSec, "BlessedMaidenBuyerNPC", "Boss")
	_addNpcButton(NpcBuyerSec, "CidBuyer", "Dungeon")
	_addNpcButton(NpcBuyerSec, "CoinFruitDealer", "Sailor")
	_addNpcButton(NpcBuyerSec, "GemFruitDealer", "Sailor")
	_addNpcButton(NpcBuyerSec, "GilgameshBuyerNPC", "Boss")
	_addNpcButton(NpcBuyerSec, "GryphonBuyerNPC", "Dungeon")
	_addNpcButton(NpcBuyerSec, "IchigoBuyer", "HollowIsland")
	_addNpcButton(NpcBuyerSec, "MadokaBuyer", "Starter")
	_addNpcButton(NpcBuyerSec, "ObservationBuyer", "Desert")
	_addNpcButton(NpcBuyerSec, "QinShiBuyer", "Boss")
	_addNpcButton(NpcBuyerSec, "RagnaBuyer", "Snow")
	_addNpcButton(NpcBuyerSec, "RimuruBuyer", "Slime")
	_addNpcButton(NpcBuyerSec, "SaberAlterBuyerNPC", "Boss")
	_addNpcButton(NpcBuyerSec, "ShadowMonarchBuyerNPC", "Dungeon")
	_addNpcButton(NpcBuyerSec, "StrongestShinobiBuyerNPC", "Ninja")
	_addNpcButton(NpcBuyerSec, "StrongestinHistoryBuyerNPC", "Shinjuku")
	_addNpcButton(NpcBuyerSec, "StrongestofTodayBuyerNPC", "Shibuya")
	_addNpcButton(NpcBuyerSec, "TrueAizenBuyerNPC", "SoulSociety")
	_addNpcButton(NpcBuyerSec, "YamatoBuyerNPC", "Judgement")
	_addNpcButton(NpcBuyerSec, "YujiBuyerNPC", "Dungeon")
	local NpcMovesetSec = TPTab:DrawSection({ Name = "Moveset & Mastery", Position = "right" })
	_addNpcButton(NpcMovesetSec, "AizenMovesetNPC", "HollowIsland")
	_addNpcButton(NpcMovesetSec, "BlessedMaidenMasteryNPC", "Boss")
	_addNpcButton(NpcMovesetSec, "GojoMasteryNPC", "Shinjuku")
	_addNpcButton(NpcMovesetSec, "GojoMovesetNPC", "Shibuya")
	_addNpcButton(NpcMovesetSec, "JinwooMovesetNPC", "Sailor")
	_addNpcButton(NpcMovesetSec, "RimuruMasteryNPC", "Slime")
	_addNpcButton(NpcMovesetSec, "SaberAlterMasteryNPC", "Boss")
	_addNpcButton(NpcMovesetSec, "StrongestShinobiMasteryNPC", "Ninja")
	_addNpcButton(NpcMovesetSec, "SukunaMasteryNPC", "Shinjuku")
	_addNpcButton(NpcMovesetSec, "SukunaMovesetNPC", "Dungeon")
	local NpcCraftSec = TPTab:DrawSection({ Name = "Crafting", Position = "right" })
	_addNpcButton(NpcCraftSec, "BabylonCraftNPC", "Boss")
	_addNpcButton(NpcCraftSec, "GojoCraftNPC", "Shinjuku")
	_addNpcButton(NpcCraftSec, "GrailCraftNPC", "Boss")
	_addNpcButton(NpcCraftSec, "SlimeCraftNPC", "Slime")
	_addNpcButton(NpcCraftSec, "SukunaCraftNPC", "Shinjuku")
	local NpcSummonSec = TPTab:DrawSection({ Name = "Boss Summoners", Position = "left" })
	_addNpcButton(NpcSummonSec, "AnosBossSummonerNPC", "Academy")
	_addNpcButton(NpcSummonSec, "AtomicBossSummonerNPC", "Lawless")
	_addNpcButton(NpcSummonSec, "RimuruSummonerNPC", "Slime")
	_addNpcButton(NpcSummonSec, "StrongestBossSummonerNPC", "Shinjuku")
	_addNpcButton(NpcSummonSec, "SummonBossNPC", "Boss")
	_addNpcButton(NpcSummonSec, "TrueAizenBossSummonerNPC", "SoulSociety")
	local NpcPortalSec = TPTab:DrawSection({ Name = "Portals & Shops", Position = "left" })
	_addNpcButton(NpcPortalSec, "BossRushMerchantNPC", "Sailor")
	_addNpcButton(NpcPortalSec, "BossRushPortalNPC", "Sailor")
	_addNpcButton(NpcPortalSec, "BossRushShopNPC", "Sailor")
	_addNpcButton(NpcPortalSec, "DungeonMerchantNPC", "Dungeon")
	_addNpcButton(NpcPortalSec, "DungeonPortalsNPC", "Dungeon")
	_addNpcButton(NpcPortalSec, "InfiniteTowerMerchantNPC", "Tower")
	_addNpcButton(NpcPortalSec, "InfiniteTowerPortalNPC", "Tower")
	_addNpcButton(NpcPortalSec, "InfiniteTowerStatShopNPC", "Tower")
	local NpcProgSec = TPTab:DrawSection({ Name = "Progression", Position = "left" })
	_addNpcButton(NpcProgSec, "AscendNPC", "Sailor")
	_addNpcButton(NpcProgSec, "BlessingNPC", "Shibuya")
	_addNpcButton(NpcProgSec, "ConquerorHakiNPC", "Shibuya")
	_addNpcButton(NpcProgSec, "DarkBladeNPC", "Snow")
	_addNpcButton(NpcProgSec, "EnchantNPC", "Shibuya")
	_addNpcButton(NpcProgSec, "ExchangeNPC", "Boss")
	_addNpcButton(NpcProgSec, "HakiQuestNPC", "Snow")
	_addNpcButton(NpcProgSec, "Katana", "Starter")
	_addNpcButton(NpcProgSec, "MerchantNPC", "Sailor")
	_addNpcButton(NpcProgSec, "RerollStatNPC", "Sailor")
	_addNpcButton(NpcProgSec, "SkillTreeNPC", "Slime")
	_addNpcButton(NpcProgSec, "SpecPassivesNPC", "Judgement")
	_addNpcButton(NpcProgSec, "StorageNPC", "Sailor")
	_addNpcButton(NpcProgSec, "TitlesNPC", "Sailor")
	_addNpcButton(NpcProgSec, "TraitNPC", "Sailor")
	local NpcQuestSec = TPTab:DrawSection({ Name = "Questline & Misc", Position = "left" })
	_addNpcButton(NpcQuestSec, "AizenQuestlineBuff", "HollowIsland")
	_addNpcButton(NpcQuestSec, "AnosQuestNPC", "Academy")
	_addNpcButton(NpcQuestSec, "ArtifactMilestoneNPC", "Snow")
	_addNpcButton(NpcQuestSec, "ArtifactsUnlocker", "Snow")
	_addNpcButton(NpcQuestSec, "AtomicQuestlineBuff", "Lawless")
	_addNpcButton(NpcQuestSec, "GroupRewardNPC", "Starter")
	_addNpcButton(NpcQuestSec, "HogyokuQuestNPC", "HollowIsland")
	_addNpcButton(NpcQuestSec, "RagnaQuestlineBuff", "Snow")
	_addNpcButton(NpcQuestSec, "ShadowMonarchQuestlineBuff", "Starter")
	_addNpcButton(NpcQuestSec, "ShadowQuestlineBuff", "Starter")
	_addNpcButton(NpcQuestSec, "TrueAizenFUnlockNPC", "SoulSociety")
	task.wait()
	S.DungeonToggles = {}
	fn.EnableDungeonType = function(dtype, v)
		if v then
			F.DungeonType = dtype
			F.AutoDungeon = true
			if F.AutoEquip then
				task.spawn(fn.EquipBothWeapons)
			end
			F.AutoFarmLevel = false
			if S.FarmToggle then
				pcall(function()
					S.FarmToggle:SetValue(false)
				end)
			end
			F.AutoBossRush = false
			if S.BossRushAutoToggle then
				pcall(function()
					S.BossRushAutoToggle:SetValue(false)
				end)
			end
			F.AutoInfiniteTower = false
			if S.TowerToggle then
				pcall(function()
					S.TowerToggle:SetValue(false)
				end)
			end
			F.BossEnabled = false
			if S.BossToggle then
				pcall(function()
					S.BossToggle:SetValue(false)
				end)
			end
			for _, ob in ipairs(S.SummonBosses) do
				if S.BSF[ob.Name] then
					S.BSF[ob.Name] = false
					fn.DisableAutoSpawn(ob.Name)
					S.SummonBossCommitted[ob.Name] = nil
					S.SummonBossFireTime[ob.Name] = nil
					if S.BSFToggle[ob.Name] then
						pcall(function()
							S.BSFToggle[ob.Name]:SetValue(false)
						end)
					end
				end
			end
			if S.BossFight then
				S.BossFight = false
				S.BossTargetName = nil
				S.BossTPDone = false
			end
			if S.SummonBossFight then
				fn.ExitSummonBossMode()
			end
			S.CurTarget = nil
			S.LockTarget = nil
			S.HoverPos = nil
			S.FarmOrigin = nil
			S.LastDungeonSwitch = 0
			fn.StopTw()
			task.spawn(fn.FireDungeonVote)
		else
			if F.DungeonType == dtype then
				F.AutoDungeon = false
			end
			S.CurTarget = nil
			S.LockTarget = nil
			S.HoverPos = nil
			S.LastDungeonSwitch = 0
			fn.StopTw()
		end
	end
	local ITSec = DTab:DrawSection({ Name = "Infinite Tower", Position = "left" })
	S.TowerToggle = ITSec:AddToggle({
		Name = "Enable Infinite Tower",
		Flag = "AutoInfiniteTower",
		Default = F.AutoInfiniteTower,
		Callback = function(v)
			F.AutoInfiniteTower = v
			if v then
				if F.AutoEquip then
					task.spawn(fn.EquipBothWeapons)
				end
				task.spawn(function()
					pcall(function()
						fn.WalkPathWait(RS, 3, unpack(R.DungeonVote)):FireServer("start")
					end)
				end)
				F.AutoFarmLevel = false
				if S.FarmToggle then
					pcall(function()
						S.FarmToggle:SetValue(false)
					end)
				end
				F.AutoDungeon = false
				S.LastDungeonSwitch = 0
				for _, dt in ipairs(S.DungeonTypes) do
					if S.DungeonToggles[dt] then
						pcall(function()
							S.DungeonToggles[dt]:SetValue(false)
						end)
					end
				end
				F.AutoBossRush = false
				if S.BossRushAutoToggle then
					pcall(function()
						S.BossRushAutoToggle:SetValue(false)
					end)
				end
				F.BossEnabled = false
				if S.BossToggle then
					pcall(function()
						S.BossToggle:SetValue(false)
					end)
				end
				S.CurTarget = nil
				S.LockTarget = nil
				S.HoverPos = nil
				fn.StopTw()
			else
				S.CurTarget = nil
				S.LockTarget = nil
				S.HoverPos = nil
				fn.StopTw()
			end
		end,
	})
	S.TowerKeybind = S.TowerToggle.Link:AddKeybind({ Default = "T", Flag = "TowerKeybind", Callback = function() end })
	ITSec:AddToggle({
		Name = "Auto-Join Infinite Tower",
		Flag = "AutoJoinTower",
		Default = false,
		Callback = function(v)
			S.AutoJoinTower = v
			if v then
				S.AutoJoinTowerFired = true
				task.spawn(function()
					pcall(function()
						local r = fn.WalkPathWait(RS, 3, unpack(R.DungeonPortal))
						if r then
							r:FireServer("InfiniteTower")
						end
					end)
				end)
			else
				S.AutoJoinTowerFired = false
			end
		end,
	}).Link
		:AddHelper({ Text = "Auto-enters Infinite Tower portal when not inside" })
	ITSec:AddDropdown({
		Name = "Stand Position",
		Default = F.TowerFarmMode,
		Values = { "Above", "Behind", "In Front", "Left Side", "Right Side" },
		Flag = "TowerFarmMode",
		Callback = function(v)
			F.TowerFarmMode = v
			fn.ClearTgt()
			S.HoverPos = nil
		end,
	})
	ITSec:AddDropdown({
		Name = "Travel Mode",
		Default = F.TowerMoveMode,
		Values = { "Tween", "Teleport" },
		Flag = "TowerMoveMode",
		Callback = function(v)
			F.TowerMoveMode = v
			fn.ClearTgt()
			S.HoverPos = nil
			if v ~= "Walk" then
				fn.RestoreWalkSpeed()
			end
		end,
	})
	ITSec:AddDropdown({
		Name = "Combat Style",
		Default = F.TowerFollowStyle,
		Values = { "Dodge", "Static", "Orbit", "Strafe" },
		Flag = "TowerFollowStyle",
		Callback = function(v)
			F.TowerFollowStyle = v
		end,
	})
	ITSec:AddSlider({
		Name = "Offset Distance",
		Min = 5,
		Max = 50,
		Default = F.TowerHeightOffset,
		Round = 0,
		Flag = "TowerHeightOffset",
		Callback = function(v)
			F.TowerHeightOffset = v
		end,
	})
	ITSec:AddSlider({
		Name = "Movement Speed",
		Min = 20,
		Max = 250,
		Default = F.TowerTweenSpeed,
		Round = 0,
		Flag = "TowerTweenSpeed",
		Callback = function(v)
			F.TowerTweenSpeed = v
		end,
	})
	local _dtFwd = { Double = "Shadow Dungeon", Rune = "Rune Dungeon", Cid = "Cid Dungeon" }
	local _dtRev = { ["Shadow Dungeon"] = "Double", ["Rune Dungeon"] = "Rune", ["Cid Dungeon"] = "Cid" }
	local DSec = DTab:DrawSection({ Name = "Auto Dungeons", Position = "left" })
	DSec:AddDropdown({
		Name = "Auto-Join",
		Default = "None",
		Values = { "None", "Shadow Dungeon", "Rune Dungeon", "Cid Dungeon" },
		Flag = "AutoJoinDungeon",
		Callback = function(v)
			for _, dt in ipairs(S.DungeonTypes) do
				S.AutoJoinDungeon[dt] = false
				S.AutoJoinFired[dt] = nil
			end
			if v ~= "None" then
				local dt = ({ ["Shadow Dungeon"] = "Double", ["Rune Dungeon"] = "Rune", ["Cid Dungeon"] = "Cid" })[v]
				if dt then
					S.AutoJoinDungeon[dt] = true
					S.AutoJoinFired[dt] = true
					task.spawn(function()
						fn.FireDungeonPortal(dt)
					end)
				end
			end
		end,
	}).Link
		:AddHelper({ Text = "Auto-enters selected dungeon portal when not inside" })
	DSec:AddToggle({
		Name = "Auto-Replay",
		Flag = "AutoReplay",
		Default = F.AutoReplay,
		Callback = function(v)
			F.AutoReplay = v
			if not v then
				S.WasInGamemode = false
			end
		end,
	}).Link
		:AddHelper({ Text = "Re-queues dungeon/boss rush/tower after completion" })
	DSec:AddDropdown({
		Name = "Dungeon Type",
		Default = _dtFwd[F.DungeonType] or "Shadow Dungeon",
		Values = { "Shadow Dungeon", "Rune Dungeon", "Cid Dungeon" },
		Flag = "SelectedDungeonType",
		Callback = function(v)
			local dt = _dtRev[v] or "Double"
			if F.AutoDungeon then
				fn.EnableDungeonType(dt, true)
			else
				F.DungeonType = dt
			end
		end,
	}).Link
		:AddHelper({ Text = "Shadow = ShadowMonarchBoss + ShadowBoss | Rune = DungeonNPC1-12 only | Cid = ShadowBoss" })
	S.DungeonUnifiedToggle = DSec:AddToggle({
		Name = "Enable Auto Dungeon",
		Flag = "AutoDungeonEnabled",
		Default = F.AutoDungeon,
		Callback = function(v)
			fn.EnableDungeonType(F.DungeonType or "Double", v)
		end,
	})
	S.DungeonKeybind =
		S.DungeonUnifiedToggle.Link:AddKeybind({ Default = "G", Flag = "DungeonKeybind", Callback = function() end })
	S.DungeonUnifiedToggle.Link:AddHelper({ Text = "Runs the selected dungeon type automatically" })
	for _, dt in ipairs(S.DungeonTypes) do
		S.DungeonToggles[dt] = S.DungeonUnifiedToggle
	end
	DSec:AddDropdown({
		Name = "Difficulty",
		Default = F.RuneDiff,
		Values = S.DungeonDifficulties,
		Flag = "DungeonDiff",
		Callback = function(v)
			for _, dt in ipairs(S.DungeonTypes) do
				F[dt .. "Diff"] = v
			end
			task.spawn(fn.FireDungeonVote)
		end,
	})
	DSec:AddDropdown({
		Name = "Stand Position",
		Default = F.FarmMode,
		Values = { "Above", "Behind", "In Front", "Left Side", "Right Side" },
		Flag = "DungeonFarmMode",
		Callback = function(v)
			F.FarmMode = v
			fn.ClearTgt()
			S.HoverPos = nil
		end,
	}).Link
		:AddHelper({ Text = "Behind = follow + Combat Style | others = fixed position (Static only)" })
	DSec:AddDropdown({
		Name = "Travel Mode",
		Default = F.MoveMode,
		Values = { "Tween", "Teleport" },
		Flag = "DungeonMove",
		Callback = function(v)
			F.MoveMode = v
			fn.ClearTgt()
			S.HoverPos = nil
			if v ~= "Walk" then
				fn.RestoreWalkSpeed()
			end
		end,
	}).Link
		:AddHelper({ Text = "Tween = smooth glide | Teleport = instant" })
	DSec:AddDropdown({
		Name = "Combat Style",
		Default = F.FollowStyle,
		Values = { "Dodge", "Static", "Orbit", "Strafe" },
		Flag = "DungeonFollowStyle",
		Callback = function(v)
			F.FollowStyle = v

		end,
	}).Link
		:AddHelper({ Text = "Dodge = strafe on threat | Static = fixed | Orbit = circle | Strafe = side-step" })
	DSec:AddSlider({
		Name = "Offset Distance",
		Min = 5,
		Max = 50,
		Default = F.OffsetDist,
		Round = 0,
		Flag = "DungeonOffsetDist",
		Callback = function(v)
			F.OffsetDist = v
		end,
	})
	DSec:AddSlider({
		Name = "Movement Speed",
		Min = 20,
		Max = 250,
		Default = F.TweenSpeed,
		Round = 0,
		Flag = "DungeonSpeed",
		Callback = function(v)
			F.TweenSpeed = v
		end,
	})
	local BRSec = DTab:DrawSection({ Name = "Boss Rush", Position = "right" })
	S.BossRushAutoToggle = BRSec:AddToggle({
		Name = "Enable Boss Rush",
		Flag = "AutoBossRush",
		Default = F.AutoBossRush,
		Callback = function(v)
			F.AutoBossRush = v
			if v then
				if F.AutoEquip then
					task.spawn(fn.EquipBothWeapons)
				end
				F.AutoFarmLevel = false
				if S.FarmToggle then
					pcall(function()
						S.FarmToggle:SetValue(false)
					end)
				end
				F.AutoDungeon = false
				S.LastDungeonSwitch = 0
				for _, dt in ipairs(S.DungeonTypes) do
					if S.DungeonToggles[dt] then
						pcall(function()
							S.DungeonToggles[dt]:SetValue(false)
						end)
					end
				end
				F.AutoInfiniteTower = false
				if S.TowerToggle then
					pcall(function()
						S.TowerToggle:SetValue(false)
					end)
				end
				F.BossEnabled = false
				if S.BossToggle then
					pcall(function()
						S.BossToggle:SetValue(false)
					end)
				end
				for _, ob in ipairs(S.SummonBosses) do
					if S.BSF[ob.Name] then
						S.BSF[ob.Name] = false
						fn.DisableAutoSpawn(ob.Name)
						S.SummonBossCommitted[ob.Name] = nil
						S.SummonBossFireTime[ob.Name] = nil
						if S.BSFToggle[ob.Name] then
							pcall(function()
								S.BSFToggle[ob.Name]:SetValue(false)
							end)
						end
					end
				end
				if S.BossFight then
					S.BossFight = false
					S.BossTargetName = nil
					S.BossTPDone = false
				end
				if S.SummonBossFight then
					fn.ExitSummonBossMode()
				end
				S.CurTarget = nil
				S.LockTarget = nil
				S.HoverPos = nil
				S.LastBossRushSwitch = 0
				fn.StopTw()
			else
				S.CurTarget = nil
				S.LockTarget = nil
				S.HoverPos = nil
				S.LastBossRushSwitch = 0
				fn.StopTw()
			end
		end,
	})
	S.BossRushKeybind =
		S.BossRushAutoToggle.Link:AddKeybind({ Default = "J", Flag = "BossRushKeybind", Callback = function() end })
	S.BossRushAutoToggle.Link:AddHelper({ Text = "Boss Rush gamemode only — targets all boss NPCs" })
	BRSec:AddDropdown({
		Name = "Difficulty",
		Default = F.BossRushDiff,
		Values = { "Easy", "Medium", "Hard" },
		Flag = "BossRushDiff",
		Callback = function(v)
			F.BossRushDiff = v
			S.LastBossRushVote = 0
			task.spawn(fn.FireBossRushVote)
		end,
	}).Link
		:AddHelper({ Text = "Votes for this difficulty — re-fires between waves automatically" })
	BRSec:AddToggle({
		Name = "Auto-Join Boss Rush",
		Flag = "AutoJoinBossRush",
		Default = false,
		Callback = function(v)
			S.AutoJoinBossRush = v
			if v then
				S.AutoJoinBossRushFired = true
				task.spawn(function()
					pcall(function()
						local r = fn.WalkPathWait(RS, 3, unpack(R.DungeonPortal))
						if r then
							r:FireServer("BossRush")
						end
					end)
				end)
			else
				S.AutoJoinBossRushFired = false
			end
		end,
	}).Link
		:AddHelper({ Text = "Auto-enters Boss Rush portal when not inside" })
	BRSec:AddDropdown({
		Name = "Stand Position",
		Default = F.FarmMode,
		Values = { "Above", "Behind", "In Front", "Left Side", "Right Side" },
		Flag = "BossRushFarmMode",
		Callback = function(v)
			F.BossRushFarmMode = v
			fn.ClearTgt()
			S.HoverPos = nil
		end,
	}).Link
		:AddHelper({
			Text = "Behind = follow + Combat Style | In Front / Left Side / Right Side = fixed position (Static only)",
		})
	BRSec:AddDropdown({
		Name = "Travel Mode",
		Default = F.BossRushMoveMode,
		Values = { "Tween", "Teleport" },
		Flag = "BossRushMoveMode",
		Callback = function(v)
			F.BossRushMoveMode = v
			fn.ClearTgt()
			S.HoverPos = nil
		end,
	}).Link
		:AddHelper({ Text = "Tween = smooth glide | Teleport = instant" })
	BRSec:AddDropdown({
		Name = "Combat Style",
		Default = F.FollowStyle,
		Values = { "Dodge", "Static", "Orbit", "Strafe" },
		Flag = "BossRushFollowStyle",
		Callback = function(v)
			F.FollowStyle = v

		end,
	}).Link
		:AddHelper({
			Text = "Dodge = strafe on threat | Static = fixed behind | Orbit = circle around enemy | Strafe = constant side-step",
		})
	BRSec:AddSlider({
		Name = "Offset Distance",
		Min = 5,
		Max = 50,
		Default = F.OffsetDist,
		Round = 0,
		Flag = "BossRushOffsetDist",
		Callback = function(v)
			F.OffsetDist = v
		end,
	})
	BRSec:AddSlider({
		Name = "Movement Speed",
		Min = 20,
		Max = 250,
		Default = F.BossRushTweenSpeed,
		Round = 0,
		Flag = "BossRushTweenSpeed",
		Callback = function(v)
			F.BossRushTweenSpeed = v
		end,
	})
	task.wait()
	local BSec = BTab:DrawSection({ Name = "Bosses", Position = "left" })
	S.BossToggle = BSec:AddToggle({
		Name = "Enable Boss Killing",
		Flag = "BossEnabled",
		Default = F.BossEnabled,
		Guard = function(v)
			if v and (F.AutoDungeon or F.AutoBossRush or F.AutoInfiniteTower) then
				S.Notify.new({ Title = "Boss Farm", Content = "Disable Gamemodes first", Duration = 3, Icon = S.ICON })
				return false
			end
			if v and fn.HasDungeonEnemiesInWorkspace() then
				S.Notify.new({
					Title = "Boss Farm",
					Content = "Can't farm boss while in a dungeon",
					Duration = 3,
					Icon = S.ICON,
				})
				return false
			end
			return true
		end,
		Callback = function(v)
			F.BossEnabled = v
			if not v and S.BossFight then
				fn.ExitBossMode(S.BossTargetName)
			end
		end,
	})
	S.BossKeybind = S.BossToggle.Link:AddKeybind({ Default = "B", Flag = "BossKeybind", Callback = function() end })
	S.BossToggle.Link:AddHelper({ Text = "Timer-based world bosses" })
	BSec:AddToggle({
		Name = "Boss Notifications",
		Flag = "BossNotify",
		Default = F.BossNotify,
		Callback = function(v)
			F.BossNotify = v
		end,
	})
	for _, bDef in ipairs(S.Bosses) do
		BSec:AddToggle({
			Name = bDef.Display .. " (" .. bDef.Island .. ")",
			Flag = "Boss_" .. bDef.Name,
			Default = false,
			Callback = function(v)
				S.BF[bDef.Name] = v
			end,
		})
	end
	local BTimerSec = BTab:DrawSection({ Name = "Boss Timers", Position = "left" })
	S.BossTimerLabels = {}
	for _, bDef in ipairs(S.Bosses) do
		S.BossTimerLabels[bDef.Name] = BTimerSec:AddParagraph({ Title = bDef.Display, Content = "Loading..." })
	end
	task.spawn(function()
		task.wait(1.5)
		fn.ScanAllBossTimers()
		while S.Running do
			fn.ScanAllBossTimers()
			for _, bDef in ipairs(S.Bosses) do
				local label = S.BossTimerLabels[bDef.Name]
				if label then
					pcall(function()
						local info = S.BossTimerCache[bDef.Name]
						local status = ""
						if info and (tick() - (info.t or 0)) < 5 then
							if info.alive then
								status = "ALIVE"
							elseif info.m and info.s then
								local total = info.m * 60 + info.s
								if total == 0 then
									status = "ALIVE"
								elseif total <= 15 then
									status = info.m .. ":" .. string.format("%02d", info.s)
								else
									status = info.m .. ":" .. string.format("%02d", info.s)
								end
							else
								status = "Loading..."
							end
						else
							local dt = S.BossDeathTimes[bDef.Name]
							if dt then
								local remain = math.max(0, 300 - (tick() - dt))
								if remain > 0 then
									local mn = math.floor(remain / 60)
									local sc = math.floor(remain % 60)
									status = mn .. ":" .. string.format("%02d", sc)
								else
									status = "Ready!"
								end
							else
								status = "Loading..."
							end
						end
						if label.SetContent then
							label:SetContent(status)
						elseif label.Set then
							label:Set(status)
						elseif label.SetText then
							label:SetText(status)
						end
					end)
				end
			end
			task.wait(1)
		end
	end)
	local BPitySec = BTab:DrawSection({ Name = "Boss Pity", Position = "right" })
	S.PityLabel = BPitySec:AddParagraph({ Title = "Pity", Content = "0 / 25" })
	do
		local buildOptions = {}
		for _, b in ipairs(S.Bosses) do
			table.insert(buildOptions, b.Display)
		end
		for _, b in ipairs(S.SummonBosses) do
			table.insert(buildOptions, b.Display)
		end
		table.sort(buildOptions)
		local useOptions = {}
		for _, b in ipairs(S.SummonBosses) do
			table.insert(useOptions, b.Display)
		end
		for _, b in ipairs(S.Bosses) do
			table.insert(useOptions, b.Display)
		end
		table.sort(useOptions)
		local displayToName = {}
		for _, b in ipairs(S.Bosses) do
			displayToName[b.Display] = b.Name
		end
		for _, b in ipairs(S.SummonBosses) do
			displayToName[b.Display] = b.Name
		end
		local hasDiff = {}
		for _, b in ipairs(S.SummonBosses) do
			if b.Difficulties then
				hasDiff[b.Name] = true
			end
		end
		BPitySec:AddDropdown({
			Name = "Build Pity On",
			Flag = "PityBuildBosses",
			Values = buildOptions,
			Default = {},
			Multi = true,
			Callback = function(v)
				S.PityBuildBosses = {}
				for display, enabled in pairs(v) do
					local name = displayToName[display]
					if name and enabled then
						S.PityBuildBosses[name] = true
					end
				end
			end,
		})
		BPitySec:AddDropdown({
			Name = "Use Pity On",
			Flag = "PityUseBoss",
			Values = useOptions,
			Callback = function(v)
				S.PityUseBoss = displayToName[v] or nil
			end,
		})
		BPitySec:AddDropdown({
			Name = "Pity Difficulty",
			Flag = "PityUseDiff",
			Values = { "Normal", "Medium", "Hard", "Extreme" },
			Default = F.PityUseDiff,
			Callback = function(v)
				F.PityUseDiff = v
			end,
		})
		S.PityToggle = BPitySec:AddToggle({
			Name = "Autofarm Boss Pity",
			Flag = "PityBossEnabled",
			Default = F.PityBossEnabled,
			Guard = function(v)
				if v and (F.AutoDungeon or F.AutoBossRush or F.AutoInfiniteTower) then
					S.Notify.new({ Title = "Boss Pity", Content = "Disable Gamemodes first", Duration = 3, Icon = S.ICON })
					return false
				end
				if v and not S.PityUseBoss then
					S.Notify.new({ Title = "Boss Pity", Content = "Select a boss to use pity on", Duration = 3, Icon = S.ICON })
					return false
				end
				if v and not next(S.PityBuildBosses) then
					S.Notify.new({ Title = "Boss Pity", Content = "Select bosses to build pity on", Duration = 3, Icon = S.ICON })
					return false
				end
				return true
			end,
			Callback = function(v)
				F.PityBossEnabled = v
				if v then
					S._pityActiveBoss = nil
				else
					if S.SummonBossFight then
						fn.ExitSummonBossMode()
					end
					if S.BossFight then
						fn.ExitBossMode(S.BossTargetName)
					end
					S._pityActiveBoss = nil
					S._pityCached = 0
				end
			end,
		})
		S.PityToggle.Link:AddHelper({ Text = "Build pity on easy bosses, spend on the one you want" })
	end
	task.spawn(function()
		while S.Running do
			if S.PityLabel then
				pcall(function()
					local c, m = fn.GetCurrentPity()
					local txt = c .. " / " .. m
					if fn.IsPityReady() then
						txt = txt .. " — READY!"
					end
					if S.PityLabel.SetContent then
						S.PityLabel:SetContent(txt)
					elseif S.PityLabel.Set then
						S.PityLabel:Set(txt)
					elseif S.PityLabel.SetText then
						S.PityLabel:SetText(txt)
					end
				end)
			end
			task.wait(1)
		end
	end)
	local BSummonSec = BTab:DrawSection({ Name = "Summon", Position = "right" })
	local BSummonDiffSec = BTab:DrawSection({ Name = "Summon (Difficulty)", Position = "right" })
	local SummonDiffKeys = {
		AtomicBoss = "AtomicDiff",
		GilgameshBoss = "GilgameshDiff",
		BlessedMaidenBoss = "BlessedMaidenDiff",
		SaberAlterBoss = "SaberAlterDiff",
		RimuruBoss = "RimuruDiff",
		AnosBoss = "AnosDiff",
		StrongestTodayBoss = "StrongestTodayDiff",
		StrongestHistoryBoss = "StrongestHistoryDiff",
		TrueAizenBoss = "TrueAizenDiff",
	}
	for _, bDef in ipairs(S.SummonBosses) do
		local bossName = bDef.Name
		local bossDisplay = bDef.Display
		local flagName = "SummonBoss_" .. bossName
		local islLabel = bDef.Island and " (" .. fn.PortalDisplayName(bDef.Island) .. ")" or ""
		local targetSec = bDef.Difficulties and BSummonDiffSec or BSummonSec
		local tgl = targetSec:AddToggle({
			Name = bossDisplay .. islLabel,
			Flag = flagName,
			Default = false,
			Callback = function(v)
				if v and (F.AutoDungeon or F.AutoBossRush or fn.HasDungeonEnemiesInWorkspace()) then
					local capName = bossName
					task.defer(function()
						if S.BSFToggle[capName] then
							pcall(function()
								S.BSFToggle[capName]:SetValue(false)
							end)
						end
					end)
					return
				end
				if v then
					for _, ob in ipairs(S.SummonBosses) do
						if ob.Name ~= bossName then
							S.BSF[ob.Name] = false
							if S.BSFToggle[ob.Name] then
								pcall(function()
									S.BSFToggle[ob.Name]:SetValue(false)
								end)
							end
						end
					end
					fn.ExitSummonBossMode()
					task.wait(0.3)
					S.BSF[bossName] = true
					S.SummonBossFailCount[bossName] = nil
				else
					S.BSF[bossName] = false
					fn.DisableAutoSpawn(bossName)
					S.SummonBossCommitted[bossName] = nil
					S.SummonBossFireTime[bossName] = nil
					if S.SummonBossTarget == bossName then
						S.SummonBossTarget = nil
						fn.ClearTgt()
					end
					if not fn.HasAnySummonBossEnabled() then
						fn.ExitSummonBossMode()
					end
				end
			end,
		})
		S.BSFToggle[bossName] = tgl
		if bDef.Difficulties then
			local diffFlag = "SummonDiff_" .. bossName
			local diffKey = SummonDiffKeys[bossName]
			BSummonDiffSec:AddDropdown({
				Name = bossDisplay .. " Difficulty",
				Default = "Normal",
				Values = bDef.Difficulties,
				Flag = diffFlag,
				Callback = function(v)
					if diffKey then
						F[diffKey] = v
					end
				end,
			})
		end
	end
	task.wait()
	local SSec = STab:DrawSection({ Name = "Auto Abilities", Position = "left" })
	S.SkillToggles.SkillZ = SSec:AddToggle({
		Name = "Skill Z",
		Flag = "SkillZ",
		Default = F.SkillZ,
		Callback = function(v)
			F.SkillZ = v
		end,
	})
	S.SkillToggles.SkillZ.Link:AddHelper({ Text = "Auto use" })
	S.SkillToggles.SkillX = SSec:AddToggle({
		Name = "Skill X",
		Flag = "SkillX",
		Default = F.SkillX,
		Callback = function(v)
			F.SkillX = v
		end,
	})
	S.SkillToggles.SkillX.Link:AddHelper({ Text = "Auto use" })
	S.SkillToggles.SkillC = SSec:AddToggle({
		Name = "Skill C",
		Flag = "SkillC",
		Default = F.SkillC,
		Callback = function(v)
			F.SkillC = v
		end,
	})
	S.SkillToggles.SkillC.Link:AddHelper({ Text = "Auto use" })
	S.SkillToggles.SkillV = SSec:AddToggle({
		Name = "Skill V",
		Flag = "SkillV",
		Default = F.SkillV,
		Callback = function(v)
			F.SkillV = v
		end,
	})
	S.SkillToggles.SkillV.Link:AddHelper({ Text = "Auto use" })
	S.SkillToggles.SkillF = SSec:AddToggle({
		Name = "Skill F (Nuke)",
		Flag = "SkillF",
		Default = F.SkillF,
		Callback = function(v)
			F.SkillF = v
		end,
	})
	S.SkillToggles.SkillF.Link:AddHelper({ Text = "Auto use — Nuke ability" })
	SSec:AddDropdown({
		Name = "Skill Mode",
		Default = F.SkillMode,
		Values = { "Normal", "Instant" },
		Flag = "SkillMode",
		Callback = function(v)
			F.SkillMode = v
		end,
	}).Link
		:AddHelper({ Text = "Normal = reads game cooldown UI | Instant = fixed timer (below)" })
	SSec:AddSlider({
		Name = "Skill Cooldown (Instant)",
		Min = 0.3,
		Max = 10,
		Default = F.SkillCooldown,
		Round = 1,
		Flag = "SkillCooldown",
		Callback = function(v)
			F.SkillCooldown = v
		end,
	})
	local HakiSec = STab:DrawSection({ Name = "Auto Haki", Position = "right" })
	local _hakiTypes = {
		{ Name = "Arm Haki", Setting = "AutoArmHaki", Flag = "AutoArmHaki" },
		{ Name = "Obs. Haki", Setting = "AutoObsHaki", Flag = "AutoObsHaki" },
		{ Name = "Conqueror Haki", Setting = "AutoConqHaki", Flag = "AutoConqHaki" },
	}
	for _, haki in ipairs(_hakiTypes) do
		HakiSec:AddToggle({
			Name = haki.Name,
			Flag = haki.Flag,
			Default = F[haki.Flag] or false,
			Callback = function(v)
				F[haki.Flag] = v
				pcall(function()
					fn.WalkPathWait(RS, 3, unpack(R.Settings)):FireServer(haki.Setting, v)
				end)
			end,
		})
	end
	task.wait()
	local STSec = SkillTreeTab:DrawSection({ Name = "Auto Upgrade", Position = "left" })
	local _stPerks = {
		{ Name = "Damage", Key = "Damage", Flag = "SkillTreeDamage", Desc = "Increases base damage output" },
		{ Name = "HP", Key = "HP", Flag = "SkillTreeHP", Desc = "Increases max health points" },
		{ Name = "Crit Chance", Key = "CritCh", Flag = "SkillTreeCritCh", Desc = "Increases critical hit chance" },
		{
			Name = "Crit Damage",
			Key = "CritDmg",
			Flag = "SkillTreeCritDmg",
			Desc = "Increases critical hit multiplier",
		},
		{ Name = "Luck", Key = "Luck", Flag = "SkillTreeLuck", Desc = "Increases item drop rates" },
	}
	STSec:AddToggle({
		Name = "Auto Upgrade Perks",
		Flag = "AutoSkillTree",
		Default = F.AutoSkillTree,
		Callback = function(v)
			F.AutoSkillTree = v
		end,
	}).Link
		:AddHelper({ Text = "Automatically upgrades enabled perks (5 levels each)" })
	STSec:AddSlider({
		Name = "Interval (s)",
		Min = 0.5,
		Max = 2,
		Default = F.SkillTreeInterval,
		Round = 1,
		Flag = "SkillTreeInterval",
		Callback = function(v)
			F.SkillTreeInterval = v
		end,
	})
	local _stPerkLabels = {}
	for _, perk in ipairs(_stPerks) do
		STSec:AddToggle({
			Name = perk.Name,
			Flag = perk.Flag,
			Default = F[perk.Flag],
			Callback = function(v)
				F[perk.Flag] = v
			end,
		}).Link
			:AddHelper({ Text = perk.Desc })
		_stPerkLabels[perk.Key] = STSec:AddParagraph({ Title = "", Content = "...", Center = true })
	end
	local _stReady = false
	local _stResetAndRebuild = nil
	local STPrioritySec = SkillTreeTab:DrawSection({ Name = "Perk Priority", Position = "right" })
	local _stPriorityOrders = {
		["Balanced"] = { "Damage", "HP", "CritCh", "CritDmg", "Luck" },
		["Damage First"] = { "Damage", "CritDmg", "CritCh", "HP", "Luck" },
		["Survivability"] = { "HP", "Damage", "CritDmg", "CritCh", "Luck" },
		["Crit Build"] = { "CritCh", "CritDmg", "Damage", "HP", "Luck" },
		["Luck First"] = { "Luck", "Damage", "CritCh", "CritDmg", "HP" },
	}
	local _stPriorityNames = {
		Damage = "Damage",
		HP = "HP",
		CritCh = "Crit Chance",
		CritDmg = "Crit Damage",
		Luck = "Luck",
	}
	local _stPriorityLabel = STPrioritySec:AddParagraph({ Title = "Order", Content = "..." })
	local function _updatePriorityLabel()
		local order = _stPriorityOrders[F.SkillTreePriority] or _stPriorityOrders["Balanced"]
		local parts = {}
		for i, key in ipairs(order) do
			table.insert(parts, i .. ") " .. _stPriorityNames[key])
		end
		pcall(function()
			_stPriorityLabel:SetContent(table.concat(parts, "\n"))
		end)
	end
	STPrioritySec:AddDropdown({
		Name = "Priority Mode",
		Default = F.SkillTreePriority,
		Values = { "Balanced", "Damage First", "Survivability", "Crit Build", "Luck First" },
		Flag = "SkillTreePriority",
		Callback = function(v)
			F.SkillTreePriority = v
			pcall(_updatePriorityLabel)
			if F.AutoSkillTree and _stReady and _stResetAndRebuild then
				task.spawn(_stResetAndRebuild, v)
			end
		end,
	}).Link
		:AddHelper({ Text = "Controls which perks get upgraded first when skill points are limited" })
	STPrioritySec:AddParagraph({ Title = "Balanced", Content = "All perks equally" })
	STPrioritySec:AddParagraph({ Title = "Damage First", Content = "Dmg, CritDmg, CritCh, HP, Luck" })
	STPrioritySec:AddParagraph({ Title = "Survivability", Content = "HP, Dmg, CritDmg, CritCh, Luck" })
	STPrioritySec:AddParagraph({ Title = "Crit Build", Content = "CritCh, CritDmg, Dmg, HP, Luck" })
	STPrioritySec:AddParagraph({ Title = "Luck First", Content = "Luck, Dmg, CritCh, CritDmg, HP" })
	_updatePriorityLabel()
	local STInfoSec = SkillTreeTab:DrawSection({ Name = "Quick Actions", Position = "right" })
	local _stRemote = nil
	pcall(function()
		_stRemote = RS:WaitForChild("RemoteEvents", 10) and RS.RemoteEvents:WaitForChild("SkillTreeUpgrade", 10)
	end)
	local function _getSTRemote()
		if _stRemote and _stRemote.Parent then
			return _stRemote
		end
		pcall(function()
			_stRemote = RS:WaitForChild("RemoteEvents", 5) and RS.RemoteEvents:WaitForChild("SkillTreeUpgrade", 5)
		end)
		return _stRemote
	end
	local _stDataRF = nil
	task.spawn(function()
		pcall(function()
			_stDataRF = RS:WaitForChild("RemoteEvents", 10)
				and RS:FindFirstChild("RemoteEvents"):FindFirstChild("GetSkillTreeData")
			if not _stDataRF then
				_stDataRF = RS:WaitForChild("GetSkillTreeData", 5)
			end
		end)
	end)
	local _stDetected = {}
	local function _fetchTreeData()
		local data = nil
		if _stDataRF then
			pcall(function()
				data = _stDataRF:InvokeServer()
			end)
		end
		return data
	end
	local function _detectAll()
		local data = _fetchTreeData()
		if data and type(data) == "table" and type(data.Nodes) == "table" then
			for _, perk in ipairs(_stPerks) do
				local lvl = 0
				for i = 5, 1, -1 do
					if data.Nodes[perk.Key .. "_" .. i] == true then
						lvl = i
						break
					end
				end
				_stDetected[perk.Key] = lvl
			end
			return true
		end
		for _, perk in ipairs(_stPerks) do
			_stDetected[perk.Key] = 0
		end
		return false
	end
	_detectAll()
	local _stQueue = {}
	local function _buildQueue()
		_stQueue = {}
		local pending = {}
		for _, perk in ipairs(_stPerks) do
			local cur = _stDetected[perk.Key] or 0
			if cur < 5 then
				table.insert(pending, { Key = perk.Key, Flag = perk.Flag, Current = cur })
			end
		end
		local priOrder = _stPriorityOrders[F.SkillTreePriority] or _stPriorityOrders["Balanced"]
		local priRank = {}
		for i, key in ipairs(priOrder) do
			priRank[key] = i
		end
		table.sort(pending, function(a, b)
			if a.Current ~= b.Current then
				return a.Current < b.Current
			end
			return (priRank[a.Key] or 99) < (priRank[b.Key] or 99)
		end)
		for _, p in ipairs(pending) do
			table.insert(_stQueue, { Key = p.Key, Flag = p.Flag, Level = p.Current + 1 })
		end
	end
	_buildQueue()
	local _stPointsLabel = STSec:AddParagraph({ Title = "Skill Points", Content = "..." })
	local function _updateSTDisplay()
		for _, perk in ipairs(_stPerks) do
			local lvl = _stDetected[perk.Key] or 0
			local dots = {}
			for i = 1, 5 do
				table.insert(dots, i <= lvl and "\226\151\143" or "\226\151\139")
			end
			local status = lvl >= 5 and "MAX" or ("Level " .. lvl .. "/5")
			pcall(function()
				_stPerkLabels[perk.Key]:SetTitle(perk.Name .. "  " .. status)
				_stPerkLabels[perk.Key]:SetContent(table.concat(dots, "  "))
			end)
		end
		pcall(function()
			local data = _fetchTreeData()
			if data and type(data) == "table" and data.SkillPoints then
				_stPointsLabel:SetContent(tostring(data.SkillPoints) .. " available")
			end
		end)
	end
	_updateSTDisplay()
	_stResetAndRebuild = function(modeName)
		pcall(function()
			RS:WaitForChild("RemoteEvents", 5):WaitForChild("SkillTreeReset", 5):FireServer()
		end)
		task.wait(0.5)
		_detectAll()
		_buildQueue()
		_updateSTDisplay()
		S.Notify.new({
			Title = "Skill Tree",
			Content = "Reset & rebuilding with " .. tostring(modeName),
			Duration = 3,
			Icon = S.ICON,
		})
	end
	_stReady = true
	_glowButton(STSec, "Scan Levels", function()
		_detectAll()
		_buildQueue()
		_updateSTDisplay()
		S.Notify.new({ Title = "Skill Tree", Content = "Levels updated", Duration = 2, Icon = S.ICON })
	end)
	_glowButton(STInfoSec, "Upgrade All Now", function()
		local r = _getSTRemote()
		if not r then
			return
		end
		_detectAll()
		for lvl = 1, 5 do
			for _, perk in ipairs(_stPerks) do
				if lvl > (_stDetected[perk.Key] or 0) then
					pcall(function()
						r:FireServer(perk.Key .. "_" .. lvl)
					end)
					task.wait(0.3)
				end
			end
		end
		task.wait(0.5)
		_detectAll()
		_buildQueue()
		S.Notify.new({ Title = "Skill Tree", Content = "All perks upgraded", Duration = 3, Icon = S.ICON })
	end)
	_glowButton(STInfoSec, "Reset Skill Tree", function()
		pcall(function()
			RS:WaitForChild("RemoteEvents", 5):WaitForChild("SkillTreeReset", 5):FireServer()
		end)
		task.wait(0.5)
		_detectAll()
		_buildQueue()
		_updateSTDisplay()
		S.Notify.new({ Title = "Skill Tree", Content = "Skill tree reset", Duration = 3, Icon = S.ICON })
	end)
	_glowButton(STInfoSec, "Teleport to Skill Tree", function()
		if F.AutoFarmLevel or F.BossEnabled or S.BossFight or S.SummonBossFight then
			S.Notify.new({ Title = "Skill Tree", Content = "Disable farming/bosses first", Duration = 3, Icon = S.ICON })
			return
		end
		S.Notify.new({ Title = "Skill Tree", Content = "Teleporting to Slime Island...", Duration = 2, Icon = S.ICON })
		fn.ForceTP("Slime")
		task.wait(0.8)
		pcall(function()
			local npc = workspace:FindFirstChild("ServiceNPCs") and workspace.ServiceNPCs:FindFirstChild("SkillTreeNPC")
			if npc then
				local hrp = npc:FindFirstChild("HumanoidRootPart")
				local myHrp = fn.PlayerHRP()
				if hrp and myHrp then
					myHrp.CFrame = hrp.CFrame * CFrame.new(0, 0, -5)
					S.Notify.new({ Title = "Skill Tree", Content = "Arrived at NPC", Duration = 2, Icon = S.ICON })
				end
			else
				S.Notify.new({ Title = "Skill Tree", Content = "NPC not found", Duration = 3, Icon = S.ICON })
			end
		end)
	end)
	STInfoSec:AddParagraph({ Title = "Information", Content = "Each perk has 5 upgrade levels." })
	STInfoSec:AddParagraph({ Title = "Priority", Content = "Cheapest upgrades are bought first." })
	STInfoSec:AddParagraph({ Title = "Detection", Content = "Rescans your levels after each cycle." })
	task.spawn(function()
		while S.Running do
			task.wait(F.SkillTreeInterval or 0.5)
			if F.AutoSkillTree and not _dead then
				local r = _getSTRemote()
				if r then
					_detectAll()
					_buildQueue()
					for _, entry in ipairs(_stQueue) do
						if F[entry.Flag] then
							pcall(function()
								r:FireServer(entry.Key .. "_" .. entry.Level)
							end)
							task.wait(0.2)
						end
					end
					_detectAll()
					_buildQueue()
					_updateSTDisplay()
				end
			end
		end
	end)
	task.wait()
	local SmartSec = StatTab:DrawSection({ Name = "Smart Stats", Position = "left" })
	local SmartToggle, ManualToggle
	SmartToggle = SmartSec:AddToggle({
		Name = "Enable Smart Stats",
		Flag = "SmartStats",
		Default = F.SmartStats,
		Callback = function(v)
			F.SmartStats = v
			S.LastStatAllocate = 0
			S._smartStatAccum = {}
			if v and F.AutoStats then
				F.AutoStats = false
				if ManualToggle then
					pcall(function()
						ManualToggle:SetValue(false)
					end)
				end
			end
		end,
	})
	SmartToggle.Link:AddHelper({ Text = "Auto-allocate based on build type" })
	SmartSec:AddDropdown({
		Name = "Build",
		Default = F.SmartStatBuild,
		Values = { "Sword Build", "Melee Build", "Power Build", "Manual Build" },
		Flag = "SmartStatBuild",
		Callback = function(v)
			local changed = F.SmartStatBuild ~= v
			F.SmartStatBuild = v
			S._smartStatAccum = {}
			if changed and F.SmartStats then
				task.spawn(function()
					pcall(function()
						fn.WalkPathWait(RS, 3, "RemoteEvents", "ResetStats"):FireServer()
					end)
					S.Notify.new({
						Title = "Build Changed",
						Content = "Stats reset — now building " .. v,
						Duration = 3,
						Icon = S.ICON,
					})
				end)
			end
		end,
	})
	local _batchSlider, _batchBox
	local _batchSyncing = false
	_batchBox = SmartSec:AddTextBox({
		Name = "Exact Amount",
		Default = tostring(F.SmartStatBatch),
		Placeholder = "1-99999",
		Numeric = true,
		Callback = function(v)
			local n = tonumber(v)
			if not n or n < 1 then
				return
			end
			F.SmartStatBatch = n
			if not _batchSyncing and _batchSlider then
				_batchSyncing = true
				pcall(function()
					_batchSlider:SetValue(math.clamp(n, 1, 5000))
				end)
				_batchSyncing = false
			end
		end,
	})
	_batchSlider = SmartSec:AddSlider({
		Name = "Points Per Tick",
		Min = 1,
		Max = 5000,
		Default = F.SmartStatBatch,
		Round = 0,
		Flag = "SmartStatBatch",
		Callback = function(v)
			F.SmartStatBatch = v
			if not _batchSyncing and _batchBox then
				_batchSyncing = true
				pcall(function()
					_batchBox:SetValue(tostring(v))
				end)
				_batchSyncing = false
			end
		end,
	})
	SmartSec:AddSlider({
		Name = "Interval (s)",
		Min = 0.5,
		Max = 2,
		Default = F.SmartStatInterval,
		Round = 1,
		Flag = "SmartStatInterval",
		Callback = function(v)
			F.SmartStatInterval = v
		end,
	})
	SmartSec:AddParagraph({ Title = "Melee Build", Content = "50% Melee | 30% Defense | 20% Sword" })
	SmartSec:AddParagraph({ Title = "Sword Build", Content = "50% Sword | 30% Defense | 20% Melee" })
	SmartSec:AddParagraph({ Title = "Power Build", Content = "45% Power | 30% Defense | 25% Sword" })
	_glowButton(SmartSec, "Reset Stats", function()
		pcall(function()
			fn.WalkPathWait(RS, 3, "RemoteEvents", "ResetStats"):FireServer()
		end)
		S._smartStatAccum = {}
		S.Notify.new({ Title = "Stats Reset", Content = "All stat points have been reset", Duration = 3, Icon = S.ICON })
	end)
	local CustomSec = StatTab:DrawSection({ Name = "Custom Ratios", Position = "left" })
	CustomSec:AddParagraph({ Title = "Manual Build", Content = "Set your own stat ratios." })
	local _customStats = {
		{ name = "Melee", flag = "CustomMelee" },
		{ name = "Defense", flag = "CustomDefense" },
		{ name = "Sword", flag = "CustomSword" },
		{ name = "Power", flag = "CustomPower" },
	}
	local _customSliders = {}
	local _customAdjusting = false
	for i, cs in ipairs(_customStats) do
		_customSliders[i] = CustomSec:AddSlider({
			Name = cs.name .. " %",
			Min = 0,
			Max = 100,
			Default = tonumber(F[cs.flag]) or 0,
			Round = 0,
			Flag = cs.flag,
			Callback = function(v)
				F[cs.flag] = v
				S._smartStatAccum = {}
				if _customAdjusting then
					return
				end
				_customAdjusting = true
				local remainder = 100 - v
				local others = {}
				for j, _ in ipairs(_customStats) do
					if j ~= i then
						table.insert(others, j)
					end
				end
				local otherTotal = 0
				for _, j in ipairs(others) do
					otherTotal = otherTotal + (tonumber(F[_customStats[j].flag]) or 0)
				end
				for _, j in ipairs(others) do
					local ov = tonumber(F[_customStats[j].flag]) or 0
					local nv
					if otherTotal > 0 then
						nv = math.floor(remainder * ov / otherTotal)
					else
						nv = math.floor(remainder / #others)
					end
					nv = math.clamp(nv, 0, 100)
					F[_customStats[j].flag] = nv
					_customSliders[j]:SetValue(nv)
				end
				_customAdjusting = false
			end,
		})
	end
	_glowButton(CustomSec, "Reset Ratios", function()
		_customAdjusting = true
		for j, cs in ipairs(_customStats) do
			F[cs.flag] = 0
			_customSliders[j]:SetValue(0)
		end
		_customAdjusting = false
		S._smartStatAccum = {}
		S.Notify.new({ Title = "Custom Ratios", Content = "All ratios reset to 0%", Duration = 3, Icon = S.ICON })
	end)

	local ManualSec = StatTab:DrawSection({ Name = "Manual Allocate", Position = "right" })
	local _statNames = { "Melee", "Defense", "Sword", "Power" }
	local _statFlags = { Melee = "StatMelee", Defense = "StatDefense", Sword = "StatSword", Power = "StatPower" }
	for _, stat in ipairs(_statNames) do
		local flag = _statFlags[stat]
		local _mSlider, _mBox
		local _mSyncing = false
		_mBox = ManualSec:AddTextBox({
			Name = stat .. " (exact)",
			Default = tostring(F[flag]),
			Placeholder = "0",
			Numeric = true,
			Callback = function(v)
				local n = tonumber(v) or 0
				F[flag] = n
				if not _mSyncing and _mSlider then
					_mSyncing = true
					pcall(function()
						_mSlider:SetValue(math.clamp(n, 0, 5000))
					end)
					_mSyncing = false
				end
			end,
		})
		_mSlider = ManualSec:AddSlider({
			Name = stat,
			Min = 0,
			Max = 5000,
			Default = tonumber(F[flag]) or 0,
			Round = 0,
			Flag = flag,
			Callback = function(v)
				F[flag] = v
				if not _mSyncing and _mBox then
					_mSyncing = true
					pcall(function()
						_mBox:SetValue(tostring(v))
					end)
					_mSyncing = false
				end
			end,
		})
		_glowButton(ManualSec, "Allocate " .. stat, function()
			local pts = tonumber(F[flag]) or 0
			if pts <= 0 then
				S.Notify.new({ Title = stat, Content = "Set a value first", Duration = 2, Icon = S.ICON })
				return
			end
			local available = fn.GetStatPoints()
			if available <= 0 then
				S.Notify.new({ Title = "No Stat Points", Content = "0 points available", Duration = 2, Icon = S.ICON })
				return
			end
			local amount = math.min(pts, available)
			pcall(function()
				fn.WalkPathWait(RS, 3, unpack(R.AllocateStat)):FireServer(stat, amount)
			end)
			S.Notify.new({ Title = stat, Content = "Allocated " .. amount .. " points", Duration = 3, Icon = S.ICON })
		end)
	end

	local QuickMaxSec = StatTab:DrawSection({ Name = "Quick Max", Position = "right" })
	for _, stat in ipairs(_statNames) do
		_glowButton(QuickMaxSec, "Max " .. stat, function()
			local pts = fn.GetStatPoints()
			if pts <= 0 then
				S.Notify.new({
					Title = "No Stat Points",
					Content = "You have 0 stat points available",
					Duration = 3,
					Icon = S.ICON,
				})
				return
			end
			pcall(function()
				fn.WalkPathWait(RS, 3, unpack(R.AllocateStat)):FireServer(stat, pts)
			end)
			S.Notify.new({
				Title = "Max " .. stat,
				Content = "Dumped " .. pts .. " points into " .. stat,
				Duration = 3,
				Icon = S.ICON,
			})
		end)
	end
	_glowButton(QuickMaxSec, "View Points", function()
		local pts = fn.GetStatPoints()
		S.Notify.new({ Title = "Stat Points", Content = pts .. " available", Duration = 3, Icon = S.ICON })
	end)

	local _shopStats = { "Damage", "HP", "CritChance", "CritDamage", "Luck" }
	local _shopDisplay =
		{ Damage = "Damage", HP = "HP", CritChance = "Crit Chance", CritDamage = "Crit Damage", Luck = "Luck" }
	local function _getBRLvl(stat) return F["BRLvl_" .. stat] or 0 end
	local function _getITLvl(stat) return F["ITLvl_" .. stat] or 0 end
	local function _setBRLvl(stat, v)
		v = math.clamp(v, 0, 5)
		if v > _getBRLvl(stat) then F["BRLvl_" .. stat] = v end
	end
	local function _setITLvl(stat, v)
		v = math.clamp(v, 0, 5)
		if v > _getITLvl(stat) then F["ITLvl_" .. stat] = v end
	end
	local _brShopLabels, _itShopLabels = {}, {}
	local function _updateBRShopDisplay()
		for _, stat in ipairs(_shopStats) do
			local lvl = _getBRLvl(stat)
			local dots = {}
			for i = 1, 5 do
				dots[i] = i <= lvl and "\226\151\143" or "\226\151\139"
			end
			local status = lvl >= 5 and "MAX" or ("Level " .. lvl .. "/5")
			pcall(function()
				_brShopLabels[stat]:SetTitle(_shopDisplay[stat] .. " " .. status)
				_brShopLabels[stat]:SetContent(table.concat(dots, "  "))
			end)
		end
	end
	local function _updateITShopDisplay()
		for _, stat in ipairs(_shopStats) do
			local lvl = _getITLvl(stat)
			local dots = {}
			for i = 1, 5 do
				dots[i] = i <= lvl and "\226\151\143" or "\226\151\139"
			end
			local status = lvl >= 5 and "MAX" or ("Level " .. lvl .. "/5")
			pcall(function()
				_itShopLabels[stat]:SetTitle(_shopDisplay[stat] .. " " .. status)
				_itShopLabels[stat]:SetContent(table.concat(dots, "  "))
			end)
		end
	end
	fn.Conn(LP.AttributeChanged:Connect(function(attr)
		if type(attr) == "string" then
			if attr:sub(1, 9) == "BossRush_" then
				local statName = attr:sub(10)
				local val = LP:GetAttribute(attr)
				if type(val) == "number" and val >= 1 and val <= 5 and val == math.floor(val) then
					_setBRLvl(statName, val)
					_updateBRShopDisplay()
				end
			elseif attr:sub(1, 14) == "InfiniteTower_" then
				local statName = attr:sub(15)
				local val = LP:GetAttribute(attr)
				if type(val) == "number" and val >= 1 and val <= 5 and val == math.floor(val) then
					_setITLvl(statName, val)
					_updateITShopDisplay()
				end
			end
		end
	end))
	pcall(function()
		local _brUIEvt = RS:WaitForChild("Remotes", 5):FindFirstChild("OpenBossRushUI")
		if _brUIEvt then
			fn.Conn(_brUIEvt.OnClientEvent:Connect(function(data)
				if type(data) == "table" then
					for _, stat in ipairs(_shopStats) do
						local key = stat
						local v = data[key] or data[key:lower()] or data["level_" .. key] or data["Level_" .. key]
						if type(v) == "number" and v >= 0 and v <= 5 then
							_setBRLvl(stat, v)
						end
					end
					if type(data.levels) == "table" then
						for _, stat in ipairs(_shopStats) do
							local v = data.levels[stat] or data.levels[stat:lower()]
							if type(v) == "number" and v >= 0 and v <= 5 then
								_setBRLvl(stat, v)
							end
						end
					end
					if type(data.upgrades) == "table" then
						for _, stat in ipairs(_shopStats) do
							local v = data.upgrades[stat] or data.upgrades[stat:lower()]
							if type(v) == "number" and v >= 0 and v <= 5 then
								_setBRLvl(stat, v)
							end
						end
					end
					_updateBRShopDisplay()
				end
			end))
		end
		local _itUIEvt = RS:WaitForChild("Remotes", 5):FindFirstChild("OpenInfiniteTowerUI")
		if _itUIEvt then
			fn.Conn(_itUIEvt.OnClientEvent:Connect(function(data)
				if type(data) == "table" then
					for _, stat in ipairs(_shopStats) do
						local key = stat
						local v = data[key] or data[key:lower()] or data["level_" .. key] or data["Level_" .. key]
						if type(v) == "number" and v >= 0 and v <= 5 then
							_setITLvl(stat, v)
						end
					end
					if type(data.levels) == "table" then
						for _, stat in ipairs(_shopStats) do
							local v = data.levels[stat] or data.levels[stat:lower()]
							if type(v) == "number" and v >= 0 and v <= 5 then
								_setITLvl(stat, v)
							end
						end
					end
					if type(data.upgrades) == "table" then
						for _, stat in ipairs(_shopStats) do
							local v = data.upgrades[stat] or data.upgrades[stat:lower()]
							if type(v) == "number" and v >= 0 and v <= 5 then
								_setITLvl(stat, v)
							end
						end
					end
					_updateITShopDisplay()
				end
			end))
		end
	end)
	local BRShopSec = ShopTab:DrawSection({ Name = "Boss Rush Shop", Position = "left" })
	BRShopSec:AddToggle({
		Name = "Auto Buy Upgrades",
		Flag = "AutoBRShop",
		Default = F.AutoBRShop,
		Callback = function(v)
			F.AutoBRShop = v
		end,
	}).Link
		:AddHelper({ Text = "Buys cheapest Boss Rush upgrade each cycle" })
	for _, stat in ipairs(_shopStats) do
		local flag = "BRShop_" .. stat
		BRShopSec:AddToggle({
			Name = _shopDisplay[stat],
			Flag = flag,
			Default = F[flag],
			Callback = function(v)
				F[flag] = v
			end,
		})
		_brShopLabels[stat] = BRShopSec:AddParagraph({ Title = "", Content = "...", Center = true })
	end
	_updateBRShopDisplay()
	task.spawn(function()
		local brRemote = nil
		pcall(function()
			brRemote = RS:WaitForChild("Remotes", 10):WaitForChild("RequestBossRushUpgrade", 5)
		end)
		local _brCalibrated = false
		local function _calibrateBR()
			if _brCalibrated then return end
			_brCalibrated = true
			for _, stat in ipairs(_shopStats) do
				local val = LP:GetAttribute("BossRush_" .. stat)
				if type(val) == "number" and val >= 1 and val <= 5 and val == math.floor(val) then
					_setBRLvl(stat, val)
				end
			end
			_updateBRShopDisplay()
		end
		while S.Running do
			task.wait(1)
			if F.AutoBRShop and not _dead and brRemote then
				local best, bestLvl = nil, math.huge
				for _, stat in ipairs(_shopStats) do
					if F["BRShop_" .. stat] and _getBRLvl(stat) < 5 then
						local lvl = _getBRLvl(stat)
						if lvl < bestLvl then
							bestLvl = lvl
							best = stat
						end
					end
				end
				if best then
					local before = LP:GetAttribute("BossRush_" .. best)
					local ok, res = pcall(function() return brRemote:InvokeServer(best) end)
					if ok and res == true then
						_calibrateBR()
						task.wait(0.2)
						local after = LP:GetAttribute("BossRush_" .. best)
						if type(after) == "number" and after ~= before and after >= 1 and after <= 5 and after == math.floor(after) then
							_setBRLvl(best, after)
							_updateBRShopDisplay()
						end
					end
				end
			end
		end
	end)
	local ITShopSec = ShopTab:DrawSection({ Name = "Tower Shop", Position = "right" })
	ITShopSec:AddToggle({
		Name = "Auto Buy Upgrades",
		Flag = "AutoTowerShop",
		Default = F.AutoTowerShop,
		Callback = function(v)
			F.AutoTowerShop = v
		end,
	}).Link
		:AddHelper({ Text = "Buys cheapest Infinite Tower upgrade each cycle" })
	for _, stat in ipairs(_shopStats) do
		local flag = "ITShop_" .. stat
		ITShopSec:AddToggle({
			Name = _shopDisplay[stat],
			Flag = flag,
			Default = F[flag],
			Callback = function(v)
				F[flag] = v
			end,
		})
		_itShopLabels[stat] = ITShopSec:AddParagraph({ Title = "", Content = "...", Center = true })
	end
	_updateITShopDisplay()
	task.spawn(function()
		local itRemote = nil
		pcall(function()
			itRemote = RS:WaitForChild("Remotes", 10):WaitForChild("RequestInfiniteTowerUpgrade", 5)
		end)
		local _itCalibrated = false
		local function _calibrateIT()
			if _itCalibrated then return end
			_itCalibrated = true
			for _, stat in ipairs(_shopStats) do
				local val = LP:GetAttribute("InfiniteTower_" .. stat)
				if type(val) == "number" and val >= 1 and val <= 5 and val == math.floor(val) then
					_setITLvl(stat, val)
				end
			end
			_updateITShopDisplay()
		end
		while S.Running do
			task.wait(1)
			if F.AutoTowerShop and not _dead and itRemote then
				local best, bestLvl = nil, math.huge
				for _, stat in ipairs(_shopStats) do
					if F["ITShop_" .. stat] and _getITLvl(stat) < 5 then
						local lvl = _getITLvl(stat)
						if lvl < bestLvl then
							bestLvl = lvl
							best = stat
						end
					end
				end
				if best then
					local before = LP:GetAttribute("InfiniteTower_" .. best)
					local ok, res = pcall(function() return itRemote:InvokeServer(best) end)
					if ok and res == true then
						_calibrateIT()
						task.wait(0.2)
						local after = LP:GetAttribute("InfiniteTower_" .. best)
						if type(after) == "number" and after ~= before and after >= 1 and after <= 5 and after == math.floor(after) then
							_setITLvl(best, after)
							_updateITShopDisplay()
						end
					end
				end
			end
		end
	end)
	local ShopMerchSec = ShopTab:DrawSection({ Name = "Auto Merchant", Position = "left" })
	ShopMerchSec:AddToggle({
		Name = "Enable Auto Merchant",
		Flag = "AutoMerchant",
		Default = F.AutoMerchant,
		Callback = function(v)
			F.AutoMerchant = v
			if v then
				S.LastMerchant = 0
			end
		end,
	}).Link
		:AddHelper({ Text = "Buys all selected items in one go; 30 min restock" })
	ShopMerchSec:AddToggle({
		Name = "Merchant Notification",
		Flag = "MerchNotify",
		Default = F.MerchNotify,
		Callback = function(v)
			F.MerchNotify = v
		end,
	}).Link
		:AddHelper({ Text = "Shows notification when items are purchased" })
	for _, item in ipairs(S.MerchantItems) do
		ShopMerchSec:AddToggle({
			Name = item,
			Flag = "Merchant_" .. item:gsub(" ", "_"),
			Default = false,
			Callback = function(v)
				S.FM[item] = v
			end,
		})
	end
	task.wait()
	S.Win:DrawCategory({ Name = "MISCELLANEOUS" })
	local MTab = S.Win:DrawTab({ Name = "Misc.", Icon = "archive", EnableScrolling = true })
	local CSec = MTab:DrawSection({ Name = "Auto Chest", Position = "left" })
	CSec:AddToggle({
		Name = "Auto Open Chests",
		Flag = "AutoChest",
		Default = F.AutoChest,
		Callback = function(v)
			F.AutoChest = v
		end,
	}).Link
		:AddHelper({ Text = "Cycles through enabled chests" })
	for _, chest in ipairs(S.ChestNames) do
		CSec:AddToggle({
			Name = chest,
			Flag = "Chest_" .. chest:gsub(" ", "_"),
			Default = true,
			Callback = function(v)
				S.FC[chest] = v
			end,
		})
	end
	local OptSec = MTab:DrawSection({ Name = "Optimize", Position = "right" })
	local _optSettings =
		{ "DisableVFX", "DisableCutscene", "DisableOtherVFX", "DisableScreenShake", "RemoveTexture", "RemoveShadows" }
	OptSec:AddToggle({
		Name = "Optimize Settings",
		Flag = "Optimize",
		Default = F.Optimize,
		Callback = function(v)
			F.Optimize = v
			pcall(function()
				local r = fn.WalkPathWait(RS, 3, unpack(R.Settings))
				if not r then
					return
				end
				for _, s in ipairs(_optSettings) do
					r:FireServer(s, v)
					task.wait(0.05)
				end
			end)
			S.Notify.new({
				Title = "Optimize",
				Content = v and "All optimizations enabled" or "All optimizations disabled",
				Duration = 3,
				Icon = S.ICON,
			})
		end,
	}).Link
		:AddHelper({ Text = "Disables VFX, cutscenes, shadows, textures, screenshake" })
	local _removeConns = {}
	local function _destroyModels(parentName)
		local found = {}
		for _, obj in ipairs(WS:GetDescendants()) do
			if obj.Name == parentName then
				table.insert(found, obj)
			end
		end
		for _, container in ipairs(found) do
			for _, child in ipairs(container:GetDescendants()) do
				pcall(function()
					if child:IsA("BasePart") then
						child.Transparency = 1
						child.CanCollide = false
						child:Destroy()
					elseif
						child:IsA("Decal")
						or child:IsA("Texture")
						or child:IsA("ParticleEmitter")
						or child:IsA("BillboardGui")
					then
						child:Destroy()
					end
				end)
			end
			for _, child in ipairs(container:GetChildren()) do
				pcall(function()
					child:Destroy()
				end)
			end
			if not _removeConns[parentName .. container:GetFullName()] then
				_removeConns[parentName .. container:GetFullName()] = container.ChildAdded:Connect(function(c)
					if F["Remove" .. parentName] then
						task.wait(0.1)
						pcall(function()
							c:Destroy()
						end)
					end
				end)
			end
		end
	end
	local function _restoreConn(parentName)
		for k, conn in pairs(_removeConns) do
			if string.sub(k, 1, #parentName) == parentName then
				pcall(function()
					conn:Disconnect()
				end)
				_removeConns[k] = nil
			end
		end
	end
	OptSec:AddToggle({
		Name = "Remove Trees",
		Flag = "RemoveTrees",
		Default = F.RemoveTrees,
		Callback = function(v)
			F.RemoveTrees = v
			if v then
				task.spawn(function()
					_destroyModels("Trees")
				end)
			else
				_restoreConn("Trees")
			end
		end,
	})
	OptSec:AddToggle({
		Name = "Remove Crops",
		Flag = "RemoveCrops",
		Default = F.RemoveCrops,
		Callback = function(v)
			F.RemoveCrops = v
			if v then
				task.spawn(function()
					_destroyModels("Crops")
				end)
			else
				_restoreConn("Crops")
			end
		end,
	})
	OptSec:AddToggle({
		Name = "Set Max FPS",
		Flag = "LimitFPS",
		Default = F.LimitFPS,
		Callback = function(v)
			F.LimitFPS = v
			pcall(function()
				if v and setfpscap then
					setfpscap(F.LimitFPSValue)
				elseif setfpscap then
					setfpscap(999)
				end
			end)
		end,
	}).Link
		:AddHelper({ Text = "Caps your FPS to the set value" })
	OptSec:AddSlider({
		Name = "FPS Cap",
		Min = 5,
		Max = 360,
		Default = F.LimitFPSValue,
		Round = 0,
		Flag = "LimitFPSValue",
		Callback = function(v)
			F.LimitFPSValue = v
			if F.LimitFPS then
				pcall(function()
					if setfpscap then
						setfpscap(v)
					end
				end)
			end
		end,
	})
	OptSec:AddToggle({
		Name = "FPS Boost",
		Flag = "FPSBoost",
		Default = F.FPSBoost,
		Callback = function(v)
			F.FPSBoost = v
			if v then
				pcall(function()
					Lighting.GlobalShadows = false
					Lighting.FogEnd = 9e9
					Lighting.Brightness = 1
					for _, eff in ipairs(Lighting:GetChildren()) do
						if
							eff:IsA("PostProcessEffect")
							or eff:IsA("BloomEffect")
							or eff:IsA("BlurEffect")
							or eff:IsA("SunRaysEffect")
						then
							eff.Enabled = false
						end
					end
					task.spawn(function()
						for i, obj in ipairs(workspace:GetDescendants()) do
							if not F.FPSBoost then
								break
							end
							pcall(function()
								if obj:IsA("BasePart") then
									obj.Material = Enum.Material.SmoothPlastic
									obj.CastShadow = false
								elseif obj:IsA("Decal") or obj:IsA("Texture") then
									obj:Destroy()
								elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
									obj.Enabled = false
								end
							end)
							if i % 500 == 0 then
								task.wait()
							end
						end
					end)
				end)
			end
		end,
	}).Link
		:AddHelper({ Text = "Removes shadows, particles, textures, effects" })
	OptSec:AddToggle({
		Name = "FPS Boost (AutoFarm)",
		Flag = "FPSBoostAF",
		Default = F.FPSBoostAF,
		Callback = function(v)
			F.FPSBoostAF = v
			if v then
				task.spawn(function()
					local protectKeywords = { "SpawnPointCrystal_", "Portal_" }
					pcall(function()
						for _, folder in ipairs(workspace:GetChildren()) do
							local name = folder.Name
							local isIsland = name:lower():find("island")
								or name == "HuecoMundo"
								or name == "ShibuyaStation"
							if folder:IsA("Folder") and isIsland then
								for _, obj in ipairs(folder:GetDescendants()) do
									if obj:IsA("Model") or obj:IsA("BasePart") then
										local skip = false
										for _, kw in ipairs(protectKeywords) do
											if obj.Name:find(kw, 1, true) then
												skip = true
												break
											end
										end
										if not skip then
											pcall(function()
												obj:Destroy()
											end)
										end
									end
								end
							end
						end
					end)
				end)
				S.Notify.new({ Title = "FPS Boost", Content = "Island meshes removed", Duration = 3, Icon = S.ICON })
			end
		end,
	}).Link
		:AddHelper({ Text = "Destroys island meshes for max FPS while farming" })
	_glowButton(OptSec, "Redeem All Codes", function()
		local codesModule = nil
		pcall(function()
			codesModule = require(RS:WaitForChild("CodesConfig", 3))
		end)
		if not codesModule or not codesModule.Codes then
			S.Notify.new({ Title = "Codes", Content = "Could not load codes module", Duration = 3, Icon = S.ICON })
			return
		end
		local codeRemote = nil
		pcall(function()
			codeRemote = RS:WaitForChild("RemoteEvents", 3):WaitForChild("CodeRedeem", 3)
		end)
		if not codeRemote then
			S.Notify.new({ Title = "Codes", Content = "Code remote not found", Duration = 3, Icon = S.ICON })
			return
		end
		local playerLevel = fn.GetLevel()
		local count = 0
		for codeName, data in pairs(codesModule.Codes) do
			local levelReq = data.LevelReq or 0
			if playerLevel >= levelReq then
				pcall(function()
					codeRemote:InvokeServer(codeName)
				end)
				count = count + 1
				task.wait(1)
			end
		end
		S.Notify.new({ Title = "Codes", Content = "Attempted " .. count .. " codes", Duration = 3, Icon = S.ICON })
	end)
	Hub.BuildSettings()
	fn.Conn(UserInputService.InputBegan:Connect(function(input, gp)
		if gp or fn.Typing() then
			return
		end
		local key = input.KeyCode
		if key == Enum.KeyCode.Unknown then
			return
		end
		local kn = key.Name
		local function _kbMatch(kb)
			if not kb then
				return false
			end
			local ok, val = pcall(function()
				return kb:GetValue()
			end)
			return ok and val and kn == val
		end
		if _kbMatch(S.FarmKeybind) then
			fn.ToggleFarm()
			return
		end
		if _kbMatch(S.BossKeybind) then
			fn.ToggleBoss()
			return
		end
		if kn == "N" then
			fn.ToggleSummonBoss()
			return
		end
		if _kbMatch(S.FollowKeybind) then
			if S.FollowToggle then
				pcall(function()
					S.FollowToggle:SetValue(not S.FollowToggle:GetValue())
				end)
			end
			return
		end
		if _kbMatch(S.DungeonKeybind) then
			if S.DungeonUnifiedToggle then
				pcall(function()
					S.DungeonUnifiedToggle:SetValue(not S.DungeonUnifiedToggle:GetValue())
				end)
			end
			return
		end
		if _kbMatch(S.TowerKeybind) then
			if S.TowerToggle then
				pcall(function()
					S.TowerToggle:SetValue(not S.TowerToggle:GetValue())
				end)
			end
			return
		end
		if _kbMatch(S.BossRushKeybind) then
			if S.BossRushAutoToggle then
				pcall(function()
					S.BossRushAutoToggle:SetValue(not S.BossRushAutoToggle:GetValue())
				end)
			end
			return
		end
		if _kbMatch(S.KillAuraKeybind) then
			if S.KillAuraToggle then
				pcall(function()
					S.KillAuraToggle:SetValue(not S.KillAuraToggle:GetValue())
				end)
			end
			return
		end
		if _kbMatch(S.AutoTitleKeybind) then
			if S.AutoTitleToggle then
				pcall(function()
					S.AutoTitleToggle:SetValue(not S.AutoTitleToggle:GetValue())
				end)
			end
			return
		end
		if _kbMatch(S.AutoRuneKeybind) then
			if S.AutoRuneToggle then
				pcall(function()
					S.AutoRuneToggle:SetValue(not S.AutoRuneToggle:GetValue())
				end)
			end
			return
		end
		if _kbMatch(S.AutoAuraKeybind) then
			if S.AutoAuraToggle then
				pcall(function()
					S.AutoAuraToggle:SetValue(not S.AutoAuraToggle:GetValue())
				end)
			end
			return
		end
		if _kbMatch(S.AutoAccessoryKeybind) then
			if S.AutoAccessoryToggle then
				pcall(function()
					S.AutoAccessoryToggle:SetValue(not S.AutoAccessoryToggle:GetValue())
				end)
			end
			return
		end
		if _kbMatch(S.AutoCosmeticKeybind) then
			if S.AutoCosmeticToggle then
				pcall(function()
					S.AutoCosmeticToggle:SetValue(not S.AutoCosmeticToggle:GetValue())
				end)
			end
			return
		end
	end))
end
S.Win:Update({ Username = LP.DisplayName, ExpireDate = "Loading..." })
task.spawn(function()
	task.wait(0.2)
	local root = S.Win and S.Win.Root
	if root then
		for _, desc in ipairs(root:GetDescendants()) do
			if desc:IsA("TextLabel") and desc.Text == "Loading..." then
				desc.RichText = true
				break
			end
		end
	end
end)
task.delay(1.5, function()
	local uid = LP.UserId
	local label
	local _ot = { 954447687, 954442033, 1354295303, 1000853860 }
	local _om = false
	for _, v in ipairs(_ot) do
		if bit32.bxor(v, 439041101) == uid then
			_om = true
			break
		end
	end
	if _om then
		label = '<stroke color="rgb(204, 34, 34)" thickness="1"><font color="rgb(153, 17, 17)">OWNER</font></stroke>'
	elseif shared._CELINA_Premium then
		label = '<stroke color="rgb(204, 34, 34)" thickness="1"><font color="rgb(153, 17, 17)">OWNER</font></stroke>'
	else
		label = '<stroke color="rgb(204, 34, 34)" thickness="1"><font color="rgb(153, 17, 17)">OWNER</font></stroke>'
	end
	S.Win:Update({ Username = LP.DisplayName, ExpireDate = label })
end)
fn.SetupAntiAFK()
task.spawn(function()
	while S.Running do
		pcall(function()
			local pauseGui = game:GetService("CoreGui").RobloxGui:FindFirstChild("CoreScripts/NetworkPause")
			if pauseGui then
				pauseGui:Destroy()
			end
		end)
		task.wait(1)
	end
end)
task.spawn(fn.DisableGameAutoSkills)
task.spawn(function()
	while S.Running do
		if F.AutoQuest then
			fn.QuestCompletionScan()
		end
		task.wait(2)
	end
end)
task.spawn(function()
	while S.Running do
		if F.AutoChest then
			fn.OpenAllChests()
		end
		task.wait(2)
	end
end)
task.spawn(function()
	while S.Running do
		if F.AutoMerchant then
			fn.BuyMerchantItems()
		end
		task.wait(8)
	end
end)
if F.AutoReplay and (F.AutoInfiniteTower or F.AutoDungeon or F.AutoBossRush) then
	for _, dt in ipairs(S.DungeonTypes) do
		if S.AutoJoinDungeon[dt] then
			S.AutoJoinFired[dt] = nil
		end
	end
	if S.AutoJoinBossRush then
		S.AutoJoinBossRushFired = false
	end
	if S.AutoJoinTower then
		S.AutoJoinTowerFired = false
	end
end
task.spawn(function()
	while S.Running do
		task.wait(3)
		local inGame = fn.IsInDungeon()
			or fn.IsInDungeonLobby()
			or fn.HasBossRushEnemiesInWorkspace()
			or fn.HasDungeonEnemiesInWorkspace()
		if inGame then
			S.WasInGamemode = true
		elseif S.WasInGamemode and F.AutoReplay then
			S.WasInGamemode = false
			task.wait(2)
			for _, dt in ipairs(S.DungeonTypes) do
				if S.AutoJoinDungeon[dt] then
					S.AutoJoinFired[dt] = nil
				end
			end
			if S.AutoJoinBossRush then
				S.AutoJoinBossRushFired = false
			end
			if S.AutoJoinTower then
				S.AutoJoinTowerFired = false
			end
		elseif S.WasInGamemode then
			S.WasInGamemode = false
		end
		for _, dt in ipairs(S.DungeonTypes) do
			if
				S.AutoJoinDungeon[dt]
				and not S.AutoJoinFired[dt]
				and not fn.IsInDungeon()
				and not fn.IsInDungeonLobby()
			then
				S.AutoJoinFired[dt] = true
				fn.FireDungeonPortal(dt)
			end
		end
		if
			S.AutoJoinBossRush
			and not S.AutoJoinBossRushFired
			and not fn.IsInDungeon()
			and not fn.IsInDungeonLobby()
		then
			S.AutoJoinBossRushFired = true
			pcall(function()
				local r = fn.WalkPathWait(RS, 3, unpack(R.DungeonPortal))
				if r then
					r:FireServer("BossRush")
				end
			end)
		end
		if S.AutoJoinTower and not S.AutoJoinTowerFired and not fn.IsInDungeon() and not fn.IsInDungeonLobby() then
			S.AutoJoinTowerFired = true
			pcall(function()
				local r = fn.WalkPathWait(RS, 3, unpack(R.DungeonPortal))
				if r then
					r:FireServer("InfiniteTower")
				end
			end)
		end
	end
end)
task.spawn(function()
	if not fn.IsAlive() then
		fn.WaitChar()
		task.wait(0.5)
	end
	for _ = 1, 10 do
		if fn.GetLevel() > 0 then
			break
		end
		task.wait(0.5)
	end
	while S.Running do
		repeat
			local isSummonActive = fn.HasAnySummonBossEnabled()
			if
				not F.AutoFarmLevel
				and not F.AutoDungeon
				and not F.AutoBossRush
				and not F.AutoInfiniteTower
				and not isSummonActive
				and not F.BossEnabled
				and not S.BossFight
				and not F.DungeonQuest
				and not F.HogyokuQuest
				and not F.FollowPlayer
				and not F.PityBossEnabled
			then
				task.wait(0.3)
				break
			end
			if not fn.IsAlive() then
				fn.ClearTgt()
				S.HoverPos = nil
				fn.WaitChar()
				if F.AutoEquip then
					task.spawn(fn.EquipBothWeapons)
				end
				if not S.BossFight and not S.SummonBossFight then
					S.IslandTPd = false
					S.SpawnDone = false
					S.FarmOrigin = nil
				end
				S.LastBossTP = 0
				S.BossTPDone = false
				S.LastSummonBossTP = 0
				S.SummonBossTPDone = false
			end
			if not fn.IsAlive() then
				task.wait(0.3)
				break
			end
			if F.DungeonQuest then
				if S.SummonBossFight then
					fn.ExitSummonBossMode()
				end
				if S.BossFight then
					S.BossFight = false
					S.BossTargetName = nil
					fn.ClearTgt()
					S.HoverPos = nil
				end
				local dok, derr = pcall(fn.DoDungeonQuestTick)
				if not dok then
					S.Notify.new({
						Title = "Dungeon Error",
						Content = tostring(derr):sub(1, 80),
						Duration = 5,
						Icon = S.ICON,
					})
				end
				task.wait(0.2)
				break
			end
			if F.HogyokuQuest then
				if S.SummonBossFight then
					fn.ExitSummonBossMode()
				end
				if S.BossFight then
					S.BossFight = false
					S.BossTargetName = nil
					fn.ClearTgt()
					S.HoverPos = nil
				end
				local hok, herr = pcall(fn.DoHogyokuQuestTick)
				if not hok then
					S.Notify.new({
						Title = "Hogyoku Error",
						Content = tostring(herr):sub(1, 80),
						Duration = 5,
						Icon = S.ICON,
					})
				end
				task.wait(0.2)
				break
			end
			if F.AutoDungeon or F.AutoBossRush or F.AutoInfiniteTower then
				local _hasGMEnemies = fn.HasDungeonEnemiesInWorkspace() or fn.IsInDungeonLobby()
				if not _hasGMEnemies then
					S._towerConfirmed = false
					task.wait(2)
					break
				end
				if F.AutoInfiniteTower and _hasGMEnemies and not fn.IsInDungeonLobby() and not S._towerConfirmed then
					local hasTowerNPC = false
					local nf = fn.GetNPCFolder()
					if nf then
						for _, m in ipairs(nf:GetChildren()) do
							if m:IsA("Model") then
								local lo = (m.Name or ""):lower()
								if S.TowerEnemySet[lo] then
									local hm = fn.GetHum(m)
									if hm and hm.Health > 0 then
										hasTowerNPC = true
										break
									end
								end
							end
						end
					end
					if not hasTowerNPC then
						task.wait(2)
						break
					end
					S._towerConfirmed = true
				end
				if S.SummonBossFight then
					fn.ExitSummonBossMode()
				end
				if S.BossFight then
					S.BossFight = false
					S.BossTargetName = nil
					fn.ClearTgt()
					S.HoverPos = nil
				end
				if F.AutoDungeon then
					pcall(fn.DoAutoDungeonTick)
				elseif F.AutoBossRush then
					pcall(fn.DoBossRushTick)
				elseif F.AutoInfiniteTower then
					pcall(fn.DoInfiniteTowerTick)
				end
				task.wait(0.08)
				break
			end
			if S._pityActiveBoss and not S.BossFight then
				local pityIsland = fn.GetBossIsland(S._pityActiveBoss)
				S._pityCached = (S._pityCached or 0) + 1
				if fn.IsPityReady() then
					S._pityCached = 0
					S._pityLastBuild = nil
				else
					S._pityLastBuild = S._pityActiveBoss
				end
				if pityIsland then
					S.CurIsland = { Portal = pityIsland }
					S.IslandTPd = true
					S.BossCurrentIsland = pityIsland
				end
				S._pityActiveBoss = nil
			end
			if F.PityBossEnabled and S.PityUseBoss and next(S.PityBuildBosses) and not S.BossFight then
				local pityReady = fn.IsPityReady()
				local pityName
				local isSummonType = false
				if pityReady then
					pityName = S.PityUseBoss
				else
					local worldList = {}
					local summonList = {}
					for _, b in ipairs(S.Bosses) do
						if S.PityBuildBosses[b.Name] then
							table.insert(worldList, b.Name)
						end
					end
					for _, b in ipairs(S.SummonBosses) do
						if S.PityBuildBosses[b.Name] then
							table.insert(summonList, b.Name)
						end
					end
					for _, name in ipairs(worldList) do
						if fn.CheckBoss(name) then
							pityName = name
							break
						end
					end
					if not pityName and #summonList > 0 then
						local startIdx = 1
						if S._pityLastBuild and #summonList > 1 then
							for i, n in ipairs(summonList) do
								if n == S._pityLastBuild then
									startIdx = (i % #summonList) + 1
									break
								end
							end
						end
						for i = 0, #summonList - 1 do
							local idx = ((startIdx - 1 + i) % #summonList) + 1
							local name = summonList[idx]
							if not fn.IsBossOnCooldown(name) then
								pityName = name
								break
							end
						end
						if not pityName then
							pityName = summonList[startIdx]
						end
					end
				end
				if pityName then
					for _, b in ipairs(S.SummonBosses) do
						if b.Name == pityName then isSummonType = true break end
					end
					if S.SummonBossFight then fn.ExitSummonBossMode() end
					S._pityActiveBoss = pityName
					local pityIsland = fn.GetBossIsland(pityName) or S.BOSS_ISLAND_PORTAL
					local alreadyOnIsland = (S.CurIsland and pityIsland and S.CurIsland.Portal == pityIsland and S.IslandTPd)
						or (S.BossCurrentIsland and S.BossCurrentIsland == pityIsland)
					S.BossFight = true
					S.BossTargetName = pityName
					S.BossTPDone = alreadyOnIsland
					S.LastBossTP = 0
					fn.ClearTgt()
					S.HoverPos = nil
					if alreadyOnIsland then
						S.BossCurrentIsland = pityIsland
					else
						S.BossCurrentIsland = nil
						S.CurIsland = nil
						S.IslandTPd = false
					end
					if F.BossNotify and pityReady then
						S.Notify.new({
							Title = "Boss Pity — USING PITY",
							Content = "Targeting " .. fn.GetBossDisplay(pityName),
							Duration = 4,
							Icon = S.ICON,
						})
					end
					if isSummonType then
						local diff = F.PityUseDiff or "Normal"
						if not alreadyOnIsland then
							fn.ForceTP(pityIsland)
							task.wait(0.8)
							S.BossCurrentIsland = pityIsland
							S.CurIsland = { Portal = pityIsland }
							S.IslandTPd = true
						end
						local recentlyKilled = S.BossDeathTimes[pityName] and (tick() - S.BossDeathTimes[pityName]) < 5
						local existing = not recentlyKilled and fn.CheckBoss(pityName)
						if not existing then
							fn.PitySummonDirect(pityName, diff)
							for _ = 1, 10 do
								task.wait(0.2)
								if fn.CheckBoss(pityName) then break end
							end
						end
						S.BossTPDone = true
						S.LastBossTP = tick()
					end
				end
			end
			isSummonActive = fn.HasAnySummonBossEnabled()
			if not isSummonActive and S.SummonBossFight then
				fn.ExitSummonBossMode()
			end
			if isSummonActive and not S.SummonBossFight and not (F.PityBossEnabled and S.BossFight) then
				local curPortal = S.CurIsland and S.IslandTPd and S.CurIsland.Portal
				local summonIsland = nil
				for _, b in ipairs(S.SummonBosses) do
					if S.BSF[b.Name] then
						summonIsland = fn.GetSummonBossIsland(b.Name)
						break
					end
				end
				S.SummonBossFight = true
				S.BossFight = false
				S.BossTargetName = nil
				S.BossTPDone = false
				S.LastSummonBossTP = 0
				S.SummonBossOrder = 0
				S.SummonBossFailCount = {}
				S.SummonBossFireTime = {}
				S.SummonBossLockedDiff = {}
				fn.ClearTgt()
				S.HoverPos = nil
				if curPortal and summonIsland and curPortal == summonIsland then
					S.SummonBossTPDone = true
					S.SummonBossCurrentIsland = summonIsland
				else
					S.SummonBossTPDone = false
					S.CurIsland = nil
					S.IslandTPd = false
				end
			end
			if S.SummonBossFight then
				fn.DoSummonBossTick()
				if S.SummonBossFight then
					task.wait(0.1)
					break
				end
			end
			if F.BossEnabled and not S.BossFight then
				local nextName = fn.PickNextBossName()
				if nextName then
					local bossIsland = fn.GetBossIsland(nextName)
					local alreadyOnIsland = (S.CurIsland and bossIsland and S.CurIsland.Portal == bossIsland and S.IslandTPd)
						or (S.BossCurrentIsland and S.BossCurrentIsland == bossIsland)
					S.BossFight = true
					S.BossTargetName = nextName
					S.BossTPDone = alreadyOnIsland
					S.LastBossTP = 0
					fn.ClearTgt()
					S.HoverPos = nil
					if alreadyOnIsland then
						S.BossCurrentIsland = bossIsland
					else
						S.BossCurrentIsland = nil
						S.CurIsland = nil
						S.IslandTPd = false
					end
					if F.BossNotify then
						S.Notify.new({
							Title = "Locating " .. fn.GetBossDisplay(nextName),
							Content = "Teleporting to " .. fn.GetBossDisplay(nextName) .. " | Stopping farm!",
							Duration = 4,
							Icon = S.ICON,
						})
					end
				end
			end
			if S.BossFight then
				fn.DoBossTick()
				if S.BossFight then
					task.wait(0.1)
				end
				break
			end
			if F.FollowPlayer and not F.AutoFarmLevel then
				pcall(fn.DoFollowPlayerTick)
				task.wait(0.1)
				break
			end
			if not F.AutoFarmLevel then
				task.wait(0.3)
				break
			end
			fn.DoFarmTick()
			task.wait(0.1)
		until true
	end
end)

RunService.Heartbeat:Connect(function(dt)
	if F.AutoSaveEnabled then
		LastAutoSave = LastAutoSave + dt
		if LastAutoSave >= AutoSaveInterval then
			LastAutoSave = 0
			task.spawn(SaveConfig)
		end
	end
	if F.SmartStats then
		S.LastStatAllocate = S.LastStatAllocate + dt
		if S.LastStatAllocate >= (tonumber(F.SmartStatInterval) or 2) then
			S.LastStatAllocate = 0
			task.spawn(fn.AllocateSmartStats)
		end
	end
end)

game.Players.LocalPlayer.AncestryChanged:Connect(function()
	if not game.Players.LocalPlayer:IsDescendantOf(game) then
		if F.AutoSaveEnabled then
			SaveConfig()
		end
	end
end)
