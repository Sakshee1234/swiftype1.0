import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../firebaseservices.dart';
import '../model/word_dic.dart';
  
List<String> _suggestions = [
  "abacus", "abalone", "abandon", "abdomen", "ability", "abnormal", "abolish", "abortion", 
  "abound", "abrasive", "abrupt", "absence", "absolute", "absorb", "abstain", "abstract", "absurd", "abuse", 
  "academy", "accelerate", "accent", "accept", "access", "accident", "acclaim", "accompany", "accomplish", "accord", 
  "account", "accumulate", "accuracy", "accuse", "ace", "achieve", "acid", "acknowledge", "acoustic", "acquire", "acre", 
  "acrobat", "across", "act", "action", "activate", "active", "actor", "actress", "actual", "acute", "ad", "adapt", "add", "addict", 
  "address", "adequate", "adhere", "adhesive", "adjacent", "adjective", "adjust", "admire", "admission", "admit", 
  "adoption", "adore", "adult", "advance", "adventure", "adverb", "adversary", "adverse", "advertise", "advice", "advise", 
  "advocate", "aerial", "aerosol", "affair", "affect", "affiliate", "affinity", "affirm", "affix", "afflict", 
  "affluent", "afford", "afraid", "Africa", "after", "again", "against", "age", "agency", "agenda", "agent", 
  "aggravate", "aggregate", "agile", "agitate", "ago", "agree", "agriculture", "ahead", "aid", "ailment", "aim", "air", 
  "aircraft", "airline", "airmail", "airport", "aisle", "alarm", "album", "alcohol", "alert", "alien", "alight", "align", "alike", 
  "alive", "all", "alley", "alliance", "allocate", "allow", "alloy", "ally", "almost","alone", "along", "alphabet", "already", 
  "also", "alter", "although", "altitude", "altogether", "always", "amateur", "amaze", "ambassador", "amber", "ambiguity", 
  "ambition", "ambulance", "amend", "amenity", "amid", "ammunition", "amount", "amphibian", "amplify", "amuse", 
  "analogy", "analysis", "analyze", "ancestor", "anchor", "ancient", "and", "anecdote", "angel", "anger", "angle", 
  "angry", "animal", "ankle", "anniversary", "announce", "annoy", "annual", "another", "answer", "ant", "antenna", 
  "anthem", "anticipate", "antique", "anxiety", "any", "anybody", "anyhow", "anymore", "anyone", "anything", "anyway", "anywhere",
  
  "baby", "back", "bacon", "bad", "badge", "bag", "bake", "balance", "ball", "balloon", "banana", "band", "bang", "bank", 
  "bar", "bare", "bargain", "barrel", "base", "basic", "basket", "bat", "batch", "bath", "bathroom", "battery", "battle", 
  "beach", "beam", "bean", "bear", "beard", "beat", "beautiful", "beauty", "because", "become", "bed", "bedroom", "bee", 
  "beef", "beer", "before", "begin", "behave", "behavior", "behind", "believe", "bell","belly", "belong", "below", "belt", 
  "bench", "bend", "beneath", "benefit", "beside", "best", "bet", "better", "between", "beyond", "bicycle", "bid", "big", 
  "bike", "bill", "bind", "bird", "birth", "biscuit", "bit", "bite", "bitter", "black", "blade", "blame", "blank", 
  "blanket", "blast", "blaze", "bleed", "blend", "bless", "blind", "block", "blood", "blow", "blue", "board", "boat", 
  "body", "boil", "bold", "bomb", "bond","bone", "bonus", "book", "boom", "boost", "boot", "border", "bore", "born", 
  "borrow", "boss", "both", "bother", "bottle", "bottom", "bounce", "bound", "bow", "bowl", "box", "boy", "brain", 
  "branch", "brand", "brave", "bread", "break", "breast", "breath", "breathe", "brick", "bridge", "brief", "bright", 
  "bring", "broad", "brother", "brown", "brush", "bubble", "budget", "build", "building", "bullet", "bump", "burn", 
  "burst", "bury","business", "busy", "but", "butter", "button", "buy", "buyer", "buzz", "by", "byte",   

  "cab", "cabin", "cabinet", "cable", "cache", "cactus", "cadence", "cafeteria", "cage", 
  "cake", "calamity", "calculate", "calendar", "calf", "caliber", "calibrate", "calm", "calorie", 
  "calmly", "camaraderie", "camouflage", "campaign", "campus", "can", "canal", "cancel", "cancer", 
  "candid", "candle", "candy", "cane", "cannon", "canoe", "canon", "canopy", "cantaloupe", "canvas", "cap", 
  "capability", "capable", "capacity", "cape", "capital", "capitol", "cappuccino", "captain", "caption", 
  "capture", "car", "caramel", "carat", "carbon", "card", "cardboard", "care", "career", "careful", "careless",
  "cargo", "caricature", "carpenter", "carpet", "carriage", "carrier", "carrot", "carry", "cart", "cartoon", 
  "carve", "cascade", "case", "cash", "casino","casserole", "cast", "castle", "casual", "catalog", "catapult", 
  "catch", "category", "cater", "cathedral", "cattle", "caucus", "caught", "cause", "caution", "cavalry", "cave", 
  "caviar", "cease", "ceiling", "celebrate", "celery", "cell", "cellar", "cello", "cement", "censor", "census", 
  "cent", "center", "central", "century", "ceramic", "cereal", "ceremony", "certain", "certificate", "chain", 
  "chair", "chairman", "chalk", "challenge", "chamber", "chance", "change", "channel", "chant", "chaos", "chap", 
  "chapel", "chapter","character", "charge", "charisma", "charitable"
  , "charity", "charm", "chart", "charter", 
  "chase", "chasm", "chat", "cheap", "cheat", "check", "cheek", "cheer", "cheese", "chef", "chemical", "chemistry", 
  "cherish", "cherry", "chest", "chew", "chicken", "chief", "child", "childhood", "chill", "chilly", "chimney", 
  "chin", "chip", "chocolate", "choice", "choir", "choose", "chop", "chord", "chorus", "chose", "chosen", "chrome", 
  "chronic", "chubby", "chuck", "chuckle", "church","cider", "cigar", "cinema", "circle", "circuit", "circulate", 
  "circumstance", "cite", "citizen", "city", "civil", "claim", "clap", "clarify", "clarity", "clash", "class", 
  "classic", "classify", "classroom", "claw", "clay", "clean", "clear", "clever", "click", "client", "cliff", "climb", 
  "cling", "clinic", "clip", "clock", "clone", "close", "closet", "cloth", "clothes", "cloud", "clown", "club", 
  "clue", "clumsy", "cluster", "clutch", "coach", "coal", "coast", "coat","coconut", "code", "coffee", "coffin", 
  "coil", "coin", "coincide", "cold", "collaborate", "collage", "collapse", "collar", "collect", "college", "collision", 
  "colon", "colonial", "colony", "color", "colossal", "column", "comb", "combat", "combine", "come", "comedy", "comfort", 
  "comic", "command", "commemorate", "comment", "commerce", "commit", "committee", "common", "communicate", "community", 
  "company", "compare", "compass", "compel", "compete", "compile", "complain", "complete", "complex", "compliance", 
  "complicate", "compliment","compose", "composition", "compound", "comprehend", "compress", "compromise", "compute", 
  "conceal", "concede", "conceive", "concentrate", "concept", "concern", "concert", "conclude", "concrete", "condemn", 
  "condense", "condition", "conduct", "confess", "confide", "confine", "confirm", "conflict", "conform", "confuse", 
  "congratulate", "congress", "connect", "conquer", "consent", "conserve", "consider", "consist", "console", 
  "consolidate", "consonant", "constant", "constitute", "construct", "consult", "consume", "contact", "contain", 
  "contemplate", "contend", "content", "contest","context", "continue", "contract", "contrast", "contribute", 
  "control", "controversy", "convene", "converge", "converse", "convert", "convey", "convict", "convince", "cook", 
  "cool", "cooperate", "coordinate", "cop", "cope", "copy", "coral", "cord", "core", "corn", "corner", "corporate", 
  "correct", "correspond", "cost", "cottage", "cotton", "couch", "cough", "could", "council", "counsel", "count", 
  "counter", "country", "coup", "couple", "courage", "course", "court", "cousin", "cover", "cow", "cowboy","crack", 
  "cradle", "craft", "cram", "cramp", "cranberry", "crane", "crash", "crate", "crave", "crawl", "crazy", "cream", 
  "create", "credit", "creed", "creek", "creep", "cremate", "creole", "crew", "crib", "cricket", "crime", "crimson", 
  "crisp", "criteria", "critic", "crop", "cross", "crow", "crowd", "crown", "crucial", "crude", "cruel", "cruise", 
  "crumb", "crumble", "crunch", "crush", "crust", "cry", "crystal", "cube", "cucumber", "cuddle", "cue", "cuff", 
  "cult", "culture","cup", "curb", "cure", "curious", "curl", "currency", "current", "curse", "curtain", "curve", 
  "cushion", "custom", "cut", "cute", "cycle", "cynical",

  "domain", "dome", "domestic", "donate", "donkey", "door", "dose", "dot", "double", "doubt", "dough", "dove", "down", "dozen", "draft", 
  "drag", "dragon", "drain", "drama", "drastic", "draw", "dread", "dream", "dress", "drift", "drill", "drink", "drip", 
  "drive", "drop", "drum", "dry", "dual", "duck", "due", "dull", "dumb", "dump", "during", "dusk", "dust", "duty", 
  "dwarf", "dwell", "dynamic", "dynamics", "dynamite", "dynasty",
  "dad", "dagger", "daily", "dairy", "daisy", "damage", "damp", "dance", "danger", "dangle", "dare", "dark", 
  "dart", "dash", "data", "date", "daughter", "dawn", "day", "dazzle", "dead", "deaf", "deal", "dear", "death", 
  "debate", "debris", "debt", "decade", "decay", "deceive", "decide", "decline", "decorate", "decrease",
  "dedicate", "deed", "deep", "defeat", "defend", "defer", "deficit", "define", "defy", "degree", "delay", "delegate", 
  "delete", "delicate", "delight", "deliver", "delta", "demand", "democracy", "demonstrate", "denial", "denim", "dense", 
  "density", "dental", "deny", "depart", "depend", "deposit", "depth", "deputy", "derive", 
  "descend", "describe", "desert", "design", "desire", "desk", "desperate", "destroy", "detail", "detect", "deter", 
  "develop", "device", "devote", "diabetes", "diagnose", "diagram","dial", "diamond", "diary", "dice", "diet", "differ", 
  "digital", "dignity", "dilemma", "diminish", "dine", "dinghy", "dinner", "dinosaur", "diploma", "direct", "dirt", 
  "disable", "disagree", "disappear", "disaster", "discard", "discipline", "discover", "discuss", "disease", "disguise", 
  "disgust", "dish", "dismiss", "disorder", "display", "distance", "distant", "distinct", "distract", "distress", 
  "distribute", "district", "diverse", "divide", "divine", "divorce", "dock", "doctor", "document", "dog", "doll", 
  "dolphin",

  "eager", "eagle", "ear", "early", "earn", "earth", "ease", "east", "easy", "eat", "eclectic", "echo", "eclipse", 
  "ecology", "economy", "eddy", "edge", "edible", "edit", "educate", "eel", "effect", "efficient", "effort", "egg", 
  "ego", "eight", "either", "elaborate", "elbow", "elder", "elect", "elegant", "element", "elevate", "eleven", "elf", 
  "elite", "else", "embark", "embody", "embrace", "emerge", "emotion", "empathy", "empower", "empty", "emulate",
  "enable", "enchant", "enclose", "encounter", "end", "endless", "endorse", "endure", "enemy", "energy", "enforce", 
  "engage", "engine", "enhance", "enjoy", "enlarge", "enlist", "enough", "enrich", "enroll", "ensure", "enter", 
  "entertain", "enthusiasm", "entire", "entry", "envelope", "environment", "envy", "epic", "episode", "equal", "equip", 
  "era", "erase", "erode", "erupt", "escape", "essay", "essence", "establish", "estate", "esteem", "estimate", 
  "eternal", "ethics", "ethnic", "evade", "evaluate","evaporate", "even", "event", "eventual", "ever", "every", 
  "evidence", "evil", "evolve", "exact", "exaggerate", "exam", "examine", "example", "exceed", "excel", "except", 
  "excerpt", "exchange", "excite", "exclude", "excuse", "execute", "exercise", "exhaust", "exhibit", "exile", "exist", 
  "exit", "exotic", "expand", "expect", "expel", "expense", "experience", "expert", "expire", "explain", "explode", 
  "exploit", "explore", "export", "expose", "express", "extend", "extra", "extract", "extreme",
  
  "fabric", "face", "facility", "fact", "factor", "factory", "fade", "fail", "faint", "fair", "faith", "fake", "fall", 
  "false", "fame", "familiar", "family", "famous", "fan", "fancy", "fantasy", "far", "fare", "farm", "fashion", "fast", 
  "fat", "fatal", "father", "fatigue", "fault", "favor", "favorite", "fear", "feasible", "feast", "feat", "feature", 
  "federal", "fee", "feed", "feel", "fellow", "female", "fence", "festival", "fetch", "fever", "few", "fiber",
  "fiction", "field", "fiery", "fifth", "fifty", "fight", "figure", "file", "fill", "film", "filter", "final", "finance", 
  "find", "fine", "finger", "finish", "fire", "firm", "first", "fiscal", "fish", "fit", "five", "fix", "flag", "flame", 
  "flash", "flat", "flavor", "flee", "flesh", "flight", "float", "flock", "flood", "floor", "flour", "flow", "flower", 
  "fluid", "flush", "fly", "foam", "focus", "fog", "foil", "fold", "follow","food", "fool", "foot", "for", "forbid", 
  "force", "forecast", "foreign", "forest", "forever", "forget", "forgive", "fork", "form", "formal", "format", "former", 
  "formula", "forth", "fortune", "forum", "forward", "fossil", "foster", "foul", "found", "foundation", "founder", 
  "four", "fourth", "fox", "fraction", "fragile", "fragment", "frame", "framework", "franchise", "frank", "free", 
  "freedom", "freeze", "French", "frequency", "frequent", "fresh", "friend", "friendly", "frighten", "fringe","frown", 
  "fruit", "frustrate", "fuel", "fulfill", "full", "fun", "function", "fund", "fundamental", "funeral", "funny", "fur", 
  "furniture", "further", "fury", "future", 
  
  "gadget", "gain", "galaxy", "gallery", "game", "gang", "gap", "garage", "garbage", "garden", "garlic", "gas", "gay","gate", 
  "gather", "gauge", "gear", "gender", "gene", "general", "generate", "generation", "generator", "generic", "genetic", 
  "genius", "genre", "gentle", "genuine", "geography", "gesture", "ghost", "giant", "gift","giggle", "ginger", "girl", 
  "give", "glad", "glance", "glass", "glide", "global", "globe", "gloom", "glory", "glove", "glow", "glue", "go", "goal", 
  "goat", "gold", "golden", "golf", "good", "goodbye", "goodness", "goose", "govern", "government", "gown", "grab", 
  "grace", "grade", "gradual", "graduate", "grain", "grammar", "grand", "grant", "grape", "graph", "graphic", "grasp", 
  "grass", "grateful", "grave", "gravity", "gray", "great", "green", "greet", "grief","group", "grove", "grow", "growth", 
  "guarantee", "guard", "guess", "guest", "guide", "guild", "guilt", "guilty", "guitar", "gun", "gut", "gutter", "gym",

  "habit", "habitat", "hair", "half", "hall", "halt", "hammer", "hand", "handle", "handsome", "hang", "happen", "happy", 
  "harass", "harbor", "hard", "hardship", "hardware", "harm", "harmony", "harness", "harsh", "harvest", "hat", "hatch", 
  "hate", "haul", "have", "hawk", "hazard", "head", "headache", "heal", "health", "healthy", "heap", "hear", "heart", 
  "heat", "heating", "heaven", "heavy", "hedgehog", "heel", "height", "heir", "helicopter", "hell",
  "hello", "helmet", "help", "hemisphere", "hence", "herald", "herb", "herd", "here", "heritage", "hero", "hesitate", 
  "hexagon", "hey", "hi", "hide", "high", "highlight", "highway", "hilarious", "hill", "him", "hint", "hippopotamus", 
  "hire", "history", "hit", "hive", "hoax", "hobby", "hockey", "hold", "hole", "holiday", "hollow", "holy", "home", 
  "homeland", "honest", "honey", "honor", "hood", "hook", "hope", "horizon", "horn", "horrible", "horse",  
  "hospital", "host", "hot", "hotel", "hour", "house", "hover", "how", "however", "hub", "huge", "human", "humid", 
  "humiliate", "humor", "hundred", "hungry", "hunt", "hurdle", "hurry", "hurt", "husband", "hybrid", "hydrogen", 
  "hygiene", "hymn", "hypocrisy", "hypothesis", 
  
  "ice",'icon', 'ideal', 'identical', 'identify', 'ideology', 'idiot', 'idle', 'idol', 'igloo', 'ignite', 'ignorant', 'ignore', 
  'iguana', 'ill', 'illegal', 'illicit', 'illness', 'illuminate', 'illusion', 'illustrate', 'image', 'imagination', 
  'imagine', 'imbibe', 'imitate', 'immediate', 'immense', 'immerse', 'imminent', 'immobile', 'immortal', 'immune', 
  'impact', 'impair', 'impart', 'impatient', 'impeach', 'impede', 'impel', 'impend', 'imperative', 'imperfect', 
  'imperial', 'impersonate', 'impetus', 'implement', 'implicate', 'imply', 'import', 'impose', 'impress', 'imprint', 
  'imprison', 'improve', 'impulse', 'impure', 'inability', 'inaccurate', 'inaction', 'inactive', 'inane', 'inanimate', 
  'inappropriate', 'inbound', 'inborn', 'inbred', 'incapable', 'incarcerate', 'incense', 'incentive', 'inch', 'incident', 
  'incidental', 'incision', 'incite', 'inclination', 'incline', 'include', 'inclusive', 'income', 'incompatible', 
  'incomplete', 'inconvenient', 'incorporate', 'incorrect', 'increase', 'incredible', 'incredulous', 'increment', 
  'incubate', 'incur', 'indebted', 'indecent', 'indecisive', 'indeed', 'indefinite', 'indelible', 'indemnify', 'indent', 
  'independence', 'independent', 'index', 'indicate', 'indict', 'indifference', 'indifferent', 'indigenous', 
  'indignant', 'indignation', 'indirect', 'indispensable', 'individual', 'indoor', 'induce', 'indulge', 'industrial', 
  'industry', 'ineffective', 'inefficient', 'inept', 'inertia', 'inevitable', 'inexact', 'inexpensive', 'infect', 
  'infer', 'inference', 'inferior', 'infertile', 'infest', 'infiltrate', 'infinite', 'infinity', 'inflammable', 
  'inflammation', 'inflate', 'inflict', 'influence', 'influenza', 'inform', 'information', 'infrastructure', 'infringe', 
  'infuse', 'ingenious', 'ingenuity', 'ingest', 'inhabit', 'inhale', 'inherit', 'inhibit', 'inhuman', 'initial', 
  'initiate', 'inject', 'injure', 'injustice', 'ink', 'inland', 'inmate', 'inn', 'innate', 'inner', 'innocence', 
  'innocent', 'innovation', 'innovative', 'input', 'inquire', 'inquiry', 'insect', 'insecure', 'insert', 'inside', 
  'insight', 'insignificant', 'insincere', 'insist', 'insomnia', 'inspect', 'inspire', 'install', 'instance', 'instant',
  'institution', 'instruct', 'instrument', 'insufficient', 'insulate', 'insult', 'insurance', 'insure', 'intact', 'intake', 
  'integral', 'integrate', 'integrity', 'intellect', 'intelligence', 'intelligent', 'intend', 'intense', 'intent', 
  'interact', 'intercede', 'intercept', 'interchange', 'intercom', 'intercourse', 'interest', 'interface', 'interfere', 
  'interior', 'interject', 'interlude', 'intermediate', 'intermittent', 'international', 'interpret', 'interrogate', 
  'interrupt', 'intersect', 'interval', 'intervene', 'interview', 'intestate', 'intestinal', 'intestine', 'intimate', 
  'intimidate', 'into', 'intolerant', 'intonation', 'introduce', 'intrude', 'intuition', 'inundate', 'invade', 'invalid', 
  'invaluable', 'invariable', 'invent', 'inventory', 'inverse', 'inversion', 'invert', 'invest', 'investigate', 
  'inveterate', 'invincible', 'invisible', 'invite', 'invoice', 'invoke', 'involuntary', 'involve', 'inward', 'iodine', 
  'ion', 'ionic', 'ipso', 'irate', 'ire', 'iridium', 'iris', 'iron', 'ironic', 'irradiate', 'irrational', 'irregular', 
  'irrelevant', 'irresistible', 'irrespective', 'irritable', 'irritate', 'is', 'island', 'isolate', 'issue', 'isthmus', 
  'it', 'italic', 'itch', 'item', 'iterate', 'itinerary', 'itself',
  
  'jab', 'jack', 'jacket', 'jade', 'jaguar', 'jail', 'jalapeno', 'jam', 'jamb', 'jammed', 'jangle', 'janitor', 'jar', 
  'jargon', 'jaundice', 'jaunt', 'jaw', 'jay', 'jazz', 'jealous', 'jeans', 'jeep', 'jejune', 'jell', 'jelly', 'jellyfish', 
  'jeopardize', 'jerk', 'jerky', 'jest', 'jester', 'jet', 'jettison', 'jewel', 'jewelry', 'jibe', 'jiffy', 'jig', 
  'jigger', 'jiggle', 'jigsaw', 'jilt', 'jingle', 'jingoism', 'jinx', 'jitterbug', 'jitters', 'jive', 'job', 'jock', 
  'jockey', 'jocose', 'jocular', 'jog', 'jogging', 'join', 'joint', 'joist', 'joke', 'jolly', 'jolt', 'jonquil', 'josh', 
  'jostle', 'jot', 'journal', 'journey', 'joust', 'jovial', 'jowl', 'joy', 'joyful', 'joyous', 'jubilant', 'jubilee', 
  'judge', 'judgment', 'judicial', 'judo', 'jug', 'juggernaut', 'juggle', 'juice', 'juicy', 'jujitsu', 'jukebox', 
  'julep', 'jumble', 'jumbo', 'jump',

  'kale', 'kangaroo', 'karaoke', 'karate', 'kayak', 'kebab', 'keel', 'keen', 'keep', 'keepsake', 'keg', 'kelp', 'ken', 
  'kennel', 'kept', 'kernel', 'kerosene', 'kestrel', 'ketch', 'ketchup', 'kettle', 'key', 'keyboard', 'keyhole', 
  'keynote', 'khaki', 'kick', 'kid', 'kidnap', 'kidney', 'kill', 'killer', 'kiln', 'kilo', 'kilt', 'kimono', 'kin', 
  'kind', 'kindergarten', 'kindle', 'kindness', 'king', 'kingdom', 'kingfisher', 'kink', 'kiosk', 'kiss', 'kit', 
  'kitchen', 'kite', 'kitten', 'kitty', 'kiwi', 'kleptomania', 'klutz', 'knack', 'knapsack', 'knead', 'knee', 'kneel', 
  'knickknack', 'knife', 'knight', 'knit', 'knob', 'knock', 'knockout', 'knoll', 'knot', 'know', 'knowing', 'knowledge', 
  'knowledgeable', 'knuckle', 'koala',
  
  'lab', 'label', 'labor', 'laboratory', 'labyrinth', 'lace', 'lack', 'lacking', 'lacquer', 'lacy', 'lad', 'ladder', 
  'laden', 'ladies', 'lady', 'ladybug', 'lag', 'lagoon', 'laid', 'lain', 'lair', 'lake', 'lamb', 'lame', 'lamp', 'lanai', 
  'lance', 'land', 'landing', 'landlady', 'landlord', 'landscape', 'landslide', 'lane', 'language', 'languid', 'languish', 
  'lanky', 'lantern', 'lap', 'lapel', 'lapse', 'laptop', 'larva', 'larynx', 'laser', 'lash', 'lasso', 'last', 'lasting', 
  'latency', 'latent', 'later', 'lateral', 'latest', 'latex', 'lath', 'latitude', 'latrine', 'latter', 'laud', 'laugh', 
  'laughter', 'launch', 'launder', 'laundry', 'laureate', 'laurel', 'lavatory', 'lavender', 'lavish', 'law', 'lawful', 
  'lawless', 'lawsuit', 'lawyer', 'lax', 'laxative', 'lay', 'layer', 'layman', 'layout', 'lazy', 'lea', 'lead', 'leader', 
  'leadership', 'leaf', 'leaflet', 'league', 'leak', 'leakage', 'leaky', 'lean', 'leap', 'leapfrog', 'learn', 'lease', 
  'least', 'leather', 'leave', 'leaves', 'lecherous', 'lectern', 'lecture', 'ledge', 'ledger', 'lee', 'leech', 'leek', 
  'leer', 'leery', 'left', 'leftovers', 'leg', 'legacy', 'legal', 'legend', 'legible', 'legion', 'legislate', 
  'legislation', 'legislature', 'legitimate',
  
  'ma', 'macabre', 'macaroni', 'macaw', 'mace', 'machete', 'machine', 'machinery', 'machinist', 'mackerel', 'macro', 
  'mad', 'madam', 'madcap', 'madden', 'made', 'madhouse', 'madman', 'madness', 'maelstrom', 'maestro', 'magazine', 
  'magenta', 'maggot', 'magic', 'magician', 'magisterial', 'magistrate', 'magnanimous', 'magnate', 'magnesium', 'magnet', 
  'magnetic', 'magnetism', 'magnificence', 'magnificent', 'magnitude', 'magpie', 'mahogany', 'maid', 'maiden', 'mail', 
  'mailbox', 'mailman', 'maim', 'main', 'mainland', 'mainstay', 'maintain', 'maintenance', 'majestic', 'majesty', 
  'major', 'majority', 'make', 'maker', 'makeup', 'malady', 'malaise', 'malaria', 'male', 'males', 'malfunction', 
  'malice', 'malicious', 'malign', 'malignant', 'mall', 'mallard', 'mallet', 'mallow', 'malt', 'mama', 'mammal', 
  'mammoth', 'man', 'manage', 'management', 'manager', 'mandate', 'mandatory', 'mane', 'maneuver', 'manger', 'mangle', 
  'mango', 'mangrove', 'manhole', 'manhood', 'mania', 'maniac', 'manic', 'manifest', 'manifestation', 'manifold', 
  'manipulate', 'mankind', 'manly', 'manna', 'manner', 'mansion', 'mantel', 'mantle', 'manual', 'manuscript', 'many', 
  'map', 'maple', 'mar', 'marathon', 'maraud', 'marble', 'march', 'mare', 'margarine', 'margin', 'marginal', 'marigold', 
  'marijuana', 'marina', 'marinate', 'marine', 'mariner', 'marionette', 'mark', 'marker', 'market', 'marketplace', 
  'marking', 'marksman', 'markup', 'maroon', 'marquee', 'marriage', 'marrow', 'marry', 'mars', 'marsh', 'marshal', 
  'marshmallow', 'mart', 'marten', 'martial', 'martin', 'martyr', 'marvel', 'mascot', 'masculine', 'masculinity', 'mash', 
  'mask', 'mason', 'masquerade', 'mass', 'massage', 'mast', 'master', 'masterful', 'masterpiece', 'mastery', 'masticate', 
  'mastiff', 'mastodon', 'mat', 'match', 'matchbox', 'matchless', 'mate', 'material', 'materialism', 'maternal', 'math', 
  'mathematical', 'mathematics', 'matinee', 'matriarch', 'matrix', 'matt', 'matter', 'matting', 'mature', 'maudlin', 
  'maul', 'mausoleum', 'mauve', 'maverick', 'maw', 'max', 'maxim', 'maximum', 'may', 'maybe',

  'nab', 'nag', 'nail', 'naive', 'naked', 'name', 'nameless', 'namely', 'nanny', 'nap', 'napkin', 'narcissism', 
  'narcissist', 'narcotic', 'narrate', 'narrative', 'narrow', 'narrowly', 'nasal', 'nascent', 'nasty', 'nation', 
  'national', 'nationalism', 'native', 'natty', 'natural', 'nature', 'naughty', 'nausea', 'nauseate', 'nautical', 
  'naval', 'navigate', 'navy', 'nay', 'near', 'nearby', 'nearly', 'neat', 'nebula', 'necessarily', 'necessary', 
  'necessitate', 'necessity', 'neck', 'necklace', 'neckline', 'necktie', 'nectar', 'nee', 'need', 'needle', 'negative', 
  'neglect', 'negligee', 'negotiate', 'negotiation', 'neighbor', 'neighborhood', 'neither', 'neon', 'nephew', 'nerve', 
  'nervous', 'nest', 'net', 'neural', 'neutral', 'neutron', 'never', 'nevertheless', 'new', 'newborn', 'newcomer', 
  'newfangled', 'newly', 'news', 'newscaster', 'newsletter', 'newspaper', 'newsstand', 'newsworthy', 'next', 'nibble', 
  'nice', 'niche', 'nick', 'nickel', 'nickname', 'nicotine', 'niece', 'nifty', 'nigh', 'night', 'nightclub', 'nightfall', 
  'nightgown', 'nightingale', 'nightlife', 'nightly', 'nightmare', 'nihilism', 'nihilist', 'nimble', 'nine', 'nineteen', 
  'ninety', 'ninth', 'nip', 'nirvana', 'nit', 'nitrogen', 'nobility', 'noble', 'nobody', 'nocturnal', 'nod', 'node', 
  'noise', 'noisome', 'nomad', 'nominal', 'nominate', 'nomination', 'nonchalant', 'none', 'nonetheless', 'nonexistent', 
  'nonfiction', 'nonpareil', 'nonsense', 'noodle', 'noose', 'nor', 'norm', 'normal', 'normalize', 'north', 'northeast', 
  'northern', 'northward', 'norway', 'nose', 'nostril', 'not', 'notable', 'notary', 'notation', 'notch', 'note', 'notebook', 
  'noteworthy', 'nothing', 'notice', 'noticeable', 'notify', 'notion', 'notoriety', 'notorious', 'noun', 'nourish', 
  'nourishment', 'novel', 'novelist', 'novelty', 'novice', 'now', 'nowadays', 'nowhere', 'noxious', 'nozzle', 'nuance', 
  'nuclear', 'nucleus', 'nudge', 'nugget', 'nuisance', 'nullify', 'numb', 'number', 'numbness', 'numerical', 'numerous', 
  'nun', 'nuptial', 'nurse', 'nursery', 'nurture', 'nut',
  
  'oak', 'oar', 'oasis', 'oath', 'obedience', 'obedient', 'obese', 'obey', 'obfuscate', 'object', 'objection', 
  'objective', 'oblige', 'obliging', 'oblique', 'obliterate', 'oblivion', 'oblivious', 'oblong', 'obnoxious', 'obscene', 
  'obscure', 'observance', 'observant', 'observation', 'observe', 'observer', 'obsess', 'obsession', 'obsessive', 
  'obsolete', 'obstacle', 'obstetrician', 'obstetrics', 'obstinacy', 'obstinate', 'obstruct', 'obstruction', 
  'obstructive', 'obtain', 'obtrude', 'obtrusive', 'obtuse', 'obverse', 'obviate', 'obvious', 'ocarina', 'occasion', 
  'occasional', 'occlude', 'occlusion', 'occlusive', 'occult', 'occupant', 'occupation', 'occupy', 'occur', 'occurrence', 
  'ocean', 'oceanography', 'ochre', 'octagon', 'octave', 'octavo', 'octet', 'octogenarian', 'octopus', 'ocular', 'odd', 
  'odds', 'ode', 'odious', 'odium', 'odometer', 'odyssey', 'off', 'offend', 'offense', 'offensive', 'offer', 'offering', 
  'offhand', 'office', 'officer', 'official', 'officialdom', 'officiate', 'officious', 'offing', 'offset', 'offshoot', 
  'offspring', 'often', 'ogle', 'ogre', 'ohm', 'oil', 'oily', 'ointment', 'okay', 'old', 'old-fashioned', 'old-time', 
  'older', 'oldest', 'oldster', 'olive', 'omega', 'omelet', 'omen', 'ominous', 'omission', 'omit', 'omnibus', 
  'omnipotence', 'omnipotent', 'omniscience', 'omniscient', 'oncology', 'oncoming', 'one', 'onerous', 'oneself', 
  'onetime', 'ongoing', 'onion', 'only', 'onrush', 'onset', 'onslaught', 'onto', 'onus', 'onward', 'onyx', 'oodles', 
  'oops', 'ooze', 'opacity', 'opal', 'opaque', 'open', 'opener', 'opening', 'openly', 'opera', 'operable', 'operate', 
  'operation', 'operative', 'operator', 'operetta', 'ophthalmologist', 'ophthalmology', 'opiate', 'opine', 'opinion', 
  'opium', 'opossum', 'opponent', 'opportune', 'opportunity', 'oppose', 'opposite', 'oppress', 'oppression', 'oppressive', 
  'oppressor', 'opt', 'optic', 'optical', 'optician', 'optimism', 'optimist', 'optimistic', 'optimum', 'option', 
  'optional', 'optometrist', 'optometry', 'opulence', 'opulent', 'or', 'oracle', 'oral', 'orange', 'orangutan', 
  'oration', 'orator', 'oratorio', 'orbit', 'orchard', 'orchestra',
  
  'pace', 'pacemaker', 'pachyderm', 'pacific', 'pacifier', 'pacifist', 'pacify', 'pack', 'package', 'packaging', 
  'packed', 'packer', 'packet', 'pact', 'pad', 'padding', 'paddle', 'paddock', 'pagan', 'page', 'pageant', 'paginate', 
  'pagoda', 'paid', 'pail', 'pain', 'painful', 'paint', 'paintbrush', 'painter', 'painting', 'pair', 'pairing', 
  'pajamas', 'pal', 'palace', 'palatable', 'palate', 'palatial', 'pale', 'palette', 'pall', 'palladium', 'pallbearer', 
  'pallet', 'palliate', 'palliative', 'palm', 'palpable', 'palpitate', 'paltry', 'pamper', 'pamphlet', 'pan', 'panacea', 
  'panache', 'pancake', 'pancreas', 'panda', 'pandemic', 'pandemonium', 'pander', 'pane', 'panel', 'panhandle', 'panic', 
  'panorama', 'pansy', 'pant', 'pantheon', 'panther', 'panties', 'pantomime', 'pantry', 'pants', 'pantyhose', 'papa', 
  'papal', 'papaya', 'paper', 'papyrus', 'par', 'parable', 'parachute', 'parade', 'paradigm', 'paradise', 'paradox', 
  'paragon', 'paragraph', 'parakeet', 'parallel', 'paralyze', 'paramedic', 'parameter', 'paramilitary', 'paramount', 
  'paranoia', 'paranormal', 'parapet', 'paraphernalia', 'paraphrase', 'paraplegic', 'parasite', 'parasol', 'paratrooper', 
  'parcel', 'parch', 'parchment', 'pard', 'pardon', 'pare', 'parent', 'parentage', 'parental', 'parentheses', 
  'parenthesis', 'parenthetically', 'parenting', 'pariah', 'parish', 'parity', 'park', 'parka', 'parking', 'parkway', 
  'parliament', 'parlor', 'parochial', 'parody', 'parole', 'parquet', 'parricide', 'parrot', 'parsimony', 'parsley', 
  'parsnip', 'parson', 'part', 'partake', 'partial', 'participant', 'participate', 'participation', 'particle', 
  'particular', 'parting', 'partisan', 'partition', 'partly', 'partner', 'partnership', 'partridge', 'parturition', 
  'party', 'pass', 'passable', 'passage', 'passageway', 'passbook', 'passe', 'passenger', 'passerby', 'passing', 
  'passion', 'passionate', 'passive', 'passport', 'password', 'past', 'pasta', 'paste', 'pastel', 'pastime', 'pastor', 
  'pastoral', 'pastry', 'pasture', 'pat', 'patch', 'patchwork', 'pate', 'patent', 'patently', 'paternal', 'paternity', 
  'path', 'pathetic',
  
  'quack', 'quad', 'quadrangle', 'quadrant', 'quadratic', 'quadrilateral', 'quadrille', 'quadruped', 'quadruple', 'quaff',
  'quagmire', 'quail', 'quaint', 'quake', 'qualification', 'qualified', 'qualify', 'qualitative', 'quality', 'qualm', 'quandary',
  'quantify', 'quantitative', 'quantity', 'quarantine', 'quark', 'quarrel', 'quarry', 'quart', 'quarter', 'quarterback', 'quartet',
  'quartz', 'quash', 'quaver', 'queen', 'queer', 'quell', 'quench', 'query', 'quest', 'question', 'questionable', 'questionnaire', 
  'quibble', 'quiche', 'quick', 'quicken', 'quickie', 'quicksand', 'quiet', 'quietude', 'quill', 'quilt', 'quince', 'quinine', 'quintessence', 
  'quintet', 'quintuple', 'quip', 'quirk', 'quirky', 'quit', 'quite', 'quits', 'quitter', 'quiver', 'quiz', 'quizzical', 'quoit', 'quota', 'quotable',
  'quotation', 'quote', 'quotient',

  'rabbit', 'rabble', 'rabid', 'race', 'racer', 'racetrack', 'racial', 'racism', 'rack', 'racket', 'raconteur', 'radiance', 'radiant', 'radiate', 'radical'
  ,'radio', 'radioactive', 'radiotherapy', 'radish', 'radium', 'radius', 'raffle', 'raft', 'rag', 'rage', 'ragged', 'ragtime', 'raid', 'rail', 'railroad',
  'rain', 'rainbow', 'raincoat', 'rainfall', 'rainy', 'raise', 'raisin', 'rake', 'rally', 'ram', 'ramble', 'ramification', 'ramp', 'rampage', 'rampant', 
  'ramshackle', 'ran', 'ranch', 'rancor', 'random', 'range', 'rank', 'ransack', 'ransom', 'rant', 'rap', 'rape', 'rapid', 'rapport', 'rapt', 'rapture',
  'rare', 'rarefy', 'rasp', 'raspberry', 'rat', 'rate', 'rather', 'ratify', 'ration', 'rational', 'rattle', 'ravage', 'rave', 'raven', 'ravenous', 
  'ravine', 'raw', 'ray', 'razor', 'reach', 'react', 'reaction', 'reactive', 'read', 'reader', 'readily', 'reading', 'ready', 'real', 'realism', 
  'reality', 'realize', 'realm', 'ream', 'reap', 'reappear', 'rear', 'reason', 'reasonable', 'reassure', 'rebel', 'rebellion', 'rebuff', 'rebuke', 
  'rebut', 'recall', 'recapture', 'receipt', 'receive', 'recent', 'reception', 'receptive', 'recess', 'recipe', 'recipient', 'reciprocal', 'recite', 
  'reckless', 'reckon', 'reclaim', 'recline', 'recognize', 'recoil', 'recollect', 'reconcile', 'recondition', 'record', 'recount', 'recover', 'recreation',
  'recruit', 'rectangle', 'rectify', 'rectitude', 'rector', 'recuperate', 'recur', 'recurrence', 'red', 'redact', 'redbird', 'redemption', 'redhead',
  'redouble', 'redress', 'reduce', 'redundant', 'reed', 'reeducate', 'reef', 'reek', 'reel', 'reeve', 'refer', 'referee', 'reference',
  'referendum', 'refill', 'refine', 'reflect', 'reflex', 'reflexive', 'reform', 'refrain', 'refresh', 'refrigerate', 'refuge', 'refund',
  'refurbish', 'refuse', 'refute', 'regain', 'regal', 'regard', 'regatta', 'regenerate', 'regent', 'regime', 'regimen', 'regiment', 'region',
  'regional', 'register', 'registry', 'regress', 'regret', 'regular', 'regulate', 'regulator', 'rehabilitate', 'rehearsal', 'rehearse', 'reign',
  'reimburse', 'rein', 'reincarnate', 'reinde',
  
  'sabbath', 'saber', 'sable', 'sabotage', 'sac', 'saccharin', 'sack', 'sacrament', 'sacred', 'sacrifice', 'saddle', 'sad', 'sadden', 'saddle', 'sadism',
  'sadly', 'sadness', 'safari', 'safe', 'safeguard', 'safety', 'sag', 'saga', 'sage', 'sail', 'sailor', 'saint', 'sake', 'salad', 'salami', 'salary', 
  'sale', 'salesman', 'salient', 'saline', 'salinity', 'saliva', 'sallow', 'salmon', 'salon', 'salt', 'saltpetre', 'salubrious', 'salutary', 'salute'
  ,'salvage', 'salvation', 'salve', 'same', 'sample', 'samurai', 'sanctify', 'sanction', 'sanctuary', 'sand', 'sandal', 'sandalwood', 'sandbank',
  'sandblast', 'sandwich', 'sane', 'sanitary', 'sanity', 'sanskrit', 'sap', 'sapient', 'sapphire', 'sarcasm', 'sarcophagus', 'sardine', 'sardonic'
  , 'sash', 'satanic', 'satchel', 'sate', 'satellite', 'satiate', 'satire', 'satisfy', 'saturated', 'Saturday', 'saucy', 'sauna', 'saunter',
  'savage', 'save', 'savings', 'savor', 'savour', 'savvy', 'saw', 'sawdust', 'sawmill', 'sax', 'saxophone', 'say', 'saying', 'scab', 'scaffold',
  'scalar', 'scald', 'scale', 'scalene', 'scallion', 'scallop', 'scalp', 'scaly', 'scam', 'scamp', 'scandal', 'scandalize', 'scapegoat', 'scar', 'scarce',
  'scarcely', 'scare', 'scarecrow', 'scarf', 'scarify', 'scarlet', 'scary', 'scathing', 'scatter', 'scepter', 'sceptic', 'sceptical', 'schedule', 'schema',
  'scheme', 'schism', 'schist', 'schizophrenia', 'scholar', 'scholastic', 'school', 'science', 'scientific', 'scientist', 'scimitar', 'scintillate', 'scissors',
  'sclerosis', 'scoff', 'scold', 'scoop', 'scoot', 'scope', 'scorch', 'score', 'scorn', 'scorpion', 'scotch', 'scoundrel', 'scour', 'scourge', 'scout', 'scowl',
  'scramble', 'scrap', 'scrape', 'scratch', 'scream', 'screech', 'screen', 'screw', 'screwdriver', 'scribble', 'scribe', 'scrimmage', 'script', 'scripture', 'scrub',
  'scrutinize', 'scrutiny', 'scuba', 'scuff', 'scuffle', 'sculpture', 'scum', 'scurry', 

  "the", "to", "that", "this", "there", "then", "they", "them", "these", "those", "than", "though", "through", "take", 
  "time", "two", "three", "think", "thought", "thing", "things", "try", "true", "towards", "today", "together", "told", 
  "took", "turn", "turns", "tell", "tell", "talking", "taken", "town", "team", "type", "types", "top", "try", "trying", 
  "ten", "tend", "tends", "trend", "trends", "total", "totally", "taken", "teach", "teaching", "teacher", "teachers", 
  "terms", "term", "technology", "talked", "takes", "towards", "tough", "told", "telling", "towards", "trust", "track", 
  "tried", "truly", "travel", "tree", "trees", "trip", "true", "trouble", "trust", "trusts", "trying", "train", "treat", 
  "treated", "treatment", "treatments", "transition", "tremendous", "tend", "tends", "ten", "thousand", "thousands", 
  "theater", "theaters", "theory", "theories", "theoretical", "thinking", "thinks", "thoughts", "thirty", "third", 
  "thorough", "though", "thoughtful", "thoroughly", "threat", "threaten", "threatened", "threatening", "threatens", 
  "throughout", "thrown", "throws", "thumb", "thumbs", "ticket", "tickets", "tight", "tightly", "tissue", "tissues", 
  "title", "titles", "today", "together", "tool", "tools", "totally", "tour", "tours", "tower", "towers", "trace", 
  "track", "tracks", "tradition", "traditional", "traffic", "tragic", "train", "trained", "trainer", "training", "trains", 
  "transaction", "transactions", "transfer", "transferred", "transfers", "transform", "transformation", "transition", 
  "translate", "translated", "translation", "transport", "transportation", "travel", "travels", "treat", "treated", 
  "treating", "treatment", "treatments", "tree", "trees", "tremendous", "trend", "trends", "trial", "trials", "trick", 
  "tricks", "trip", "trips", "trouble", "troubled", "troubles", "truck", "trucks", "true", "truly", "trust", "trusted", 
  "trusts", "trying", "tube", "tubes", "tumor", "tumors", "tune", "tunes", "turn", "turned", "turning", "turns", 
  "twelve", "twenties", "twenty", "twice", "twin", "twins", "twist", "twists", "type", "types", "typical", "typically",

  "up", "us", "use", "used", "under", "until", "usually", "upward", "upon", "united", 
  "ultimate", "university", "unique", "unless", "unit", "urban", "usd", "usage", "update", 
  "unable", "uniform", "users", "unsure", "uk", "ultimately", "unlock", "utah", "utilize", "upload", "uh", "upcoming", 
  "upside", "universal", "unfold", "umbrella", "username", "unhappy", "unsuccessful", "unfortunately", "unlike", "ugly", 
  "unprecedented", "unclear", "updates", "unauthorized", "unavailable", "unrelated", "usability", "understandable", 
  "uncover", "uncommon", "untitled", "upset", "upwards", "upstream", "uphold", "upgrades", "upholstery", "usages", 
  "useful", "ucla", "utterly", "unsolicited", "uproar", "untrue", "underscore", "unplugged", "unwilling", "unified", 
  "unwise", "unsuccessfuly", "unanimous", "unplug", "unrivaled", "utilizing", "unravel", "unbeatable", "unbiased",
  "unfamiliar", "unearthed", "untouchable", "unmistakable", "upholstered", "unhappiness", "unharmed", "unmistakably", 
  "unsatisfied", "unauthorizedly", "unconventional", "unashamed", "unruly", "unoccupied", "unending", "ungrateful", 
  "unconvinced", "unwillingly", "uncertainty", "unifieds", "unclearly", "unpopular", "unforgivable", "unbroken", 
  "unenforceable", "unfaithful", "unproductive", "unresolved", "unrivaledly", "unquestioned", "unconditional", "unjust", 
  "unsound", "unsteady", "unsurely", "unwavering", "unaffected", "unappreciated", "unanticipated", "unattended", 
  "unapologetic", "uncensored", "unclean", "unconvincing", "uncooperative", "understatement", "unacceptably", 
  "unappealing", "unaccounted", "unaccompanied", "unattributed", "unborn", "unclaimed", "uncanny", "uncivilized", 
  "uncleanly", "underpriced", "undersized", "undertones", "underutilized", "undervalued", "underweight", "undesirable", 
  "undoubtedly", "undue", "undecided", "undemanding", "undeveloped", "undignified", "undisputed", "unemployed", 
  "unethical", "unenlightened", "unenlightening", "unenviable", "unexplained", "unexposed", "unexpressed", "unflappable", 
  "unfocused", "unforgiving", "unfulfilled", "ungraceful", "unguarded", "unhealthily", "unhygienic", "unidentifiable", 
  "unimaginable", "unimaginative", "unimpressive", "uninformed", "uninhabitable","unable", "unacceptable", "unauthorized", 
  "unavailable", "unavoidable", "unaware", "uncertain", "unchanged", "uncomfortable", "uncommon", "unconscious", 
  "unconstitutional", "uncontrolled", "unconventional", "uncover", "under", "underestimate", "undergo", "undergraduate", 
  "underground", "underlie", "underline", "underlying", "undermine", "underneath", "understand", "understanding", 
  "undertake", "undoubtedly", "uneasy", "unemployed", "unemployment", "unequal", "unequivocal", "unethical", "unexpected", 
  "unfair", "unfavorable", "unfinished", "unfortunate", "unfortunately", "unfriendly", "unhappy", "uniform", "unify", 
  "union", "unique", "unit", "unite", "unity", "universal", "universally", "universe", "university", "unknown", "unlawful", 
  "unless", "unlike", "unlikely", "unlimited", "unlock", "unlucky", "unmarried", "unmistakable", "unnecessary", "unpleasant", 
  "unprecedented", "unpredictable", "unprepared", "unproductive", "unprofitable", "unrealistic", "unreasonable", "unrelated", 
  "unrest", "unsafe", "unsatisfactory", "unsatisfied", "unsatisfying", "unseen", "unsettled", "unsolved", "unspeakable", "unstable", 
  "unsuccessful", "unsuitable", "unsure", "untidy", "until", "unthinkable", "unthinking", "untimely", "untouched", "unusual", 
  "unveil", "unwanted", "unwilling", "unwitting", "up", "upcoming", "update", "upgrade", "uphold", "upon", "upper", 
  "upright", "upset", "upstairs", "upstream", "uptake", "uptown", "upward", "urban", "urge", "urgent", "us", "usage", 
  "use", "used", "useful", "useless", "user", "usual", "usually", "utility", "utilize", "utmost", "utter", "utterly",

  "Virulent", "Virus", "Visa", "Visage", "Viscera", "Visceral", "Viscosity", "Viscount", "Visible", "Visibly", "Vision", 
  "Visionary", "Visit", "Visitor", "Visor", "Vista", "Visual", "Visualize", "Vital", "Vitality", "Vitalize", "Vitally", 
  "Vitamin", "Vitriol", "Vivacious", "Vivaciously", "Vivacity", "Vivid", "Vividly", "Vixen", "Vocabulary", "Vocal", "Vocalist", 
  "Vocalize", "Vocation", "Vocational", "Vociferous", "Vociferously", "Vodka", "Vogue", "Voice", "Void", "Volatility", "Volatile",
  "Volcanic", "Volcano", "Volition", "Volley", "Volt", "Voltage", "Volume", "Voluminous", "Voluntary", "Volunteer", "Vomit", "Voodoo",
  "Voracious", "Voraciously", "Voracity", "Vote", "Voter", "Votive", "Vouch", "Voucher", "Vow", "Vowel", "Voyage", "Voyager", "Vulgar", 
  "Vulgarize", "Vulnerability", "Vulnerable", "Vulture", "Vying", "Vylophone", "Vying", "Vylophone",



  "wad", "wade", "waddle", "wade", "wadi", "wadset", "wafer", "waffle", "waft", "wag", "wage", "wager", "waggle", 
  "wagon", "wagoner", "wail", "wain", "wainscot", "wainwright", "waist", "waistband", "waistcoat", "waistline", "wait", 
  "waiter", "waitress", "waive", "waiver", "wake", "wakeful", "waken", "waker", "waking", "wale", "walk", "walkabout", 
  "walkaway", "walkie-talkie", "walkout", "walkover", "walkway", "wall", "wallet", "walleye", "wallflower", "wallop", 
  "wallow", "wallpaper", "walnut", "walrus", "waltz", "wamble", "wampum", "wand", "wander", "wanderer", "wandering",
  "wanderlust", "wane", "wangle", "wanion", "want", "wanting", "wanton", "wapentake", "war", "warble", "warbler", 
  "ward", "warden", "warder", "wardrobe", "ware", "warehouse", "warfare", "warhead", "warily", "wariness", "warlike", 
  "warlock", "warlord", "warm", "warmer", "warmhearted", "warmonger", "warmth", "warn", "warning", "warp", "warpath", 
  "warrant", "warranty", "warren", "warrior", "warsaw", "wart", "warthog", "wartime", "wary", "wash", "washable", 
  "washbasin", "washbowl", "washboard", "washcloth", "washday", "washer", "washerwoman", "washhouse", "washout", 
  "washstand", "washtub", "washy", "wasp", "waspish", "wassail", "wastage", "waste", "wastebasket", "wasteful", 
  "wasteland", "wastepaper", "waster", "wastrel", "watch", "watchband", "watchdog", "watcher", "watchful", "watchmaker", 
  "watchman", "watchtower", "watchword", "water", "waterborne", "watercolor", "watercourse", "watercraft", "watercress", 
  "waterfall", "waterfowl", "waterfront", "waterhole", "waterline", "waterlogged", "watermelon", "waterproof", 
  "watershed", "waterside", "waterspout", "watertight", "waterway", "waterworks", "watt", "wattage", "wattle", "wave", 
  "wavelength", "waver", "wavy", "wax", "waxwork", "way", "waybill", "wayfarer", "waylay", "wayside", "wayward", "weak", 
  "weaken", "weakling", "weakness", "weal", "weald", "wealth", "wealthy", "wean", "weapon", "weaponize", "wear", 
  "wearable", "wearer", "weary", "weasel", "weather", "weatherboard", "weathercock", "weathering", "weatherman", 
  "weathervane", "weave",
"weaver", "web", "webbing", "webcam", "webcast", "webinar", "website", "wed", "wedding", "wedge", "wedlock", "wee", 
"weed", "weedy", "week", "weekday", "weekend", "weekly", "ween", "weeny", "weep", "weeper", "weeping", "weevil", 
"weigh", "weight", "weighted", "weightless", "weighty", "weir", "weird", "weirdo", "welcome", "weld", "welder",
"welfare", "welkin", "well", "wellbeing", "wellborn", "wellhead", "wellington", "wellness", "wellspring", "welly", 
"welsh", "welt", "weltanschauung", "welter", "wench", "wend", "went", "wept", "were", "werewolf", "wert", "west", 
"westbound", "westerly", "western", "westerner", "westernize", "westward", "wet", "wetback", "wether", "wetland", 
"wetness", "whack", "whale", "whalebone", "whaler", "whaling", "wham", "wharf", "wharfage", "wharves", "what", 
"whatchamacallit", "whatever", "whatnot", "wheat", "wheatear", "wheatgerm", "wheatmeal", "wheedle", "wheel", 
"wheelbarrow", "wheelbase", "wheelchair", "wheeler", "wheeler-dealer", "wheelhouse", "wheelie", "wheelwright", "wheeze", 
"wheezy", "whelk", "whelp", "when", "whence", "whenever", "whensoever", "where", "whereabouts", "whereas", "whereby", 
"wherefore", "wherefrom", "wherein", "whereof", "whereon", "wheresoever", "whereto", "whereupon", "wherever", 
"wherewith", "wherewithal", "wherry", "whet", "whether", "whetstone", "whey", "which", "whichever", "whiff", 
"whiffletree", "while", "whilom", "whilst", "whim", "whimper", "whimsical", "whimsy", "whin", "whine", "whinge", 
"whinny", "whip", "whiplash", "whippersnapper", "whippet", "whipping", "whippletree", "whippoorwill", "whip-round", 
"whipsaw", "whir", "whirl", "whirligig", "whirlpool", "whirlwind", "whirr", "whisk", "whisker", "whiskered", "whiskers", 
"whiskey", "whisky", "whisper", "whist", "whistle", "whistleblower", "whistler", "white", "whitebait", "whiteboard", 
"white-collar", "whitefish", "whitehead", "whiten", "whiteness", "whitening", "whitewash", "whitewashed", "whitewashing", 
"whitey", "whither", "whitish", "whittle", "whiz",
"wood", "wooden", "woodland", "woods", "woodwork", "woody", "wool", "woolen", "woolly", "word", "wording", "wordplay", "words", 
"work", "workable", "workbench", "worker", "workforce", "working", "workload", "workman", "workmanship", "workout", 
"workplace", "works", "workshop", "world", "worldly", "worm", "worn", "worried", "worry", "worrying", "worse", "worship", 
"worshipper", "worst", "worth", "worthwhile", "worthy", "wound", "wove", "woven", "wow", "wrack", "wraith", "wrangle", 
"wrap", "wrapper", "wrapping", "wrasse", "wrath", "wreak", "wreath", "wreck", "wrench", "wrest", "wrestle", "wrestler", 
"wretched", "wriggle", "wring", "wrinkle", "wrist", "wristband", "wristwatch", "writ", "write", "writer", "writing", 
"written", "wrong", "wrongdoer", "wrongful", "wrongly", "wrote", "wrought", "wrung", "wry", "wryly", "wunderkind", 
"wuss", "wussy", "wuthering", "wyvern",

"xenon", "xerox", "x-ray", "xylophone", "xerophyte", "xenophile", "xanthan", "xenophobia", "xenon", "xerox", 
"xerographic", "xerography", "xerophyte", "xerophytic", "xerothermic", "xerothermophilous", "xiphoid", "x-ray", 
"xylem", "xylene", "xylography", "xylophone", "xyloid", "xylol", "xylyl", "xyrid", "xyst", "xyster", "xystus","x", 
"x-axis", "xanadu", "xanthate", "xanthic", "xanthin", "xanthine", "xanthoma", "xanthous", "xenobiotic", "xenocryst", 
"xenograft", "xenolith", "xenophile", "xenophobe", "xenophobia", "xenophobic", "xenopus", "xeric", "xeriscape", 
"xeroderma", "xerographic", "xerography", "xerophyte", "xerophytic", "xerox", "xiphoid", "xis", "xmas", "xoanon", 
"xylene", "xylitol", "xylograph", "xylography", "xylophone", "xylophonist", "xylyl", "xyrid", "xyster", "xystus", 
"xyst", "xysti", "xystoi", "xystos", "xystus",

"yacht", "yard", "yardage", "yardarm", "yarn", "yarrow", "yaw", "yawn", "year", "yearbook", "yearling", "yearly", 
"yearn", "yeast", "yeasty", "yell", "yellow", "yellowish", "yelp", "yen", "yeoman", "yeomanry", "yes", "yesterday", 
"yet", "yield", "yielding", "yin", "yip", "yob", "yodel", "yoga", "yoghourt", "yoghurt", "yogi", "yogic", "yogurt", 
"yoke", "yolk", "yonder", "yore", "you", "young", "younger", "youngest", "youngster", "your", "yours", "yourself", 
"youth", "youthful", "yowl", "ytterbium", "yttrium", "yuan", "yucca", "yuck", "yule", "yuletide", "yum", "yummy", "yup", 
"yuppie", "yurt", "ywis", "y", "yack", "yahoo", "yak", "yale", "yam", "yang", "yank", "yankee", "yap", "yard", "yardarm", 
"yarn", "yarrow", "yashmak", "yaw", "yawn", "yaws", "yea", "yeah", "yean", "year", "yearbook", "yearling", "yearn", 
"yeast", "yeasty", "yegg", "yell", "yellow", "yelp", "yen", "yeoman", "yeomanry", "yes", "yesterday", "yesteryear", 
"yet", "yew", "yield", "yikes", "yin", "yip", "yippee", "yob", "yobbo", "yodel", "yoga", "yoghurt", "yogi", "yogurt", 
"yoke", "yolk", "yonder", "yore", "you", "young", "younger", "youngster", "your", "yours", "yourself", "youth", 
"youthful", "yowl", "ytterbium", "yttrium", "yuan", "yucca", "yuck", "yucky", "yule", "yuletide", "yum", "yummy", "yup", 
"yuppie", "yurt", "ywis",

"zap", "zeal", "zealous", "zealot", "zebra", "zebu", "zed", "zenith", "zephyr", "zeppelin", "zero", "zest", 
"zigzag", "zinc", "zing", "zinger", "zip", "zipper", "zircon", "zirconium", "zit", "zodiac", "zombie", "zone",
"zonked", "zoom", "zoophyte", "zoological", "zoologist", "zoology", "zoomorphic", "zucchetto", "zucchini",
"zulu", "zydeco", "zymurgy", "z", "zabaglione", "zaftig", "zaffer", "zafu", "zag", "zaibatsu", "zaikai",
"zain", "zaire", "zakat", "zalambdodont", "zamarras", "zamarra", "zamarro", "zambomba", "zambo", "zamindar",
"zamindari", "zamite", "zamouse", "zamouse-click", "zampone", "zanana", "zander", "zanella", "zany",
"zanzibari", "zap", "zapatista", "zaporozhye", "zapus", "zaqqum", "zareba", "zarf", "zariba",
"zariba-click", "zariba-hover", "zariba-pan", "zariba-smash", "zariba-state", "zariba-text",
"zariba-withdraw", "zariba-wrap", "zariba-zoom", "zariba-zoomout", "zariba-zoomwrap", "zarzuela",
"zastruga", "zax", "zea", "zeal", "zealant", "zealful", "zealot", "zealotry", "zealous",
"zealousness", "zeatin", "zebec", "zebecs", "zebedee", "zebedees", "zebedees-canteen", 
"zebedee-sampler", "zebra", "zebrano", "zebrawood", "zebrina", "zebroid", "zebub", "zebus",
"zebu", "zebus-crossed", "zebus-crossed-bell", "zebus-crossed-state", "zebus-crossed-wrap", 
"zebu-state", "zebu-wrap", "zebus-hover", "zebus-pan", "zebus-smash", "zebus-text",
"zebus-withdraw", "zebus-zoom", "zebus-zoomout", "zebus-zoomwrap", "zed", "zedoary", 
"zedong", "zedongist", "zeds", "zee", "zeeman", "zeese", "zeesee", "zeeshan", "zeeweed", "zeff",
"zeffirelli", "zeffirellian", "zeffish", "zeiform", "zeitgeist", "zeke", "zelkova", 
"zelos", "zelos-metres", "zelotyper", "zelotypian", "zelotypic", "zelotypography",
"zelotypy", "zen", "zenaga", "zenaida", "zenaida-click", "zenaida-hover", "zenaida-pan", 
"zenaida-smash", "zenaida-state", "zenaida-text", "zenaida-withdraw", 
];

