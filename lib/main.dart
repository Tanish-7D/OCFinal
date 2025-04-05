import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(StoryGameApp());

class StoryGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Environmental Adventure',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[800],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
          ),
        ),
      ),
      home: StoryPage(),
    );
  }
}

class StoryPage extends StatefulWidget {
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  String story = "Welcome to your environmental adventure!";
  String imageUrl = '';
  bool loading = false;
  List<String> choices = ["Start your adventure"];
  String storyState = 'start';
  String path = '';
  final Random random = Random();

  final List<String> natureImages = [
    'https://images.unsplash.com/photo-1506765515384-028b60a970df',
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
    'https://images.unsplash.com/photo-1493244040629-496f6d136cc3',
    'https://images.unsplash.com/photo-1465146633011-14f5a4c7a5b2',
    'https://images.unsplash.com/photo-1441829266145-b7a2d2c5f3f1',
    'https://images.unsplash.com/photo-1508780709619-79562169bc64',
    'https://images.unsplash.com/photo-1470770903676-69b98201ea1c',
    'https://images.unsplash.com/photo-1501004318641-b39e6451bec6',
  ];

  void resetGame() {
    setState(() {
      story = "Welcome to your environmental adventure!";
      storyState = 'start';
      choices = ["Start your adventure"];
      imageUrl = '';
      path = '';
    });
  }

  void setRandomNatureImage() {
    int index = random.nextInt(natureImages.length);
    imageUrl =
        '${natureImages[index]}?auto=format&fit=crop&w=${MediaQuery.of(context).size.width.toInt()}&q=80';
  }

