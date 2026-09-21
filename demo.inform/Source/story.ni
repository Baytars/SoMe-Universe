"SoMe" by Baytars

Chapter 1 - World

Singularity is a room. "[if visited]After the Big Bang, the sigularity no more exists.[otherwise]You are in Singularity. The universe is beginning to explode."

After looking in Singularity for the first time:
	say "You can choose to ";
	place a link to command "go south";
	say " to Hall of Medicine or ";
	place a link to command "go north";
	say " to Disease Citadel".

Instead of going to Singularity,
	say "After the Big Bang, the sigularity no more exists.".

Hall of Medicine is south of Singularity. The description is "In the Hall of Medicine shrines many deceased historical medical characters."

After looking in Hall of Medicine for the first time:
	show a modal window;
	set output focus to the modal window;
	say "[bold type]Aristotle[roman type]: Hey! Dude! Over here! Welcome to Hall of Medicine! First you need to choose your mentor. Who would you like to choose?";
	place a link to command "go south";
	say " to Hall of Medicine or ";
	place a link to command "go north";
	say " to Disease Citadel";
	place the image "Aristotle.jpeg" with the description "Aristotle", centered;
	set output focus to the main window.

Disease Citadel is north of Singularity. "Disease Citadel is where diseases are born.[paragraph break]Here you can see many patients being tortured by the diseases."

Typhoid Mary is a woman in Disease Citadel.

Instead of asking Typhoid Mary about "mentorship" for the first time:
	show a modal window;
	set output focus to the modal window;
	say "[bold type]Typhoid Mary[roman type]: How would you prove that you are qualified for my mentorship?";
	place the image "angel.png" with the description "Typhoid Mary", centered.

After looking in Disease Citadel for the first time:
	show a modal window;
	set output focus to the modal window;
	say "[bold type]Lucifer[roman type]: Welcome to Disease Citadel! First you need to choose your mentor. Who would you like to choose?";
	place a link to command "ask Typhoid Mary about mentorship";
	place the image "Lucifer.jpeg" with the description "Lucifer", centered.

Lime Street is south of Thames Street End. West of Thames Street End is north of Fisher's Row. The description of Fisher's Row is "A waterfront street that runs south towards Chocolata Hole, where the small craft are harboured. It also continues north around the tip of the peninsula from here, turning into the east-west Thames Street."

Thames Street End is down from Hall of Fame. Up from Thames Street End is nowhere.

Water Lane is east of Thames Street End. "Here Thames Street -- never very straight -- goes steeply southeast for a portion before continuing more directly to the east.

Water Lane runs south toward Queen Street, and facing onto it is the New Prison -- which, in the way of these things, is neither.  It did serve in that capacity for a time, and in a measure of the villainy which has been usual in Port Royal from its earliest days, it is nearly the largest building in the town."


East of Water Lane is a room called Thames Street at the Wherry Bridge.  Thames Street at the Wherry Bridge has the description "To the southwest is the fishmarket; directly across the street is the entrance to a private alley through a brick archway."

The Fishmarket is southwest of Thames Street at the Wherry Bridge.

The Private Alley is south of Thames Street at the Wherry Bridge. "You're just outside the tavern the Feathers. To the north, under a pretty little archway, is the active mayhem of Thames Street, but the alley narrows down to a dead end a little distance to the south."

The Feathers is inside from the Private Alley.  "Newly built with brick, replacing the older Feathers tavern that used to stand here. It sells wines in quantity, as well as serving them directly, and the goods are always of the best quality. There's a room upstairs for those wanting to stay the night." The Feathers Bedroom is above the Feathers.

Thames Street by the King's House is east of Thames Street at the Wherry Bridge.  "The King's House is reserved for the use of the Governor, but he does not live in it, and it is frequently being rented out to some merchant so that the government will at least derive some value from it. It is nearly the least interesting establishment on Thames Street, and the crowd -- which, to the west, is extremely dense -- here thins out a bit."

Thames Street before Fort Carlisle is east of Thames Street by the King's House. "Here Thames Street, formerly a respectable width, narrows to a footpath in order to edge around the front of Fort Carlisle, underneath the mouths of the cannon.

There are no buildings on the harbour side of Thames Street at this point, which means that you have an unusually good view of the ships at dock, water beyond, and the Blue Mountains rising on the other side of the harbour."


South of Thames Street before Fort Carlisle is a room called Fort Carlisle. The description of Fort Carlisle is "Handsomely arrayed with cannons which you could fire at any moment -- though of course there are ships at dock which might be in the way."

Queen Street End is south of Lime Street.

Queen Street Middle is east of Queen Street End.


Queen Street East is east of Queen Street Middle and south of Private Alley.

Queen Street at the Prison is east of Queen Street East.
	
Inland is a region. Queen Street End, Queen Street Middle, Queen Street East, Private Alley, Lime Street, and Queen Street at the Prison are in Inland.

Waterfront is a region. Thames Street before Fort Carlisle, Thames Street by the King's House, Thames Street at the Wherry Bridge, Water Lane, Fishmarket, Fisher's Row, and Disease Citadel are in Waterfront.
	
Military Holdings is a region. Fort Carlisle and Hall of Medicine are in Military Holdings.
	
Tavern is a region. It is in Inland. Feathers and Feathers Bedroom are in Tavern.


Chapter 2 - Background music

Include Vorple Multimedia by Juhana Leinonen.
Include Vorple Modal Windows by Juhana Leinonen.
Include Vorple Hyperlinks by Juhana Leinonen.
Include Vorple Status Line by Juhana Leinonen.
Release along with the "Vorple" interpreter.

A region has some text called the background audio.
The current region is a region that varies.

A mood is a kind of value. Moods are crying, sad, neutral, smiling and happy.
A person has a mood. The mood of a person is usually neutral.

The background audio of Inland is "https://vorple-if.com/resources/audio/inland.mp3".
The background audio of Waterfront is "Beyond the Obsidian Sands-Black Ice 9.mp3".
The background audio of Military Holdings is "age.mp3".
The background audio of Tavern is "https://vorple-if.com/resources/audio/tavern.mp3".

Every turn when the map region of the location is not nothing and the map region of the location is not the current region and the background audio of the map region of the location is not "" (this is the play background audio rule):
	play music file background audio of the map region of the location, looping;
	now the current region is the map region of the location.
	
[Every turn rules aren't run on the first turn so we'll run it manually.]
When play begins (this is the start initial background audio rule):
	construct a Vorple status line with 3 columns;
	if the map region of the location is not nothing and the background audio of the map region of the location is not "":
		follow the play background audio rule.	  

Rule for constructing the Vorple status line:
	clear the Vorple status line;
	set the output focus to the element called "status-line-left";
	place an image "https://vorple-if.com/resources/images/Face-[mood of the player].png" with the description "[mood of the player]";
	set the output focus to the element called "status-line-right";
	say "[the player's surroundings]";
	set the output focus to the element called "status-line-mobile";
	place an image "https://vorple-if.com/resources/images/Face-[mood of the player].png" with the description "[mood of the player]";
	set the output focus to the main window;
	rule succeeds.

Test me with "s / s / n / e / e / s / in".

Release along with the file "Figures/angel.png".
Release along with the file "Figures/girl.jpg".
Release along with the file "Figures/Aristotle.jpeg".
Release along with the file "Figures/Lucifer.jpeg".
Release along with the file "BGM/age.mp3".
Release along with the file "BGM/Beyond the Obsidian Sands-Black Ice 9.mp3".