class addword {
  void addwordtodict(String word) {
    _suggestions.add(word);
  }

  void remove(String word) {
    _suggestions.remove(word);
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController typing = TextEditingController();
  User user = FirebaseAuth.instance.currentUser!;
  Future<void> addfromfirebase() async {
    await FirebaseFirestore.instance
        .collection("words")
        .where('UID', isEqualTo: user.uid)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (!_suggestions.contains(doc.data()['word'])) {
          _suggestions.add(doc.data()['word']);
        }
      });
    });
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSnackbarDisplayed = false;
  @override
  void initState() {
    super.initState();
    typing.addListener(_onTypingValueChanged);
  }

  void _onTypingValueChanged() {
    String text = typing.text;
    int textLength = text.length;

    if (textLength > 0 && text[textLength - 1] == ' ') {
      String lastWord = text.trim().split(' ').last;
      print(lastWord);
      print(!_suggestions.contains(lastWord));
      if (!_suggestions.contains(lastWord)) {
        // print(lastWord);
        _showAddWordDialog(lastWord);
      }
    }
  }

  Future<void> _showAddWordDialog(String word) async {
    final snackBar = SnackBar(
      content: Text('Do you want to add "$word" to your dictionary?'),
      action: SnackBarAction(
        label: 'Yes',
        onPressed: () async {
          await FirestoreService().insertWord(word, user.uid);
          _isSnackbarDisplayed = false;
        },
      ),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(top: 80),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    addfromfirebase();
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 350, // <-- TextField width
                    height: 200,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 3, 0, 28),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        autocorrect: false,
                        maxLines: 6,
                        controller: typing,
                        decoration: InputDecoration(
                          hintText: "Start typing...",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Source Sans Pro'),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Source Sans Pro',
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        var wordList = pattern.split(" ");
                        var lastWord = wordList.last;
                        String text = typing.text;
                        int textLength = text.length;
                        return _suggestions
                            .where((word) => word.startsWith(lastWord))
                            .toList()
                            .take(3);
                      },
                      itemBuilder: (context, suggestion) {
                        String text = typing.text;
                        int textLength = text.length;
                        return ListTile(
                          title: Text(suggestion),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        var wordList = typing.text.split(" ");
                        var lastWord = wordList.last;
                        var newText =
                            typing.text.replaceAll(lastWord, suggestion);
                        typing.text = newText;
                        typing.selection = TextSelection.fromPosition(
                            TextPosition(offset: typing.text.length));
                      },
                    ),
                  ),

                  Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: typing.text));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 3, 0, 28),
                            ),
                            minimumSize: MaterialStateProperty.all<Size>(
                              Size(150, 60),
                            ),
                          ),
                          child: Text("Copy Text",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 20))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