  void continueStory(String choice) {
    setState(() {
      loading = true;
    });

    Future.delayed(Duration(milliseconds: 300), () {
      String nextStory = "";
      List<String> nextChoices = [];
      String nextState = storyState;

      if (storyState == 'start') {
        if (choice == "Start your adventure") {
          nextStory = '''
The local river is facing a severe pollution crisis. Fish are dying, and the water is unsafe. What will you do?
''';
          nextChoices = [
            "Option A: Work with local officials and environmental agencies.",
            "Option B: Investigate the source of the pollution independently.",
            "Option C: Organize a community cleanup and awareness campaign.",
          ];
          nextState = 'Choose Path';
          setRandomNatureImage();
        }
      } else if (storyState == 'Choose Path') {
        if (choice ==
            "Option A: Work with local officials and environmental agencies.") {
          path = 'officials';
          nextStory = '''
You meet with the mayor and EPA representatives. They are concerned but need solid evidence.
What's your first step to help them?
''';
          nextChoices = [
            "Offer to help fund a scientific investigation.",
            "Share any initial observations you've made.",
            "Suggest a town hall meeting to gather community information.",
          ];
          nextState = 'Officials Path Start';
          setRandomNatureImage();
        } else if (choice ==
            "Option B: Investigate the source of the pollution independently.") {
          path = 'independent';
          nextStory = '''
You decide to investigate on your own. You'll need to gather clues and evidence.
Where do you begin your search?
''';
          nextChoices = [
            "Follow the river upstream to look for discharge pipes.",
            "Interview residents living near the river.",
            "Check public records of local industries.",
          ];
          nextState = 'Independent Path Start';
          setRandomNatureImage();
        } else if (choice ==
            "Option C: Organize a community cleanup and awareness campaign.") {
          path = 'community';
          nextStory = '''
You rally the community to take action. You need to organize both a cleanup and raise awareness.
What do you focus on first?
''';
          nextChoices = [
            "Organize a volunteer meeting to plan the cleanup.",
            "Create flyers and social media posts to spread awareness.",
            "Seek donations for cleanup supplies.",
          ];
          nextState = 'Community Path Start';
          setRandomNatureImage();
        }
      }
      // Officials Path
      else if (storyState == 'Officials Path Start') {
        if (choice == "Offer to help fund a scientific investigation.") {
          nextStory = '''
Your offer is greatly appreciated. The investigation confirms that the "ChemCorp" plant upstream is the likely source of the pollution due to improper waste disposal.
What action do you push for?
''';
          nextChoices = [
            "Demand immediate shutdown and hefty fines for ChemCorp.",
            "Negotiate with ChemCorp for a rapid cleanup and improved practices.",
            "Advocate for stricter environmental regulations for all industries.",
          ];
          nextState = 'Officials Path Investigate';
          setRandomNatureImage();
        } else if (choice == "Share any initial observations you've made.") {
          nextStory = '''
You share your observations of dead fish and unusual smells near the ChemCorp plant. This helps focus the official investigation. The findings confirm ChemCorp's responsibility.
What's your priority now?
''';
          nextChoices = [
            "Ensure ChemCorp compensates the affected community.",
            "Work with officials to implement long-term river monitoring.",
            "Publicly commend the officials for their swift investigation.",
          ];
          nextState = 'Officials Path Observe';
          setRandomNatureImage();
        } else if (choice ==
            "Suggest a town hall meeting to gather community information.") {
          nextStory = '''
The town hall reveals numerous accounts of unusual discharges from the ChemCorp plant, strengthening the case for investigation. The official report confirms ChemCorp as the polluter.
What do you propose next?
''';
          nextChoices = [
            "Organize a follow-up meeting to discuss solutions.",
            "Demand transparency from ChemCorp regarding their practices.",
            "Support local businesses affected by the pollution.",
          ];
          nextState = 'Officials Path TownHall';
          setRandomNatureImage();
        }
      } else if (storyState == 'Officials Path Investigate') {
        if (choice ==
            "Demand immediate shutdown and hefty fines for ChemCorp.") {
          nextStory = '''
Your strong stance leads to a temporary shutdown and significant fines. However, ChemCorp threatens to relocate, causing job losses.
Outcome: Mixed. The pollution source is addressed, but there are economic consequences.
''';
          nextChoices = ["Start again"];
          nextState = 'end_bad';
          setRandomNatureImage();
        } else if (choice ==
            "Negotiate with ChemCorp for a rapid cleanup and improved practices.") {
          nextStory = '''
You successfully negotiate a comprehensive cleanup plan, and ChemCorp agrees to invest in better waste management. The river slowly recovers, and jobs are preserved.
Outcome: Good. The pollution is addressed sustainably with cooperation.
''';
          nextChoices = ["Start again"];
          nextState = 'end_good';
          setRandomNatureImage();
        } else if (choice ==
            "Advocate for stricter environmental regulations for all industries.") {
          nextStory = '''
Your advocacy leads to new, stricter regulations that will prevent future pollution incidents across the region. ChemCorp complies, albeit reluctantly.
Outcome: Great. Systemic change is achieved, protecting the environment long-term.
''';
          nextChoices = ["Start again"];
          nextState = 'end_great';
          setRandomNatureImage();
        }
      } else if (storyState == 'Officials Path Observe') {
        if (choice == "Ensure ChemCorp compensates the affected community.") {
          nextStory = '''
You work to ensure ChemCorp provides fair compensation to residents and businesses impacted by the pollution, helping them recover.
Outcome: Good. The community receives necessary support.
''';
          nextChoices = ["Start again"];
          nextState = 'end_good';
          setRandomNatureImage();
        } else if (choice ==
            "Work with officials to implement long-term river monitoring.") {
          nextStory = '''
You collaborate on a robust long-term monitoring program to ensure the river's health and detect any future issues early.
Outcome: Great. Preventative measures are put in place.
''';
          nextChoices = ["Start again"];
          nextState = 'end_great';
        } else if (choice ==
            "Publicly commend the officials for their swift investigation.") {
          nextStory = '''
Your public support boosts the officials' commitment to environmental protection, encouraging further positive actions.
Outcome: Good. Positive reinforcement strengthens official resolve.
''';
          nextChoices = ["Start again"];
          nextState = 'end_good';
        }
      } else if (storyState == 'Officials Path TownHall') {
        if (choice == "Organize a follow-up meeting to discuss solutions.") {
          nextStory = '''
The follow-up meeting generates several community-led solutions for river conservation and pollution prevention, fostering local ownership.
Outcome: Good. Community engagement leads to sustainable solutions.
''';
          nextChoices = ["Start again"];
          nextState = 'end_good';
        } else if (choice ==
            "Demand transparency from ChemCorp regarding their practices.") {
          nextStory = '''
Your demands for transparency lead to ChemCorp publishing detailed reports and opening their facilities for public tours, increasing accountability.
Outcome: Good. Increased transparency builds trust and encourages better practices.
''';
          nextChoices = ["Start again"];
          nextState = 'end_good';
        } else if (choice ==
            "Support local businesses affected by the pollution.") {
          nextStory = '''
You initiate a campaign to support local businesses that suffered losses due to the river pollution, aiding their recovery.
Outcome: Good. Economic recovery for the affected community is supported.
''';
          nextChoices = ["Start again"];
          nextState = 'end_good';
        }
      }
      // Independent Path
      else if (storyState == 'Independent Path Start') {
        if (choice ==
            "Follow the river upstream to look for discharge pipes.") {
          nextStory = '''
You discover a hidden discharge pipe from the ChemCorp plant, secretly releasing pollutants into the river. You take photos and videos as evidence.
What do you do with this crucial information?
''';
          nextChoices = [
            "Anonymously leak the evidence to the local news.",
            "Present your findings directly to the environmental protection agency.",
            "Confront the ChemCorp management with your evidence.",
          ];
          nextState = 'Independent Path Evidence';
          setRandomNatureImage();
        } else if (choice == "Interview residents living near the river.") {
          nextStory = '''
Residents share stories of unusual smells and discolored water, often coinciding with nighttime activity at the ChemCorp plant.
How do you use this anecdotal evidence?
''';
          nextChoices = [
            "Encourage residents to file formal complaints with the authorities.",
            "Look for patterns in their stories to pinpoint potential pollution events.",
            "Try to find physical evidence to corroborate their accounts.",
          ];
          nextState = 'Independent Path Residents';
          setRandomNatureImage();
        } else if (choice == "Check public records of local industries.") {
          nextStory = '''
You find records of past environmental violations by ChemCorp, though none recent enough to explain the current crisis. However, you note inconsistencies in their reported waste disposal methods.
What do you investigate further?
''';
          nextChoices = [
            "Try to obtain more recent, non-public records from inside sources.",
            "Compare ChemCorp's records with those of similar industries.",
            "Focus your physical investigation on ChemCorp's facilities.",
          ];
          nextState = 'Independent Path Records';
          setRandomNatureImage();
        }
      } else if (storyState == 'Independent Path Evidence') {
        if (choice == "Anonymously leak the evidence to the local news.") {
          nextStory = '''
The news report creates a public outcry, forcing the authorities to launch a full-scale investigation into ChemCorp.
Outcome: Good. Public pressure leads to official action.
''';
          nextChoices = ["Start again"];
          nextState = 'end_good';
          setRandomNatureImage();
        } else if (choice ==
            "Present your findings directly to the environmental protection agency.") {
          nextStory = '''
Your evidence is compelling, and the EPA immediately launches an investigation, confirming ChemCorp's illegal dumping.
Outcome: Great. Direct action leads to swift official intervention.
''';
          nextChoices = ["Start again"];
          nextState = 'end_great';
        } else if (choice ==
            "Confront the ChemCorp management with your evidence.") {
          nextStory = '''
ChemCorp management denies the allegations and attempts to discredit your evidence. They might even try to silence you.
Outcome: Bad. Direct confrontation without official backing can be risky.
''';
          nextChoices = ["Start again"];
          nextState = 'end_bad';
          setRandomNatureImage();
        }
      } else if (storyState == 'Independent Path Residents') {
        if (choice ==
            "Encourage residents to file formal complaints with the authorities.") {
          nextStory = '''
The collective complaints from residents trigger an official investigation, which eventually uncovers ChemCorp's illegal activities.
Outcome: Good. Community voices lead to justice.
''';
          nextChoices = ["Start again"];
          nextState = 'end_good';
        } else if (choice ==
            "Look for patterns in their stories to pinpoint potential pollution events.") {
          nextStory = '''
By analyzing the residents' accounts, you identify a pattern of pollution spikes after nighttime operations at ChemCorp, giving authorities a specific timeframe to investigate.
Outcome: Good. Your analysis helps focus the investigation.
''';
          nextChoices = ["Start again"];
          nextState = 'end_good';
        } else if (choice ==
            "Try to find physical evidence to corroborate their accounts.") {
          nextStory = '''
Based on the residents' information, you search specific areas along the river and find traces of the pollutants matching ChemCorp's waste.
Outcome: Great. Corroborating evidence strengthens the case against ChemCorp.
''';
          nextChoices = ["Start again"];
          nextState = 'end_great';
        }
      } else if (storyState == 'Independent Path Records') {
        if (choice ==
            "Try to obtain more recent, non-public records from inside sources.") {
          nextStory = '''
You manage to connect with a concerned employee at ChemCorp who provides you with damning internal documents detailing their illegal waste disposal practices.
Outcome: Great. Insider information exposes the truth.
''';
          nextChoices = ["Start again"];
          nextState = 'end_great';
        } else if (choice ==
            "Compare ChemCorp's records with those of similar industries.") {
          nextStory = '''
Your comparison reveals significant discrepancies in ChemCorp's reported waste volumes, raising red flags and prompting further scrutiny from authorities.
Outcome: Good. Your research triggers official suspicion.
''';
          nextChoices = ["Start again"];
          nextState = 'end_good';
        } else if (choice ==
            "Focus your physical investigation on ChemCorp's facilities.") {
          nextStory = '''
By carefully observing ChemCorp's plant, you witness suspicious nighttime discharges into a hidden pipe leading to the river.
Outcome: Good. Direct observation provides crucial evidence.
''';
          nextChoices = ["Start again"];
          nextState = 'end_good';
        }
      }
      // Community Path
      else if (storyState == 'Community Path Start') {
        if (choice == "Organize a volunteer meeting to plan the cleanup.") {
          nextStory = '''
The volunteer meeting is a success! Many enthusiastic residents sign up, and you create teams for different tasks.
What's your next organizational step?
''';
          nextChoices = [
            "Assign specific cleanup zones along the river.",
            "Organize a training session on safe waste handling.",
            "Coordinate with local businesses for supplies and support.",
          ];
          nextState = 'Community Path CleanupPlan';
          setRandomNatureImage();
        } else if (choice ==
            "Create flyers and social media posts to spread awareness.") {
          nextStory = '''
Your awareness campaign goes viral! Many people are sharing your posts, and local media is showing interest.
How do you capitalize on this momentum?
''';
          nextChoices = [
            "Organize a large-scale rally to demand action from officials.",
            "Partner with influencers to reach a wider audience.",
            "Create a series of educational videos about river pollution.",
          ];
          nextState = 'Community Path Awareness';
          setRandomNatureImage();
        } else if (choice == "Seek donations for cleanup supplies.") {
          nextStory = '''
You reach out to local businesses and residents for donations. Support is strong, and you secure enough funds for the cleanup.
What do you do with the collected funds?
''';
          nextChoices = [
            "Purchase high-quality safety gear and cleanup equipment.",
            "Set aside a portion for long-term river monitoring tools.",
            "Organize a community event to thank donors and volunteers.",
          ];
          nextState = 'Community Path Donations';
          setRandomNatureImage();
        }
      } else if (storyState == 'Community Path CleanupPlan') {
        if (choice == "Assign specific cleanup zones along the river.") {
          nextStory =
              "Assigning zones ensures a thorough cleanup. Volunteers work efficiently, and the riverbanks become noticeably cleaner.";
          nextChoices = ["Start again"];
          nextState = 'end_good';
          setRandomNatureImage();
        } else if (choice ==
            "Organize a training session on safe waste handling.") {
          nextStory =
              "The training session ensures everyone's safety. The cleanup is effective, and volunteers are well-prepared to handle hazardous materials.";
          nextChoices = ["Start again"];
          nextState = 'end_great';
          setRandomNatureImage();
        } else if (choice ==
            "Coordinate with local businesses for supplies and support.") {
          nextStory =
              "Local businesses provide generous support, donating supplies and offering logistical help. The cleanup is a resounding success, demonstrating community collaboration.";
          nextChoices = ["Start again"];
          nextState = 'end_great';
          setRandomNatureImage();
        }
      } else if (storyState == 'Community Path Awareness') {
        if (choice ==
            "Organize a large-scale rally to demand action from officials.") {
          nextStory =
              "The rally draws a massive crowd, attracting significant media attention. Officials are compelled to take the pollution crisis seriously and launch a full investigation.";
          nextChoices = ["Start again"];
          nextState = 'end_great';
          setRandomNatureImage();
        } else if (choice ==
            "Partner with influencers to reach a wider audience.") {
          nextStory =
              "Partnering with influencers dramatically expands the campaign's reach. More people become aware of the issue, and public pressure mounts on the polluting company.";
          nextChoices = ["Start again"];
          nextState = 'end_good';
          setRandomNatureImage();
        } else if (choice ==
            "Create a series of educational videos about river pollution.") {
          nextStory =
              "The educational videos become a valuable resource, informing the community about the causes and consequences of pollution. This leads to long-term behavior change and greater environmental responsibility.";
          nextChoices = ["Start again"];
          nextState = 'end_good';
          setRandomNatureImage();
        }
      } else if (storyState == 'Community Path Donations') {
        if (choice ==
            "Purchase high-quality safety gear and cleanup equipment.") {
          nextStory =
              "Investing in quality gear ensures the volunteers' safety and the effectiveness of the cleanup. The river is cleaned thoroughly, and the community is proud of its efforts.";
          nextChoices = ["Start again"];
          nextState = 'end_great';
          setRandomNatureImage();
        } else if (choice ==
            "Set aside a portion for long-term river monitoring tools.") {
          nextStory =
              "Setting up long-term monitoring ensures the river's health is protected for the future. The community becomes a vigilant steward of its environment.";
          nextChoices = ["Start again"];
          nextState = 'end_great';
          setRandomNatureImage();
        } else if (choice ==
            "Organize a community event to thank donors and volunteers.") {
          nextStory =
              "The appreciation event strengthens community bonds and inspires continued environmental action. The cleanup's success becomes a source of collective pride.";
          nextChoices = ["Start again"];
          nextState = 'end_good';
          setRandomNatureImage();
        }
      }

      setState(() {
        story = nextStory;
        choices = nextChoices;
        storyState = nextState;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Environmental Adventure")),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                if (imageUrl.isNotEmpty)
                  Positioned.fill(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fitHeight,
                      errorBuilder: (context, error, stackTrace) {
                        print('Error loading image: $error');
                        return Container(
                          color: Colors.grey[400],
                          child: Center(
                              child: Text('Failed to load image',
                                  style: TextStyle(color: Colors.white))),
                        );
                      },
                    ),
                  ),
                Container(
                  color: Colors.black.withOpacity(0.3),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: loading
                      ? Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 12),
                              Text(
                                'Phase: $storyState',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 12),
                              Text(story,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                              SizedBox(height: 24),
                              ...choices.map((choice) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (choice == "Start again") {
                                        resetGame();
                                      } else {
                                        continueStory(choice);
                                      }
                                    },
                                    child: Text(choice),
                                  ),
                                );
                              }).toList()
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
