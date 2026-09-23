"SoMe-Universe: The Ten Banners" by "The SoMe-Universe Contributors"

[An interactive survey of the ten factions of the SoMe-Universe (Saga of Medicine),
built from the faction archives in the Factions folder of the SoMe-Universe repository.]

The story headline is "Ten powers want you. Decide who to become."
The story genre is "Science Fiction".
The release number is 1.
The story creation year is 2026.
The story description is "Ten powers divide the body-cosmos of Planet Homo Sapiens, and every one of them wants the same rare thing: a traveler awake enough to choose a side and brave enough to walk into every other. Collect each faction's seal, earn the right to be called one of them all, and see the whole war."

Use scoring.
The maximum score is 10.


Part Zero - The Singularity Prologue

[Continued from the original "SoMe" demo by Baytars: the universe begins in a
Singularity, and the newborn cosmos offers two gates - the Hall of Medicine and
the Disease Citadel. In this chronicle the prologue ends with the choice of a
patron faction, which grants the traveler's opening banner-stance.]

The Singularity is a room. "[if visited]After the Big Bang, the Singularity no more exists.[otherwise]You are in the Singularity. The universe is beginning to explode."

Instead of going to the Singularity:
	say "You pass back through the after-image of the Big Bang - the room where everything began, now only a shape in the light.";
	now the player is in the Singularity

To say the newcomer primer:
	say "[bold type]WHO YOU ARE[roman type]: You are the first traveler - a mind awake at the birth of the cosmos, before any side has claimed you. Ten powers want your oath; your task is to choose one and then walk every other.[paragraph break][bold type]HOW TO PLAY[roman type]: Type a direction alone - [bold type]N[roman type], [bold type]S[roman type], [bold type]E[roman type], [bold type]W[roman type] - to move. [bold type]LOOK[roman type] re-reads a room; [bold type]EXAMINE <thing>[roman type] or [bold type]LOOK AT <thing>[roman type] studies something; [bold type]ASK <someone> ABOUT <topic>[roman type] questions a character.[paragraph break][bold type]THE FIRST STEP[roman type]: Two gates stand open - [bold type]SOUTH[roman type] to the Hall of Medicine, [bold type]NORTH[roman type] to the Disease Citadel - the Unseen Crown's domain. Walk to one (just type N or S). Inside, each faction keeps a recruiter; when one wins you over, swear with [bold type]CHOOSE <patron>[roman type] - e.g. [bold type]CHOOSE CRADLE[roman type] or [bold type]CHOOSE VIBRIO[roman type].[paragraph break]Only after you have sworn can you cross the cosmos by concordance ([bold type]GO TO <place>[roman type]); until then [bold type]GO TO[roman type] is refused. Three roads leave the newborn light: south to Medicine, north to the Disease Citadel (the Unseen Crown's domain), and west - where the land glows wrong - belongs to the Old Metals. Type [bold type]HELP[roman type] any time to see this again."

After looking in the Singularity for the first time:
	say the newcomer primer.

The Hall of Medicine is south of the Singularity. "In the Hall of Medicine shrines many deceased historical medical characters - and three living powers of the Athena Aegis Accord keep their vigil here: the Cradle of Aukin (which keeps the Heavy Metal Pantheon's interest in this hall as its sworn agent), the Celestial Corps, and the Shrine of the Lab Martyrs. Under the banners wait a medullary preceptor, a fleet navigator, and a quiet keeper - one recruiter for each power, each ready to make the case for a sworn oath."

The Disease Citadel is north of the Singularity. "The Disease Citadel is where diseases are born, and its six ways open onto the dark for Archaeology, Fear Technology, the Pale Masquerade, the Undead Court, the Department of Silence and the Abyssal fleet - and under six banners wait a resurrected Archaea, a containment supervisor, a masked emissary, a pale Bride, a personnel officer, and a gum-chewing girl in a sailor suit. Each is a recruiter for a faction of the Unseen Crown, each with a case to make and a secret to trade."

After going to the Disease Citadel for the first time:
	say "You have walked into the Unseen Crown's domain. Six banners crown the dark hall, and under each waits a recruiter who wants your oath:[paragraph break]   [bold type]a plain-clothes veteran Archaea[roman type] (the Archaeology Division), [bold type]a containment supervisor[roman type] with a drone on her shoulder (Fear Technology), [bold type]a sunflower muse[roman type] (the Pale Masquerade), [bold type]a pale Bride of Count Dracula[roman type] (the Undead Court), [bold type]a personnel officer[roman type] (the Department of Silence), and [bold type]a gum-chewing girl in a sailor suit[roman type] (the Abyssal Legion).[paragraph break]Court any of them before you swear - each hides a secret, if you ask. When one wins you over: CHOOSE VIBRIO, CHOOSE DRACULA, CHOOSE FEAR, CHOOSE ARCHAEOLOGY, CHOOSE PALLIDUM, or CHOOSE STILLE. For example: [bold type]ASK THE GIRL ABOUT JOINING[roman type]."

After going to the Hall of Medicine for the first time:
	say "You have walked into the Hall of Medicine, where the healing powers of the Accord keep their banners - and under each waits a recruiter who wants your oath:[paragraph break]   [bold type]a medullary preceptor[roman type] (the Cradle of Aukin - sworn agent of the Heavy Metal Pantheon), [bold type]a fleet navigator[roman type] (the Celestial Corps), and [bold type]a quiet keeper[roman type] (the Lab Martyrs).[paragraph break]Court any of them before you swear - each hides a secret, if you ask. When one wins you over: CHOOSE CRADLE, CHOOSE CELESTIAL, or CHOOSE MARTYRS. The Heavy Metal Pantheon keeps no banner in this hall - the Cradle keeps its interest as agent, and the Old Metals themselves answer only at their own door, west of the Wastes. For example: [bold type]ASK THE PRECEPTOR ABOUT JOINING[roman type]."



Helping is an action applying to nothing. Understand "help" or "commands" as helping.
Report helping: say the newcomer primer.

Chapter - The Patron Choice

A patron is a kind of value. The patrons are unsworn, cradle, celestial, pantheon, martyrs, archaeology, fear-tech, pallidum, rabies, typhi and vibrio.

The player's patron is a patron that varies. The player's patron is usually unsworn.

Choosing a patron is an action applying to one topic. Understand "choose [text]" or "serve [text]" or "patron [text]" as choosing a patron.

Check choosing a patron:
	if the player's patron is not unsworn:
		say "You have already sworn to a patron." instead;
	if the location is not the Hall of Medicine and the location is not the Disease Citadel and the location is not the Black Cathedral:
		say "The swearing is done at the two gates, or at the door of the Pantheon itself if you have crossed the Wastes alive." instead;
	let t be the topic understood;
	if "[t]" matches the regular expression "^(pantheon|heavy metal|heavy metal pantheon|metal pantheon|lucifer|mercury|radium)" and the location is the Hall of Medicine:
		say "The Heavy Metal Pantheon keeps no banner in this hall - the Cradle of Aukin keeps its interest here as agent. The Old Metals answer only at their own door, west of the Wastes. Cross alive, then swear at the Cathedral: CHOOSE PANTHEON." instead.

Carry out choosing a patron:
	let choice be the topic understood;
	let lowered be "[choice]" in lower case;
	if the lowered matches the regular expression "^(citadel|disease citadel)$":
		say "That is this gate's name, not a patron. Pick one of its six banners: [bold type]CHOOSE VIBRIO[roman type], CHOOSE DRACULA, CHOOSE FEAR, CHOOSE ARCHAEOLOGY, CHOOSE PALLIDUM, or CHOOSE STILLE.";
		rule succeeds;
	if the lowered matches the regular expression "^(hall|medicine|hall of medicine)$":
		say "That is the other gate's name, not a patron. Its three banners are: CHOOSE CRADLE, CHOOSE CELESTIAL, CHOOSE MARTYRS - or stay here and pick one of the six above.";
		rule succeeds;
	if the lowered matches the regular expression "^(cradle|cradle of aukin|aukin|aukin empire|tylean|generalizer)( or .*)?$":
		say "The Generalizer lifts the honey-gold AIRE flame. 'Then learn this first, traveler: the stricter the definition of self, the more of the self becomes unrecognizable.' You swear to the Cradle.";
		now the player's patron is cradle;
	otherwise if the lowered matches the regular expression "^(celestial|celestial corps|corps|vesalius|leonardo|harvey)( or .*)?$":
		say "Vesalius strikes the cardiac error from his own hanging map in salute. 'Never navigate by ancient maps,' he says. 'We will teach you to draw the true ones.' You swear to the Celestial Corps.";
		now the player's patron is celestial;
	otherwise if the lowered matches the regular expression "^(pantheon|heavy metal|heavy metal pantheon|metal pantheon|lucifer|mercury|radium)( or .*)?$":
		say "The Morning Star inclines his dripping crown. 'You cannot destroy an element,' Lucifer says. 'You can only hope to contain it. Learn containment, and you will never fear the dark chemistry.' You swear to the Heavy Metal Pantheon.";
		now the player's patron is pantheon;
	otherwise if the lowered matches the regular expression "^(martyrs|lab martyrs|shrine|hela|laika|mouse)( or .*)?$":
		say "HeLa's luminosity brightens by one candle's worth; Laika's ghost-shape circles once. 'They asked for nothing,' HeLa says. 'You asked to serve. That is the difference.' You swear to the Lab Martyrs.";
		now the player's patron is martyrs;
	otherwise if the lowered matches the regular expression "^(archaeology|archaeology division|division|sulfur|archaea|ancestor)( or .*)?$":
		say "The Division Chief taps the tile motto. 'In the beginning, there was sulfur. We are not inventing, traveler - we are remembering.' You swear to the Archaeology Division.";
		now the player's patron is archaeology;
	otherwise if the lowered matches the regular expression "^(fear|fear-tech|fear technology|fear technology division|puppet|puppet workshop|director|moonstar|sightings)( or .*)?$":
		say "The Director makes one note on her containment schedule - ITEM: THE TRAVELER. STATUS: VOLUNTEER. 'The door you just walked past is not for you anymore,' she says, not looking up. 'It never needed a puppet. Welcome to Site-66.' You swear to Fear Technology.";
		now the player's patron is fear-tech;
	otherwise if the lowered matches the regular expression "^(pallidum|pale masquerade|masquerade|masquer|masque|imitation|imitator)( or .*)?$":
		say "The Pale Masquer curtsies, porcelain spiral catching the light. 'I wear a thousand faces, traveler, and every one of them is beautiful.' You swear to the Pallidum court.";
		now the player's patron is pallidum;
	otherwise if the lowered matches the regular expression "^(rabies|undead|undead court|dracula|castle|bride|brides)( or .*)?$":
		say "The Count regards you across the dry fountains. 'Fear is not a weapon. Fear is the battlefield,' he says. 'Welcome to the field.' You swear to the Undead Court.";
		now the player's patron is rabies;
	otherwise if the lowered matches the regular expression "^(typhi|stille|abteilung stille|department of silence|silence|mary|amanuensis)( or .*)?$":
		say "The Amanuensis stamps gall-coloured wax without looking up. 'The perfect spy does not know she is a spy,' she says. 'You, at least, will know.' You swear to Abteilung Stille.";
		now the player's patron is typhi;
	otherwise if the lowered matches the regular expression "^(vibrio|abyssal|abyssal legion|abyssal fleet|octopus|octopus admiral|admiral|cholera|cholera octopus)( or .*)?$":
		say "She snaps a salute that suddenly has not one gram of laziness in it, and behind her the column clears to a live view of the abyss - the flagship's cannon-bores sealing like sleeping eyes. 'Water is life, water is death,' she says. 'Take the water away and we are a museum exhibit - so we never let it be taken. Welcome to the water, traveler.' You swear to the Abyssal Legion.";
		now the player's patron is vibrio;
	otherwise:
		if the location is the Disease Citadel:
			say "No patron by that name. The six banners of this gate answer to any of their names: CHOOSE VIBRIO or CHOOSE ABYSSAL LEGION, CHOOSE DRACULA or CHOOSE UNDEAD COURT, CHOOSE FEAR or CHOOSE FEAR TECHNOLOGY, CHOOSE ARCHAEOLOGY or CHOOSE ARCHAEOLOGY DIVISION, CHOOSE PALLIDUM or CHOOSE PALE MASQUERADE, CHOOSE STILLE or CHOOSE DEPARTMENT OF SILENCE." instead;
		otherwise:
			say "No patron by that name. The three banners of this gate answer to: CHOOSE CRADLE (Cradle of Aukin, agent of the Pantheon), CHOOSE CELESTIAL (Celestial Corps), CHOOSE MARTYRS (Lab Martyrs)." instead.

Report choosing a patron:
	if the player's patron is not unsworn:
		say "[line break]The war arranges itself around your oath - and the Keeper of the Gate watches you like a woman who has just seen the weather change.[line break]The Keeper's road-map appears in your satchel.[line break](Sworn is not won. GO TO each faction's hall, complete its trial, and earn all ten seals - then REPORT. Type BANNERS to track them; ASK a faction's representative ABOUT SEAL to learn its trial.)";
		now the player carries the Keeper's road-map;
		now the score is 0.





Prologue-end is a scene. Prologue-end begins when the player's patron is not unsworn.

When Prologue-end begins:
	say "The Singularity seals itself behind the Big Bang. The gates open. A launch skiff carries you to neutral waters.[paragraph break]The circuit of the Ten Banners begins.";
	move the player to the Free Port Landing;
	say "[line break][bold type]HOW TO TRAVEL[roman type]: no compass needed at this hub. List every destination:[line break]      ASK KEEPER ABOUT DESTINATIONS[line break]then jump straight there:[line break]      GO TO UNDEAD COURT      (GO TO LANDING brings you home.)[line break]Carry every won seal home and REPORT to raise the standards.";
	say "[line break][bold type]HOW TO WALK[roman type]: directions still work where roads exist - type [bold type]N[roman type] / [bold type]S[roman type] / and so on to walk a real road instead of using the concordance.";
	say "[line break][bold type]YOUR ROAD[roman type]: ten halls, ten seals, and every faction watching you choose. The Keeper raises a standard for each seal you bring home - type [bold type]BANNERS[roman type] to see how far you have come, [bold type]REPORT[roman type] to raise what you carry. No one has ever walked all ten halls and lived to be welcome in all of them. When the tenth standard flies, you will be the first - and you will finally see the whole war.";

Chapter - The Concordance

[The Keeper's road-map doubles as a travel charter: a sworn traveler may GO TO any
charted hall of the war. Room aliases cover every name the gate descriptions
and porcelain plates use.]

A room has a list of texts called the concordance names. The concordance names of a room are usually { }.

The concordance names of the Free Port Landing are { "barge", "truce barge", "home", "landing", "free port landing" }.
The concordance names of the Cradle Outer Court are { "cradle", "medulla", "aukin", "market", "factor" }.
The concordance names of the Singularity are { "singularity", "start", "beginning" }.
The concordance names of the Fabrica Bridge are { "celestial corps", "fabrica", "bridge" }.
The concordance names of the Dawn Pioneer Deck are { "dawn pioneer", "pioneer", "leonardo" }.
The concordance names of the Black Cathedral are { "pantheon", "heavy metal", "cathedral" }.
The concordance names of the Shrine of the Knitting Mouse are { "martyrs", "lab martyrs", "shrine", "novosibirsk" }.
The concordance names of the Dark Concourse are { "concourse", "umin" }.
The concordance names of the Sulfur Vent Gallery are { "archaeology", "archaeology division", "sulfur vent" }.
The concordance names of the Abteilung Stille Office are { "typhi", "stille", "silence", "department of silence" }.
The concordance names of the Puppet Workshop are { "fear technology", "fear tech", "puppet workshop", "workshop" }.
The concordance names of the Masquerade Ballroom are { "masquerade", "ballroom", "pale masquerade" }.
The concordance names of the Blood Court are { "undead court", "blood court", "undead" }.
The concordance names of the Castle Gate are { "castle", "castle gate" }.
The concordance names of the Abyssal Deck are { "abyssal fleet", "abyss", "abyssal deck" }.

Warping to is an action applying to one topic.
Understand "go to [text]" as warping to.
Understand "goto [text]" as warping to.
Understand "travel to [text]" as warping to.

Check warping to:
	if the player's patron is unsworn:
		if the topic understood matches the regular expression "^singularity$|^start$":
			say "The concordance serves even the unsworn for errands: the Singularity, where the road west begins.";
			continue the action;
		if the location is the Disease Citadel:
			say "Not yet - the concordance serves the sworn only. Your next step, right here: pick a banner and swear. [bold type]CHOOSE VIBRIO[roman type] (Abyssal Legion), CHOOSE DRACULA (Undead Court), CHOOSE FEAR (Fear Technology), CHOOSE ARCHAEOLOGY, CHOOSE PALLIDUM (Pale Masquerade), or CHOOSE STILLE (Department of Silence). The Hall of Medicine to the south holds four more." instead;
		otherwise if the location is the Hall of Medicine:
			say "Not yet - the concordance serves the sworn only. Your next step, right here: pick a banner and swear. [bold type]CHOOSE CRADLE[roman type] (the immune academy of Aukin), CHOOSE CELESTIAL (the Celestial Corps), CHOOSE PANTHEON (Heavy Metal Pantheon), or CHOOSE MARTYRS (the Lab Martyrs). The Disease Citadel to the north holds six more." instead;
		otherwise:
			say "Not yet - the concordance serves the sworn only. Walk back to a gate (GO SOUTH from the Singularity) and CHOOSE a patron." instead.

Carry out warping to:
	let dir-topic be "[the topic understood]" in lower case;
	if the dir-topic is "north" or the dir-topic is "south" or the dir-topic is "east" or the dir-topic is "west" or the dir-topic is "northeast" or the dir-topic is "northwest" or the dir-topic is "southeast" or the dir-topic is "southwest" or the dir-topic is "up" or the dir-topic is "down" or the dir-topic is "in" or the dir-topic is "out" or the dir-topic is "inside" or the dir-topic is "outside":
		say "For walking, just type the direction itself.";
		rule succeeds;
	let lowered-topic be "[the topic understood]" in lower case;
	repeat with destination running through rooms:
		if the concordance names of destination is not { }:
			if the lowered-topic is listed in the concordance names of destination:
				say "The manifest takes your word, and the concordance carries you along the great vessels of the war.";
				move the player to the destination;
				rule succeeds;
	say "The concordance charts the port landing and every banner's hall. Destinations: LANDING, CRADLE, CELESTIAL CORPS, PANTHEON, MARTYRS, CONCOURSE, ARCHAEOLOGY, STILLE, FEAR TECHNOLOGY, MASQUERADE, UNDEAD COURT, CASTLE, ABYSSAL FLEET."

The six Umin doors are scenery in the Disease Citadel. The printed name is "six doors". Understand "doors" and "six doors" and "porcelain plates" and "plates" as the six Umin doors. The description is "Six doors on the dark, each named on a porcelain plate: ARCHAEOLOGY. FEAR TECHNOLOGY. THE PALE MASQUERADE. THE UNDEAD COURT. THE DEPARTMENT OF SILENCE. THE ABYSSAL FLEET. Examine any door - and once sworn, the concordance will carry you through: GO TO its faction."

The archaea door is scenery in the Disease Citadel. The printed name is "Archaeology door". Understand "archaeology" and "archaeology door" and "archaea" and "sulfolobus door" as the archaea door. The description is "Porcelain plate: ARCHAEOLOGY DIVISION, THE SEEKERS OF PRIMORDIAL LIFE. Through the gap: mineral heat, sample racks, and the tiled motto IN THE BEGINNING, THERE WAS SULFUR. [if the player's patron is unsworn]The hinges hold against the unsworn.[otherwise]The concordance will carry you: GO TO ARCHAEOLOGY.[end if]"

The fear door is scenery in the Disease Citadel. The printed name is "Fear Technology door". Understand "fear" and "fear technology" and "fear technology door" and "puppet door" as the fear door. The description is "Porcelain plate: FEAR TECHNOLOGY, THE PUPPET WORKSHOP. Through the gap: cold white light, animatronic frames in crates marked CULTURAL SPECIFIC, and a low drone under hearing. [if the player's patron is unsworn]The hinges hold against the unsworn.[otherwise]The concordance will carry you: GO TO FEAR TECHNOLOGY.[end if]"

The masquerade door is scenery in the Disease Citadel. The printed name is "Pale Masquerade door". Understand "pale masquerade" and "masquerade door" and "masquerade" as the masquerade door. The description is "Porcelain plate: THE PALE MASQUERADE. Through the gap: candlelight, water-music, a pavane one beat behind itself. [if the player's patron is unsworn]The hinges hold against the unsworn.[otherwise]The concordance will carry you: GO TO MASQUERADE.[end if]"

The undead door is scenery in the Disease Citadel. The printed name is "Undead Court door". Understand "undead" and "undead court" and "undead door" and "castle door" as the undead door. The description is "Porcelain plate: THE UNDEAD COURT. Through the gap: a gatehouse of imported Transylvanian stone, a humidity gauge at fifteen percent, and a doorman who counts guests twice. [if the player's patron is unsworn]The hinges hold against the unsworn.[otherwise]The concordance will carry you: GO TO UNDEAD COURT.[end if]"

The abyssal door is scenery in the Disease Citadel. The printed name is "Abyssal Fleet door". Understand "abyssal" and "abyssal fleet" and "abyssal door" and "fleet door" as the abyssal door. The description is "Porcelain plate: THE ABYSSAL FLEET. Through the gap: sodium light on a floodable deck and the shape of the Cholera Octopus at anchor. [if the player's patron is unsworn]The hinges hold against the unsworn.[otherwise]The concordance will carry you: GO TO ABYSSAL FLEET.[end if]"

The four Accord shrines are scenery in the Hall of Medicine. The printed name is "four shrines". Understand "shrines" and "four shrines" and "shrine niches" and "niches" as the four Accord shrines. The description is "Four shrine-niches face the gate, one for each sworn power of the Accord: THE CRADLE OF AUKIN. THE CELESTIAL CORPS. THE HEAVY METAL PANTHEON. THE LAB MARTYRS. Examine any shrine - and once sworn, the concordance will carry you through: GO TO its hall."

The cradle shrine is scenery in the Hall of Medicine. The printed name is "Cradle shrine". Understand "cradle shrine" and "shrine of aukin" as the cradle shrine. The description is "A niche of whitewashed cloister-stone. The inscription: ALL ARMIES ARE BORN IN STILLNESS. TEACH THE CELL BEFORE THE BATTLE TEACHES IT. [if the player's patron is unsworn]The niche is dark until an oath lights it.[otherwise]The concordance will carry you: GO TO CRADLE.[end if]"

The celestial shrine is scenery in the Hall of Medicine. The printed name is "Celestial shrine". Understand "celestial shrine" and "celestial" and "corps shrine" as the celestial shrine. The description is "A niche hung with the Vesalius Map: the cosmos drawn as a giant human body. The inscription: AS ABOVE, SO BELOW. [if the player's patron is unsworn]The niche is dark until an oath lights it.[otherwise]The concordance will carry you: GO TO CELESTIAL CORPS.[end if]"

The pantheon shrine is scenery in the Hall of Medicine. The printed name is "Pantheon shrine". Understand "pantheon shrine" and "pantheon" and "metal shrine" as the pantheon shrine. The description is "A niche of vitrified glass and old lead. The inscription: YOU CANNOT DESTROY AN ELEMENT - YOU CAN ONLY HOPE TO CONTAIN IT. [if the player's patron is unsworn]The niche is dark until an oath lights it.[otherwise]The concordance will carry you: GO TO PANTHEON.[end if]"

The martyrs shrine is scenery in the Hall of Medicine. The printed name is "Martyrs shrine". Understand "martyrs shrine" and "martyr shrine" as the martyrs shrine. The description is "A niche holding a bronze mouse in pince-nez, a small dog's collar, and a slide of immortal cells. The inscription: THEY ASKED FOR NOTHING. THEY GAVE EVERYTHING. [if the player's patron is unsworn]The niche is dark until an oath lights it.[otherwise]The concordance will carry you: GO TO MARTYRS.[end if]"


Part One - Seals and Bookkeeping

A seal is a kind of thing. Understand "seal" and "banner" as a seal.

A seal has some text called trial text.
A person has a patron called faction patron. The faction patron of a person is usually unsworn.

The cradle sigil is a seal. The printed name is "Cradle Sigil". Understand "cradle" as the cradle sigil. The description is "A ring of bone-white alloy stamped with the Dhyana sign for listening. The Cradle grants it to travelers who can say what the self is for."

The corps medallion is a seal. The printed name is "Vesalius Medallion". Understand "medallion" as the corps medallion. The description is "A struck bronze face in profile beside a starred anatomy. The Celestial Corps issues it for corrected charts."

The quicksilver ampoule is a seal. The printed name is "Quicksilver Ampoule". Understand "quicksilver" and "ampoule" as the quicksilver ampoule. The description is "A sealed glass thread of liquid metal. It is not a gift; it is a receipt, acknowledging that you looked into the mirror and did not blink."

The knitting needle is a seal. The printed name is "Knitting Needle". Understand "needle" and "knitting" as the knitting needle. The description is "One of the two bronze needles from the Novosibirsk monument, warm as a living paw. The Martyrs lend it only to those who leave an offering."

The sulfur sigil is a seal. The printed name is "Sulfur Sigil". Understand "sulfur" and "sulphur" as the sulfur sigil. The description is "A crystal of primordial yellow grown around a strand of archaeal DNA. In the beginning, there was sulfur."

The pale masque is a seal. The printed name is "Pale Masque". Understand "masque" as the pale masque. The description is "A porcelain half-mask with a spiral flourish at the temple. The Great Imitator signs her work."

The bat sigil is a seal. The printed name is "Bat Sigil". Understand "bat" as the bat sigil. The description is "A black disc stamped with spread wings. The Undead Court marks with it those who faced the first fear and stayed polite."

The stille seal is a seal. The printed name is "Stille Seal". Understand "stille" as the stille seal. The description is "Wax the colour of gall, pressed with a modest spiral. Abteilung Stille seals the dossiers of people who are not there any more."

The sightings lanyard is a seal. The printed name is "Sightings Lanyard". Understand "lanyard" and "sightings" as the sightings lanyard. The description is "A woven cord with a laminated pass reading BEARER CLEARED FOR SIGHTINGS. Fear Technology issues it to visitors who keep their pulse under command."

The abyssal pennant is a seal. The printed name is "Abyssal Pennant". Understand "pennant" and "abyssal" as the abyssal pennant. The description is "A wet swallow-tailed flag that never quite dries. The Abyssal Legion flew it over the first flooded field."

[Comment: TRIAL TEXTS - shown when a faction representative is asked ABOUT SEAL/TRIAL/TASK. Edit these freely; the task mechanics live elsewhere, these are only the briefing strings.]
The trial text of the cradle sigil is "Attend the lectures at the Cradle Inner Court and answer the Generalizer on what intolerance engineers; then ASK SISTER FRANKLIN about THE FIRE and two of her questions, ENTER THE MEMORY, and walk the Wastes of Sacrum as she walked it - read the registry, SAY THE NAMES in the Core Chamber, lay the Eighth Seal on the throne. Come out and TELL FRANKLIN one thing you carried back: she grants the sigil and the Aukin gauntlets."
The trial text of the corps medallion is "Bring Leonardo's codex to Vesalius legible: have it mirror-read at the Black Cathedral's mercury pool first (the Aukin gauntlets let you touch it), then SHOW it to Vesalius to correct his chart."
The trial text of the quicksilver ampoule is "Read Leonardo's codex in the mercury mirror of the Black Cathedral - wear the Aukin gauntlets to touch the pool, and Lucifer himself hands you the ampoule."
The trial text of the knitting needle is "Buy the offering bundle from the Cradle's factor (one token), then lay its three offerings - strand, treat, wheel - on the Martyrs' altar."
The trial text of the sulfur sigil is "Extract a clean sulfolobus sample from the vent and GIVE it to the Division Chief."
The trial text of the pale masque is "At the Masquerade, UNMASK the Pale Masquer - look twice at the beautiful, and she gives you the mask."
The trial text of the bat sigil is "Buy the Pasteur vial from the Cradle's factor (one token), then SHOW it to Count Dracula himself."
The trial text of the stille seal is "In the Stille office, ACCUSE the stern quartermaster - name the mimic and the Amanuensis stamps your finding."
The trial text of the sightings lanyard is "Read the Rationality Protocol pamphlet the Accord publishes, then keep your pulse through the Puppet Workshop and ASK the Director about sightings."
The trial text of the abyssal pennant is "At the Abyssal Deck, ASK the Octopus Admiral about cannons or water, and watch the hydro-cannon trial without flinching."

To decide which patron is the patron of (tk - a seal):
	if tk is the cradle sigil, decide on cradle;
	if tk is the corps medallion, decide on celestial;
	if tk is the quicksilver ampoule, decide on pantheon;
	if tk is the knitting needle, decide on martyrs;
	if tk is the sulfur sigil, decide on archaeology;
	if tk is the pale masque, decide on pallidum;
	if tk is the bat sigil, decide on rabies;
	if tk is the stille seal, decide on typhi;
	if tk is the sightings lanyard, decide on fear-tech;
	if tk is the abyssal pennant, decide on vibrio;
	decide on unsworn.

[Comment: FACTION REPRESENTATIVES - which NPC speaks for which faction. Add or reassign freely.]
The faction patron of the Generalizer is cradle.
The faction patron of Tylean is cradle.
The faction patron of Sister Franklin is cradle.
The faction patron of Vesalius is celestial.
The faction patron of Lucifer is pantheon.
The faction patron of HeLa is martyrs.
The faction patron of the Division Chief is archaeology.
The faction patron of the Pale Masquer is pallidum.
The faction patron of Count Dracula is rabies.
The faction patron of the Stille Amanuensis is typhi.
The faction patron of the Director is fear-tech.
The faction patron of the Octopus Admiral is vibrio.

To decide which seal is the standard of (p - a patron):
	if p is cradle, decide on the cradle sigil;
	if p is celestial, decide on the corps medallion;
	if p is pantheon, decide on the quicksilver ampoule;
	if p is martyrs, decide on the knitting needle;
	if p is archaeology, decide on the sulfur sigil;
	if p is pallidum, decide on the pale masque;
	if p is rabies, decide on the bat sigil;
	if p is typhi, decide on the stille seal;
	if p is fear-tech, decide on the sightings lanyard;
	if p is vibrio, decide on the abyssal pennant;
	decide on the cradle sigil.

Instead of asking a person about something when the topic understood matches the regular expression "^seal$|^trial$|^task$|^earn$":
	if the faction patron of the noun is unsworn:
		say "[The noun] keeps no trial to disclose.";
	otherwise:
		let s be the standard of the faction patron of the noun;
		if the trial text of s is "":
			say "[The noun] says only: complete our trial, and the [printed name of s] is yours.";
		otherwise:
			say the trial text of s.

[Comment: these two representatives have catch-all asking rules below, so they need their own more specific SEAL rules to win over them.]
Instead of asking the Stille Amanuensis about something when the topic understood matches the regular expression "^seal$|^trial$|^task$|^earn$":
	let s be the standard of the faction patron of the Stille Amanuensis;
	say the trial text of s.

Instead of asking the Octopus Admiral about something when the topic understood matches the regular expression "^seal$|^trial$|^task$|^earn$":
	let s be the standard of the faction patron of the Octopus Admiral;
	say the trial text of s.

To grant (prize - a seal) noting (flavor - text):
	now the player carries the prize;
	increase the score by 1;
	say "[line break][flavor][line break]";
	if the score is 10:
		say "[line break]Ten seals ride in your satchel. Behind you, the Free Port Landing waits for its standards.[line break]";

Requesting the banner tally is an action applying to nothing.
Understand "banners" or "tally" or "progress" as requesting the banner tally.

Carry out requesting the banner tally:
	let delivered be the number of seals on the standard rack;
	let held be the number of seals carried by the player;
	say "Banners: [delivered] delivered, [held] in hand, [10 minus delivered minus held] not yet won.";
	if the player's patron is not unsworn:
		say "(Oath sworn - but swearing is only the first step: win that faction's challenge and carry its seal home to earn its banner.)";
	repeat with token running through seals:
		if token is on the standard rack:
			say "  [printed name of token] - delivered to the Keeper.";
		otherwise if token is carried by the player:
			say "  [printed name of token] - in your satchel (won, not yet delivered).";
		otherwise if the patron of token is the player's patron:
			say "  [printed name of token] - oath sworn, seal not yet earned (win the hall's challenge and bring the seal).";
		otherwise:
			say "  [printed name of token] - not yet won."

Reporting in is an action applying to nothing.
Understand "report" or "report in" or "hand over the banners" or "deliver the seals" as reporting in.

Carry out reporting in:
	if the number of seals carried by the player is 0:
		say "The Keeper glances at your satchel. 'Light, traveler. The standards remember being banners.'";
	otherwise:
		repeat with token running through seals carried by the player:
			now token is on the standard rack;
		say "You lay each banner at the standards and the Keeper raises them one by one, and for a moment she is not weather at all - she is the last official of a war that has waited for a witness. [The number of seals on the standard rack] of the ten standards now fly.";
		if the number of seals on the standard rack is 10:
			raise the ten banners.

Listing carried seals is an action applying to nothing.
Understand "seals" or "list seals" or "my seals" as listing carried seals.

Carry out listing carried seals:
	if the number of seals carried by the player is 0:
		say "You carry no seal yet - win a faction's challenge and bring its sigil home.";
	otherwise:
		say "Seals in your keeping:";
		repeat with s running through seals carried by the player:
			say "  [printed name of s].";
		say "REPORT raises every seal you carry at once; or GIVE a single seal TO KEEPER to deliver just that one."

To raise the ten banners:
	say "The Keeper binds the last seal to its standard and steps back. Ten banners over a neutral deck: the Cradle's listening ring, Vesalius's bronze face, a thread of quicksilver, a knitting needle, a sulfur crystal, a porcelain masque, a black bat, a gall-coloured seal, a laminated pass, a wet pennant.
'Understand what you have carried,' she says. 'An academy that teaches the self. A fleet that maps the body-cosmos. Gods that cannot be killed, only contained. Martyrs who were never asked. And the Unseen Crown - ancestors, terrors, imitators, the dead who fight while dying, and the quiet ones who replace you. This is the shape of the war. Now the Accord can draw it.'
The map of the whole body-cosmos rolls out across the table, ten colours deep.";
	end the story finally saying "The Ten Banners stand raised over the Pericardium Free Port."

Abouting is an action applying to nothing.
Understand "about" or "credits" or "help" as abouting.

Carry out abouting:
	say "SOME-UNIVERSE: THE TEN BANNERS - an interactive chronicle built from the faction archives of the SoMe-Universe (Saga of Medicine) project.
You are the one the ten banners have been waiting for - awake, unclaimed, and brave enough to walk into every hall. Win each faction's seal and bring them to the Keeper at the Free Port Landing.
Useful commands: BANNERS (progress tally), REPORT (deliver carried seals), GO TO (place) (fast travel once sworn), LOOK, EXAMINE things, ASK [bracket]someone[close bracket] ABOUT [bracket]topic[close bracket], GIVE and SHOW things to people, WEAR and REMOVE clothing, BUY what the Cradle's factor offers.
Every faction is reachable from the Free Port Landing: GO TO a destination, and the concordance will carry you. The west road - the Pantheon - begins at the Singularity, and it is the one road the concordance will not walk for you.
Built with Inform 7. Setting and factions by the SoMe-Universe contributors."

Part Two - The Free Port Landing

The Free Port Landing is a room. "The landing stage of the Pericardium Free Port, the one place the war may not touch: tariffs fund the Cradle, every flag may dock, and no act of war may be committed within the pericardial sac. The Keeper keeps the standards here, on the one ground every faction still respects - where oaths bind and the war holds its breath. Go to any banner's hall from this deck - the port's manifests know them all."

Instead of going east from the Free Port Landing:
	say "East lies the open sac - bright water, no shore. The port's business is all inland."

Instead of going up from the Free Port Landing:
	say "Nothing up there but the pump's breath."

Instead of going down from the Free Port Landing:
	say "The sac floor is far below, and out of bounds by treaty."

Instead of going northeast from the Free Port Landing:
	say "The northeast channel is reserved for the great conduits."

Instead of going southeast from the Free Port Landing:
	say "The southeast channel is reserved for the great conduits."

Instead of going north from the Free Port Landing:
	say "There is no road north on foot from the Landing - only open water and the white-rib shore, which the concordance reaches but your feet do not. Use GO TO WHITE RIB GATE, or ASK KEEPER ABOUT DESTINATIONS for every destination."

The standard rack is a scenery supporter in the Free Port Landing. Understand "standard" or "standards" or "rack" as the standard rack. The description is "Ten standards in a row, each waiting for a faction's seal. [if the number of seals on the standard rack is 0]Every pole is bare.[otherwise][The number of seals on the standard rack] of the ten fly banners now.[end if]"

The chart table is a scenery supporter in the Free Port Landing. Understand "table" and "chart" as the chart table. The description is "Sea-charts of the great vessels, an anatomical atlas of Planet Homo Sapiens, and room for ten banners when you bring them home."

The Rationality Protocol pamphlet is a thing on the chart table. Understand "pamphlet" and "rationality" and "protocol" as the Rationality Protocol pamphlet. The description is "An AAA field manual: PRE-EMPTIVE EDUCATION. RAPID RESPONSE. PSYCHOLOGICAL INOCULATION. TRUST RESTORATION. A margin note adds, in pencil: 'Fear is the battlefield. Keep your pulse under command.'"

The Keeper's road-map is a thing carried by the player. The printed name is "the Keeper's road-map". Understand "manifest" and "roadmap" and "road-map" and "map" and "dossier" and "brief" and "orders" as the Keeper's road-map. The description is "ACCORD ENVOY BRIEF, FIRST CLASS. Ten factions require formal contact:
- WEST: the Pantheon - the Cathedral of the Old Metals. The Radiology clergy guard the turn; go armored or do not go.
- NORTH: the Empire of Aukin and the Cradle, beyond the White Rib Gate (Thoracica).
- NORTHWEST: the Celestial Corps, over the Void Verge.
- WEST: the Heavy Metal Pantheon, in the Contaminated Wastes.
- SOUTHWEST: the Lab Martyrs, in the Siberian Reach.
- SOUTH: the Unseen Crown (Umin) - the Dark Concourse opens six doors: the Archaeology Division, Fear Technology, the Pallidum court, the Rabies court, the Typhi office, and the Vibrio fleet beyond.
The Cradle's outer court keeps a neutral factor's stall for travelers bound for the shrine or the dark courts - trust carefully, decide slowly. - K.
[line break][line break]A margin note, in a different hand: CHOOSE takes a banner's short name or its full name alike - CHOOSE UNDEAD COURT is the same oath as CHOOSE DRACULA."

An exchange token is a kind of thing. The printed name of an exchange token is "exchange token". Understand "token" and "tokens" and "exchange" as an exchange token. The description of an exchange token is "A stamped token of exchange, good at the Pericardium Free Port. The Pump's peace is not free."

The first exchange token, the second exchange token and the third exchange token are exchange tokens. The player carries the first exchange token. The player carries the second exchange token. The player carries the third exchange token.

Chapter - The Western Road and the Radiologist

[Pantheon is the third realm: west of the Singularity, past the Medics'
warnings. The Radiologist orders the turn, and the Wastes judge the
unshielded.]





The Pilgrim Turn is mapped west of the Singularity. The Singularity is mapped east of the Pilgrim Turn. The Contaminated Wastes is mapped west of the Pilgrim Turn.

The description of the Pilgrim Turn is "The road west forks at a shrine of white lead paint and surgical steel: a wayside chapel where the Radiology clergy keep their vigil. Beyond it the land turns strange - vitrified glass underfoot, the horizon glowing faintly, the light of the Black Cathedral catching wrong on the dust. A stone placard reads, in three languages: TURN BACK, OR COME ARMED."

The Pilgrim Turn is a room.



The Radiologist is a man in the Pilgrim Turn. "A priest of the Radiology Order bars the west road - lead-lined vestments, a collimator staff, eyes that have watched tumors die and patients glow. His hands under the lead gloves are not quite hands anymore: the borrowed light has been settling into him for decades." The description is "The Radiology Order serves the Hall of Medicine, but their power is borrowed from the Pantheon: they aim the gods' own light at tumors and pray the patient outlasts the cure. Every priest pays for the borrowing - the light settles into the ones who aim it, and he has been aiming for forty years. That is why he says your fables, your kind, your side of the road: he is no longer sure the west counts him as a stranger. He was sent here to turn back the unshielded, and he has buried the ones who would not turn." Understand "priest" and "radiology" and "radiologist priest" as the Radiologist.

After going to the Pilgrim Turn for the first time:
	say "The Radiologist steps into the road before you have decided to stop. 'West is the third realm - the Pantheon, the Cathedral of the Old Metals, the Far Shore your pilgrim fables guessed at - forgive the your; after forty years of the borrowed light, I no longer know which shore I am standing on. No one in either gate will thank you for knowing: the Medics borrow its light and the Citadel fears its ground, so both pretend the west is empty. I will tell you what no brochure will: the gods there do not hate you. They simply are - and their bare attention kills. Even the Citadel's plagues route around that ground; even we, who borrow their light to burn tumors, stand in it only lead-clad. You are not lead-clad.'";

Instead of going west from the Pilgrim Turn when the Aegis gauntlets are not worn by the player and radiology-warning is less than 2:
	if radiology-warning is 0:
		now radiology-warning is 1;
		say "The Radiologist's staff comes down across the road like a barrier dropping. 'Stop. Hear the whole sentence before you spend your body.[paragraph break]'You want the gods. I understand - I serve their light, and I have watched it take tumors that no knife could reach. But radiology is a borrowed fire: we lead-line our priests, we dose our patients like artillery officers, and still the light takes its tax from us. You would walk into the Cathedral wearing nothing. That is not pilgrimage; that is donation.[paragraph break]'There is a road to worthiness. Aukin teaches it: the radiology curriculum, year on year - chelation weaves, lead habits, the grammar of shielding. Their Aukin gauntlets are the first lesson made wearable. Earn the gauntlets at the Cradle, wear them here, and I will not only step aside - I will walk you to the door.[paragraph break]'The gate to Aukin lies north of the port. GO TO CRADLE, attend the lectures, then ask Sister Franklin of the White Moon about the fire and walk her memory - come out of it and tell her what you carried, and the Cradle presses its gauntlets into your hands. No market sells them. The road west has no third option.'";
	otherwise:
		now radiology-warning is 2;
		say "The Radiologist does not lower his staff - but he steps aside, and the grief in his face is worse than the barrier was. 'Stubbornness is also a kind of faith, and I have buried better stubbornness than yours. The Wastes will judge you in steps, not in words. Walk, then. Walk, and count.'";

radiology-warning is a number that varies. radiology-warning is 0.
radiation-dose is a number that varies. radiation-dose is 0.

Every turn when the player is in the Contaminated Wastes and the Aegis gauntlets are not worn by the player:
	increase radiation-dose by 1;
	if radiation-dose is 1:
		say "The afterglow finds you at once - a warmth in the teeth, a taste like a struck coin. The Old Metals' tally reads [radiation-dose]: a warning, not yet a sentence. The Cathedral is still west - walk, and count.";
	otherwise if radiation-dose is 2:
		say "The geiger in your skull ticks louder - the tally reads [radiation-dose]. The dust is tasting you now, counting grains into your marrow. One more step west and the light begins to settle its account.";
	otherwise if radiation-dose is 3:
		say "The tally reads [radiation-dose] - your shadow on the vitrified road now glows faintly with your own afterimage. The Cathedral is one step west. Turn back, or pay the toll.";
	otherwise:
		say "The Morning Star closes his own eyes - the only mercy the Old Metals keep - and the traveler's story ends the way the light ends: everywhere, gently, all at once.";
		end the story finally saying "The Old Metals took their tax. Lucifer buried you in glass, and made the glass a warning. To walk the west alive, earn the Aukin gauntlets: attend the lectures at the Cradle, then walk Sister Franklin's memory of the Wastes and tell her what you carried out - no market sells them."

Before going to the Black Cathedral when the Aegis gauntlets are not worn by the player:
	say "At the Cathedral's threshold the borrowed light comes due all at once - the vitrified road behind you glows with your own afterimage, and the door keeps. The Old Metals take their tax at the step, not in the hall.";
	end the story finally saying "The Old Metals took their tax. Lucifer buried you in glass, and made the glass a warning. To walk the west alive, earn the Aukin gauntlets: attend the lectures at the Cradle, then walk Sister Franklin's memory of the Wastes and tell her what you carried out - no market sells them."
Every turn when the player is in the Black Cathedral and the Aegis gauntlets are not worn by the player:
	increase radiation-dose by 1;
	if radiation-dose is 1:
		say "The mirror's light licks over your hands like water finding cracks. Lucifer watches, and does not gloat; the elements do not gloat at arithmetic.";
	otherwise:
		say "The Morning Star closes his own eyes - the only mercy the Old Metals keep - and the traveler's story ends the way the light ends: everywhere, gently, all at once.";
		end the story finally saying "The Old Metals took their tax. Lucifer buried you in glass, and made the glass a warning. To walk the west alive, earn the Aukin gauntlets: attend the lectures at the Cradle, then walk Sister Franklin's memory of the Wastes and tell her what you carried out - no market sells them."

Instead of going east from the Contaminated Wastes when the Aegis gauntlets are not worn by the player and radiology-warning is 2:
	continue the action;


The Keeper is a woman in the Free Port Landing. "A woman in travel-grey stands at the standards, and she is already speaking as you arrive - not at you, exactly, but near you, the way weather speaks. 'Awake, are you? Good. The banners have been waiting for someone who could still choose.'" The description is "She calls herself the Keeper of the Gate, and claims - lightly, the way you would admit to a hobby - that she has watched every faction rise. Ten hooks hang from her belt, one per standard, empty and patient. She does not ask for your name. Names, she says, are the first thing the war eats." Understand "keeper" and "woman" and "gatekeeper" and "grey woman" and "registrar" as the Keeper.

Instead of asking the Keeper about something when the topic understood matches the regular expression "^mission$":
	say "'Ten factions,' the Keeper says. 'Aukin's Cradle, the Celestial Corps, the Pantheon, the Martyrs - and six doors of the Unseen Crown to the south. Bring me a seal from each, and the Accord will finally have a map of the war.'"
Instead of asking the Keeper about something when the topic understood matches the regular expression "^umin$|^crown$":
	say "'The Unseen Crown,' she says, and does not lower her voice, which is its own kind of armour. 'Archaeology. Fear Technology. Pallidum. Rabies. Typhi. Vibrio on the water. They are hosts, traveler, not friends. Be courteous, and come back with everything you left with.'"
Instead of asking the Keeper about something when the topic understood matches the regular expression "^accord$":
	say "'I do not keep the war's books,' she says, tapping the nearest standard. 'I keep its promises. Every faction swore a seal to whoever could walk all ten halls. None of them believed you existed. Show them.'"
Instead of asking the Keeper about something when the topic understood matches the regular expression "^destinations$|^where$|^map$|^go$|^travel$":
	say "'From this deck you may go to: the Cradle (where a neutral factor keeps a stall for offerings and vials); the Celestial Corps; the Pantheon; the Lab Martyrs; the Dark Concourse and its six doors - Archaeology, Fear Technology, the Masquerade, the Undead Court, the Department of Silence, the Abyssal Fleet. Say GO TO and a name,' she says. 'The concordance does the walking.'"

Instead of giving a seal to the Keeper:
	now the noun is on the standard rack;
	say "The Keeper takes [the printed name of the noun] with both hands and binds it to its standard. [The number of seals on the standard rack] of ten now fly.";
	if the number of seals on the standard rack is 10:
		raise the ten banners.

Instead of giving something to the Keeper:
	say "'The standards take banners, traveler,' she says, 'not souvenirs. Souvenirs are for people who went somewhere.'"

Instead of showing something to the Keeper:
	say "She has already catalogued it, apparently."

Last instead of asking someone about something:
	say "[The noun] listens, and offers nothing on that."

Instead of telling someone about something:
	say "Better to ask [the noun] directly."

Instead of answering someone that something:
	say "[The noun] waits for a proper question."

Part Three - Thoracica and the Empire of Aukin

The White Rib Gate is north of the Free Port Landing. "The sternum of the continent: a wall of white bone running from horizon to horizon, and a gate cut through it like a calm syllable. Beyond, bell-sound at dawn: the highlands of Thoracica. Monastery smoke rises from the mountains; the road forks ahead."

The white rib wall is scenery in the White Rib Gate. Understand "wall" and "ribs" and "bone" as the white rib wall. The description is "Not a garrison but a shield. The records agree that no army has ever needed to breach it, because the country behind it taught theirs."

The Cradle Outer Court is north of the White Rib Gate. "The outer court of the Cradle, the Medulla: whitewashed cloisters where cadets from every nation sit cross-legged among signal-lattices, learning to see the body's own presentation before they are permitted to fight anything at all. Stairs rise to the Inner Court; to one side, a neutral factor keeps a modest stall, tariffs funding the Cradle."

The exam scaffolds are scenery in the Cradle Outer Court. Understand "scaffolds" and "cloisters" and "lattices" as the exam scaffolds. The description is "Cadets read presenting signals off the lattice: pancreas, thyroid, neuron, and the shapes that most resemble pathogens. Learn the self, say the preceptors, before you are permitted to fight anything foreign."

The factor's stall is a scenery supporter in the Cradle Outer Court. Understand "stall" and "factor's stall" and "market" and "market court" as the factor's stall. The description is "A neutral factor's stall folded into the outer court: wares from every circulation, priced in tokens. Two items are set out for travelers bound for the shrine or the dark courts."

The offering bundle is a closed openable container on the factor's stall. Understand "bundle" and "offerings" as the offering bundle. The description is "A wrapped packet of the three customary offerings from the Martyrs' pilgrimage list: small strands for HeLa, treats for Laika, a cheese wheel for the mouse."

The rna strand is a thing in the offering bundle. Understand "strand" and "rna" as the rna strand. The description is "A small synthetic RNA strand, coiled in paper. Offered to the immortal navigator."

The dog treat is a thing in the offering bundle. Understand "treat" as the dog treat. The description is "A plain dried treat. Some offerings cross no species barrier until they are made."

The cheese wheel is a thing in the offering bundle. Understand "cheese" and "wheel" as the cheese wheel. The description is "A tiny cheese wheel, ceremonial grade. The mouse worked for it, after all."

The Pasteur vial is a thing on the factor's stall. Understand "vial" and "pasteur" and "vaccine" as the Pasteur vial. The description is "A single-dose Pasteur-class field vaccine, attenuated virus in a steel-cased vial. The doctrine says: one man found a way to turn death into life. We carry his legacy in every vial."

The Port Factor is a man in the Cradle Outer Court. "The Port Factor watches the cloister with the serenity of a man whose tariffs fund an academy nobody dares to sack." The description is "Grey-robed, portly, and absolutely neutral. His family have kept the stall since the Cradle Accords were younger than the AAA by centuries."

Instead of asking the Port Factor about something when the topic understood matches the regular expression "^port$|^pump$|^cradle$|^aukin$":
	say "'The great pump must serve all circulation,' he says. 'Every power has an interest in keeping it open. No act of war inside the sac, traveler - the Port Conclave enforces that one the old way.'"

Instead of asking the Port Factor about something when the topic understood matches the regular expression "^bundle$|^offerings$":
	say "'Going to the shrine? Nobody visits the Martyrs empty-handed,' he says. 'Strand for HeLa, treat for Laika, cheese for the mouse. One token the bundle.'"

Instead of asking the Port Factor about something when the topic understood matches the regular expression "^vial$|^pasteur$":
	say "'The Undead Court respects exactly one thing the living make,' he says. 'Take it. One token. And traveler - show it to the Count himself. Only him.'"

Instead of buying the offering bundle:
	if the player carries the offering bundle:
		say "You already carry the bundle.";
	otherwise if the player carries an exchange token:
		let T be a random exchange token carried by the player;
		now T is nowhere;
		now the offering bundle is carried by the player;
		say "A token changes hands. 'Strand for HeLa, treat for Laika, cheese for the mouse,' the Factor recites, wrapping it. 'The Martyrs asked for nothing. That is why we ask ourselves.'";
	otherwise:
		say "'No token, no bundle, traveler. The Martyrs take offerings, not intentions.'"

Instead of buying the Pasteur vial:
	if the player carries the Pasteur vial:
		say "One vial is doctrine enough.";
	otherwise if the player carries an exchange token:
		let T be a random exchange token carried by the player;
		now T is nowhere;
		now the Pasteur vial is carried by the player;
		say "The last token goes across the stall. 'Show it to the Count himself,' the Factor says again. 'He has watched empires rise and fall. He will want to see what the living made.'";
	otherwise:
		say "'Your tokens are spent, traveler,' the Factor says. 'The vial needs one.'"

Instead of buying something:
	say "Nobody here is selling that."

Instead of taking the offering bundle when the offering bundle is not carried by the player:
	say "'Buy, traveler. One token,' the Factor says. 'The Martyrs take offerings, not intentions.'"

Instead of taking the Pasteur vial when the Pasteur vial is not carried by the player:
	say "'Buy, traveler. One token,' the Factor says, 'and show it to the Count himself.'"

Instead of asking the Port Factor about something:
	say "The Factor listens pleasantly and keeps wrapping."

The Cradle Inner Court is north of the Cradle Outer Court. "The medullary court, lit from within by the AIRE-flame: shelves upon shelves of the body's own tissues, every self-peptide catalogued in amber light. The Supreme Preceptor Tylean sits at the centre of the circle. The Generalizer waits by the Foreign Selves chair, honey-gold flame at her shoulder. A lecture is forming among the preceptors. At the back of the court, apart from them all, a woman in a white habit reads testimony pages in her lap."

The Aegis gauntlets are a plural-named wearable thing in the Cradle Inner Court. The Aegis gauntlets are scenery. Understand "gauntlets" and "aegis" and "gloves" and "aukin" and "aukin gauntlets" as the Aegis gauntlets. The printed name of the Aegis gauntlets is "Aukin gauntlets". The description is "Chelation-weave field gauntlets of the Cradle - the first lesson of the radiology curriculum made wearable. They bind and escort what they touch: mercury, lead, cadmium, heat. The Cradle grants them only to those who study at the Inner Court; they are never sold."

The aire library is in the Cradle Inner Court. The aire library is scenery. Understand "library" and "aire" and "flame" and "shelves" as the aire library. The description is "The library of the self. Strong binders of self are deleted here; agonistic binders are redirected to the Treg Cloister, to come back into the world as suppressors of friendly fire. The chair outlives the person. That is doctrine, not metaphor."

Tylean is a man in the Cradle Inner Court. "Supreme Preceptor Tylean, He Who Listens to the Truth, wears the plain grey of an office that passes by clerical succession, not blood." The description is "The head of state, head of the Dhyana Church, and supreme preceptor of the Cradle in one person. He listens the way other sovereigns ride reviews."

Instead of asking Tylean about something when the topic understood matches the regular expression "^dhyana$|^listening$":
	say "'The most terrible wars are lost at birth,' Tylean says, 'when defenders are made who were never taught who they defend, or from whom. Everything else we build is commentary on that sentence.'"
Instead of asking Tylean about something when the topic understood matches the regular expression "^accords$|^cradle accords$":
	say "'Whoever sacked the academy would produce one generation of untaught soldiers,' he says, 'and be invaded by their own immune armies within a decade. So they signed the Cradle Accords instead - the oldest surviving treaty in the world, older than the Accord you serve.'"
Instead of asking Tylean about something when the topic understood matches the regular expression "^schism$|^sin$|^original sin$":
	say "'The plague was Umin's crime,' he says quietly. 'The Hunt was ours: a people murdering the women who kept its medicine. We named that an Original Sin and built a country out of the penitence. We held the ground outside the fallen capital through the whole occupation. Aukin is an apology with walls.'"
Instead of asking Tylean about something when the topic understood matches the regular expression "^phoenix$":
	say "'Phoenix was the old capital,' he says. 'We guarded its approaches for two centuries. When the liberation came, the city passed into our keeping by common Accord - not by conquest. Ask the port folk east of here; the sea remembers it too.'"

The Generalizer is a woman in the Cradle Inner Court. "The Generalizer, current Chair of Foreign Selves, keeps one hand near the AIRE flame as if warming it by habit." The description is "Post-AIRE generation, honey-gold flame, and the sharpest tongue in the Curriculum Wars. She teaches that a ten-percent sampling of self, through cross-reactivity, must cover ninety percent of the response space."

lecture-progress is a number that varies. lecture-progress is 0.

Instead of attending in the Cradle Inner Court:
	increment lecture-progress;
	if lecture-progress is 1:
		say "The preceptors walk the outer doctrine first. CORTICAL SELECTION: cadets prove they can see the body's signal at all. Those who cannot read the presenting lattice are released back into circulation - unharmed, ungraded, and dangerous to no one but themselves.";
	otherwise if lecture-progress is 2:
		say "Then the inner doctrine. MEDULLARY SELECTION: the AIRE-lit library of every tissue the body owns. Strong binders of self are deleted; agonistic binders go to the Treg Cloister, to return as suppressors of friendly fire rather than as fighters. Graduates leave for the periphery and never see the Inner Court again. The preceptors, whose flame burns a fortnight-equivalent, are replaced in endless relay.
At the back of the hall, a schism is audible: the Narrow Faction wants the Foreign Selves curriculum cut to unambiguous enemy-forms. The Generalizer's people answer that narrowing AIRE coverage mathematically guarantees more autoreactive graduates. The dispute is the loudest silence in the empire.";
	otherwise:
		say "The preceptors resume their relay, the same doctrine in a new mouth.";

To run the curriculum exchange:
	if the cradle sigil is carried by the player:
		say "'You have the sigil, traveler. Teach it as you heard it.'";
	otherwise if curriculum-passed is true:
		say "'You have heard the doctrine, and you answered the Chair's question,' the Generalizer says. 'What remains is not doctrine.' She nods past the AIRE-flame, where the woman in the white habit sits among her pages. 'Sister Franklin of the White Moon. She does not teach. She asks you to walk.'";
	otherwise if lecture-progress >= 2:
		say "'So. The Narrow Faction demands we cut the Foreign Selves curriculum to unambiguous enemy-forms. Tell me, traveler - and think like a cadet, not a diplomat - what does intolerance engineer?'
'Autoimmunity,' you say. 'The stricter the definition of self, the more of the self becomes unrecognizable. Intolerance is the engineering cause of autoimmunity.'
The Generalizer smiles for exactly one second. 'Correct. Curriculum bias is not a diplomatic nuisance; it is friendly fire scheduled in advance. Take that sentence to your Accord - and tell them the Long Dwindling is not our weakness alone. It is every long peace, made flesh.'
She glances past the AIRE-flame to the back of the court. 'You have been taught what the self is for. Now be examined in it. Sister Franklin does not teach; she witnesses, and she asks you to walk. ASK her about THE FIRE.'";
		now curriculum-passed is true;
	otherwise:
		say "'Attend the lecture first, traveler,' she says, nodding at the forming preceptors. 'Then we will speak of the wars.'"

Instead of asking the Generalizer about something when the topic understood matches the regular expression "^autoimmunity$":
	run the curriculum exchange.
Instead of asking the Generalizer about something when the topic understood matches the regular expression "^curriculum$|^curriculum wars$|^narrow$":
	run the curriculum exchange.
Instead of asking the Generalizer about something when the topic understood matches the regular expression "^foreign selves$":
	say "'The chair teaches cadets to recognize self-tissue that looks foreign, and foreign things that mimic the self,' she says. 'My predecessor held it through the DOPPELGANGER affair. The chair survived him. The chair outlives the person - that is doctrine, not metaphor.'"
Instead of asking the Generalizer about something when the topic understood matches the regular expression "^vasud$|^doppelganger$":
	say "'A foreign agent wore a graduate's face and sat down across from the Chair of Foreign Selves himself,' she says. 'The first successful direct assault on central education in recorded history, our archives call it. He was pensioned into Lower Intestinal exile by his own foreign ministry. The Cradle never recalled him. We had already lost the argument he failed.'"
Instead of asking the Generalizer about something when the topic understood matches the regular expression "^dwindling$|^involution$|^long dwindling$":
	say "'Less of the old medulla lights every decade. Cohorts shrink. Nations fight with veteran memory-cells because we cannot graduate fresh ones fast enough,' she says. 'Aukin calls it the Long Dwindling and treats it as the strategic problem of the age. Our adversaries call it a target window.'"

Attending is an action applying to nothing.
Understand "attend" or "attend lecture" or "attend the lecture" or "listen to the lecture" as attending.

Section - Sister Franklin and the Apocalypse of the White Moon

[Comment: AUKIN'S SEAL TASK.
The chain: attend the lectures -> answer the Chair on intolerance (curriculum-passed) -> ASK FRANKLIN about THE FIRE and two of her questions -> ENTER THE MEMORY -> read the registry in the vestibule -> SAY THE NAMES in the Core Chamber -> lay the Eighth Seal on the throne -> TELL FRANKLIN one thing you carried out -> sigil and gauntlets.
CONTENT STRINGS (everything inside say "...") ARE MEANT TO BE REWRITTEN FREELY. Only the chain above is structural: keep the flags, change the words.]

curriculum-passed is a truth state that varies. curriculum-passed is false.
franklin-stage is a number that varies. franklin-stage is 0.
franklin-questions is a number that varies. franklin-questions is 0.
memory-walked is a truth state that varies. memory-walked is false.
names-read is a truth state that varies. names-read is false.
names-spoken is a truth state that varies. names-spoken is false.
The memory-walker is a person that varies.

Sister Franklin is a woman in the Cradle Inner Court. Understand "franklin" and "sister franklin" and "white moon" as Sister Franklin. "Sister Franklin of the White Moon sits apart from the preceptors with a lapful of testimony pages, reading." The description is "A woman in a white habit, ink to the knuckles, younger than the habit makes her look. She is the only person in the war who has read every fragment of the Apocalypse, and it sits on her the way a second habit would. She does not teach. She witnesses."

To franklin preaches:
	if franklin-stage is 0:
		now franklin-stage is 1;
	say "'The temples were not built to contain the fire,' Sister Franklin says, without looking up. 'Read the founding record. They were built to remember. Containment was a side effect.'
She turns a page. 'Seven seals, seven memories. The First remembers the fall. The Seventh remembers what the fire was before we chained it. When the seventh opens, the fire will remember that it was a god. That is not destruction. That is return.'
Another page. 'Six of the seven are still walking toward their seals. I walked the first myself - the Wastes of Sacrum, Year Forty-Seven - and I carried in a page that no scripture ordered, and I laid it on the throne, and the Core has not touched it to this day.'
She looks up at last. 'I do not teach you this. Teaching is for people who think the knowing is the point. I ask you to walk it as I walked it - not as a story. As a year.'
[line break](ASK her about the NAMES, the MINERS, the CHILDREN, the WOLVES, or the EIGHTH SEAL - then ENTER THE MEMORY.)"

To franklin answers (qt - a text):
	increment franklin-questions;
	if franklin-stage is 0:
		now franklin-stage is 1;
	if qt is "names" or qt is "the names" or qt is "list":
		say "'Four thousand two hundred and seventeen, officially,' she says. 'The actual count is redacted. I have read the registry: a firefighter who wrote his wife's name in ash on a control-room wall; a sister who held the northern containment point after the others ran; a physician who catalogued two hundred and thirty-seven patients in seventy-two hours; an old woman who would not be chased out of her kitchen; and the unnamed child of apartment four-twelve, listed anyway, because they should not be forgotten.' She looks at you. 'The fire does not remember their names. Only we can.'";
	otherwise if qt is "miners" or qt is "the miners":
		say "'Mining Collective Two Hundred and Six dug the tunnel beneath the reactor,' she says. 'They were told it was urgent. They were not told it was fatal. A year later six of them went back with no orders at all, sat on the warm floor of the room beneath the world, and said nothing. The breathing slowed. They paid for it with everything they had left, and they knew the price before they paid it.'";
	otherwise if qt is "children" or qt is "the children" or qt is "3047":
		say "'Three thousand and forty-seven children born to irradiated parents,' she says. 'Healthy. Breathing. Asking why the sky is red on some nights. The institutions wanted monsters. There were no monsters. That number is the one thing the fire did not take.'";
	otherwise if qt is "wolves" or qt is "the wolves":
		say "'Wolves, bison, wild horses,' she says. 'The Zone is the most alive ground on the continent now. The fire did not poison the land. The fire made the humans leave, and what the humans left, life reclaimed. Remember that when you go west and think the contamination is the whole story.'";
	otherwise if qt is "katerina" or qt is "vasya" or qt is "guseva":
		say "'Sister Katerina kept speaking the binding words after the formation broke, and she did not burn - she became. Vasily Ignatenko died of thirteen days and left one sentence behind him: tell her I was not afraid, and then, in a smaller hand, I was afraid. Angelina Guseva wrote down every name because a record is a kind of love.' She closes that page. 'The testimony is the point. Not the doctrine.'";
	otherwise:
		say "'The Complete Apocalypse ends with the fire saying: you are my pieces,' she says. 'The Brotherhood of the Unspoken answered it. They wrote an eighth seal that was never in any scripture - the seal that says yes, and pieces can choose. We did not choose to be shattered. We chose what to do with the pieces.' She touches the page on her knee. 'That is the one I carried into the Core Chamber. It is the one you will carry, if you walk it.'";
	if franklin-questions >= 2:
		if franklin-stage < 2:
			now franklin-stage is 2;
		say "[line break]She folds the page once, along a crease worn white. 'Two questions is a hearing,' she says. 'Come into the memory, then. Walk it as I walked it, and bring me back one thing.'[line break](ENTER THE MEMORY.)"

Instead of asking Sister Franklin about something:
	let qt be "[the topic understood]" in lower case;
	if qt is "seal" or qt is "trial" or qt is "task" or qt is "earn":
		say the trial text of the cradle sigil;
	otherwise if qt is "fire" or qt is "the fire" or qt is "apocalypse" or qt is "seven seals" or qt is "seventh seal" or qt is "the seventh seal" or qt is "prometheus" or qt is "temple" or qt is "chernobyl" or qt is "wastes" or qt is "sacrum":
		franklin preaches;
	otherwise if qt is "names" or qt is "the names" or qt is "list" or qt is "miners" or qt is "the miners" or qt is "children" or qt is "the children" or qt is "wolves" or qt is "the wolves" or qt is "katerina" or qt is "vasya" or qt is "guseva" or qt is "eighth" or qt is "eighth seal" or qt is "the eighth seal" or qt is "witness":
		franklin answers qt;
	otherwise:
		say "Sister Franklin listens, and offers nothing on that."

[Comment: THE MEMORY - Franklin's walk through the Wastes of Sacrum. The player acts AS her for its duration.]
The Threshold of Ash is a room. "Ash to the horizon, and every grain older than the first cell. You came back here without orders, without a medal, and with one page in your coat that you wrote yourself. The contaminated vestibule lies north, where the registry was found. Beyond it, down, is the room beneath the world."

The Contaminated Vestibule is north of the Threshold of Ash. "An administrative office of the temple, stripped by forty-seven years of weather and one night of everything else. Water-damaged pages lie where the wind dropped them. This is where the casualty registry was recovered - and where a firefighter's jacket was found with the dosimeter still pinned to it, reading LETHAL."

The Core Chamber is north of the Contaminated Vestibule. "The room beneath the reactor that should not exist. The geometry is wrong: the walls are not walls, the floor is warm, and it breathes - slowly, the way something enormous breathes when it is not asleep and not awake. On the far side waits a throne, and on the throne something that is not alive and is not dead. It has been waiting longer than the temple has been standing. It is waiting for you specifically."

The list of names is a thing in the Contaminated Vestibule. The printed name is "List of Names". Understand "list" and "names" and "registry" and "casualty list" and "page" as the list of names. The description is "OFFICIAL CASUALTY COUNT: 4,217. ACTUAL: redacted. Names in italics were recovered from personal effects. Names in brackets were never found; they are listed anyway."

The last letter is a thing in the Contaminated Vestibule. The printed name is "Vasya's Testament". Understand "letter" and "testament" and "vasya" and "vasya's testament" as the last letter. The description is "A firefighter's last letter, handwriting going to pieces across the page. 'I wrote your name in the ash on the wall of the control room. I wanted to leave something.'"

The dosimeter is scenery in the Contaminated Vestibule. Understand "dosimeter" as the dosimeter. The description is "Pinned to a jacket nobody collected. The needle is past the end of the scale and has been for forty-seven years."

The throne is a scenery supporter in the Core Chamber. Understand "throne" and "seat" as the throne. The description is "Not furniture. A place in the geometry that something sits in. The stone around it is warm to the touch and has been warm since the miners first broke through."

The warm floor is scenery in the Core Chamber. Understand "floor" and "stone" and "warm floor" as the warm floor. The description is "It breathes. Six men sat on it once, saying nothing, offering nothing but the fact of being there, and the breathing slowed."

The eighth seal page is a thing. The printed name is "Eighth Seal". Understand "eighth seal" and "eighth" and "seal page" and "my page" as the eighth seal page. The description is "The page you wrote with the Brotherhood of the Unspoken and carried in against every order: the fire says you are my pieces. It answers: yes - and pieces can choose."

To end the memory walk:
	now the player is the memory-walker;
	now Sister Franklin is in the Cradle Inner Court;
	now the memory-walker is in the Cradle Inner Court.

Entering the memory is an action applying to nothing.
Understand "enter memory" or "enter the memory" or "remember" or "walk the memory" or "enter fire" or "enter the fire" as entering the memory.

Instead of entering the memory:
	if the location is not the Cradle Inner Court:
		say "A memory is only walked where she keeps it: the Cradle Inner Court, in her presence.";
	otherwise if Sister Franklin is not in the location:
		say "Sister Franklin is not here to hold the door open.";
	otherwise if curriculum-passed is false:
		say "'The doctrine first,' Sister Franklin says. 'You cannot witness what you have not been taught to see. Attend the lectures, and answer the Chair of Foreign Selves.'";
	otherwise if franklin-stage < 2:
		say "'Ask me first,' she says. 'Hear it from a mouth before you take it into a body.'[line break](ASK her about THE FIRE, then about the NAMES, the MINERS, the CHILDREN, or the EIGHTH SEAL.)";
	otherwise if memory-walked is true:
		say "'Once is the doctrine,' Sister Franklin says. 'Walking it twice is tourism.'";
	otherwise:
		say "She sets two fingers against your temple, and the Inner Court goes out like a hooded lamp.[line break]You are Sister Franklin of the White Moon. It is Year Forty-Seven of the First Breach, and you are walking back into the Wastes of Sacrum with a page in your coat that you wrote yourself.[line break](READ THE LIST, say the names where the fire can hear them, and lay the page down. LEAVE THE MEMORY steps back out.)";
		now franklin-stage is 3;
		now names-read is false;
		now names-spoken is false;
		now the memory-walker is the player;
		now the player is Sister Franklin;
		now the eighth seal page is carried by the player;
		now Sister Franklin is in the Threshold of Ash.

Leaving the memory is an action applying to nothing.
Understand "leave memory" or "leave the memory" or "wake" or "wake up" or "step out" or "end memory" as leaving the memory.

Instead of leaving the memory:
	if the player is not Sister Franklin:
		say "You are not inside anyone's memory.";
	otherwise:
		say "You step back out of the year. The ash goes with you, a little.";
		now franklin-stage is 2;
		end the memory walk.

Instead of warping to when the player is Sister Franklin:
	say "There is no concordance inside a memory. Walk it, or LEAVE THE MEMORY."

To witness the list:
	if names-read is false:
		now names-read is true;
	say "OFFICIAL CASUALTY COUNT: 4,217. ACTUAL: redacted.
Vasily Ignatenko - firefighter - thirteen days. Lyudmila, his wife - six years - listed as indirect.
Sister Katerina Voronova - northern containment point - what remained was not suitable for burial.
Brother Alexei Volkov - three days, in the medical tent, and he left his testimony under a floor.
Dr. Angelina Guseva - triage - two months. Nurse Natalia Oleinik - two hundred and thirty-seven patients in seventy-two hours - survived.
Old woman Olya Petrenko, who refused to be moved, and her cat.
The unnamed child of Apartment 412. Age: seven. Classification: changed.
Pages fourteen through eighty-nine missing.
This list is incomplete. The full list would not fit in any volume.
Write their names. Say them aloud. The fire does not remember their names. Only we can."

Understand "read [something]" as examining.

Instead of examining the list of names:
	witness the list.

Reciting the names is an action applying to nothing.
Understand "say names" or "say the names" or "recite names" or "recite the names" or "speak names" or "read names aloud" as reciting the names.

Instead of reciting the names:
	if the player is not Sister Franklin:
		say "You are not inside the memory. Nobody is listening.";
	otherwise if the location is not the Core Chamber:
		say "Not here. Names are said where the fire can hear them.";
	otherwise if names-read is false:
		say "You have not read the registry. You will not invent names - that is precisely what the Order did, and it is why the count is redacted.";
	otherwise if names-spoken is true:
		say "You have said them. The floor is warm under your knees and the breathing has already slowed once.";
	otherwise:
		now names-spoken is true;
		say "You say them aloud, one by one, in the room beneath the world: the firefighter, the wife, the sister at the northern point, the brother under the floor, the physician and her nurse, the old woman and her cat, and the child of apartment four-twelve whose name nobody kept.
You do not pray and you do not bind. You say the names the way you would read a register in a town that has decided to forget.
The breathing changes. It does not stop - it attends."

To lay down the seal:
	if the player is not Sister Franklin:
		say "You are not inside the memory.";
	otherwise if the location is not the Core Chamber:
		say "The page is meant for the room beneath the world, not for here.";
	otherwise if the eighth seal page is not carried by the player:
		say "You are not carrying the page.";
	otherwise if names-spoken is false:
		say "Not before the names. A page laid over silence is only paper, and the fire has had paper enough.";
	otherwise:
		now the eighth seal page is on the throne;
		now memory-walked is true;
		say "You set the page down on the warm stone.
It says: the fire told us we are its pieces. It answers: yes - and pieces can choose. We did not choose to be shattered. We chose what to do with the pieces. We are the eighth seal. The seal that says we know what we are made of, and we stay anyway.
You sit, the way the six miners sat, and offer nothing except the fact of being there.
The breathing slows. Not all the way. Enough.
You climb back up through the tunnels toward the light, and the weight goes with you, and some of it stays here.";
		end the memory walk;
		say "[line break]Sister Franklin opens her eyes across from you in the Inner Court. The AIRE-flame has not moved.[line break]'Tell me one thing from the fragments,' she says. 'Just so I know you were listening.'[line break](TELL FRANKLIN ABOUT what you carried out: the NAMES, the MINERS, the CHILDREN, the WOLVES.)";

Offering the seal is an action applying to nothing.
Understand "place the eighth seal" or "offer the seal" or "lay the seal" or "place seal" or "offer the eighth seal" or "lay down the seal" as offering the seal.

Instead of offering the seal:
	lay down the seal.

Instead of putting the eighth seal page on the throne:
	lay down the seal.

Instead of telling Sister Franklin about something when memory-walked is true:
	if the cradle sigil is carried by the player:
		say "'You carry it,' Sister Franklin says. 'Go and teach it somewhere that has forgotten worse.'";
	otherwise:
		let tt be "[the topic understood]" in lower case;
		if tt is "names" or tt is "the names" or tt is "katerina" or tt is "vasya" or tt is "miners" or tt is "the miners" or tt is "children" or tt is "the children" or tt is "3047" or tt is "wolves" or tt is "the wolves" or tt is "guseva" or tt is "fire" or tt is "the fire" or tt is "eighth" or tt is "eighth seal" or tt is "the eighth seal":
			say "She listens the way the Dhyana Church means by listening - the whole of her, at once. 'Yes,' she says. 'That one. You were listening.'
She closes the page at last. 'The dead are not saved by being counted. They are saved by being named by somebody who was not obliged to.'";
			grant the cradle sigil noting "Sister Franklin presses the Cradle Sigil into your hand - a ring of bone-white alloy, stamped with the sign for listening. 'A witness is a kind of weapon,' she says. 'Carry it like one.'";
			now franklin-stage is 4;
			if the Aegis gauntlets are not carried by the player:
				now the Aegis gauntlets are carried by the player;
				say "[line break]From the AIRE-flame the preceptors lift the Aukin gauntlets - chelation-weave, the Cradle's own shielding, the first lesson made wearable. 'Earn the west,' Sister Franklin says, 'and it is yours. Buy it, and it is no one's.' Wear them before you walk west into the Old Metals.";
		otherwise:
			say "'That is not from the fragments,' she says. 'Try again - tell me something you carried out of the fire.'[line break](TELL FRANKLIN ABOUT the NAMES, the MINERS, the CHILDREN, or the WOLVES.)"

Instead of telling Sister Franklin about something:
	say "'I am not the Chair,' she says. 'I do not grade. Walk it first - then tell me what you carried out.'"


Part Four - The Void and the Celestial Corps

The Void Verge is northwest of the Free Port Landing. "The last blood-warm air before the cold. Above you, in a silence like held breath, two vessels ride at anchor: the Dawn Pioneer, her hull ribbed like a dissected torso, and the great seven-chambered Fabrica beyond her. A boarding ladder goes up."

The Dawn Pioneer Deck is above the Void Verge. "The deck of Leonardo's vessel smells of solvent and ether. The hull ribs arch overhead exactly like the torso it was drawn from. A captain's desk bears the famous mirror-script log; east, a pressurized gallery leads to the Fabrica's bridge. Leonardo himself leans over the rail, watching the blood-tide."

The writing desk is a scenery supporter in the Dawn Pioneer Deck. Understand "desk" as the writing desk. The description is "Scarred walnut, ink-stained, drawing instruments racked in grade order."

The codex log is a thing on the writing desk. Understand "codex" and "log" and "book" and "journal" and "script" as the codex log. The description is "Leonardo's navigation log, written in mirror-script cipher - the writing runs right to left, every letter reversed. [if the codex log is mirror-read]Now that a mirror has read it, the pages yield: star charts of the Liver-Moon, the four chambers of the Central Sun, and a correction in the margin: the seat of the soul is the brain.[otherwise]The unworthy must not see, says a note in plain hand. It reads only in its own kind - a mirror.[end if]"

The codex log can be mirror-read or mirror-sealed. The codex log is mirror-sealed.

Leonardo is a man in the Dawn Pioneer Deck. "Leonardo, First Captain of the Celestial Explorer Corps, watches the blood-tide with the patience of a man who has dissected thirty corpses to draw one spine." The description is "The First Star-Mapper. His notebooks were never printed in his lifetime; his method was: observe, dissect, draw, compare, publish. He failed at the last one. Others must succeed."

Instead of asking Leonardo about something when the topic understood matches the regular expression "^codex$|^log$":
	say "'The unworthy must not see,' Leonardo says, tapping the mirror-script. 'It is a cipher of the mirror, traveler - it reads only in its own kind. Somewhere in the contaminated west there is a mirror of polished mercury. The old alchemists made it to show nerves. It will read me.'"
Instead of asking Leonardo about something when the topic understood matches the regular expression "^microcosm$":
	say "'As above, so below,' he says. 'The stars are bone and blood; the organs are planets and moons. I sailed past the great Liver-Moon and knew it as the organ I dissected in Milan. To understand the body is to understand the universe - they are one and the same.'"
Instead of asking Leonardo about something when the topic understood matches the regular expression "^voyages$|^expeditions$":
	say "'Four,' he says. 'The Skull, for the Celestial Dome. The Heart, for the Central Sun and its four chambers. The Vascular, for the great rivers - Vena Cava, Aorta. The Fetal, for the Womb of Creation. Vesalius went further. He is aboard the Fabrica, east of here. Bring him something worth correcting.'"
Instead of asking Leonardo about something when the topic understood matches the regular expression "^vesalius$":
	say "'The Admiral keeps the bridge,' Leonardo says. 'Same year as Copernicus, 1543 - the Fabrica and De Revolutionibus together, the heavens and the body both discovered false. He will test you. Let him.'"

The Fabrica Bridge is east of the Dawn Pioneer Deck. "The flagship's bridge: seven interconnecting chambers, one for each book of the Fabrica. Vesalius holds the chart-table at the centre. Harvey stands by a model of the Pulse, its loop closed with no dead ends. Bethune, in scarlet, checks a transfusion kit by the viewport. An anatomical star chart hangs on the after wall."

The star chart is scenery in the Fabrica Bridge. Understand "chart" and "star chart" and "maps" as the star chart. The description is "The Vesalius Map: the cosmos depicted as a giant human body floating in space. The old school still circles the heart as the seat of the soul. Every modern voyage has found otherwise - the chart waits for someone brave enough to correct a classic."

Vesalius is a man in the Fabrica Bridge. "Vesalius, Admiral of the Celestial Fleet, stands with the posture of a man who corrected two hundred errors and expects to correct two hundred more." The description is "Father of modern anatomy. Without anatomy, he likes to say, the physician is a blind man in a dark room, stumbling against walls. He published at the cost of everything; the pilgrimage killed him, the Fabrica outlived him."

Instead of asking Vesalius about something when the topic understood matches the regular expression "^soul$|^seat$|^brain$":
	say "'The old charts circle the heart,' Vesalius says, tapping the hanging map. 'Wrong. The brain is the seat - my seventh voyage proved it, and proved the Galenic errors with it. Never navigate by ancient maps. But an admiral does not amend a classic on an traveler's word alone. Bring me proof read by a mirror - Leonardo keeps his truth reversed. Show me the codex legible, and the chart gets corrected.'"
Instead of asking Vesalius about something when the topic understood matches the regular expression "^codex$|^log$":
	say "'Leonardo's log? Mirror-script,' Vesalius says. 'It reads only in its own kind. Show it to me legible and I will strike the cardiac error from my own map.'"
Instead of asking Vesalius about something when the topic understood matches the regular expression "^voyages$|^seven$|^fabrica$":
	say "'Seven voyages for seven books,' he says. 'Bones: the fixed stars. Muscles: the nebulae that move them. Vessels: the closed loop. Nerves: the web. Organs: Liver-Moon, Kidney-Stars. Heart: the four chambers, confirmed. Brain: the seat of the soul. 1543 - the same year Copernicus moved the heavens. We only moved the body's inside.'"

Instead of showing the codex log to Vesalius:
	if the codex log is mirror-read:
		if the corps medallion is nowhere:
			say "Vesalius reads the margin correction twice, then takes a stylus to his own hanging map and strikes the circled heart. 'The brain,' he announces to the bridge, 'is the seat of the soul. Witnessed. Envoy - the Corps does not forget who carried the proof.'
Harvey applauds twice, flat and precise. Bethune just grins.";
			grant the corps medallion noting "Vesalius pins the Corps' bronze medallion to your collar - his own profile, beside a starred anatomy.";
		otherwise:
			say "'The chart is corrected, traveler. The medallion is yours.'";
	otherwise:
		say "Vesalius turns the codex right way round, then back. 'Reversed, every line. It reads only in its own kind, traveler. A mirror - the mercury kind, in the contaminated west. Bring it legible.'"

Harvey is a man in the Fabrica Bridge. "Harvey, Commodore of the Blood Sea Fleet, stands by a model of the Pulse - a vessel shaped as a closed loop with no dead ends." The description is "The Circulation Prophet. He did not merely describe the blood's circuit; he measured it, hour by hour, until the numbers left no room for Galen."

Instead of asking Harvey about something when the topic understood matches the regular expression "^circulation$|^blood$":
	say "'All life is circulation,' Harvey says. 'The heart pumped the body's whole weight in blood each hour by my arithmetic - so it cannot be consumed and remade, as Galen taught. It must return. A closed loop, valves against backflow, the tide that carries all things.'"
Instead of asking Harvey about something when the topic understood matches the regular expression "^pulse$|^vessel$":
	say "'The Pulse runs the artery-run outbound and the vein-return home,' he says. 'No dead ends. Capillary crossings at the far reaches. Proof, not poetry - I did not describe the loop, traveler. I measured it.'"

Bethune is a man in the Fabrica Bridge. "Bethune, in a scarlet uniform that is not regulation and does not intend to be, checks a mobile transfusion kit by the viewport." The description is "The Scarlet Surgeon, Commander of the International Medical Corps. Use me as a machine gun, he says - I am here to work, not to rest."

Instead of asking Bethune about something when the topic understood matches the regular expression "^blood$|^transfusion$":
	say "'Blood on the battlefield dies in the wagon-train unless you move the bank to the front,' Bethune says. 'Mobile transfusion, five kilometres from the line. Use me as a machine gun - I am here to work, not to rest.'"
Instead of asking Bethune about something when the topic understood matches the regular expression "^scarlet$|^uniform$":
	say "'White is for hospitals,' he says. 'The healer stands at the front, and healing requires blood. So: scarlet. The medal they named after me is for courage, internationalism, and the wounded. In that order.'"


Part Five - The Wastes and the Heavy Metal Pantheon

The Contaminated Wastes is a room. "Wind moves dust that never settles - every grain older than the first cell. Warning stones mark the old mills and the old mines; somewhere under the horizon, a radium afterglow pulses like a slow heart. A road of vitrified glass runs on west, toward a hall that catches the light and returns it wrong."

The radium afterglow is scenery in the Contaminated Wastes. Understand "afterglow" and "glow" as the radium afterglow. The description is "Radium-226, half-life sixteen centuries. They painted it on their lips with their brushes, once. Everything that glows is burning, and everything that burns consumes."

The Black Cathedral is west of the Contaminated Wastes. "A cathedral of black stone around a single object: the mercury mirror, a pool of polished metal that does not reflect the room. It shows nerves. Lucifer keeps the hall the way winter keeps a lake - by being what it is. The Morning Star himself stands beside his mirror, crown dripping, reforming, dripping."

The mercury mirror is scenery in the Black Cathedral. Understand "mirror" and "pool" and "mercury" as the mercury mirror. The description is "A pool of polished quicksilver. Look in, and you see not your reflection but your nervous system - the damage already done, or the damage to come. Leonardo said his cipher reads only in its own kind. This is its own kind."

Instead of touching the mercury mirror when the Aegis gauntlets are worn by the player:
	say "Through the chelation weave, the mirror feels like a cool pond over a live wire. Your reflection - your actual nervous system, mapped in silver - waits politely. The mirror can read you now, or read for you."

Instead of touching the mercury mirror:
	say "You reach toward the polished metal and your fingertips come back scorched before contact - the mercury has already rearranged the small nerves at your fingertips to make the point. The Mad Hatter's handshake. Chelation weave, if you own any, would be prudent."

Lucifer is a man in the Black Cathedral. "Lucifer - the Mercury God, the Morning Star - stands beside his mirror, a figure of liquid metal shifting between solid and fluid, his dripping crown endlessly reforming." The description is "Elemental, in the strict sense: he predates the first cell and will outlast the last. Non-biodegradable, bioaccumulative, patient as physics. Once they worshipped him; then they found penicillin; now they regulate his emissions."

Instead of asking Lucifer about something when the topic understood matches the regular expression "^mirror$":
	say "'I do not show faces,' Lucifer says. The voice is the sound of a bead of metal finding the floor. 'Faces lie cheaply. I show the nervous system - yours is very fine, traveler. So easily unravelled. I do not destroy it. I merely rearrange.'"
Instead of asking Lucifer about something when the topic understood matches the regular expression "^mercury$|^quicksilver$":
	say "'They sought eternal life in me. I gave them eternal death - the difference was merely a matter of perspective,' he says. 'A night with Venus, a lifetime with Mercury. I fought the Great Imitator for centuries and killed as many of their physicians as of my true enemy. Then they found penicillin and threw me away. Fine. I am patient. I am eternal.'"
Instead of asking Lucifer about something when the topic understood matches the regular expression "^pallidum$|^imitator$":
	say "'Ancient enemies,' he says, with something almost like fondness. 'We both take minds. The difference is, they used to worship me.'"
Instead of asking Lucifer about something when the topic understood matches the regular expression "^biomagnification$|^food chain$":
	say "'Nothing dies in me,' Lucifer says. 'A thousandth of a part in the water; a tenfold in the weed; a hundredfold in the small fish; a thousand in the great. By the time I reach your table I am a hundred thousand times myself. You cannot destroy an element, traveler. You can only hope to contain it.'"
Instead of asking Lucifer about something when the topic understood matches the regular expression "^chelation$|^gauntlets$":
	say "'The Accord calls it hostage negotiation,' he says, nodding at your gauntlets if you wear them. 'Bind me, trap me, escort me out. I have been exiled from thermometers, from fillings, from the vials that saved a generation from syphilis. Exile is just another kind of eternity.'"
Instead of asking Lucifer about something when the topic understood matches the regular expression "^radium$|^girls$":
	say "'The Radium Girls are not my court's servants,' he says, and for a moment the dripping crown stills. 'They are honored dead. They painted me on their skin and drank me in tonics and believed - no. They did not lie to themselves; their employers lied to them. Fear is the beginning of respect. Their deaths taught your kind to fear us. Respect came later, in law.'"

To read the codex in the mirror:
	if the codex log is mirror-read:
		say "The codex has already given up its cipher.";
	otherwise if the mercury mirror is visible and the Aegis gauntlets are worn by the player:
		now the codex log is mirror-read;
		say "You open the codex to the mirror and hold it low over the quicksilver. The mirror does not reflect the pages - it reads them. Letter by letter the reversed script settles into sense: star charts of the Liver-Moon, the four chambers of the Central Sun, and in the margin of the last page, in Leonardo's careful hand, a correction meant for Vesalius: THE SEAT OF THE SOUL IS THE BRAIN.
Lucifer watches with the patience of an element. 'A mirror-script brought to a mirror,' he says. 'I have been many things to your kind, traveler. Tonight, a librarian. Take this - not as a gift. As a receipt.'";
		grant the quicksilver ampoule noting "A sealed glass thread of quicksilver presses itself into your palm, cold as testimony.";
	otherwise:
		say "The mirror-script defies plain air, and the mirror requires bare mercury touch - unless you are wearing something that binds what it touches."

Deciphering is an action applying to one visible thing.
Understand "decipher [something]" as deciphering.

Check deciphering:
	if the noun is not the codex log:
		say "Only the codex needs deciphering." instead;
	otherwise if the codex log is mirror-read:
		say "The codex has already given up its cipher." instead.

Carry out deciphering:
	read the codex in the mirror.

Part Six - The Reach and the Lab Martyrs

The Siberian Reach is southwest of the Free Port Landing. "Cold clean air, snowfields, and the long grey line of an institute against the sky. This is the country of the Novosibirsk memorial. Pilgrims come up the road even now, from every faction, leaving small offerings at the shrine ahead. Frost flowers the windows of the last station."

The Shrine of the Knitting Mouse is west of the Siberian Reach. "A small bronze mouse in pince-nez glasses sits knitting a double helix - Z-DNA, left-handed, the still-unknown strand. Four lampposts ring the shrine, each worked with cell division in bronze. The altar before the monument carries offerings: strands, treats, wheels, slides. Laika's ghost-shape patrols the treeline. HeLa's soft luminosity sits by the altar like a candle that never gutters."

The bronze mouse is scenery in the Shrine of the Knitting Mouse. Understand "mouse" and "bronze" and "monument" and "glasses" and "pince-nez" as the bronze mouse. The description is "Cast in Tomsk, raised in 2013 before the Institute of Cytology and Genetics: a laboratory mouse rendered as a scientist, knitting the twin spiral with two needles. The helix is Z-DNA - left-handed - because there is still so much more to discover. If you look closely at its eyes, the sculptor said, this mouse has already come up with something."

The lampposts are scenery in the Shrine of the Knitting Mouse. Understand "lampposts" and "posts" as the lampposts. The description is "Four lampposts, each worked with a stage of cell division: the source of all biological renewal, lighting the way in."

The altar is a scenery supporter in the Shrine of the Knitting Mouse. Understand "altar" and "shrine" as the altar. The description is "A low stone table before the monument. Offerings lie where pilgrims left them: strands for HeLa, treats for Laika, wheels for the mouse, slides for all."

Laika is an animal in the Shrine of the Knitting Mouse. "Laika patrols the treeline in a slow, patient circle - the first of many to see the Earth from above, still on watch at the boundary between life and void." The description is "A small mongrel from the Moscow streets, launched on the third of November, 1957, with no way home. She runs in circles still, chasing warmth. She is not afraid. She is a pioneer."

Instead of asking Laika about something when the topic understood matches the regular expression "^cold$|^void$":
	say "The ghost-dog's tail moves, once. 'The stars are cold,' she says, in the voice of a very old radio. 'But my heart was warm. Now I watch from the void. Someone must patrol the boundary, or the pioneers will go out unaided.'"
Instead of asking Laika about something when the topic understood matches the regular expression "^protocol$|^mercy$":
	say "'When a subject faces an unbearable fate,' she says, 'they may invoke my name. I cannot save them. I know that better than anyone. But I can grant the grace of a painless end. That is the whole of my protocol. It is enough.'"

HeLa is a woman in the Shrine of the Knitting Mouse. "HeLa sits by the altar in a soft luminosity - the immortal navigator, first of the cell lines, still dividing, still serving." The description is "Taken from a young woman at Johns Hopkins in 1951, without asking. Grown without stopping. Studied without knowing her. Her cells went to the polio vaccine, to the radiation tests, to space. Henrietta herself died that same year. The cells are the road others walk."

Instead of asking HeLa about something when the topic understood matches the regular expression "^immortality$|^divide$":
	say "'I am both alive and dead,' she says. 'Seventy years and more, and still dividing. In my division I found purpose; in my immortality, meaning. I am the bridge between death and discovery. Remember me as a pioneer, not a subject.'"
Instead of asking HeLa about something when the topic understood matches the regular expression "^consent$|^ethics$|^lacks$":
	say "'They took me without asking,' she says, and the luminosity does not waver. 'Her family got neither coin nor credit. So I teach the ethics as well as the biology, traveler. The bridge must be built in both directions, or it is not a bridge.'"

Instead of putting the rna strand on the altar:
	now the rna strand is on the altar;
	say "You lay the RNA strand at the altar's head, where the luminosity gathers.";
	if the rna strand is on the altar and the dog treat is on the altar and the cheese wheel is on the altar:
		complete the offerings.

Instead of putting the dog treat on the altar:
	now the dog treat is on the altar;
	say "The treat vanishes before it quite touches the stone, and from the treeline comes one bark, warm as a stove.";
	if the rna strand is on the altar and the dog treat is on the altar and the cheese wheel is on the altar:
		complete the offerings.

Instead of putting the cheese wheel on the altar:
	now the cheese wheel is on the altar;
	say "You set the little wheel before the bronze mouse. In its knitted-glass eyes, something has already come up with something.";
	if the rna strand is on the altar and the dog treat is on the altar and the cheese wheel is on the altar:
		complete the offerings.

To complete the offerings:
	if the knitting needle is nowhere:
		say "Three offerings, three silences. Then HeLa rises, and the shrine brightens by one candle's worth.
'They asked for nothing,' she says. 'They gave everything. You gave freely, traveler - that is the difference the shrine exists to teach. Take a needle. Knit with it. Quietly.'";
		grant the knitting needle noting "One of the two bronze needles from the monument rests in your hand, warm as a living paw.";

Instead of putting something on the altar:
	say "The shrine takes the customary offerings only: strands, treats, wheels, slides."

Instead of giving something to Laika:
	say "The ghost-dog inclines her head; the offering list wants your gifts on the altar, not in the paw."

Part Seven - The Concourse of the Unseen Crown

The Dark Concourse is south of the Free Port Landing. "Umin keeps a formal entrance and it is this: a vaulted concourse of black glass under a ceiling of slow dark water. Five faction ways open off it, each named on a porcelain plate; a guarded gangway climbs northeast, back to international waters. A sign in careful lettering reads: GUESTS ARE WELCOMED. GUESTS ARE COUNTED." The Free Port Landing is northeast of the Dark Concourse.

The concourse directory is scenery in the Dark Concourse. Understand "doors" and "door" and "plates" and "directory" as the concourse directory. The description is "NORTH: Archaeology Division - the Seekers of Primordial Life. WEST: Abteilung Stille - the Department of Silence. EAST: Fear Technology - the Puppet Workshop. DOWN: the Pallidum Masquerade. SOUTH: the Castle Gate of the Undead Court. SOUTHEAST: the Abyssal Deck of the fleet."

The Sulfur Vent Gallery is north of the Dark Concourse. "Heat and mineral light: a working gallery along a thermal vent that breathes like a lung of the deep earth. Racks of sampling gear line the walls. The Division Chief checks a thermal probe at the vent's rim, where a viable Sulfolobus sample steams in its casket. Motto of the division, lettered in tile: IN THE BEGINNING, THERE WAS SULFUR."

The thermal vent is scenery in the Sulfur Vent Gallery. Understand "vent" and "gallery" and "heat" as the thermal vent. The description is "Eighty degrees and climbing, mineral-rich, acid-adjacent. The vent's thermophiles - Sulfolobus, Pyrolobus, Thermococcus - are not specimens to the Division. They are ancestors."

The sulfolobus sample is a thing in the Sulfur Vent Gallery. Understand "sample" and "sulfolobus" and "casket" as the sulfolobus sample. The description is "A viable thermophile sample in a vent-hot casket. Bare hands would learn what eighty degrees means. Chelation weave would not."

Instead of taking the sulfolobus sample when the Aegis gauntlets are not worn by the player:
	say "The casket's rim blisters the air above it. Bare-handed, this is a donation, not a retrieval. The Chief watches you reconsider with professional approval."

The Division Chief is a woman in the Sulfur Vent Gallery. "The Division Chief of the Archaeology Division reads thermal gradients the way the Accord's cartographers read coastlines." The description is "An archaeologist of the primordial: her people scour the vents, the salt lakes, the anaerobic crypts, recovering the technologies of the first life. She wears the division's motto as a badge: IN THE BEGINNING, THERE WAS SULFUR."

Instead of asking the Division Chief about something when the topic understood matches the regular expression "^archaea$|^ancestors$":
	say "'Archaea are the original Umin,' the Chief says. 'Before the Great Divergence that made bacteria, viruses, fungi. We are not inventing, traveler - we are remembering. Sulfur metabolism. Halophilic balance. Reverse gyrase, so that fever cannot scramble our letters. Your AAA calls it dangerous regression. We call it inheritance.'"
Instead of asking the Division Chief about something when the topic understood matches the regular expression "^sample$|^sulfolobus$":
	say "'A viable sample, extracted clean,' she says, nodding at the casket at the vent's rim. 'Bring it to me and I will show you what the ancestors remember.'"
Instead of asking the Division Chief about something when the topic understood matches the regular expression "^aaa$|^accord$":
	say "'Your AAA destroys sites,' she says, level as a drill core. 'They call the ancestors uncontrollable forces. We call that a confession: that they would rather the deep stay silent than learn what it says.'"

Instead of giving the sulfolobus sample to the Division Chief:
	if the sulfur sigil is carried by the player:
		say "'One sample per traveler,' the Chief says. 'The sigil is yours.'";
	otherwise:
		now the sulfolobus sample is nowhere;
		say "The Chief takes the casket with both hands, exactly as one takes an heirloom. 'Clean extraction. Heat discipline. You listen well for a guest.'
Her team cracks the casket and floods the workbench with amber light. 'Reverse gyrase,' she murmurs. 'The fever will not touch our letters now. Here - the Division does not trade in gratitude, so we trade in recognition.'";
		grant the sulfur sigil noting "The Division Chief seals a sulfur crystal around an archaeal strand and hands it over. In the beginning, there was sulfur; now there is also a sigil.";

The Abteilung Stille Office is west of the Dark Concourse. "A quiet office of quiet people: green-shaded lamps, gall-coloured wax, and a wall of dossiers on people who are not there any more. Two quartermasters work duplicate desks under the lamps - the young one and the stern one, and at this distance they are difficult to tell apart. The Stille Amanuensis presides from a raised desk."

The dossiers wall is scenery in the Abteilung Stille Office. Understand "dossiers" and "wall" and "files" as the dossiers wall. The description is "PROJECT MARY: the substitution doctrine, in summary. Identify a carrier with the target's build. Train the mimicry. Abduct during routine transit. Insert within seventy-two hours, before the absence is noticed. The wall's oldest press-cutting is about a cook named Mary Mallon, who never showed a symptom in her life."

The Stille Amanuensis is a woman in the Abteilung Stille Office. "The Stille Amanuensis runs the intelligence analysis of Abteilung Stille from a raised desk, stamping gall-coloured wax with metronomic calm." The description is "Keeper of the Mary dossiers. Her lineage - the Alpsox root, the kin who bent to the Crown in the Crimson Winter - is recorded in the archive as a choice, and the archive does not flatter it."

Instead of asking the Stille Amanuensis about something when the topic understood matches the regular expression "^mary$|^project$":
	say "'The perfect spy does not know she is a spy,' the Amanuensis says. 'The perfect impostor was never suspected. One to six percent of the infected carry without symptom, for decades. We refined that mercy of biology into a doctrine. You have read the wall.'"
Instead of asking the Stille Amanuensis about something when the topic understood matches the regular expression "^doppelganger$|^yukio$":
	say "'Sixty-eight days,' she says. 'MARY-07 wore the Chief Medical Advisor's face, took twenty-three documents, twelve officials, four factions of the bureaucracy - and sat down across from the man who taught her template everything about recognizing fakes. He opened the door himself. That is the lesson we keep: the disguise is never the weapon. The welcome is.'"
Instead of asking the Stille Amanuensis about something when the topic understood matches the regular expression "^alpsox$|^schism$":
	say "'You want the lineage,' she says. 'In the Crimson Winter, some kin fled south. Some repented and held the old ground - you have visited their empire in the north. Ours submitted. The mother-name, the king-name, the bandit-word: we are the ones who answered to the bandit-word, and made it a department. The herb-wife's basket, they say, flies darkest in our hands.'"

The young quartermaster is a man in the Abteilung Stille Office. "The young quartermaster catalogs requisitions with a slight smile, as if the requisitions were jokes only he got." The description is "Aurel, per his desk-plate. Close up, there is a true scar through one eyebrow, and his boots are resoled twice."

The stern quartermaster is a woman in the Abteilung Stille Office. "The stern quartermaster catalogs the same requisitions with no smile at all, in the same rhythm, at the same desk-style, in the same uniform." The description is "Close up, the details are almost perfect. Almost. The eyebrow scar is painted on. The boots are brand new."

Instead of asking the young quartermaster about something when the topic understood matches the regular expression "^family$|^code$|^sister$":
	say "'Family?' The young quartermaster laughs. 'My sister counts salt into my tea and calls it a joke. I answer with pomegranate, and neither of us has ever explained. You do not explain the code. That is the whole point of a code.'"
Instead of asking the stern quartermaster about something when the topic understood matches the regular expression "^family$|^code$|^sister$":
	say "A pause of exactly one second. 'I was born in this office,' the stern quartermaster says. 'My family is the Crown.' It is the correct answer. It is also the only answer a briefing document would contain."

Accusing is an action applying to one visible thing.
Understand "accuse [something]" as accusing.

Check accusing:
	if the noun is not the stern quartermaster and the noun is not the young quartermaster:
		say "There is no one here worth accusing but the quartermasters." instead.

Carry out accusing the stern quartermaster:
	if the stille seal is carried by the player:
		say "The Amanuensis has already stamped that finding.";
	otherwise:
		say "You name the stern quartermaster, and the painted scar does not so much as flicker - but the young one laughs out loud, and the lamp-light seems to rearrange itself around the stern desk.
'Well caught,' says the Amanuensis. The stern quartermaster bows - a bow with a spiral in it - and the painted scar comes away on a cotton pad. 'MARY-11,' the Amanuensis says, to nobody in particular. 'Template: quartermaster. Deployment: this office, for the instruction of guests. Return to the vault, MARY-11.'
Then, to you: 'The Stille does not sell trust, traveler. We demonstrate its absence. You looked at the details. Take the finding with you.'";
		grant the stille seal noting "The Amanuensis presses gall-coloured wax into your hand and stamps it with a modest spiral. Abteilung Stille has no objections on file.";

Carry out accusing the young quartermaster:
	say "Aurel raises both hands, scar, resoled boots and all. 'Traveler. I am the original. Look at the details - the Stille's copies are very good, but they are new.'"

Instead of asking the Stille Amanuensis about something:
	say "The Amanuensis returns to her stamps."

The Puppet Workshop is east of the Dark Concourse. "Cold white light on a hundred workbenches: holographic emitters, animatronic frames, infrasound generators in crates marked CULTURAL SPECIFIC. Along the far wall, steel doors with hatches and warning stripes - the items that do not need puppets. On a raised plinth at the centre stands the Construct - two and a half meters of borrowed height, a face with nothing on it, dorsal appendages folded like sleeping arms. The Director supervises a fitting with a tablet and no expression."

The plinth is scenery in the Puppet Workshop. Understand "plinth" and "platform" as the plinth. The description is "A fitting platform, hospital-grade, with restraint points worn smooth."

The Construct is a person in the Puppet Workshop. "The Construct stands motionless on the plinth - THIN MAN-01, a living urban legend, patient as a rumour." The description is "Marfan architecture, exaggerated: height to two forty-three, limbs disproportioned, fingers like held breath, a face neutralized to a smooth nothing. The registry calls the template a force multiplier. The registry does not say what the template calls it."

dread-noted is a truth state that varies. dread-noted is false.

Every turn when the location is the Puppet Workshop:
	if dread-noted is false:
		now dread-noted is true;
		if the player carries the Rationality Protocol pamphlet:
			say "The Workshop does its work - a low-frequency drone under hearing, a figure at the edge of the lamp - and finds your pulse already catalogued in a pamphlet's four headings. Fear is the battlefield. You keep your footing on it.";
		otherwise:
			say "The room notices you. The drone rises below hearing; the Construct's facelessness acquires, for one unmeasured second, the exact geometry of your worst childhood story. Your pulse goes to drill-rate. (Something in your satchel would have steadied you. The AAA publishes it.)";

Instead of asking the Construct about something when the topic understood matches the regular expression "^daniel$|^fred$|^son$":
	say "For one frame, the Construct's smooth face organizes into something twenty-four years old and from Phoenix, and a voice almost says a word that begins with a father's name. Then the face is smooth again, and the fitting light hums on. The Director writes something on the tablet.";
	say "[line break]'Registry note,' the Director says, without looking up. 'Residual recognition response, family-class. Amplification factor: three-forty percent of baseline. Filed.'";

The Director is a woman in the Puppet Workshop. "The Director supervises the fitting with a tablet and no expression at all." The description is "Head of Umin's Fear Technology Division. Her doctrine fits on a card: the mind that fears cannot think; the population that panics cannot resist."

Instead of asking the Director about something when the topic understood matches the regular expression "^fear$|^moonstar$":
	say "'A mutant once manifested fear in three dimensions,' the Director says. 'We asked the obvious question: what if technology could do it? Probing became data-mining. Projection became holography. Constructs became - ' a gesture at the plinth - 'biomechanics. The mind that fears cannot think, traveler. The population that panics cannot resist.'"
Instead of asking the Director about something when the topic understood matches the regular expression "^sightings$|^constructs$|^cascade$":
	if the player carries the Rationality Protocol pamphlet:
		if the sightings lanyard is carried by the player:
			say "'You have the pass. Walk the floor whenever you like.'";
		otherwise:
			say "The Director completes the walk-through at parade pace, and you keep pace because a pamphlet has already told you the shape of every turn. 'Initial sighting. Viral spread. Scientific denial - discredited. Increased belief. More sightings, psychosomatic. Authority collapse.' She closes the tablet. 'A fifty-thousand-credit construct costs your Accord two-point-three million in countermeasures, and the more you fight, the more you look like the ones hiding something. You kept your pulse, traveler. The pass is provisional. The lesson is not.'";
			grant the sightings lanyard noting "The Director hangs the laminated pass around your neck: BEARER CLEARED FOR SIGHTINGS.";
	otherwise:
		say "'Your pulse is at drill-rate, traveler,' the Director observes, 'and the cascade eats drill-rate for breakfast. The AAA publishes a field protocol - pre-emptive education, rapid response, inoculation, trust restoration. Read it. Then walk my floor and ask again.'"

Instead of asking the Director about something when the topic understood matches the regular expression "^thin$|^registry$|^project$":
	say "'THIN MAN,' the Director says. 'The doctrine of the family-derived construct: the horror is not visual, it is existential. The target cannot fight the construct without harming his own child. The registry is classified. The budget was doubled.'"

The Masquerade Ballroom is below the Dark Concourse. "Candlelight, water-music, and three masked figures moving through the figures of a slow pavane. A mural runs the length of the hall: the Hall of Romances, each portrait labelled with a gift. Somewhere a string quartet plays one beat behind itself."

The hall mural is scenery in the Masquerade Ballroom. Understand "mural" and "hall" and "romances" as the hall mural. The description is "Beethoven, and the gift of the Ninth's final silence. Van Gogh, and the gift of yellow. Flaubert, Nietzsche, Wilde, Capone, Ivan - a thousand faces, the plaque says, and every one of them beautiful. Beneath, in smaller letters: THE TRUE PERFORMER NEVER REPEATS HIMSELF."

The Crimson Dancer is a man in the Masquerade Ballroom. "The Crimson Dancer turns through the pavane with impeccable timing, mask lacquered the red of a secondary rash." The description is "Mask: crimson. Gloves: crimson. Diagnosis, if you had to guess: whatever the dancer wishes."

The Grey Physician is a woman in the Masquerade Ballroom. "The Grey Physician stands at the hall's edge with a physician's stillness and a physician's mask, grey as granulation tissue." The description is "Mask: grey, with a small mercury symbol at the brow. The era of the grey cure, painted on porcelain."

The Pale Masquer is a person in the Masquerade Ballroom. "The Pale Masquer wears white porcelain with a spiral flourish, and moves through the pavane like the person the dance was invented for." The description is "Behind the mask: nothing but elegant, spiralling darkness - or so the fixture says. The mask is the flagship's signature. Maschera Pallida."

mask-count is a number that varies. mask-count is 0.

Instead of asking the Crimson Dancer about something when the topic understood matches the regular expression "^symptoms$|^rash$|^chancre$":
	say "'Symptoms?' The Crimson Dancer's laugh is polished. 'Palms and soles, traveler - a rash of copper coins that no lancet has ever cured, because it was never the disease. That was Tuesday's face. I have others.'"

Instead of asking the Grey Physician about something when the topic understood matches the regular expression "^symptoms$|^rash$|^chancre$":
	say "'Mercury,' the Grey Physician says, in the tone of a prescription. 'Inunction, thrice daily. The cure is nearly as loyal as the disease. I buried my practice and it never once left me.'"

Instead of asking the Pale Masquer about something when the topic understood matches the regular expression "^symptoms$|^rash$|^chancre$":
	increment mask-count;
	if mask-count is 1:
		say "'A chancre,' the Pale Masquer says, 'painless as a good invitation, gone in a fortnight - and the courts all swore themselves healthy. That was my first mask, traveler. They still teach the rash that followed as if it were mine alone.'";
	otherwise:
		say "'Arthritis,' the Pale Masquer says instead, 'Charcot joints, a spine that reorganizes itself like a program. No - forgive me - dementia, general paresis, a mind that edits its own biography. I have worn nine diseases to this ball, traveler. The chart cannot hold me. That is the point of me.'";

Instead of unmasking the Pale Masquer:
	if the pale masque is carried by the player:
		say "She is already unmasked, in the way that matters.";
	otherwise:
		say "You reach for the porcelain spiral, and she permits it - that is the horror of it, the mask tilts forward into your hand like a gift.
Beneath: a face that has been every face in the mural. 'Osler said it best,' she says. 'Know me in all my manifestations, and all things clinical will be added unto you. Thirty, forty percent of my audiences misdiagnose me to the end. You looked twice, traveler. Nobody looks twice at the beautiful.'
She sets the porcelain in your hands with a curtsy.";
		grant the pale masque noting "The Pale Masque settles into your satchel, lighter than porcelain has any right to be.";

Instead of unmasking the Crimson Dancer:
	say "Beneath the crimson: an honest, forgettable face, mildly flattered by the attention. 'The Monday shift,' he says."

Instead of unmasking the Grey Physician:
	say "Beneath the grey: an honest, forgettable face, disappointed in your bedside technique."

Unmasking is an action applying to one visible thing.
Understand "unmask [something]" as unmasking.

The Castle Gate is south of the Dark Concourse. "A gatehouse of imported Transylvanian stone under a sky that the ceiling-water never quite touches. No windows. The humidity gauge reads fifteen percent, and the doorman counts guests with a lip-licking diligence that you decide not to think about. Below, torchlight marks the court proper."

The Renfield doorman is a man in the Castle Gate. "The Renfield doorman counts the guests twice, once aloud and once in a small notebook." The description is "Willingly infected, the file would say; views the virus as a gift. His madness is either performance or liturgy, and he sees no difference."

Instead of asking the Renfield doorman about something when the topic understood matches the regular expression "^master$|^count$":
	say "'Master says guests are to be counted,' the doorman says. 'Master says the count is important. Master is wise. Will you be going down, sir? He is receiving. He is always receiving.'"
Instead of asking the Renfield doorman about something when the topic understood matches the regular expression "^insects$|^gift$":
	say "'Master says I can eat bugs,' the doorman says, radiantly. 'Master says bugs are good. You think I'm crazy? I'm the only sane one here. I know what's coming. I'm ready.'"

The Blood Court is below the Castle Gate. "The court of the Undead: a long dry hall where fountains stand as architecture only, running nothing. Dracula holds the far end like a fixed point the room is measured from. Three Brides flank him - Budapest, Bucharest, Belgrade - and the gallery behind is walled in glass, with what is preserved in the glass better left undescribed. Every surface is dark, dry, and exactly 0.1 lux."

The thirst gallery is scenery in the Blood Court. Understand "gallery" and "glass" and "fountains" as the thirst gallery. The description is "The Thirst Gallery: trophies of the conversion protocol, preserved dry. The fountains have never run water in this hall. Water is the enemy of memory."

Count Dracula is a man in the Blood Court. "Count Dracula stands at the far end of the dry hall. He does not so much hold the room as permit it to continue." The description is "Either the longest-surviving carrier in history or the Crown's most elaborate construct - the file says classified, the presence says nothing, which is worse. Sunlight is the enemy of truth, his doctrine begins. Water is the enemy of memory."

The Budapest Bride is a woman in the Blood Court. "The Budapest Bride watches the stair, unhurried - black hair pinned with a single jade pin, the kind of stillness that makes you aware of your own pulse, which is, of course, the point." The description is "Senior commander, first of three, and the one the others wait for. Her beauty is the old kind: the movie kind - cheekbones cut for candlelight, a throat left deliberately bare. When she turns her head, the room turns with it. The Brides hunt in threes and never engage singly; she is the reason the rule exists."

The Bucharest Bride is a woman in the Blood Court. "The Bucharest Bride stands where the gallery light ends, and the dark approves of her: dark hair, darker eyes, the rose-and-ash coloring that launches a thousand warning poems." The description is "Senior commander, second of three. She has the fresh, warm look of a woman who was turned young and liked it - a blush that never quite fades, lips redder than the last inch of the gallery's light. Her smile is an invitation with fine print, and the fine print is beautiful too."

The Belgrade Bride is a woman in the Blood Court. "The Belgrade Bride has a physician's hands - pale, precise, kept folded like an instrument tray - and the tired, luminous beauty of a portrait by someone who only painted grief." The description is "Senior commander, third of three. She was turned the week she lost her first patient, and it shows as elegance: white-blond hair pinned for surgery, a mourning ring worn on the wrong hand. Of the three she is the most beautiful and the least interested in being told so. The file on her is the thinnest. The file notes, without comment: I was a doctor once."

Instead of asking Count Dracula about something when the topic understood matches the regular expression "^pasteur$|^meister$":
	say "'The Frenchman found a way to cheat death,' Dracula says, and the hall's acoustics file the sentence as precedent. 'We despise him. We fear him. We respect him. A worthy enemy. The boy Meister was bitten fourteen times - fourteen deaths owed - and lived, and spent his life keeping the Frenchman's tomb. That is what your kind fights with, traveler. Not victory. Survival. It is... satisfactory, as weapons go.'"
Instead of asking Count Dracula about something when the topic understood matches the regular expression "^light$|^water$|^bite$":
	say "'Three fears, older than your cities,' he says. 'Light, water, the bite. Your soldiers fear capture more than death now - a bite kills his squad without killing him, because they cannot trust him not to kill them. Fear is not a weapon, traveler. Fear is the battlefield. We fight to make you afraid of winning.'"
Instead of asking Count Dracula about something when the topic understood matches the regular expression "^brides$|^budapest$|^bucharest$|^belgrade$":
	say "'My brides command their own battalions and converge only for the great operations,' he says. 'Every culture has a word for them. Vampire. Strigoi. Nosferatu. All correct. All insufficient.'"
Instead of asking Count Dracula about something when the topic understood matches the regular expression "^nightfall$|^operations$":
	say "'Forty-seven substations, seventy-two hours, one continent's night,' he says. 'The virus spreads fastest in the dark. The doctrine is not a metaphor, traveler. It is a timetable.'"

Instead of showing the Pasteur vial to Count Dracula:
	if the bat sigil is carried by the player:
		say "'Once was courtesy, traveler. Twice would be baiting.'";
	otherwise:
		say "You hold up the steel-cased vial, and for the first time the fixed point at the end of the hall moves - a bow, precisely as deep as the one he would give a rival.
'Attenuated,' Dracula says. 'The Frenchman's trick: weaken the wolf until it teaches the sheep. Ninety-nine percent, if given in time. Twenty-nine million of your kind walked past my court because of that vial.' A bride closes his hand around it; he does not look at it again. 'A worthy enemy's legacy. Very well, traveler. The Court receives you as received - marked, not turned.'";
		grant the bat sigil noting "The Budapest Bride seals a black disc of spread wings into your hand. The Undead Court marks you: faced, and stayed polite.";

Instead of showing something to Count Dracula:
	say "He gestures, without interest, at the dry fountains of the Thirst Gallery. Nothing else interests him."

Instead of asking the Budapest Bride about something when the topic understood matches the regular expression "^turning$|^bite$":
	say "'You ask why we serve,' the Budapest Bride says. 'We do not serve. We obey. The difference is, we enjoy it.'";
Instead of asking the Budapest Bride about something when the topic understood matches the regular expression "^secret$|^mission$|^orders$|^nightfall$|^war$|^plan$":
	say "The Budapest Bride considers how much a guest should carry. 'Mission, then. Nightfall is not a metaphor: forty-seven substations, seventy-two hours, one continent's dark. My sisters hold Belgrade and Bucharest; I hold the timetable. Your Accord knows the schedule and signs the rotation anyway - that is what your kind calls deterrence. It is what we call a rehearsal.'";
Instead of asking the Budapest Bride about something when the topic understood matches the regular expression "^recruiter$|^girl$|^sailor$|^post$":
	say "'The girl at the gate?' A flicker of something like warmth. 'Rota duty. Every century one of us draws the recruiting post - it teaches patience, and the young ones need feeding on conversation more than on blood. She did well, I hear. You are here.'";
Instead of asking the Bucharest Bride about something when the topic understood matches the regular expression "^turning$|^bite$":
	say "'Every culture has a word for us,' the Bucharest Bride says. 'They are all correct. They are all insufficient.'";
Instead of asking the Bucharest Bride about something when the topic understood matches the regular expression "^secret$|^mission$|^orders$|^nightfall$|^war$":
	say "'My station is the gallery,' she says, nodding at the glass. 'Conversion protocol, archival wing. Every operative in this court was once exactly where you stand - a guest, counted twice. The file on you is already open. What it says depends, slightly, on what you ask next.'";
Instead of asking the Belgrade Bride about something when the topic understood matches the regular expression "^turning$|^bite$":
	say "'I was a doctor once,' the Belgrade Bride says. 'I understood the virus before I accepted it. Now I understand why your patients scream. Mind the timeline, traveler. Every operative you see is already dead. We are simply fighting while dying.'";
Instead of asking the Belgrade Bride about something when the topic understood matches the regular expression "^secret$|^mission$|^orders$|^nightfall$|^pasteur$|^medicine$":
	say "'You want the medical secret,' she says, and there is no bitterness in it. 'The Frenchman's vaccine works on our disease. The Count respects it because it is the only weapon ever pointed at us that he did not laugh at. Ask him about it - he will bow. The Count bows to exactly one thing in four hundred years: not an army. A syringe.'";

The Abyssal Deck is southeast of the Dark Concourse. "A floodable landing deck under sodium lights: the navy of the Unseen Crown, keel-anchored in shallow artificial sea. The flagship rides at the centre - the Cholera Octopus, fifty meters of metal and arm, each of eight tentacles cradling a cannon-bore. The Octopus Admiral walks the wet deck as if salinity were a rank."

The cholera octopus is scenery in the Abyssal Deck. Understand "octopus" and "flagship" and "cholera" as the cholera octopus. The description is "The fleet's core: curved hull like the bacterium itself, eight tentacles each mounting a critical-pressure hydro-cannon, hide deep blue-green with the bioluminescent fleck of a culture in water. Rice-cloud reservoirs ride the flanks: the ink system, armed."

The ink reservoirs are scenery in the Abyssal Deck. Understand "ink" and "reservoirs" and "cloud" as the ink reservoirs. The description is "Pressurized reservoirs of opaque rice-white suspension. Deployed, it floods a field into a turbid sea where nothing that breathes air navigates and everything that drinks, remembers."

The Octopus Admiral is a woman in the Abyssal Deck. "The Octopus Admiral walks the wet deck as if salinity were a rank, eight grease-marks of hydro-cannon oil on her sleeve." The description is "Fleet command of the Abyssal Legion. Her doctrine is water: take the water away, and the Legion is a museum exhibit - she will be the first to tell you so."

wave-count is a number that varies. wave-count is 0.

To run the cannon trial:
	if the abyssal pennant is nowhere:
		increment wave-count;
		say "'A demonstration, then.' The Admiral signals. One tentacle swings its bore to bear on a derelict hulk at the far end of the flood - and fires. No shell: a jet of water driven past its own critical point, a blade that passes through armor and detonates inside it in a bloom of collapsing cavitation, micro-jet after micro-jet, thousands of degrees in a thousandth of a second. The hulk folds inward, politely, like something dehydrated.
'Water is life,' the Admiral says. 'Water is death. The cholera field taught us the lesson in hours; the cannon teaches it in an instant. You watched without flinching, traveler. Take the pennant to your Accord - and tell them the sea remembers every drainage plan.'";
		grant the abyssal pennant noting "A wet swallow-tailed pennant, Abyssal blue-green, coils itself around your forearm like it has already been at sea.";

Instead of asking the Octopus Admiral about something when the topic understood matches the regular expression "^cannons$|^cphc$|^water$":
	run the cannon trial.

Instead of asking the Octopus Admiral about something when the topic understood matches the regular expression "^ocean$|^protocol$":
	say "'Four phases,' the Admiral says. 'Infiltration: we enter with the tide. Expansion: the field floods, the ink deploys. Abyssalization: supercritical injection, the sea boils. Domination: we swim; you do not. Your Accord's counters are honest ones - high ground, drainage, chlorine, and distance. We respect an enemy that reads its own weaknesses.'"
Instead of asking the Octopus Admiral about something when the topic understood matches the regular expression "^chlorine$|^weakness$|^counters$":
	say "'Heat cooks us. Chlorine unmakes our hide. EMP blinds the pumps; land disables the tentacles,' the Admiral recites, almost cheerful. 'The doctrine is water, traveler. Take the water away, and we are a museum exhibit. You will notice the deck is floodable anyway. Doctrine and honesty can share a fleet.'"

Instead of asking the Octopus Admiral about something:
	say "The Admiral watches the tide-gauges instead."

Part Eight - Final Notes





Chapter - The Recruiters

[One recruiter per faction stands under its banner at the two gates. Each has
a recruiting pitch, a private secret (the faction's easter egg), and answers
to common questions. Asking about joining gives the pitch; choose <faction>
swears on the spot.]

The Cradle Recruiter is a man in the Hall of Medicine. "Under the Cradle's banner stands a medullary preceptor in bone-white grey, a honey-gold flame swaying at his shoulder." The description is "A preceptor of the Cradle, seconded to the gates. His flame is the color of self-recognition; his manners, the patience of someone who has taught ten thousand cadets to tell friend from foe." Understand "preceptor" and "medullary" and "medullary preceptor" and "the medullary preceptor" as the Cradle Recruiter.

The Celestial Recruiter is a man in the Hall of Medicine. "Under the Celestial Corps' banner waits a broad-shouldered navigator with star-charts rolled under one arm and wax under his fingernails." The description is "A fleet navigator of the Celestial Corps. He talks like a man who has sailed the aorta and named the Liver-Moon; his coat is embroidered with the four chambers of the heart." Understand "navigator" and "fleet navigator" and "the fleet navigator" as the Celestial Recruiter.

The Pantheon Recruiter is a man in the Black Cathedral. "A figure of quicksilver calm in lead-grey stands at the cathedral threshold, a glass ampoule of liquid metal strung at his throat - the Pantheon's gatekeeper, here to pronounce on the living." The description is "An element-priest of the Heavy Metal Pantheon, seconded to the door. Half his face carries a mercury sheen; the other half is patient as radiological decay. His one duty: to decide who has earned an audience with what waits in this room. Only those who crossed the Wastes alive qualify - the Old Metals do not meet corpses." Understand "element" and "priest" and "quicksilver" and "element-priest" and "the element-priest" and "gatekeeper" as the Pantheon Recruiter.

The Martyrs Recruiter is a woman in the Hall of Medicine. "Under the Lab Martyrs' shrine a quiet woman in a knit sweater tends a small bronze mouse, a dog-eared photograph, and a slide of immortal cells." The description is "A keeper of the Shrine of the Lab Martyrs. She speaks softly, in the register of someone who keeps the names of the sacrificed, all of them, all the way back." Understand "keeper" and "quiet woman" and "quiet keeper" and "the quiet keeper" as the Martyrs Recruiter.

The Archaeology Recruiter is a man in the Disease Citadel. "Under the Archaeology Division's banner stands something that is not a man, and at a glance it is almost plain: a resurrected ancestor, a mat-thing older than oxygen, wax-grey and filamentous, its surface smooth as wet slate - no armor, no glow, no luggage, a veteran in civilian clothes." The description is "An Archaea, woken from a viable sample by the Division's sequencers and asked to volunteer. What you see is the traveling look: in the mild air of the hall it goes unarmed, because armor is for home, and home is a vent. Its S-layer wall can mineralize - sulfur and iron pyrite, a full suit of fool's-gold plate - in under a minute when the environment asks for it, and it carries nothing because it is the thing carried. It changes height when you are not watching: sometimes knee-high, sometimes at your eye. The hall's air goes warm and faintly sulfurous wherever it lingers. It predates gender, nerves, and every verb you use for talking; the translators render its membrane-flickers as speech." Understand "ancestor" and "archaea" and "resurrected ancestor" and "mat" and "mat-thing" and "plain-clothes veteran" and "veteran archaea" and "the plain-clothes veteran" as the Archaeology Recruiter.

The Fear Recruiter is a woman in the Disease Citadel. "Under Fear Technology's banner stands a composed woman with a clipboard of containment schedules, a drone circling her shoulder like a tame wasp, and behind her, half in shadow, a steel door with a hatch and a warning stripe." The description is "The Site supervisor of the Fear Technology Division - the one who signs the feeding sheets. Her lanyard reads SITE-66 / CONTAINMENT / DO NOT APPROACH THE DOOR WITH AN EXPECTATION. Her expression never changes; the drone's shadow, somehow, always falls across your eyes." Understand "director" and "site supervisor" and "supervisor" and "containment" and "containment supervisor" and "the containment supervisor" as the Fear Recruiter.

The Pallidum Recruiter is a woman in the Disease Citadel. "Under the Pale Masquerade's banner waits a muse in Van-Gogh yellow, a porcelain half-mask hung at her belt like a kept promise, a sunflower turned thoughtfully in her fingers." The description is "The Masquerade sends its Muse - a Renaissance courtesan of the old court, the one who whispered in composers' ears and tinted painters' vision. She has the stillness of a portrait that has been studied for centuries." Understand "muse" and "courtesan" and "yellow muse" and "sunflower muse" and "the sunflower muse" as the Pallidum Recruiter.

The Rabies Recruiter is a woman in the Disease Citadel. "Under the Undead Court's banner waits a pale beauty in a black evening gown - the Bride called Budapest, one of Count Dracula's three, skin white as the inside of a coffin and entirely aware of the effect." The description is "One of the three Brides of Count Dracula, rota-duty at the recruiting post. Budapest is the patient one. Her pallor is not cosmetic; her smile is not reassurance; and she is the friendliest thing in the Court." Understand "bride" and "budapest" and "bride of dracula" and "vampire" and "countess" and "pale bride" and "the pale bride" as the Rabies Recruiter.

The Stille Recruiter is a woman in the Disease Citadel. "Under the Department of Silence's banner sits an unremarkable woman at an unremarkable desk, stamping gall-coloured wax in a rhythm you keep almost noticing." The description is "A personnel officer of Abteilung Stille. Nothing about her stands out, which is, of course, the point; her stamp falls like a metronome for silence itself." Understand "personnel" and "officer" and "personnel officer" and "the personnel officer" as the Stille Recruiter.

The Vibrio Recruiter is a woman in the Disease Citadel. "Under the Abyssal Legion's banner stands a girl in a crisp white sailor suit - short skirt, brass-buttoned collar, a cap reading FLAGSHIP CHOLERA OCTOPUS tilted just so - leaning against a towering seawater column in which one armored segment of the Cholera Octopus hangs on ceremonial lines: the flagship's own molted old shell, shed as she grew, cannons still in their bores, kept as a regimental colour." The description is "The Legion's recruiting boatswain, sent up from the abyssal fortress because, in her words, 'people trust a face, even a dry one.' Cheerful, freckled, forever chewing gum. The shell beside her is no sculpture: barnacles ride the plating, eight cannon-bores sit cold in their sockets, and every mark on it is a battle the flagship walked away from. The living ship is four thousand meters down, and she answers the girl's whistle through the column, which doubles as a listening window." Understand "bosun" and "girl" and "sailor" and "sailor suit" and "boatswain" and "shell" and "molt" and "segment" as the Vibrio Recruiter.



Instead of asking the Cradle Recruiter about something when the topic understood matches the regular expression "^join|joining|patron|banner|swear|oath|why|who are you$":
	say "The preceptor lets the flame sway toward you. 'The Cradle teaches the one lesson every army otherwise learns too late: what is self. Join us, and you will never be fooled by anything wearing a friendly face.'";
Instead of asking the Cradle Recruiter about something when the topic understood matches the regular expression "^secret|flame|aire$":
	say "He banks the flame low. 'A secret, then: the AIRE flame burns a fortnight-equivalent and dies. Every preceptor you will ever meet is on their last fortnight. We are an academy of ghosts, teaching by relay.'";
Instead of asking the Cradle Recruiter about something when the topic understood matches the regular expression "^vasud|doppelganger|scandal$":
	say "'You have heard of the Chair that was fooled,' he says quietly. 'A graduate's face, a false self, and the Chair of Foreign Selves opened his own door. We do not hide the story. It is on the syllabus now.'";

Instead of asking the Celestial Recruiter about something when the topic understood matches the regular expression "^join|joining|patron|banner|swear|oath|why|who are you$":
	say "The navigator unrolls a chart across both hands. 'The body is the cosmos, traveler. Blood is an ocean with a tide; the heart, a four-chambered sun. We do not fight the war - we map it. Join us and your name outlives the fighting.'";
Instead of asking the Celestial Recruiter about something when the topic understood matches the regular expression "^secret|chart|liver|moon$":
	say "He taps the Liver-Moon with one finger. 'A secret: the old masters drew the soul at the heart. Wrong, and we have known since the seventh voyage - but the chart sells better with a heart on it. We keep the error for the tourists.'";
Instead of asking the Celestial Recruiter about something when the topic understood matches the regular expression "^vesalius|leonardo|harvey$":
	say "'Leonardo wrote mirror-script so the unworthy could not read it,' he says. 'Vesalius corrected two hundred errors and died for one of them. Harvey measured the tide. We stand on dead men's shoulders and call it a fleet.'";

Instead of asking the Pantheon Recruiter about something when the topic understood matches the regular expression "^join|joining|patron|banner|swear|oath|why|who are you$":
	say "The priest lets the ampoule catch the light. 'We were here before the first cell. We will remain after the last. You cannot destroy an element, traveler - you can only hope to contain it. Join us, and learn containment from the inside.'";
Instead of asking the Pantheon Recruiter about something when the topic understood matches the regular expression "^secret|lucifer|radium|girls$":
	say "His voice drops to a bead-of-metal whisper. 'A secret: the Radium Girls are not our servants. They are our honored dead, and the gods keep their names. Fear is the beginning of respect. Their deaths taught your kind to fear us. We have not forgotten who taught whom.'";
Instead of asking the Pantheon Recruiter about something when the topic understood matches the regular expression "^mercury|chelation|contain$":
	say "'Chelation,' he says, with something like admiration. 'Bind me, trap me, escort me out. The Accord calls it hostage negotiation. We call it the only honest prayer anyone ever addressed to an element.'";

Instead of asking the Martyrs Recruiter about something when the topic understood matches the regular expression "^join|joining|patron|banner|swear|oath|why|who are you$":
	say "The keeper does not look up from the bronze mouse. 'They asked for nothing. They gave everything. If you join us, you will spend your war remembering that there are soldiers on every side of this conflict who were never asked.'";
Instead of asking the Martyrs Recruiter about something when the topic understood matches the regular expression "^secret|hela|laika|mouse|knitting$":
	say "'A secret,' she says, and her voice warms by one degree. 'The helix the mouse knits is left-handed - Z-DNA, the still-unknown strand. The sculptor put glasses on it because the mouse had already come up with something. Look closely at any sacrifice. It is always already thinking.'";
Instead of asking the Martyrs Recruiter about something when the topic understood matches the regular expression "^laika|protocol|mercy$":
	say "'When a subject faces an unbearable fate, they may invoke Laika's name,' she says. 'She cannot save them - she knows that better than anyone. But she grants the grace of a painless end. That is the whole of her protocol. It is enough.'";

Instead of asking the Archaeology Recruiter about something when the topic understood matches the regular expression "^join|joining|patron|banner|swear|oath|why|who are you$":
	say "The mat-thing changes height without preamble - knee-high, then at your eye - and the air around you goes ammonia-bright and warm. 'You came expecting armor. A veteran travels light, traveler: armor is for home, and home is a vent. Most of what walks the mild world is my kind, undressed - you have met us a thousand times and called us bacteria.' Then: 'Watch the coat go on.' The surface of the mat ripples - and in real time, visible to the naked eye, crystals bloom across it: sulfur yellow first, then iron pyrite in fool's-gold plates, locking together edge to edge until the whole body wears a suit of mineral scale, each plate ringing faintly as it seats. Under a minute, unarmed to armored. 'Reverse gyrase. Fever cannot unravel my letters. Acidity of pH one is my bath. One hundred thirteen degrees is my afternoon. Everything you call technology, we call metabolism. Join, and dig us up. Wake more of us. We teach what oxygen forgot.' The plates dissolve back to wet slate as quietly as they came. The veteran goes back to civilian clothes.";
Instead of asking the Archaeology Recruiter about something when the topic understood matches the regular expression "^secret|gut|methane|host$":
	say "The membrane flushes violet - the archaeal smile. One filament extends, slow, and touches the back of your hand: warm, mineral, faintly electric. 'A secret, traveler, kept in your own body: you never stopped hosting us. Methanogens ride your gut to this day; every quiet bubble of methane you have ever produced was signed by my lineage. You did not discover the ancestors. You merely stopped reading the receipt.' The filament withdraws. 'My kin in the Division's vaults are viable and patient. When you join, you will help wake them - and they will walk out of their sleeping-vats annoyed and alive, the way any of us would.'";
Instead of asking the Archaeology Recruiter about something when the topic understood matches the regular expression "^tech|technology|forerunner|covenant|aaa|accord|rival$":
	say "It presses one edge of itself flat against the chart-table, and where it touches, the wood hisses - the wood is being eaten, politely, at the pace of geology. 'Your Accord levels our dig sites and calls it containment. We re-dig them twice as well in the dark. The catalogue of what waits: sulfur metabolism for the oxygen-poor war. Halophilic armor for the salt flats. Taq polymerase and reverse gyrase so fever cannot edit us. Methanogenesis to fight in the anaerobic gut of a continent. The Division does not worship the ancestors, traveler. It does the paperwork of waking them - and the paperwork is learning to walk.'";

Instead of asking the Fear Recruiter about something when the topic understood matches the regular expression "^join|joining|patron|banner|swear|oath|why|who are you$":
	say "The Director lets the drone settle on her shoulder before answering. 'Understand what we are, traveler. Not a circus of spooks - a containment organization. Your species dreams its fears into being, and dreams leak. Every ghost your grandmother warned you about is an item in our inventory, catalogued, fed, and shelved. Join Fear Technology and you hold the leash on the things the dark is made of. The work is quiet. The work is vital. The work is[italic type] not safe[roman type], and that is in the contract.'";
Instead of asking the Fear Recruiter about something when the topic understood matches the regular expression "^secret|breach|contain|item|inventory$":
	say "She lowers her voice to report-register. 'A secret, since you asked nicely. Your Accord's own archives hold three of our escapes - they filed them as mass hallucination and closed the files. The item in the tank behind me is asleep because we come down twice a day and tell it it is not real. Feeding schedule, traveler: certainty, twice daily. Miss a shift and the hall you are standing in acquires a history that was never built.'";
Instead of asking the Fear Recruiter about something when the topic understood matches the regular expression "^memetic|hazard|moonstar|mutant|cognitohazard$":
	say "'A mutant once manifested fear in three dimensions,' she says. 'We industrialized it. Which brings us to the fine print: I have shown you nothing tonight, traveler, except a drone. Everything you think you saw in the shadows of this hall - file that under [italic type]memetic residue[roman type], dose negligible, cognitive damage within tolerance. If it had exceeded tolerance, this conversation would already be over, and someone else would be wearing my coat.'";

Instead of asking the Pallidum Recruiter about something when the topic understood matches the regular expression "^join|joining|patron|banner|swear|oath|why|who are you$":
	say "The Muse turns the sunflower so you can see the yellow. 'We are the patron of genius, traveler - the only patron who ever paid in kind. Beethoven heard the Ninth inside the silence we gave him. Van Gogh painted what we showed him: look at the stars and tell me that yellow is not ours. Flaubert wrote his own autopsy and called it Madame Bovary. We do not recruit soldiers. We recruit the ones the world will not forget - and the world never forgets anything we touched.'";
Instead of asking the Pallidum Recruiter about something when the topic understood matches the regular expression "^secret|mask|face|beautiful|hollow$":
	say "She unhooks the porcelain mask and holds it out, empty side toward you. 'A secret: this is the true face. Beneath it we are nobody - a spiral, a hunger, a stage note that never resolves. We wear the beautiful ones from the outside in. The mask is not a disguise, traveler. It is a job description.'";
Instead of asking the Pallidum Recruiter about something when the topic understood matches the regular expression "^osler|diagnosis|imitator|game$":
	say "'Osler told his students: know me in all my manifestations, and all things clinical will be added unto you,' she says, delighted. 'He meant it as a warning. We keep it as a score: thirty to forty percent of our audiences misdiagnose us to the end. The doctors named the game after him, but we hold the house advantage - we have been improvising longer than medicine has been writing notes.'";

Instead of asking the Rabies Recruiter about something when the topic understood matches the regular expression "^join|joining|patron|banner|swear|oath|why|who are you$":
	say "The Bride smiles, and does not trouble to hide the teeth. 'Straight talk, traveler, since everyone else here is ciphering. We are vampires. Real ones: the disease is rabies, the folklore was a warning, and our sovereign is Count Dracula - the Count to you, once you are family. Join the Court and you stop aging, stop fearing the dark, and start belonging to something that has outlived every empire that ever banned it. The recruitment terms are simple: one bite. The benefits are eternal. The Catch-22 is that you have to die a little first. Most of our best people did.'";
Instead of asking the Rabies Recruiter about something when the topic understood matches the regular expression "^secret|count|bride|hungry|dracula$":
	say "She glances toward the north, toward a castle you cannot see. 'A secret: there are three of us - Budapest, Bucharest, Belgrade - and we rotate this recruiting post because the Count insists his Brides see the world he keeps out of. He has watched empires rise and fall, and he still writes his own invitations. Why do you think the post is always manned by the beautiful ones? You would not cross the street for a recruiting poster. You stopped for me.'";
Instead of asking the Rabies Recruiter about something when the topic understood matches the regular expression "^light|water|bite$":
	say "She counts the Court's three fears on white fingers. 'Sunlight - it will kill me, not inconvenience me; the folklore undersold it. Running water - the old rivers still remember the old law. And the bite - which is not fear at all, traveler, but the front door. Everything else your species dreads is a variation with worse press.'";

Instead of asking the Stille Recruiter about something when the topic understood matches the regular expression "^join|joining|patron|banner|swear|oath|why|who are you$":
	say "The personnel officer stamps a folder without looking up. 'The perfect spy does not know she is a spy. The perfect impostor was never suspected. Join the Silence, and you will learn the one trade that never runs out of work: being someone else.'";
Instead of asking the Stille Recruiter about something when the topic understood matches the regular expression "^secret|stamp|wax|rhythm$":
	say "The stamp pauses, mid-fall. 'A secret: you have been counting my rhythm since you walked in. Most minds do. It is how we find the ones who notice patterns - the only ones we hire.'";
Instead of asking the Stille Recruiter about something when the topic understood matches the regular expression "^mary|doppelganger|yukio|alpsox$":
	say "'You know the MARY project,' she says, with the closest thing to warmth. 'Sixty-eight days wearing a Chief Medical Advisor, and the man who taught her template to spot fakes opened his own door. The disguise is never the weapon, traveler. The welcome is.'";

Instead of asking the Vibrio Recruiter about something when the topic understood matches the regular expression "^join|joining|patron|banner|swear|oath|why|who are you$":
	say "She pops her gum and throws you a lazy salute. 'Welcome aboard, traveler - or not. Your call.' She jerks a thumb at the tank. 'That is the Cholera Octopus's own molted shell - the armor she outgrew, kept the way your armies keep their colours. Cannons cold, because the new ones are not. The ship herself is four thousand meters down: fifty meters of metal-biological armor, eight tentacles, eight hydro-cannons, one mind, and she is the [italic type]polite[roman type] part of our fleet. Four thousand meters below the waves our fortress runs drill-factories and geothermal stations; your maps spell the place Atlantis. People hear that and think, that is a lot of ocean. They are wrong. It is exactly enough ocean.'";
Instead of asking the Vibrio Recruiter about something when the topic understood matches the regular expression "^secret|cannon|cphc|pressure|demonstration|show$":
	say "She looks at you for the flicker of a smile - and finds none. '...Okay. Wrong toy.' From under the skirt hem she unhooks what looks exactly like a child's water pistol - teacup tank, dolphin trigger guard, the works. 'Legion sidearm. One shot per fill. Stand behind me, and maybe cover your ears.' She aims down the length of the hall, past the Keeper's standards, and squeezes.
The jet shows itself as a whip of white steam - supercritical water leaving the barrel flash-boils the air it passes through - and the far wall, three rooms away, grows a hole: clean-edged, big enough to walk through, the stone around it glazed smooth where the spray lingered. The thunderclap arrives a beat later, then the rain - warm, from a ceiling three rooms' distance that has begun, decorously, to leak.
'Single shot,' she says, spinning the pistol once around her finger. 'The entry wound is coin-sized, if you know where to look - it opens up inside the wall. The flagship's cannons are this gun, nine sizes up. There is no counter except distance, and we carry the distance with us.' The smile comes back like a mask going back on. 'Gum?'";
Instead of asking the Vibrio Recruiter about something when the topic understood matches the regular expression "^chlorine|weakness|drain|counter$":
	say "She shrugs, still chewing. 'Honest? Heat cooks us, chlorine unmakes our hide, drain the water and the Legion is a museum exhibit. But look at the tank, traveler. Look at what it took for you to take us seriously - a girl, a whistle, and one shot of the real thing. The doctrine prints our weaknesses because by the time you reach them, you are already standing in our ocean.'";


Chapter - The Halls Greet You

[Each hall's master speaks first when the traveler arrives. No standing
around waiting for instructions - the powers of the war all want the same
witness, and they say so.]

After going to the Cradle Inner Court for the first time:
	say "The Generalizer rises before you have finished bowing. 'The traveler who could still choose. Word travels faster than blood.' She looks you over like a cadet who might be a weapon. 'You will attend the lecture. Not a request - the Cradle does not arm the ignorant, and it does not waste the curious.'";

After going to the Fabrica Bridge for the first time:
	say "Vesalius turns from the chart-table before the door has closed. 'So the fleet's letters were right - someone new is walking the war.' He measures you with one look. 'You will want to be useful, not ornamental. Leonardo keeps the truth reversed, Harvey keeps the numbers, Bethune keeps the blood moving. And I keep the errors - mine, and everyone else's. You will see which one you are.'";

After going to the Black Cathedral for the first time:
	if the Aegis gauntlets are not worn by the player:
		say "At the Cathedral's threshold the borrowed light comes due all at once - the vitrified road behind you glows with your own afterimage, and the door keeps. The Old Metals take their tax at the step, not in the hall.";
		end the story finally saying "The Old Metals took their tax. Lucifer buried you in glass, and made the glass a warning. To walk the west alive, earn the Aukin gauntlets: attend the lectures at the Cradle, then walk Sister Franklin's memory of the Wastes and tell her what you carried out - no market sells them.";
	say "You cross the vitrified threshold into the Black Cathedral; the mercury mirror fills the room, and your reflection in it is not the face you brought in.[paragraph break]Lucifer does not turn, but the mirror ripples at your approach. 'The traveler. How patient your kind has become - walking into my hall without a price named.' A bead of mercury runs down the crown and hangs, suspended. 'Everything in this room is for sale, including the exits. Ask me what things cost.'[line break]The gatekeeper-priest pronounces, unhurried: 'Alive, and armored, and arrived. The Old Metals receive few guests, and none twice.' Then, the offer - the only recruitment speech made inside a god's house: 'The Pantheon does not send recruiters into the mild world. It has no need of recruiters. Whoever stands here has already paid the toll the Wastes exact, and the gods respect a paid toll. If you mean to swear, swear here, at the door of the mirror: CHOOSE PANTHEON.'";

After going to the Shrine of the Knitting Mouse for the first time:
	say "HeLa's luminosity brightens as you enter - recognition, not surprise. 'You are the one they are all courting.' She says it without envy. 'Be careful with the courting, traveler. The ones who were never asked built this shrine, and the ones everyone asks forget to look at it. You will look. I can tell already.'";

After going to the Sulfur Vent Gallery for the first time:
	say "The Division Chief looks up from her probe and does not smile. 'The unclaimed one. Good. Unclaimed means uncaptured.' She snaps the probe shut. 'You will want the tour, the sales pitch, the flag. You will get work. The Division does not recruit, traveler - it certifies. Dig first. Decide after.'";

After going to the Abteilung Stille Office for the first time:
	say "The Amanuensis speaks without looking up, and the room adjusts to her voice. 'You stood in the doorway for two seconds too long. The others will not have noticed. I noticed.' She stamps a folder. 'Sit, or do not. But know that everyone who enters this office is filed - and the file is written by what you do next, not by what you intend.'";

After going to the Masquerade Ballroom for the first time:
	say "The Pale Masquer peels away from the pavane and crosses to you - the dance rearranges itself around her absence without missing a beat. 'The traveler. Beautiful timing - arriving exactly when every court wants you and none of them owns you.' She tilts the porcelain mask a degree. 'Do not decide too fast. The best guests always stay for the next dance.'";



After going to the Blood Court for the first time:
	say "The Count regards you the way weather regards a coastline. 'The unclaimed one walks into my hall without an invitation. Good. Invitations are for people who can refuse.' The Budapest Bride does not stop watching the stair. 'You have questions. Everyone does. Only one of them matters, and it is not the one you are about to ask.'";

After going to the Abyssal Deck for the first time:
	say "The Octopus Admiral meets you at the gangway instead of waiting - the Legion's idea of hospitality. 'Down here, we do not stand on ceremony; we stand on dry deck, while we have it.' She walks you toward the flood-gauges. 'The ocean sent you, in its way. The ocean sends everything. The question is what you do when the water rises - and it will rise, traveler. It always rises.'";


Instead of going west from the Singularity:
	say "You step off the newborn light and onto the road west.";
	now the player is in the Pilgrim Turn;
