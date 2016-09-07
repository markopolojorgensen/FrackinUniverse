-- unit times for the extractor tech levels
local timers = { 0.75, 0.45, 0.1 }

-- Format:
--   inputs = list of item=quantity pairs
--   outputs = list of item=quantity pairs
--   timeScale = extraction time scaling value (default 1); may be a list as for quantity
--               e.g. { 1, 2, 4 } gives { 0.75 * 1, 0.45 * 2, 0.1 * 4 } = { 0.75, 0.9, 0.4 }, but generally a single value should be used
--   reversible = true if the conversion can be reversed
--
--   Each quantity is either a single number or a table containing a value for each extractor tech level
--   Order is basic (1), advanced (2), quantum (3)
--
--   Listing order is no guarantee of checking order
--   No checks are made for multi-input recipes being overridden by single-input recipes
local recipes = {
	-- liquids
	{ inputs = { algaegreen = 5 }, outputs = { fu_nitrogen = { 1, 1, 3 } } },
	{ inputs = { frozenwater = 50 }, outputs = { liquidwater = 1 } },
	{ inputs = { fu_nitrogen = 1 }, outputs = { liquidnitrogenitem = 1 }, reversible = true },
	{ inputs = { liquidbioooze = 25 }, outputs = { fu_hydrogen = 2 } },
	{ inputs = { liquidblacktar = 1 }, outputs = { liquidoil = { 1, 1, 2 } } },
	{ inputs = { liquidblood = 1 }, outputs = { fu_oxygen = { 1, 1, 2 } } },
	{ inputs = { liquiddarkwater = 20 }, outputs = { fu_nitrogen = { 1, 1, 2 }, fu_salt = { 2, 2, 3 }, fu_carbon = 1 } },
	{ inputs = { liquidhealing = 10 }, outputs = { fu_nitrogen = { 1, 1, 2 }, fu_oxygen = 1, fu_salt = { 2, 2, 3 } } },
	{ inputs = { liquidironfu = 25 }, outputs = { fu_carbon = { 1, 1, 2 } } },
	{ inputs = { liquidorganicsoup = 25 }, outputs = { geneticmaterial = { 1, 1, 3 } } },
	{ inputs = { liquidpus = 50 }, outputs = { fu_nitrogen = { 1, 1, 3 } } },
	{ inputs = { liquidwater = 10 }, outputs = { fu_salt = { 1, 1, 2 }, fu_oxygen = { 2, 1, 2 }, fu_hydrogen = { 1, 1, 2 } } },
	{ inputs = { poop = 1 }, outputs = { fu_nitrogen = { 3, 3, 5 } } },
	{ inputs = { swampwater = 10 }, outputs = { fu_salt = { 1, 1, 2 }, fu_oxygen = { 1, 1, 2 }, fu_hydrogen = { 1, 1, 2 } } },
	-- bees mod content
	{ inputs = { adaptivedrone = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { adaptivequeen = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { aggressivedrone = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { aggressivequeen = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { arcticcomb = 1 }, outputs = { ice = 2 } },
	{ inputs = { arcticdrone = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { arcticqueen = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { aridcomb = 1 }, outputs = { sand = 2 } },
	{ inputs = { ariddrone = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { aridqueen = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { coppercomb = 1 }, outputs = { copperore = 2 } },
	{ inputs = { darkcomb = 1 }, outputs = { shadowgasliquid = 2 } },
	{ inputs = { durasteelcomb = 1 }, outputs = { durasteelore = 2 } },
	{ inputs = { exceptionalcomb = 1 }, outputs = { fu_liquidhoney = 5 } },
	{ inputs = { exceptionaldrone = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { exceptionalqueen = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { flowerblue = 1 }, outputs = { fu_nitrogen = 1 } },
	{ inputs = { flowercomb = 1 }, outputs = { liquidorganicsoup = 2 } },
	{ inputs = { flowerdrone = 1 }, outputs = { fu_oxygen = { 1, 1, 4 } } },
	{ inputs = { flowerqueen = 1 }, outputs = { fu_oxygen = { 1, 1, 4 } } },
	{ inputs = { flowerred = 1 }, outputs = { fu_nitrogen = 1 } },
	{ inputs = { flowerspring = 1 }, outputs = { fu_nitrogen = 1 } },
	{ inputs = { floweryellow = 1 }, outputs = { fu_nitrogen = 1 } },
	{ inputs = { forestcomb = 1 }, outputs = { fu_liquidhoney = 2 } },
	{ inputs = { forestdrone = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { forestqueen = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { godlycomb = 1 }, outputs = { solariumore = 2 } },
	{ inputs = { godlydrone = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { godlyqueen = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { goldcomb = 1 }, outputs = { goldore = 2 } },
	{ inputs = { hardydrone = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { hardyqueen = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { hunterdrone = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { hunterqueen = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { ironcomb = 1 }, outputs = { ironore = 2 } },
	{ inputs = { junglecomb = 1 }, outputs = { biospore = 2 } },
	{ inputs = { jungledrone = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { junglequeen = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { minercomb = 1 }, outputs = { coalore = 3 } },
	{ inputs = { minerdrone = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { minerqueen = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { mooncomb = 1 }, outputs = { helium3gasliquid = 2 } },
	{ inputs = { morbidcomb = 1 }, outputs = { rottingfleshmaterial = 2 }, timeScale = { nil, nil, 9.1 } },
	{ inputs = { mythicalcomb = 1 }, outputs = { vialproto = 2 } },
	{ inputs = { nocturnalcomb = 1 }, outputs = { shadowgasliquid = 2 } },
	{ inputs = { nocturnaldrone = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { nocturnalqueen = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { normalcomb = 1 }, outputs = { fu_liquidhoney = 2 } },
	{ inputs = { normaldrone = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { normalqueen = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { plutoniumcomb = 1 }, outputs = { plutoniumore = 2 } },
	{ inputs = { plutoniumdrone = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { plutoniumqueen = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { preciouscomb = 1 }, outputs = { diamond = 1 } },
	{ inputs = { radioactivecomb = 1 }, outputs = { uraniumore = 2 } },
	{ inputs = { radioactivedrone = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { radioactivequeen = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { redcomb = 1 }, outputs = { liquidblood = 2 } },
	{ inputs = { reddrone = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { redqueen = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { silkcomb = 1 }, outputs = { beesilk = 1 } },
	{ inputs = { silvercomb = 1 }, outputs = { silverore = 2 } },
	{ inputs = { solariumcomb = 1 }, outputs = { solariumore = 2 } },
	{ inputs = { solariumdrone = 1 }, outputs = { solariumore = { 2, 2, 4 } } },
	{ inputs = { solariumqueen = 1 }, outputs = { solariumore = { 2, 2, 4 } } },
	{ inputs = { suncomb = 1 }, outputs = { solariumore = 2 } },
	{ inputs = { sundrone = 1 }, outputs = { solariumore = { 1, 1, 2 } } },
	{ inputs = { sunqueen = 1 }, outputs = { solariumore = { 1, 1, 2 } } },
	{ inputs = { titaniumcomb = 1 }, outputs = { titaniumore = 2 } },
	{ inputs = { tungstencomb = 1 }, outputs = { tungstenore = 2 } },
	{ inputs = { volcaniccomb = 1 }, outputs = { cinnabarore = 2 } },
	{ inputs = { volcanicdrone = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { volcanicqueen = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	-- vanilla bugs
	{ inputs = { ashsprite = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { aurorabee = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { beebug = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { blueback = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { brightstripe = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { butterbee = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { cinderfly = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { dewhopper = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { driftbell = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { dustmoth = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { fawnfly = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { fireflyspawner = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { fireygiant = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { flameroach = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { flyspawner = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { frostfleck = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { frostfly = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { gasgiant = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { glowbug = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { goldbug = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { greentip = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { heathugger = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { hivehog = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { icetip = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { lavahopper = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { muddancer = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { orphanfly = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { phoenixfly = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { polarmoth = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { redwing = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { sandclown = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { scuttleploom = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { seahornet = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { shadowmoth = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { shardwing = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { shellcreep = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { snowskater = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { stinkjack = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { sunskipper = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { testbug = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { thornbee = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { tidefly = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { vineclimber = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { wavebird = 1 }, outputs = { geneticmaterial = 1 } },
	{ inputs = { xenofly = 1 }, outputs = { geneticmaterial = 1 } },
	-- resources
	{ inputs = { alienwoodsap = 1 }, outputs = { tissueculture = { 1, 1, 4 } } },
	{ inputs = { ancientbones = 1 }, outputs = { tissueculture = { 1, 1, 4 } } },
	{ inputs = { artificialbrain = 1 }, outputs = { tissueculture = { 1, 1, 4 } } },
	{ inputs = { biosample = { 2, 3, 2 } }, outputs = { dnasample = 1 } },
	{ inputs = { biospore = 2 }, outputs = { tissueculture = { 1, 1, 2 }, fu_oxygen = { 1, 1, 2 } } },
	{ inputs = { blooddiamond = 1 }, outputs = { quietusore = { 2, 2, 3 } } },
	{ inputs = { bolt = 1 }, outputs = { tissueculture = { 1, 1, 4 } } },
	{ inputs = { bone = 1 }, outputs = { liquidoil = { 5, 5, 9 } } },
	{ inputs = { bottle = 1 }, outputs = { tissueculture = { 1, 1, 4 } } },
	{ inputs = { brain = 1 }, outputs = { tissueculture = { 5, 5, 9 } } },
	{ inputs = { bugshell = 1 }, outputs = { tissueculture = { 1, 1, 4 } } },
	{ inputs = { cellmateria = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { cellmatter = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { coralfragment = 1 }, outputs = { tissueculture = { 1, 1, 4 } } },
	{ inputs = { dragonbone = 1 }, outputs = { tissueculture = { 1, 1, 4 } } },
	{ inputs = { ebonshard = 1 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { endomorphicjelly = 1 }, outputs = { tissueculture = { 4, 4, 8 } } },
	{ inputs = { energywood = 5 }, outputs = { fu_oxygen = { 3, 3, 5 } } },
	{ inputs = { fabric = 1 }, outputs = { tissueculture = { 1, 1, 4 } } },
	{ inputs = { ff_bambooshoot = 1 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { ff_mercury = 1 }, outputs = { coalore = { 1, 1, 2 }, ironore = { 1, 1, 2 } } },
	{ inputs = { ff_resin = 1 }, outputs = { nutrientpaste = { 1, 1, 4 } } },
	{ inputs = { ff_spareparts = 2 }, outputs = { tungstenore = 1 } },
	{ inputs = { flesh = 1 }, outputs = { tissueculture = { 1, 1, 2 } } },
	{ inputs = { fleshstrand = 10 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { florangiantpod = 1 }, outputs = { agaranichor = { 4, 4, 8 }, geneticmaterial = { 24, 24, 36 } } },
	{ inputs = { floranopenpod1 = 1 }, outputs = { agaranichor = { 1, 1, 2 }, geneticmaterial = { 6, 6, 9 } } },
	{ inputs = { floranopenpod2 = 1 }, outputs = { agaranichor = { 1, 1, 2 }, geneticmaterial = { 6, 6, 9 } } },
	{ inputs = { floranpod1 = 1 }, outputs = { agaranichor = 2, geneticmaterial = 6 } },
	{ inputs = { floranpod2 = 1 }, outputs = { agaranichor = 2, geneticmaterial = 6 } },
	{ inputs = { floranpod3 = 1 }, outputs = { agaranichor = 2, geneticmaterial = 6 } },
	{ inputs = { floranpodapex = 1 }, outputs = { agaranichor = { 3, 3, 6 }, geneticmaterial = { 12, 12, 24 } } },
	{ inputs = { fossilore = 1 }, outputs = { tissueculture = { 1, 1, 4 } } },
	{ inputs = { fu_nodule = 1 }, outputs = { tissueculture = { 4, 4, 8 } } },
	{ inputs = { giantflowerpetal = 1 }, outputs = { tissueculture = { 1, 1, 4 } } },
	{ inputs = { gnome = 1 }, outputs = { bone = { 1, 1, 4 } } },
	{ inputs = { greenslime = 1 }, outputs = { fu_oxygen = { 1, 1, 4 }, fu_hydrogen = { 1, 1, 2 } } },
	{ inputs = { gunpowder = 1 }, outputs = { saltpeter = { 1, 1, 4 } } },
	{ inputs = { inferiorbrain = 1 }, outputs = { tissueculture = { 1, 1, 4 } } },
	{ inputs = { laboil = 1 }, outputs = { liquidoil = { 20, 20, 40 } } },
	{ inputs = { larva = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { leather = 1 }, outputs = { geneticmaterial = { 8, 8, 16 } } },
	{ inputs = { metalchunk = 2 }, outputs = { tungstenbar = { 1, 1, 2 } } },
	{ inputs = { metallic = 1 }, outputs = { tissueculture = { 1, 1, 2 } } },
	{ inputs = { moltencore = 1 }, outputs = { tissueculture = { 1, 1, 2 } } },
	{ inputs = { monsterplating = 1 }, outputs = { geneticmaterial = { 1, 1, 2 } } },
	{ inputs = { mutavisksilk = 5 }, outputs = { dnasample = { 1, 1, 2 } } },
	{ inputs = { obsidianshard = 1 }, outputs = { ammoniumsulfate = { 1, 1, 2 } } },
	{ inputs = { paper = 1 }, outputs = { tissueculture = { 1, 1, 2 } } },
	{ inputs = { pelt = 1 }, outputs = { tissueculture = { 1, 1, 4 } } },
	{ inputs = { petalblue = 1 }, outputs = { tissueculture = { 1, 1, 2 } } },
	{ inputs = { petalred = 1 }, outputs = { tissueculture = { 1, 1, 2 } } },
	{ inputs = { petalyellow = 1 }, outputs = { tissueculture = { 1, 1, 2 } } },
	{ inputs = { reed = 1 }, outputs = { tissueculture = { 1, 1, 2 } } },
	{ inputs = { rottenfood = 1 }, outputs = { fu_mulch = { 1, 2, 3 } } },
	{ inputs = { seaweed = 1 }, outputs = { tissueculture = { 1, 1, 2 } } },
	{ inputs = { silkspider = 1 }, outputs = { silk = { 1, 1, 2 } } },
	{ inputs = { silkworm = 1 }, outputs = { silk = { 1, 1, 2 } } },
	{ inputs = { toxicwaste = { 10, 10, 5 } }, outputs = { uraniumore = 1 } },
	{ inputs = { tritium = 2 }, outputs = { helium3cannister = { 1, 1, 2 }, toxicwaste = { 1, 2, 3 } } },
	-- tiles
	{ inputs = { aegisaltcrystal = 50 }, outputs = { ff_silicon = 1 }, timeScale = { nil, nil, 4.5 } },
	{ inputs = { alienrock = 50 }, outputs = { ff_silicon = { 2, 2, 4 } } },
	{ inputs = { aliensoil = 50 }, outputs = { algaegreen = { 2, 3, 5 } } },
	{ inputs = { alienstripedwood = 50 }, outputs = { tissueculture = { 2, 2, 4 } } },
	{ inputs = { alienweirdwood = { 50, 50, 1 } }, outputs = { tissueculture = { 2, 2, 4 } } },
	{ inputs = { andesite = 50 }, outputs = { rawminerals = { 1, 1, 2 } } },
	{ inputs = { andesitematerial = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { arkosematerial = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { ash = 50 }, outputs = { nutrientpaste = { 2, 2, 4 } } },
	{ inputs = { avalichits = 50 }, outputs = { fu_carbon = { 1, 1, 2 } }, timeScale = { 1.2666666666667, 1.5555555555556, 6 } },
	{ inputs = { avalidarkmetal2 = 50 }, outputs = { ironore = { 1, 1, 2 } }, timeScale = { 1.2666666666667, 1.5555555555556, 6 } },
	{ inputs = { avalihexagons1 = 50 }, outputs = { ff_silicon = { 1, 1, 2 } }, timeScale = { 1.2666666666667, 1.5555555555556, 6 } },
	{ inputs = { avalitechpanel = 50 }, outputs = { ff_plastic = { 1, 1, 2 } }, timeScale = { 1.2666666666667, 1.5555555555556, 6 } },
	{ inputs = { bamboo = 50 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { bioblock2material = 50 }, outputs = { geneticmaterial = { 1, 1, 2 } } },
	{ inputs = { bioblockmaterial = 50 }, outputs = { geneticmaterial = { 1, 1, 2 } } },
	{ inputs = { biodirtmaterial = 50 }, outputs = { fu_nitrogen = { 1, 1, 2 } } },
	{ inputs = { biogravelmaterial = 50 }, outputs = { tissueculture = { 1, 1, 2 } } },
	{ inputs = { biorock = 50 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { biorock2 = 50 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { biostonematerial = 50 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { blackslimematerial = 8 }, outputs = { blobbushjelly = { 1, 1, 2 } } },
	{ inputs = { blaststone = 50 }, outputs = { rawminerals = { 4, 4, 6 } } },
	{ inputs = { bloodsandmaterial = 50 }, outputs = { liquidoil = { 2, 2, 4 } } },
	{ inputs = { bloodstonematerial = 50 }, outputs = { phosphorus = { 1, 1, 3 } } },
	{ inputs = { bloodstonewall = 50 }, outputs = { blooddiamond = { 1, 1, 2 } } },
	{ inputs = { bloodstonewall2 = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { bloodstonewall3 = 50 }, outputs = { phosphorus = { 1, 1, 2 } } },
	{ inputs = { bonematerial = 25 }, outputs = { bone = { 5, 5, 8 }, liquidoil = { 10, 10, 20 } } },
	{ inputs = { bonemealmaterial = 50 }, outputs = { nutrientpaste = 2 } },
	{ inputs = { boneyflesh = 50 }, outputs = { bone = { 2, 3, 4 } }, timeScale = { 0.6, nil, 4.5 } },
	{ inputs = { brainsblock = 50 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { brick = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { brittlejunk = 50 }, outputs = { rawminerals = { 2, 2, 3 } } },
	{ inputs = { brittlemetal = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { cactiblock = 50 }, outputs = { tissueculture = { 2, 2, 4 } } },
	{ inputs = { calichewall = 6 }, outputs = { iodine = { 1, 1, 3 }, saltpeter = { 1, 1, 3 } } },
	{ inputs = { castlewalls1 = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { castlewalls2 = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { chertmaterial = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { chromadirtmaterial = 50 }, outputs = { fu_carbon = { 1, 1, 2 } } },
	{ inputs = { clay = 50 }, outputs = { nutrientpaste = { 3, 3, 5 } } },
	{ inputs = { cloudblock = 50 }, outputs = { liquidwater = { 2, 2, 4 } } },
	{ inputs = { cobblestone = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { cobblestonematerial = 50 }, outputs = { rawminerals = { 2, 2, 3 } } },
	{ inputs = { concretematerial = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { conglomeratematerial = 50 }, outputs = { rawminerals = { 2, 2, 3 } } },
	{ inputs = { coral2material = 50 }, outputs = { coralfragment = { 2, 2, 3 } } },
	{ inputs = { coralmaterial = 50 }, outputs = { coralfragment = { 2, 2, 3 } } },
	{ inputs = { corruptdirtmaterial = 50 }, outputs = { tissueculture = { 2, 2, 4 } } },
	{ inputs = { corruptmaterial = 50 }, outputs = { nutrientpaste = { 2, 2, 3 } } },
	{ inputs = { corruptslimematerial = 50 }, outputs = { tissueculture = { 2, 2, 4 } } },
	{ inputs = { crystal = 50 }, outputs = { icecrystal = { 1, 1, 2 } } },
	{ inputs = { crystalblock = 50 }, outputs = { crystal = { 2, 2, 4 } } },
	{ inputs = { crystalsandmaterial = 50 }, outputs = { ff_silicon = { 1, 1, 2 } } },
	{ inputs = { dacitematerial = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { darknessmaterial = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { darkstonematerial = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { diamondblockmaterial = 10 }, outputs = { diamond = 1 } },
	{ inputs = { direstone = 50 }, outputs = { rawminerals = { 4, 4, 8 } } },
	{ inputs = { dirtmaterial = 50 }, outputs = { nutrientpaste = { 2, 2, 5 } } },
	{ inputs = { drydirt = 50 }, outputs = { nutrientpaste = { 2, 2, 4 } } },
	{ inputs = { drysand = 50 }, outputs = { iodine = { 1, 1, 2 }, liquidoil = { 2, 2, 4 } } },
	{ inputs = { ebonblockmaterial = 4 }, outputs = { ebonshard = { 3, 3, 5 } } },
	{ inputs = { elderblock2material = 50 }, outputs = { rawminerals = { 3, 3, 5 } } },
	{ inputs = { elderblockmaterial = 50 }, outputs = { rawminerals = { 3, 3, 5 } } },
	{ inputs = { elderstone2material = 50 }, outputs = { rawminerals = { 3, 3, 5 } } },
	{ inputs = { elderstonematerial = 50 }, outputs = { rawminerals = { 3, 3, 5 } } },
	{ inputs = { eyepiles = 50 }, outputs = { tissueculture = { 2, 2, 4 } } },
	{ inputs = { fleshblock = 50 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { floweryblock = 50 }, outputs = { geneticmaterial = { 3, 3, 6 } } },
	{ inputs = { frozendirt = 50 }, outputs = { nutrientpaste = { 3, 3, 5 } } },
	{ inputs = { frozensand2material = 50 }, outputs = { ff_silicon = { 1, 1, 3 } } },
	{ inputs = { frozensandmaterial = 50 }, outputs = { ff_silicon = { 1, 1, 3 } } },
	{ inputs = { frozenstonematerial = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { fu_honeycombblock = 50 }, outputs = { fu_liquidhoney = { 2, 2, 4 } } },
	{ inputs = { fu_redhoneycombblock = 50 }, outputs = { fu_liquidhoney = { 2, 2, 4 } } },
	{ inputs = { fujellyblock = 50 }, outputs = { endomorphicjelly = 1 } },
	{ inputs = { fumetalblockmaterial = 50 }, outputs = { tungstenore = { 1, 1, 2 } }, timeScale = { 1.2666666666667, 0.88888888888889, 5 } },
	{ inputs = { fumossyrock = 50 }, outputs = { rawminerals = { 2, 2, 3 } } },
	{ inputs = { fumossyrock2 = 50 }, outputs = { rawminerals = { 2, 2, 3 } } },
	{ inputs = { fungalstonematerial = 50 }, outputs = { rawminerals = { 2, 2, 3 } } },
	{ inputs = { gabbromaterial = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { genetile = 50 }, outputs = { geneticmaterial = { 1, 2, 4 } } },
	{ inputs = { geodeblock = 50 }, outputs = { crystal = { 1, 1, 3 } } },
	{ inputs = { geodestone = 50 }, outputs = { crystal = { 1, 1, 3 } } },
	{ inputs = { glasssandmaterial = 50 }, outputs = { ff_silicon = { 1, 1, 2 } } },
	{ inputs = { glowsandmaterial = 50 }, outputs = { ff_silicon = { 1, 1, 2 } } },
	{ inputs = { gneissmaterial = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { grassy = 50 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { grassyrock = 50 }, outputs = { rawminerals = 2 } },
	{ inputs = { gravelmaterial = 50 }, outputs = { rawminerals = { 1, 1, 3 } } },
	{ inputs = { gritstonematerial = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { harrowstone = 50 }, outputs = { rawminerals = { 1, 2, 4 } } },
	{ inputs = { hellstonematerial = 50 }, outputs = { rawminerals = { 4, 4, 6 }, iodine = { 1, 1, 2 } } },
	{ inputs = { hive = 50 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { hiveoldmaterial = 50 }, outputs = { geneticmaterial = { 2, 2, 4 } }, timeScale = { 1.2666666666667, 1.3333333333333, 3 } },
	{ inputs = { honeycombmaterial = 50 }, outputs = { fu_liquidhoney = { 2, 2, 5 } } },
	{ inputs = { ice = 50 }, outputs = { nutrientpaste = { 1, 1, 2 }, liquidwater = { 3, 5, 12 } } },
	{ inputs = { iceblock1material = 50 }, outputs = { fu_nitrogen = { 1, 1, 2 }, liquidwater = { 3, 5, 12 } } },
	{ inputs = { iceblock2material = 50 }, outputs = { fu_nitrogen = { 1, 1, 2 }, liquidwater = { 3, 5, 12 } } },
	{ inputs = { iceblock3material = 50 }, outputs = { fu_nitrogen = { 1, 1, 2 }, liquidwater = { 3, 5, 12 } } },
	{ inputs = { iceblock4material = 50 }, outputs = { fu_nitrogen = { 1, 1, 2 }, liquidwater = { 3, 5, 12 } } },
	{ inputs = { icecrystal = 5 }, outputs = { crystal = { 50, 50, 55 } } },
	{ inputs = { irradiatedwall = 50 }, outputs = { uraniumore = { 1, 1, 2 } } },
	{ inputs = { irradiatedwall2 = 50 }, outputs = { rawminerals = { 2, 2, 3 } } },
	{ inputs = { irradiatedwall3 = 50 }, outputs = { uraniumore = { 1, 1, 2 } } },
	{ inputs = { jellyblock = 50 }, outputs = { endomorphicjelly = { 1, 1, 2 } } },
	{ inputs = { jellystone = 50 }, outputs = { endomorphicjelly = { 1, 1, 2 } } },
	{ inputs = { jungledirt1material = 50 }, outputs = { fu_mulch = { 1, 1, 3 } } },
	{ inputs = { jungledirt2material = 50 }, outputs = { fu_nitrogen = { 2, 2, 4 }, fu_oxygen = { 1, 1, 3 } } },
	{ inputs = { junglestonematerial = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { junk = 50 }, outputs = { ff_silicon = { 1, 1, 2 }, ironore = { 1, 1, 2 } } },
	{ inputs = { limestonematerial = 50 }, outputs = { rawminerals = { 2, 2, 4 }, calciumnitrate = 1 } },
	{ inputs = { logblock = 5 }, outputs = { methanol = { 2, 2, 4 } } },
	{ inputs = { magmarock = 50 }, outputs = { ammoniumsulfate = { 1, 1, 2 } } },
	{ inputs = { magmawall1 = 50 }, outputs = { ammoniumsulfate = { 2, 2, 4 } } },
	{ inputs = { magmawall2 = 50 }, outputs = { rawminerals = { 3, 3, 4 }, corefragmentore = { 1, 1, 2 } } },
	{ inputs = { magmawall3 = 50 }, outputs = { rawminerals = { 4, 4, 5 }, corefragmentore = { 1, 1, 2 } } },
	{ inputs = { magmawall4 = 50 }, outputs = { ammoniumsulfate = { 1, 1, 2 } } },
	{ inputs = { marestonematerial = 50 }, outputs = { rawminerals = { 1, 1, 2 }, iodine = { 2, 2, 4 } } },
	{ inputs = { meteoriterock = 50 }, outputs = { ff_silicon = { 1, 1, 2 } } },
	{ inputs = { moltenmetal = 50 }, outputs = { metalchunk = { 1, 1, 2 } } },
	{ inputs = { moltensand = 50 }, outputs = { metalchunk = { 1, 1, 2 } } },
	{ inputs = { moltensteel = 50 }, outputs = { metalchunk = { 1, 1, 2 } } },
	{ inputs = { moltentile = 50 }, outputs = { metalchunk = { 1, 1, 2 } } },
	{ inputs = { moondust = 50 }, outputs = { helium3cannister = { 1, 1, 4 } } },
	{ inputs = { moonrock = 50 }, outputs = { rawminerals = { 3, 3, 4 } } },
	{ inputs = { moonstone = 50 }, outputs = { rawminerals = { 1, 1, 3 } } },
	{ inputs = { mossypackeddirt = 50 }, outputs = { fu_nitrogen = { 2, 2, 4 } } },
	{ inputs = { mud = 50 }, outputs = { nutrientpaste = { 1, 1, 2 } } },
	{ inputs = { mudstonematerial = 50 }, outputs = { rawminerals = { 2, 2, 3 } } },
	{ inputs = { obsidian = 10 }, outputs = { obsidianshard = { 1, 1, 2 } } },
	{ inputs = { oystershellmaterial = 50 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { packeddirt = 50 }, outputs = { nutrientpaste = { 1, 1, 2 } } },
	{ inputs = { peglacigiantekblock = 50 }, outputs = { durasteelore = { 1, 1, 2 } }, timeScale = { 1.2666666666667, 1.5555555555556, 5 } },
	{ inputs = { peglacihexpane = 50 }, outputs = { ff_plastic = { 2, 3, 5 } }, timeScale = { 1.2666666666667, 1.5555555555556, 5 } },
	{ inputs = { peglaciinscribedpykreteblock = 50 }, outputs = { tungstenore = { 2, 2, 4 } }, timeScale = { 1.2666666666667, 1.5555555555556, 5 } },
	{ inputs = { peglacimetalblock = 50 }, outputs = { tungstenore = { 1, 1, 2 } }, timeScale = { 1.2666666666667, 1.5555555555556, 5 } },
	{ inputs = { peglacimetalpanel = 50 }, outputs = { tungstenore = { 1, 1, 2 } }, timeScale = { 1.2666666666667, 1.5555555555556, 5 } },
	{ inputs = { peglacimetalscreen = 50 }, outputs = { tungstenore = { 1, 1, 2 } }, timeScale = { 1.2666666666667, 1.5555555555556, 5 } },
	{ inputs = { peglacipykreteblock = 50 }, outputs = { tungstenore = { 1, 1, 2 } }, timeScale = { 1.2666666666667, 1.5555555555556, 5 } },
	{ inputs = { peglacipykretedecor = 50 }, outputs = { tungstenore = { 1, 1, 2 } }, timeScale = { 1.2666666666667, 1.5555555555556, 5 } },
	{ inputs = { penumbradirtmaterial = 30 }, outputs = { nutrientpaste = { 1, 1, 2 } } },
	{ inputs = { penumbrastonematerial = 30 }, outputs = { rawminerals = { 1, 1, 2 } } },
	{ inputs = { petalblock = 50 }, outputs = { geneticmaterial = { 3, 3, 6 } } },
	{ inputs = { plantblock = 50 }, outputs = { tissueculture = { 3, 3, 4 }, fu_oxygen = { 1, 1, 3 } } },
	{ inputs = { plantmatter = 50 }, outputs = { fu_oxygen = { 1, 1, 3 }, fu_mulch = { 3, 3, 4 } } },
	{ inputs = { purplecrystalmaterial = 50 }, outputs = { ff_silicon = { 1, 1, 3 } } },
	{ inputs = { rainbowsandmaterial = 50 }, outputs = { ff_silicon = { 2, 2, 4 } } },
	{ inputs = { raincloudmat = 50 }, outputs = { liquidwater = { 4, 4, 5 } } },
	{ inputs = { redhoneycombmaterial = 50 }, outputs = { fu_liquidhoney = { 2, 2, 5 } } },
	{ inputs = { redhotcobblestone = 50 }, outputs = { corefragmentore = { 1, 2, 4 } } },
	{ inputs = { redsand = 50 }, outputs = { ff_silicon = { 1, 1, 2 } } },
	{ inputs = { redsand2 = 50 }, outputs = { ff_silicon = { 1, 1, 3 } } },
	{ inputs = { retexaetherdust = 50 }, outputs = { mineralsample = { 1, 2, 4 } }, timeScale = { nil, 1.5555555555556 } },
	{ inputs = { retexcobblestone = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { retexdirt = 50 }, outputs = { nutrientpaste = { 2, 2, 4 } } },
	{ inputs = { retexironblock = 50 }, outputs = { tungstenore = { 2, 1, 2 } }, timeScale = { 1.0666666666667, 1.3333333333333, 6 } },
	{ inputs = { retexironpipe = 50 }, outputs = { tungstenore = { 2, 1, 2 } }, timeScale = { 1.0666666666667, 1.3333333333333, 6 } },
	{ inputs = { retexredsandstone = 50 }, outputs = { phosphorus = { 1, 1, 3 } } },
	{ inputs = { retexsandstone = 50 }, outputs = { phosphorus = { 1, 1, 2 } } },
	{ inputs = { rostonematerial = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { rottingfleshmaterial = 50 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { rustymetal = 50 }, outputs = { ironore = { 1, 1, 2 } } },
	{ inputs = { sand = 50 }, outputs = { ff_silicon = { 1, 1, 2 } } },
	{ inputs = { sand2 = 50 }, outputs = { ff_silicon = { 1, 1, 2 } } },
	{ inputs = { sandstoneblock = 50 }, outputs = { phosphorus = { 1, 1, 2 } } },
	{ inputs = { sandstonematerial = 50 }, outputs = { phosphorus = { 1, 1, 2 } } },
	{ inputs = { sewage = 50 }, outputs = { poop = { 2, 2, 4 } } },
	{ inputs = { shadowblock = 50 }, outputs = { rawminerals = { 3, 4, 5 } } },
	{ inputs = { shadowspikeblock = 50 }, outputs = { rawminerals = { 3, 4, 53 } } },
	{ inputs = { shadowwallblock = 50 }, outputs = { rawminerals = { 3, 4, 5 } } },
	{ inputs = { shroomblock = 50 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { shroomblockglow = 50 }, outputs = { agaranichor = { 1, 1, 4 } } },
	{ inputs = { slime = 50 }, outputs = { nutrientpaste = { 2, 2, 4 } } },
	{ inputs = { slime2material = 50 }, outputs = { greenslime = { 1, 1, 2 } } },
	{ inputs = { slimedirtmaterial = 50 }, outputs = { tissueculture = { 3, 3, 4 } } },
	{ inputs = { slush = 50 }, outputs = { nutrientpaste = { 1, 1, 2 } } },
	{ inputs = { snow = 50 }, outputs = { nutrientpaste = { 2, 2, 4 } } },
	{ inputs = { spidersilkblock = 50 }, outputs = { silk = { 1, 1, 3 } } },
	{ inputs = { springvines = 50 }, outputs = { geneticmaterial = { 1, 2, 3 } } },
	{ inputs = { steelmetal = 50 }, outputs = { metalchunk = { 1, 1, 2 } } },
	{ inputs = { steelpartblock = 50 }, outputs = { metalchunk = { 1, 1, 2 } } },
	{ inputs = { steelsand = 50 }, outputs = { metalchunk = { 1, 1, 2 } } },
	{ inputs = { steelstonematerial = 50 }, outputs = { metalchunk = { 1, 1, 2 } } },
	{ inputs = { stonerubble = 50 }, outputs = { rawminerals = 3 } },
	{ inputs = { sulphurdirtmaterial = 50 }, outputs = { rawminerals = { 2, 2, 4 }, sulphur = { 1, 2, 3 } } },
	{ inputs = { sulphurstonematerial = 50 }, outputs = { rawminerals = { 3, 3, 5 }, sulphur = { 1, 2, 3 } } },
	{ inputs = { supermatter = 4 }, outputs = { liquidfuel = { 3, 3, 5 } } },
	{ inputs = { swampdirtffmaterial = 50 }, outputs = { fu_oxygen = { 1, 1, 2 }, nutrientpaste = { 2, 2, 3 } } },
	{ inputs = { tar = 50 }, outputs = { liquidoil = { 3, 3, 4 } } },
	{ inputs = { tarstonematerial = 50 }, outputs = { liquidblacktar = { 2, 2, 4 } } },
	{ inputs = { techhull1 = 50 }, outputs = { ironore = 3 } },
	{ inputs = { vine = 50 }, outputs = { fu_oxygen = 1, plantfibre = { 2, 2, 4 } } },
	{ inputs = { violiumcrystal = 50 }, outputs = { ff_silicon = { 1, 1, 2 } } },
	{ inputs = { warttile = 50 }, outputs = { tissueculture = { 1, 2, 4 } } },
	{ inputs = { waste = 50 }, outputs = { nutrientpaste = { 2, 2, 4 } } },
	{ inputs = { wastestone = 50 }, outputs = { rawminerals = { 2, 2, 4 } } },
	{ inputs = { wetdirt = 50 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	-- seeds
	{ inputs = { aenemaflower = 1 }, outputs = { geneticmaterial = { 2, 2, 5 } } },
	{ inputs = { algaeseed = 1 }, outputs = { fu_nitrogen = { 3, 3 }, geneticmaterial = { nil, nil, 5 } } },
	{ inputs = { aquapodseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { arkaentree = 1 }, outputs = { geneticmaterial = { 2, 2, 5 } } },
	{ inputs = { automatoseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { avesmingoseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { bambooseed = 1 }, outputs = { geneticmaterial = { 2, 2, 4 } }, timeScale = { 1.3333333333333, 2.2222222222222, 10 } },
	{ inputs = { bananaseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { batterystem = 1 }, outputs = { geneticmaterial = { 2, 2, 5 } } },
	{ inputs = { beakseedseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { beetlesproutseed = 1 }, outputs = { algaeseed = { 1, 1, 3 } } },
	{ inputs = { bellamorte = 1 }, outputs = { geneticmaterial = { 2, 2, 5 } } },
	{ inputs = { biscornseed = 1 }, outputs = { tissueculture = { 3, 3, 4 } } },
	{ inputs = { bladetree = 1 }, outputs = { geneticmaterial = { 2, 2, 5 } } },
	{ inputs = { blexplantseed = 1 }, outputs = { ff_resin = { 2, 2, 3 } } },
	{ inputs = { blisterbushplantseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { blizzberryseed = 1 }, outputs = { tissueculture = { 2, 2, 4 } } },
	{ inputs = { bloodrootseed = 1 }, outputs = { liquidblood = { 4, 4, 5 } } },
	{ inputs = { bluemelonseed = 1 }, outputs = { geneticmaterial = { 2, 2, 3 } } },
	{ inputs = { boltbulbseed = 1 }, outputs = { coil = { 1, 1, 2 } } },
	{ inputs = { bonebooseed = 1 }, outputs = { bone = { 2, 2, 3 } } },
	{ inputs = { brackentreeseed = 1 }, outputs = { silk = { 4, 4, 5 } } },
	{ inputs = { caprioleplantseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { carrotseed = 1 }, outputs = { cellmateria = { 2, 2, 3 } } },
	{ inputs = { cellpodsplant = 1 }, outputs = { geneticmaterial = { 5, 5, 7 } }, timeScale = { 6.6666666666667, 11.111111111111, 50 } },
	{ inputs = { chiliseed = 1 }, outputs = { tissueculture = { 3, 3, 4 } } },
	{ inputs = { cinnamonseed = 1 }, outputs = { fu_nitrogen = { 2, 2, 4 } } },
	{ inputs = { cocoaseed = 1 }, outputs = { tissueculture = { 1, 2, 3 } } },
	{ inputs = { coffeeseed = 1 }, outputs = { geneticmaterial = { 4, 4, 5 } } },
	{ inputs = { coralcreepseed = 1 }, outputs = { geneticmaterial = { 5, 5, 6 } } },
	{ inputs = { cornseed = 1 }, outputs = { geneticmaterial = { 1, 1, 2 } } },
	{ inputs = { corvexseed = 1 }, outputs = { corvex = { 1, 1, 2 } } },
	{ inputs = { cottonseed = 1 }, outputs = { tissueculture = { 2, 2, 4 } } },
	{ inputs = { crystallite = 1 }, outputs = { geneticmaterial = { 2, 2, 5 } } },
	{ inputs = { crystalplantseed = 1 }, outputs = { crystal = { 1, 1, 2 } } },
	{ inputs = { currentcornseed = 1 }, outputs = { ff_silicon = { 1, 1, 2 } } },
	{ inputs = { darklightflower = 1 }, outputs = { geneticmaterial = { 2, 2, 5 } } },
	{ inputs = { deathblossomseed = 1 }, outputs = { biospore = { 4, 4, 5 } } },
	{ inputs = { diodiahybridseed = 1 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { diodiaseed = 1 }, outputs = { geneticmaterial = { 1, 1, 3 } } },
	{ inputs = { dirturchinseed = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { dragonsbeardseed = 1 }, outputs = { ammoniumsulfate = { 1, 1, 2 } } },
	{ inputs = { eggshootseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { energiflowerseed = 1 }, outputs = { plantfibre = { 8, 8, 12 } } },
	{ inputs = { erithianalgaeseed = 1 }, outputs = { algaeseed = { 1, 1, 3 } } },
	{ inputs = { fayshroomseed = 1 }, outputs = { geneticmaterial = 4 } },
	{ inputs = { feathercrownseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { fletchweed = 1 }, outputs = { geneticmaterial = { 2, 2, 5 } } },
	{ inputs = { floralytplantseed = 1 }, outputs = { geneticmaterial = { 13, 13, 18 } } },
	{ inputs = { flowerblueseed = 1 }, outputs = { geneticmaterial = { 1, 1, 3 } } },
	{ inputs = { flowerredseed = 1 }, outputs = { geneticmaterial = { 1, 1, 3 } } },
	{ inputs = { floweryellowseed = 1 }, outputs = { geneticmaterial = { 1, 1, 3 } } },
	{ inputs = { fubioshroomblue = 1 }, outputs = { biospore = { 3, 3, 5 } } },
	{ inputs = { fubioshroomgreen = 1 }, outputs = { biospore = { 3, 3, 5 } } },
	{ inputs = { fubioshroompurple = 1 }, outputs = { biospore = { 3, 3, 5 } } },
	{ inputs = { fubioshroomred = 1 }, outputs = { biospore = { 3, 3, 5 } } },
	{ inputs = { fubioshroomyellow = 1 }, outputs = { biospore = { 3, 3, 5 } } },
	{ inputs = { fusnowberryseed = 1 }, outputs = { tissueculture = { 6, 6, 8 } }, timeScale = { 6.6666666666667, 11.111111111111, 50 } },
	{ inputs = { fuspongeweedseed = 1 }, outputs = { geneticmaterial = { 4, 4, 7 } }, timeScale = { 6.6666666666667, 11.111111111111, 50 } },
	{ inputs = { garikleaf = 1 }, outputs = { geneticmaterial = { 2, 2, 5 } } },
	{ inputs = { garpberry = 4 }, outputs = { aliencompound = { 1, 2, 2 } } },
	{ inputs = { garpberryseed = 1 }, outputs = { tissueculture = { 2, 2, 4 } } },
	{ inputs = { gazelemonseed = 1 }, outputs = { tissueculture = { 4, 4, 6 } } },
	{ inputs = { genesiberryseed = 1 }, outputs = { tissueculture = { 12, 12, 18 } } },
	{ inputs = { ghostmushroomseed = 1 }, outputs = { geneticmaterial = 4 } },
	{ inputs = { ginsengseed = 1 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { glarestalkseed = 1 }, outputs = { eyepiles = { 10, 10, 13 } } },
	{ inputs = { goldenglowseed = 1 }, outputs = { geneticmaterial = { 5, 5, 8 } } },
	{ inputs = { goldenrootseed = 1 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { goldenseaspongeplant = 1 }, outputs = { tissueculture = { 5, 5, 7 } }, timeScale = { 6.6666666666667, 11.111111111111, 50 } },
	{ inputs = { goldshroomseed = 1 }, outputs = { goldore = { 4, 4, 6 } } },
	{ inputs = { grapesseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { greenleafseed = 1 }, outputs = { geneticmaterial = 5 } },
	{ inputs = { guamseed = 1 }, outputs = { geneticmaterial = { 4, 4, 6 } } },
	{ inputs = { haleflowerseed = 1 }, outputs = { geneticmaterial = { 6, 6, 7 } } },
	{ inputs = { hellfireplantseed = 1 }, outputs = { ammoniumsulfate = { 11, 11, 15 } } },
	{ inputs = { herrodbush = 1 }, outputs = { geneticmaterial = { 2, 2, 5 } } },
	{ inputs = { hopsseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { ighantseed = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { ignuschili2seed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { ignuschiliseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { itaseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { jillyrootseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { kamaranpodsplant = 1 }, outputs = { geneticmaterial = { 4, 4, 8 } }, timeScale = { 6.6666666666667, 11.111111111111, 50 } },
	{ inputs = { kiwiseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { kramil = 1 }, outputs = { geneticmaterial = { 2, 2, 5 } } },
	{ inputs = { lactariusindigoseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { lasherplantseed = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { leafshellseed = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { littlegoodberryseed = 1 }, outputs = { geneticmaterial = { 4, 4, 6 } } },
	{ inputs = { littlerascalseed = 1 }, outputs = { geneticmaterial = { 4, 4, 6 } } },
	{ inputs = { melodistarseed = 1 }, outputs = { geneticmaterial = { 5, 5, 7 } } },
	{ inputs = { minkocoapodseed = 1 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { mintseed = 1 }, outputs = { geneticmaterial = { 4, 4, 5 } } },
	{ inputs = { miraclegrassseed = 1 }, outputs = { geneticmaterial = { 3, 3, 6 } } },
	{ inputs = { mireurchinseed = 1 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { mutaviskseed = 1 }, outputs = { geneticmaterial = { 4, 4, 6 } } },
	{ inputs = { naileryseed = 1 }, outputs = { rawminerals = { 4, 4, 6 } } },
	{ inputs = { neonmelonseed = 1 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { neuropodseed = 1 }, outputs = { tissueculture = { 2, 2, 4 } } },
	{ inputs = { nissseed = 1 }, outputs = { tissueculture = { 4, 4, 6 } } },
	{ inputs = { oculemonseed = 1 }, outputs = { tissueculture = { 3, 3, 4 } } },
	{ inputs = { oonfortaseed = 1 }, outputs = { biospore = { 1, 1, 3 } } },
	{ inputs = { pasakavineseed = 1 }, outputs = { tissueculture = { 1, 1, 3 } } },
	{ inputs = { pearlpeaseed = 1 }, outputs = { geneticmaterial = { 5, 5, 7 } } },
	{ inputs = { pekkitseed = 1 }, outputs = { tissueculture = { 5, 5, 7 }, fu_nitrogen = 2 } },
	{ inputs = { petrifiedrootseed = 1 }, outputs = { geneticmaterial = 6 } },
	{ inputs = { pineappleseed = 1 }, outputs = { geneticmaterial = { 5, 5, 7 } } },
	{ inputs = { pinkloomseed = 1 }, outputs = { geneticmaterial = { 5, 5, 7 } } },
	{ inputs = { poetree = 1 }, outputs = { geneticmaterial = { 2, 2, 5 } } },
	{ inputs = { porphisplantseed = 1 }, outputs = { tissueculture = { 5, 5, 7 } } },
	{ inputs = { potatoseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { pussplumseed = 1 }, outputs = { tissueculture = { 4, 4, 7 } } },
	{ inputs = { quellstem = 1 }, outputs = { geneticmaterial = { 2, 2, 5 } } },
	{ inputs = { reefpodseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { riceseed = 1 }, outputs = { geneticmaterial = { 4, 4, 7 } } },
	{ inputs = { rockrootseed = 1 }, outputs = { rawminerals = { 4, 4, 7 } } },
	{ inputs = { sapling = 1 }, outputs = { tissueculture = { 3, 3, 7 }, fu_oxygen = { 1, 1, 3 } } },
	{ inputs = { shinyacornseed = 1 }, outputs = { tissueculture = { 3, 3, 4 } } },
	{ inputs = { shockshroomseed = 1 }, outputs = { tissueculture = { 8, 8, 11 } } },
	{ inputs = { silverleafseed = 1 }, outputs = { silverore = { 2, 2, 4 } } },
	{ inputs = { slimeplantseed = 1 }, outputs = { greenslime = { 4, 4, 5 } } },
	{ inputs = { springvaultseed = 1 }, outputs = { tissueculture = { 2, 2, 3 } } },
	{ inputs = { stranglevineseed = 1 }, outputs = { tissueculture = { 4, 4, 6 } } },
	{ inputs = { sugarcaneseed = 1 }, outputs = { geneticmaterial = { 4, 4, 6 } } },
	{ inputs = { talonseedseed = 1 }, outputs = { geneticmaterial = { 5, 5, 7 } } },
	{ inputs = { teratomatoseed = 1 }, outputs = { geneticmaterial = { 11, 11, 13 } } },
	{ inputs = { tetherhookseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { thornitoxseed = 1 }, outputs = { geneticmaterial = { 4, 4, 7 } } },
	{ inputs = { tinselbush = 1 }, outputs = { geneticmaterial = { 2, 2, 5 } } },
	{ inputs = { tomatoseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { toxictopseed = 1 }, outputs = { geneticmaterial = { 4, 4, 6 } } },
	{ inputs = { tyvokkseed = 1 }, outputs = { geneticmaterial = { 5, 5, 8 } } },
	{ inputs = { vanusflowerseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { varanberryseed = 1 }, outputs = { geneticmaterial = { 1, 1, 2 } } },
	{ inputs = { vashtaplantseed = 1 }, outputs = { tissueculture = { 6, 6, 7 } } },
	{ inputs = { vextongueseed = 1 }, outputs = { tissueculture = { 2, 2, 4 } } },
	{ inputs = { victorleaf = 1 }, outputs = { geneticmaterial = { 2, 2, 5 } } },
	{ inputs = { voritseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { wartweedseed = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { wheatseed = 1 }, outputs = { tissueculture = { 4, 4, 5 } } },
	{ inputs = { whitespine = 1 }, outputs = { geneticmaterial = { 2, 2, 5 } } },
	{ inputs = { wildalgaeseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { wildaquapodseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { wildautomatoseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { wildavesmingoseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { wildbambooseed = 1 }, outputs = { geneticmaterial = { 2, 2, 4 } }, timeScale = { 1.3333333333333, 2.2222222222222, 10 } },
	{ inputs = { wildbananaseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { wildbeakseedseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { wildbeetlesproutseed = 1 }, outputs = { algaeseed = { 1, 1, 3 } } },
	{ inputs = { wildbiospore = 1 }, outputs = { shroom = { 2, 2, 3 } } },
	{ inputs = { wildbiscornseed = 1 }, outputs = { tissueculture = { 3, 3, 4 } } },
	{ inputs = { wildblexplantseed = 1 }, outputs = { ff_resin = { 2, 2, 3 } } },
	{ inputs = { wildblisterbushplantseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { wildblizzberryseed = 1 }, outputs = { tissueculture = { 2, 2, 4 } } },
	{ inputs = { wildbloodrootseed = 1 }, outputs = { liquidblood = { 4, 4, 5 } } },
	{ inputs = { wildbluemelonseed = 1 }, outputs = { geneticmaterial = { 2, 2, 3 } } },
	{ inputs = { wildboltbulbseed = 1 }, outputs = { coil = { 1, 1, 2 } } },
	{ inputs = { wildbonebooseed = 1 }, outputs = { bone = { 2, 2, 3 } } },
	{ inputs = { wildbrackentreeseed = 1 }, outputs = { silk = { 4, 4, 5 } } },
	{ inputs = { wildcaprioleplantseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { wildcarrotseed = 1 }, outputs = { cellmateria = { 2, 2, 3 } } },
	{ inputs = { wildcellpodsplant = 1 }, outputs = { geneticmaterial = { 5, 5, 7 } } },
	{ inputs = { wildchiliseed = 1 }, outputs = { tissueculture = { 3, 3, 4 } } },
	{ inputs = { wildcocoaseed = 1 }, outputs = { tissueculture = { 1, 2, 3 } } },
	{ inputs = { wildcoffeeseed = 1 }, outputs = { geneticmaterial = { 4, 4, 5 } } },
	{ inputs = { wildcoralcreepseed = 1 }, outputs = { geneticmaterial = { 5, 5, 6 } } },
	{ inputs = { wildcornseed = 1 }, outputs = { geneticmaterial = { 1, 1, 2 } } },
	{ inputs = { wildcorvexseed = 1 }, outputs = { corvex = { 1, 1, 2 } } },
	{ inputs = { wildcrystalplantseed = 1 }, outputs = { crystal = { 1, 1, 2 } } },
	{ inputs = { wildcurrentcornseed = 1 }, outputs = { ff_silicon = { 1, 1, 2 } } },
	{ inputs = { wilddeathblossomseed = 1 }, outputs = { biospore = { 4, 4, 5 } } },
	{ inputs = { wilddiodiahybridseed = 1 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { wilddiodiaseed = 1 }, outputs = { geneticmaterial = { 1, 1, 3 } } },
	{ inputs = { wilddirturchinseed = 1 }, outputs = { geneticmaterial = { 1, 1, 4 } } },
	{ inputs = { wilddragonsbeardseed = 1 }, outputs = { ammoniumsulfate = { 1, 1, 2 } } },
	{ inputs = { wildeggshootseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { wildenergiflowerseed = 1 }, outputs = { plantfibre = { 8, 8, 12 } } },
	{ inputs = { wilderithianalgaeseed = 1 }, outputs = { algaeseed = { 1, 1, 3 } } },
	{ inputs = { wildfayshroomseed = 1 }, outputs = { geneticmaterial = 4 } },
	{ inputs = { wildfeathercrownseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { wildfloralytplantseed = 1 }, outputs = { geneticmaterial = { 13, 13, 18 } } },
	{ inputs = { wildflowerblueseed = 1 }, outputs = { geneticmaterial = { 1, 1, 3 } } },
	{ inputs = { wildflowerredseed = 1 }, outputs = { geneticmaterial = { 1, 1, 3 } } },
	{ inputs = { wildfloweryellowseed = 1 }, outputs = { geneticmaterial = { 1, 1, 3 } } },
	{ inputs = { wildfubioshroomblue = 1 }, outputs = { biospore = { 3, 3, 5 } } },
	{ inputs = { wildfubioshroomgreen = 1 }, outputs = { biospore = { 3, 3, 5 } } },
	{ inputs = { wildfubioshroompurple = 1 }, outputs = { biospore = { 3, 3, 5 } } },
	{ inputs = { wildfubioshroomred = 1 }, outputs = { biospore = { 3, 3, 5 } } },
	{ inputs = { wildfubioshroomyellow = 1 }, outputs = { biospore = { 3, 3, 5 } } },
	{ inputs = { wildfusnowberryseed = 1 }, outputs = { tissueculture = { 6, 6, 8 } } },
	{ inputs = { wildgazelemonseed = 1 }, outputs = { tissueculture = { 4, 4, 6 } } },
	{ inputs = { wildgenesiberryseed = 1 }, outputs = { tissueculture = { 12, 12, 18 } } },
	{ inputs = { wildghostmushroomseed = 1 }, outputs = { geneticmaterial = 4 } },
	{ inputs = { wildginsengseed = 1 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { wildglarestalkseed = 1 }, outputs = { eyepiles = { 10, 10, 13 } } },
	{ inputs = { wildgoldenglowseed = 1 }, outputs = { geneticmaterial = { 5, 5, 8 } } },
	{ inputs = { wildgoldenrootseed = 1 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { wildgoldenseaspongeplant = 1 }, outputs = { tissueculture = { 5, 5, 7 } } },
	{ inputs = { wildgoldshroomseed = 1 }, outputs = { goldore = { 4, 4, 6 } } },
	{ inputs = { wildgrapesseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { wildgreenleafseed = 1 }, outputs = { geneticmaterial = 5 } },
	{ inputs = { wildguamseed = 1 }, outputs = { geneticmaterial = { 4, 4, 6 } } },
	{ inputs = { wildhaleflowerseed = 1 }, outputs = { geneticmaterial = { 6, 6, 7 } } },
	{ inputs = { wildhellfireplantseed = 1 }, outputs = { ammoniumsulfate = { 11, 11, 15 } } },
	{ inputs = { wildhopsseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { wildighantseed = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { wildignuschili2seed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { wildignuschiliseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { wilditaseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { wildjillyrootseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { wildkamaranpodsplant = 1 }, outputs = { geneticmaterial = { 4, 4, 8 } } },
	{ inputs = { wildkiwiseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { wildlactariusindigoseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { wildlasherplantseed = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { wildleafshellseed = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { wildlittlegoodberryseed = 1 }, outputs = { geneticmaterial = { 4, 4, 6 } } },
	{ inputs = { wildlittlerascalseed = 1 }, outputs = { geneticmaterial = { 4, 4, 6 } } },
	{ inputs = { wildmelodistarseed = 1 }, outputs = { geneticmaterial = { 5, 5, 7 } } },
	{ inputs = { wildminkocoapodseed = 1 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { wildmintseed = 1 }, outputs = { geneticmaterial = { 4, 4, 5 } } },
	{ inputs = { wildmiraclegrassseed = 1 }, outputs = { geneticmaterial = { 3, 3, 6 } } },
	{ inputs = { wildmireurchinseed = 1 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { wildmutaviskseed = 1 }, outputs = { geneticmaterial = { 4, 4, 6 } } },
	{ inputs = { wildnaileryseed = 1 }, outputs = { rawminerals = { 4, 4, 6 } } },
	{ inputs = { wildneonmelonseed = 1 }, outputs = { geneticmaterial = { 2, 2, 4 } } },
	{ inputs = { wildneuropodseed = 1 }, outputs = { tissueculture = { 2, 2, 4 } } },
	{ inputs = { wildnissseed = 1 }, outputs = { tissueculture = { 4, 4, 6 } } },
	{ inputs = { wildoculemonseed = 1 }, outputs = { tissueculture = { 3, 3, 4 } } },
	{ inputs = { wildoonfortaseed = 1 }, outputs = { biospore = { 1, 1, 3 } } },
	{ inputs = { wildpasakavineseed = 1 }, outputs = { tissueculture = { 1, 1, 3 } } },
	{ inputs = { wildpearlpeaseed = 1 }, outputs = { geneticmaterial = { 5, 5, 7 } } },
	{ inputs = { wildpekkitseed = 1 }, outputs = { tissueculture = { 5, 5, 7 } } },
	{ inputs = { wildpetrifiedrootseed = 1 }, outputs = { geneticmaterial = 6 } },
	{ inputs = { wildpineappleseed = 1 }, outputs = { geneticmaterial = { 5, 5, 7 } } },
	{ inputs = { wildpinkloomseed = 1 }, outputs = { geneticmaterial = { 5, 5, 7 } } },
	{ inputs = { wildporphisplantseed = 1 }, outputs = { tissueculture = { 5, 5, 7 } } },
	{ inputs = { wildpotatoseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { wildpussplumseed = 1 }, outputs = { tissueculture = { 4, 4, 7 } } },
	{ inputs = { wildreefpodseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { wildriceseed = 1 }, outputs = { geneticmaterial = { 4, 4, 7 } } },
	{ inputs = { wildrockrootseed = 1 }, outputs = { rawminerals = { 4, 4, 7 } } },
	{ inputs = { wildshinyacornseed = 1 }, outputs = { tissueculture = { 3, 3, 4 } } },
	{ inputs = { wildshockshroomseed = 1 }, outputs = { tissueculture = { 8, 8, 11 } } },
	{ inputs = { wildsilverleafseed = 1 }, outputs = { silverore = { 2, 2, 4 } } },
	{ inputs = { wildslimeplantseed = 1 }, outputs = { greenslime = { 4, 4, 5 } } },
	{ inputs = { wildspongeweedseed = 1 }, outputs = { geneticmaterial = { 4, 4, 7 } } },
	{ inputs = { wildspringvaultseed = 1 }, outputs = { tissueculture = { 2, 2, 3 } } },
	{ inputs = { wildstranglevineseed = 1 }, outputs = { tissueculture = { 4, 4, 6 } } },
	{ inputs = { wildsugarcaneseed = 1 }, outputs = { geneticmaterial = { 4, 4, 6 } } },
	{ inputs = { wildtalonseedseed = 1 }, outputs = { geneticmaterial = { 5, 5, 7 } } },
	{ inputs = { wildteratomatoseed = 1 }, outputs = { geneticmaterial = { 11, 11, 13 } } },
	{ inputs = { wildtetherhookseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { wildthornitoxseed = 1 }, outputs = { geneticmaterial = { 4, 4, 7 } } },
	{ inputs = { wildtomatoseed = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { wildtoxictopseed = 1 }, outputs = { geneticmaterial = { 4, 4, 6 } } },
	{ inputs = { wildtyvokkseed = 1 }, outputs = { geneticmaterial = { 5, 5, 8 } } },
	{ inputs = { wildvanusflowerseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { wildvaranberryseed = 1 }, outputs = { geneticmaterial = { 1, 1, 2 } } },
	{ inputs = { wildvashtaplantseed = 1 }, outputs = { tissueculture = { 6, 6, 7 } } },
	{ inputs = { wildvextongueseed = 1 }, outputs = { tissueculture = { 2, 2, 4 } } },
	{ inputs = { wildvoritseed = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { wildwartweedseed = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { wildwheatseed = 1 }, outputs = { tissueculture = { 4, 4, 5 } } },
	{ inputs = { wildwretchelseed = 1 }, outputs = { tissueculture = { 9, 9, 11 } } },
	{ inputs = { wildwubstemseed = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { wildxaxseed = 1 }, outputs = { tissueculture = { 5, 5, 7 } } },
	{ inputs = { wildyellowfootseed = 1 }, outputs = { tissueculture = { 4, 4, 7 } } },
	{ inputs = { wildzathiseed = 1 }, outputs = { geneticmaterial = { 8, 8, 9 } } },
	{ inputs = { wretchelseed = 1 }, outputs = { tissueculture = { 9, 9, 11 } } },
	{ inputs = { wubstemseed = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { xaxseed = 1 }, outputs = { tissueculture = { 5, 5, 7 } } },
	{ inputs = { yellowfootseed = 1 }, outputs = { tissueculture = { 4, 4, 7 } } },
	{ inputs = { zathiseed = 1 }, outputs = { geneticmaterial = { 8, 8, 9 } } },
	-- from FU
	{ inputs = { aenemapetal = 1 }, outputs = { shadowgasliquid = 1 } },
	{ inputs = { aquapod = 1 }, outputs = { tissueculture = { 3, 3, 6 } } },
	{ inputs = { arkaendart = 1 }, outputs = { tissueculture = { 4, 4, 8 } } },
	{ inputs = { batterystemcharge = 1 }, outputs = { tissueculture = { 4, 4, 8 } } },
	{ inputs = { beetlesproutflower = 1 }, outputs = { tissueculture = { 4, 4, 6 } } },
	{ inputs = { bellamortecore = 1 }, outputs = { tissueculture = { 4, 4, 8 } } },
	{ inputs = { biscorn = 1 }, outputs = { tissueculture = { 5, 5, 9 } } },
	{ inputs = { bladetreeblade = 1 }, outputs = { tissueculture = { 4, 4, 8 } } },
	{ inputs = { blexsap = 1 }, outputs = { tissueculture = { 3, 3, 6 } } },
	{ inputs = { blisterbushplantfood = 1 }, outputs = { tissueculture = { 1, 1, 3 } } },
	{ inputs = { blizzberry = 1 }, outputs = { tissueculture = { 2, 2, 5 } } },
	{ inputs = { bloodroot = 1 }, outputs = { tissueculture = { 3, 3, 6 } } },
	{ inputs = { bluemelon = 1 }, outputs = { tissueculture = { 3, 3, 6 } } },
	{ inputs = { capriole = 1 }, outputs = { tissueculture = { 4, 4, 8 } } },
	{ inputs = { carcass1 = 1 }, outputs = { tissueculture = { 12, 12, 24 }, geneticmaterial = { 12, 12, 24 } } },
	{ inputs = { carcass2 = 1 }, outputs = { tissueculture = { 12, 12, 24 }, geneticmaterial = { 12, 12, 24 } } },
	{ inputs = { cellpods = 1 }, outputs = { tissueculture = { 5, 5, 10 } }, timeScale = { 6.6666666666667, 11.111111111111, 50 } },
	{ inputs = { cinnamon = 1 }, outputs = { geneticmaterial = 2 } },
	{ inputs = { cotton = 1 }, outputs = { geneticmaterial = 2 } },
	{ inputs = { crystalliteshard = 1 }, outputs = { tissueculture = { 4, 4, 8 } } },
	{ inputs = { darklightblossom = 1 }, outputs = { tissueculture = { 4, 4, 8 } } },
	{ inputs = { diodiahybrid = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { dragonsbeard = 1 }, outputs = { tissueculture = { 7, 7, 9 } } },
	{ inputs = { energiflower = 1 }, outputs = { tissueculture = { 2, 2, 5 } } },
	{ inputs = { erithianalgae = 1 }, outputs = { tissueculture = { 4, 4, 10 } } },
	{ inputs = { fayshroom = 1 }, outputs = { tissueculture = { 3, 3, 6 } } },
	{ inputs = { fletchweedstem = 1 }, outputs = { tissueculture = { 4, 4, 8 } } },
	{ inputs = { floralytcandy = 1 }, outputs = { tissueculture = { 3, 3, 6 } } },
	{ inputs = { fusnowberry = 1 }, outputs = { tissueculture = { 6, 6, 10 } }, timeScale = { 6.6666666666667, 11.111111111111, 50 } },
	{ inputs = { fuspongeweed = 1 }, outputs = { tissueculture = { 4, 4, 10 } }, timeScale = { 6.6666666666667, 11.111111111111, 50 } },
	{ inputs = { garikleafblossom = 1 }, outputs = { tissueculture = { 4, 4, 8 } } },
	{ inputs = { gazelemon = 1 }, outputs = { tissueculture = { 4, 4, 6 } } },
	{ inputs = { genesiberry = 1 }, outputs = { tissueculture = { 12, 12, 16 } } },
	{ inputs = { ghostmushroom = 1 }, outputs = { tissueculture = { 6, 6, 12 } } },
	{ inputs = { ginseng = 1 }, outputs = { tissueculture = { 6, 6, 9 } } },
	{ inputs = { glarestalkeye = 1 }, outputs = { geneticmaterial = { 12, 12, 22 } } },
	{ inputs = { goldenglowleaf = 1 }, outputs = { tissueculture = { 7, 7, 12 } } },
	{ inputs = { goldenroot = 1 }, outputs = { tissueculture = { 7, 7, 12 } } },
	{ inputs = { goldenseasponge = 1 }, outputs = { tissueculture = { 5, 5, 10 } }, timeScale = { 6.6666666666667, 11.111111111111, 50 } },
	{ inputs = { goldshroom = 1 }, outputs = { tissueculture = { 7, 7, 12 } } },
	{ inputs = { greenleaf = 1 }, outputs = { tissueculture = { 5, 5, 12 } } },
	{ inputs = { guam = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { haleflowerpetal = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { herrodbushgem = 1 }, outputs = { tissueculture = { 4, 4, 8 } } },
	{ inputs = { hops = 1 }, outputs = { geneticmaterial = 2 } },
	{ inputs = { ighantbulb = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { itahead = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { jillyroot = 1 }, outputs = { tissueculture = { 7, 7, 10 } } },
	{ inputs = { kamaranpods = 1 }, outputs = { tissueculture = { 4, 4, 10 } }, timeScale = { 6.6666666666667, 11.111111111111, 50 } },
	{ inputs = { kramilspine = 1 }, outputs = { tissueculture = { 4, 4, 8 } } },
	{ inputs = { lactariusindigo = 1 }, outputs = { tissueculture = { 6, 6, 10 } } },
	{ inputs = { lasherstem = 1 }, outputs = { tissueculture = { 6, 6, 10 } } },
	{ inputs = { leafshell = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { littlegoodberry = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { littlerascal = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { melodistar = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { minkocoapod = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { mint = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { miraclegrass = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { mireurchin = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { nailery = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { neuropod = 1 }, outputs = { tissueculture = { 7, 7, 10 } } },
	{ inputs = { nisscap = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { nyanifruit = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { onion = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { pasaka = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { peach = 1 }, outputs = { tissueculture = { 4, 4, 10 } }, timeScale = { 6.6666666666667, 11.111111111111, 50 } },
	{ inputs = { pear = 1 }, outputs = { tissueculture = { 4, 4, 10 } }, timeScale = { 6.6666666666667, 11.111111111111, 50 } },
	{ inputs = { pearlfruit = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { pekkit = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { petrifiedroot = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { pinkloom = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { porphisblossom = 1 }, outputs = { tissueculture = { 1, 1, 4 } } },
	{ inputs = { quellstembud = 1 }, outputs = { tissueculture = { 4, 4, 8 } } },
	{ inputs = { raptoregg = 1 }, outputs = { geneticmaterial = { 6, 6, 12 } } },
	{ inputs = { rockroot = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { shinyacorn = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { silverleaf = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { slimeleaf = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { springvaultcoil = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { stranglevineroot = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { talonseed = 1 }, outputs = { tissueculture = { 4, 4, 10 } } },
	{ inputs = { tearnut = 1 }, outputs = { tissueculture = { 6, 6, 10 } } },
	{ inputs = { teratomato = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { tetherhookwheel = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { thornitox = 1 }, outputs = { tissueculture = { 3, 3, 10 } } },
	{ inputs = { tinselbushsprout = 1 }, outputs = { tissueculture = { 4, 4, 8 } } },
	{ inputs = { toxicflower = 1 }, outputs = { tissueculture = { 4, 4, 10 } } },
	{ inputs = { tyvokkhook = 1 }, outputs = { tissueculture = { 3, 3, 10 } } },
	{ inputs = { vanusflower = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { varanberry = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { vashtaclaw = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { vextonguestamen = 1 }, outputs = { tissueculture = { 4, 4, 10 } } },
	{ inputs = { victorleafbud = 1 }, outputs = { tissueculture = { 4, 4, 8 } } },
	{ inputs = { voritcap = 1 }, outputs = { tissueculture = { 3, 3, 10 } } },
	{ inputs = { whitespineshell = 1 }, outputs = { tissueculture = { 4, 4, 8 } } },
	{ inputs = { wretchel = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { wubstem = 1 }, outputs = { tissueculture = { 4, 4, 10 } } },
	{ inputs = { xaxwing = 1 }, outputs = { tissueculture = { 4, 4, 10 } } },
	{ inputs = { yellowfoot = 1 }, outputs = { tissueculture = { 5, 5, 10 } } },
	{ inputs = { zathitails = 1 }, outputs = { tissueculture = { 6, 6, 10 } } },
	-- from vanilla
	{ inputs = { alienfruit = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { alienmeat = 1 }, outputs = { geneticmaterial = { 5, 5, 8 } } },
	{ inputs = { boltbulb = 1 }, outputs = { rawminerals = 3 } },
	{ inputs = { cacti = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { carrot = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { chili = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { coconut = 1 }, outputs = { tissueculture = { 4, 4, 7 } } },
	{ inputs = { coffeebeans = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { cookedalienmeat = 1 }, outputs = { geneticmaterial = { 3, 3, 6 } } },
	{ inputs = { cookedbacon = 1 }, outputs = { geneticmaterial = { 3, 3, 6 } } },
	{ inputs = { cookedfish = 1 }, outputs = { geneticmaterial = { 3, 3, 6 } } },
	{ inputs = { cookedfleshlump = 1 }, outputs = { geneticmaterial = { 3, 3, 6 } } },
	{ inputs = { cookedham = 1 }, outputs = { geneticmaterial = { 3, 3, 6 } } },
	{ inputs = { cookedpoultry = 1 }, outputs = { geneticmaterial = { 3, 3, 6 } } },
	{ inputs = { cookedribmeat = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { cookedtentacle = 1 }, outputs = { geneticmaterial = { 3, 3, 5 } } },
	{ inputs = { coralcreep = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { corn = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { crystalplant = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { currentcorn = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { diodia = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { dirturchin = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { eggshoot = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { feathercrown = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { grapes = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { greenapple = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { hivebomb = 1 }, outputs = { tissueculture = { 5, 5, 8 } } },
	{ inputs = { kelp = 12 }, outputs = { iodine = { 1, 1, 3 } } },
	{ inputs = { kiwi = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { meatchunks = 1 }, outputs = { geneticmaterial = { 4, 4, 5 } } },
	{ inputs = { neonmelon = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { oculemon = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { offal = 1 }, outputs = { geneticmaterial = { 4, 4, 5 } } },
	{ inputs = { orange = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { pearlpea = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { pineapple = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { plantfibre = 50 }, outputs = { tissueculture = { 2, 2, 5 } } },
	{ inputs = { potato = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { pussplum = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { rawbacon = 1 }, outputs = { geneticmaterial = { 1, 1, 5 } } },
	{ inputs = { rawfish = 1 }, outputs = { geneticmaterial = 5 } },
	{ inputs = { rawfleshlump = 1 }, outputs = { geneticmaterial = { 5, 5, 8 } } },
	{ inputs = { rawpoultry = 1 }, outputs = { geneticmaterial = { 3, 3, 4 } } },
	{ inputs = { rawribmeat = 1 }, outputs = { geneticmaterial = { 5, 5, 8 } } },
	{ inputs = { rawtentacle = 1 }, outputs = { geneticmaterial = { 5, 5, 8 } } },
	{ inputs = { redapple = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { reefpod = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { rice = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { shroom = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { soylentgreen = 1 }, outputs = { geneticmaterial = { 5, 5, 8 } } },
	{ inputs = { sugar = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { thornfruit = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { tomato = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { toxictop = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { wartweed = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { wheat = 1 }, outputs = { tissueculture = { 3, 3, 5 } } },
	{ inputs = { wildvines = 1 }, outputs = { tissueculture = { 4, 4, 7 } } },
	-- vanilla ores
	{ inputs = { aegisaltore = 1 }, outputs = { rawminerals = { 7, 7, 9 } } },
	{ inputs = { coalore = { 10, 10, 5 } }, outputs = { fu_carbon = 1 } },
	{ inputs = { copperore = 1 }, outputs = { rawminerals = { 4, 4, 6 } } },
	{ inputs = { corefragmentore = 2 }, outputs = { volatilepowder = { 1, 1, 2 }, ammoniumsulfate = { 1, 1, 2 } } },
	{ inputs = { diamond = 1 }, outputs = { fu_carbon = { 8, 8, 11 } } },
	{ inputs = { feroziumore = 1 }, outputs = { rawminerals = { 7, 7, 8 } } },
	{ inputs = { goldore = 1 }, outputs = { rawminerals = { 6, 6, 8 } } },
	{ inputs = { ironore = 1 }, outputs = { liquidironfu = { 2, 2, 4 } }, timeScale = { 1.3333333333333, 2.2222222222222 } },
	{ inputs = { lead = 1 }, outputs = { rawminerals = { 4, 4, 7 } } },
	{ inputs = { moonstoneore = 1 }, outputs = { rawminerals = { 4, 4, 8 } } },
	{ inputs = { platinumore = 1 }, outputs = { rawminerals = { 7, 7, 9 } } },
	{ inputs = { plutoniumore = 1 }, outputs = { matteritem = { 4, 4, 6 } } },
	{ inputs = { prisiliteore = 1 }, outputs = { rawminerals = { 8, 8, 10 } } },
	{ inputs = { silverore = 1 }, outputs = { rawminerals = { 5, 5, 8 } } },
	{ inputs = { solariumore = 1 }, outputs = { rawminerals = { 4, 4, 8 } } },
	{ inputs = { sulphur = 1 }, outputs = { liquidsulphuricacid = { 2, 2, 4 } }, timeScale = { 1.3333333333333, 2.2222222222222 } },
	{ inputs = { titaniumore = 1 }, outputs = { rawminerals = { 7, 7, 9 } } },
	{ inputs = { triangliumore = 1 }, outputs = { rawminerals = { 4, 4, 8 } } },
	{ inputs = { uraniumore = 1 }, outputs = { matteritem = { 4, 4, 7 } } },
	{ inputs = { violiumore = 1 }, outputs = { rawminerals = { 7, 7, 9 } } },
	-- fu ores
	{ inputs = { berliniteore = 4 }, outputs = { phosphorus = { 1, 1, 3 } } },
	{ inputs = { cinnabarore = 4 }, outputs = { rawminerals = { 8, 8, 10 } }, timeScale = { 2.4, 4 } },
	{ inputs = { corruptionore = 4 }, outputs = { rawminerals = { 5, 5, 7 } }, timeScale = { 2.5333333333333, 4.2222222222222 } },
	{ inputs = { densiniumore = 4 }, outputs = { rawminerals = { 12, 12, 24 } } },
	{ inputs = { irradiumore = 4 }, outputs = { rawminerals = { 4, 4, 5 } } },
	{ inputs = { lazuliteore = 4 }, outputs = { phosphorus = { 1, 1, 2 } } },
	{ inputs = { magnesiumore = 4 }, outputs = { magnesiumpowder = { 1, 1, 2 } } },
	{ inputs = { mascagniteore = 4 }, outputs = { ammoniumsulfate = { 1, 1, 2 } } },
	{ inputs = { matteritem = 50 }, outputs = { unstableparticles = { 1, 1, 2 } }, timeScale = { 2.2, 3.6666666666667 } },
	{ inputs = { penumbriteore = 4 }, outputs = { rawminerals = { 9, 9, 10 } } },
	{ inputs = { protociteore = 4 }, outputs = { rawminerals = { 9, 9, 10 } }, timeScale = { 2.2666666666667, 3.7777777777778 } },
	{ inputs = { rawminerals = 4 }, outputs = { lead = { 1, 1, 2 } }, timeScale = { 2.2 } },
	{ inputs = { solaricrystal = 1 }, outputs = { solarishard = { 2, 2, 3 } } },
	{ inputs = { solarishard = 20 }, outputs = { crystal = { 1, 1, 2 } }, timeScale = { 2.1333333333333, 3.5555555555556 } },
	{ inputs = { zerchesiumore = 4 }, outputs = { fu_carbon = { 4, 4, 12 } }, timeScale = { 2.2, 3.6666666666667 } },
}

function init(args)
	if args then return end
	self.mintick = config.getParameter("fu_mintick", 1)
	self.timer = self.timer or self.mintick
	self.crafting = false
	self.output = nil
	self.light = config.getParameter("lightColor")

	self.techLevel = config.getParameter("fu_extractorTechLevel", 1)

	storage.activeConsumption = false
	if self.light then
		object.setLightColor({0, 0, 0, 0})
	end

	-- generate reversed recipes here to avoid complicating the other code
	local reversed = {}
	for _, recipe in pairs(recipes) do
		if recipe.reversible then
			recipe.reversible = nil -- unmark it :-)
			table.insert(reversed, { inputs = recipe.outputs, outputs = recipe.inputs, timeScale = recipe.timeScale })
		end
	end
	for _, recipe in pairs(reversed) do
		table.insert(recipes, recipe)
	end
end

function techlevelMap(v)
	-- if the input is a table, do a lookup using the extractor tech level
	if type(v) == "table" then return v[self.techLevel] end
	return v
end

function getInputContents()
	local id = entity.id()
	local contents = {}
	for i = 0, 2 do
		local stack = world.containerItemAt(entity.id(),i)
		if stack then
			contents[stack.name] = (contents[stack.name] or 0) + stack.count
		end
	end
	return contents
end

function map(list, func)
	local res = {}
	for k,v in pairs(list) do
		res[k] = func(v)
	end
	return res
end

function filter(list, func)
	return map(list, function(e) return func(e) and e or nil end)
end

function getValidRecipes(query)
	local function subset(inputs, query)
		if next(query) == nil then return false end
		if inputs == query then return true end
		local validRecipe = false
		for k, _ in pairs(inputs) do
			local required = techlevelMap(inputs[k])
			if required then
				validRecipe = true
				if required > (query[k] or 0) then return false end
			end
		end
		return validRecipe
	end

	return filter(recipes, function(l) return subset(l.inputs, query) end)
end

function getOutSlotsFor(something)
	-- TODO: use world.containerItemsFitWhere? Seems not too useful
	local empty = {} -- empty slots in the outputs
	local slots = {} -- slots with a stack of "something"

	for i = 3, 11 do -- iterate all output slots
		local stack = world.containerItemAt(entity.id(), i) -- get the stack on i
		if stack then -- not empty
			if stack.name == something then -- its "something"
				table.insert(slots,i) -- possible drop slot
			end
		else -- empty
			table.insert(empty, i)
		end
	end

	for _, e in pairs(empty) do -- add empty slots to the end
		table.insert(slots,e)
	end
	return slots
end

function update(dt)
	if not self.mintick then init() end

	if config.getParameter("isn_requiredPower") and isn_hasRequiredPower() == false then
		animator.setAnimationState("samplingarrayanim", "idle")
		if self.light then
			object.setLightColor({0, 0, 0, 0})
		end
		storage.activeConsumption = false
		return
	end

	self.timer = self.timer - dt
	if self.timer <= 0 then
		if self.output then
			for k,v in pairs(self.output) do
				local leftover = {name = k, count = techlevelMap(v)}
				local slots = getOutSlotsFor(k)
				for _, i in pairs(slots) do
					leftover = world.containerPutItemsAt(entity.id(), leftover, i)
					if leftover == nil then
						break
					end
				end

				if leftover then
					world.spawnItem(leftover.name, entity.position(), leftover.count)
				end
			end

			self.output = nil
			self.timer = self.mintick --reset timer to a safe minimum
		else
			if not startCrafting(getValidRecipes(getInputContents())) then
				--set timeout and indicate not crafting if there were no recipes
				animator.setAnimationState("samplingarrayanim", "idle")
				if self.light then
					object.setLightColor({0, 0, 0, 0})
				end
				self.timer = self.mintick
				storage.activeConsumption = false
			end
		end
	end
end

function startCrafting(result)
	if next(result) == nil then
		return false
	else
		_, result = next(result)

		for k, v in pairs(result.inputs) do
			-- if we ever do multiple inputs, FIXME undo partial consumption on failure
			if not world.containerConsume(entity.id(), {item = k , count = techlevelMap(v)}) then
				return false
			end
		end

		self.timer = (techlevelMap(result.timeScale) or 1) * timers[self.techLevel]
		self.output = result.outputs
		animator.setAnimationState("samplingarrayanim", "working")
		if self.light then
			object.setLightColor(self.light)
		end

		storage.activeConsumption = true
		return true
	end			  
end

--[[	Validation code - run only from a command shell

		require "extractionlab_common.lua"
		validateRecipes()

	Example test data, if not using live recipes:
	{ inputs = { a = 1 }, outputs = { b = 1 } }, -- loop
	{ inputs = { b = 1 }, outputs = { c = 1 } }, -- loop
	{ inputs = { c = 1 }, outputs = { a = 1 } }, -- loop
	{ inputs = { d = 1 }, outputs = { e = 1 } }, -- reversible
	{ inputs = { e = 1 }, outputs = { d = 1 } }, -- reversible
	{ inputs = { f = 1 }, outputs = { g = 2 } }, -- mismatch
	{ inputs = { g = 1 }, outputs = { f = 2 } }, -- mismatch
	{ inputs = { h = 1 }, outputs = { i = i } } -- control
]]
function validateRecipes(testData)
	testData = testData or recipes

	local printfunc = sb and sb.logWarn or print

	local ikeys = {}
	local okeys = {}
	local pair = {}

	for i = 1, table.getn(testData) do
		ikeys[i] = {}
		okeys[i] = {}
		for key, _ in pairs(testData[i].inputs) do
			table.insert(ikeys[i], key)
		end
		for key, _ in pairs(testData[i].outputs) do
			table.insert(okeys[i], key)
		end
	end

	-- http://stackoverflow.com/questions/25922437/how-can-i-deep-compare-2-lua-tables-which-may-or-may-not-have-tables-as-keys
	local table_eq
	table_eq = function(table1, table2)
		local avoid_loops = {}
		local function recurse(t1, t2)
			-- compare value types
			if type(t1) ~= type(t2) then return false end
			-- Base case: compare simple values
			if type(t1) ~= "table" then return t1 == t2 end
			-- Now, on to tables.
			-- First, let's avoid looping forever.
			if avoid_loops[t1] then return avoid_loops[t1] == t2 end
			avoid_loops[t1] = t2
			-- Copy keys from t2
			local t2keys = {}
			local t2tablekeys = {}
			for k, _ in pairs(t2) do
				if type(k) == "table" then table.insert(t2tablekeys, k) end
				t2keys[k] = true
			end
			-- Let's iterate keys from t1
			for k1, v1 in pairs(t1) do
				local v2 = t2[k1]
				if type(k1) == "table" then
					-- if key is a table, we need to find an equivalent one.
					local ok = false
					for i, tk in ipairs(t2tablekeys) do
						if table_eq(k1, tk) and recurse(v1, t2[tk]) then
							table.remove(t2tablekeys, i)
							t2keys[tk] = nil
							ok = true
							break
						end
					end
					if not ok then return false end
				else
					-- t1 has a key which t2 doesn't have, fail.
					if v2 == nil then return false end
					t2keys[k1] = nil
					if not recurse(v1, v2) then return false end
				end
			end
			-- if t2 has a key which t1 doesn't have, fail.
			if next(t2keys) then return false end
			return true
		end
		return recurse(table1, table2)
	end

	local containsAll = function (full, partial)
		local fullmatch = true
		for _, i in pairs(partial) do
			local match = false
			for _, j in pairs(full) do
				if i == j then match = true break end
			end
			if not match then fullmatch = false end
		end
		return fullmatch
	end

	local containsAny = function(full, partial)
		for _, i in pairs(partial) do
			for _, j in pairs(full) do
				if i == j then return true end
			end
		end
		return false
	end

	local dumpChain = function(chain)
		local ret = ''
		for _,v in ipairs(chain) do
			ret = ret .. ' ' .. ikeys[v][1]
		end
		return ret
	end

	local huntOutput
	huntOutput = function(chain)
		local last = chain[table.getn(chain)]
		for i = 1, table.getn(testData) do
			if i ~= last and containsAny(ikeys[i], okeys[last]) then
				if --[[containsAny(chain, {i})]] i == chain[1] then
					printfunc("chain loop:" .. dumpChain(chain))
				elseif not containsAny(chain, {i}) then
					table.insert(chain, i)
					huntOutput(chain)
					table.remove(chain, table.getn(chain))
				end
			end
		end
	end

	for i = 1, table.getn(testData) - 1 do
		for j = i + 1, table.getn(testData) do
			if containsAll(ikeys[i], okeys[j]) and containsAll(okeys[i], ikeys[j]) then
				if table_eq(testData[i].inputs, testData[j].outputs) and table_eq(testData[i].outputs, testData[j].inputs) then
					printfunc(string.format("reversible: %s <-> %s", ikeys[i][1], ikeys[j][1]))
					pair[i] = true
					pair[j] = true
				else
					printfunc(string.format("mismatched pair: %s <-> %s", ikeys[i][1], ikeys[j][1]))
					pair[i] = true
					pair[j] = true
				end
			end
		end

		if not pair[i] then huntOutput({i}) end
	end
	huntOutput({table.getn(testData)}) -- last entry
end
