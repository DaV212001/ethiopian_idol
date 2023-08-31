import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ethiopian_idol/components/categorymodel.dart';
import 'package:flutter/material.dart';
import 'package:ethiopian_idol/components/showcard.dart';
import 'package:flutter/services.dart';
import 'package:ethiopian_idol/main.dart';
import 'package:provider/provider.dart';
final List<Map<String, dynamic>> people = [
  {
    'name': 'Getachew Gerem',
    'image': 'https://img.youtube.com/vi/8QeWXl4_2Oc/maxresdefault.jpg',
    'video': '8QeWXl4_2Oc',
    'description':
    'Getachew Gerem is a multi-talented artist whose journey in the world of music started at a young age. Born and raised in Ethiopia, he was exposed to diverse musical influences that shaped his unique sound. Getachew is not only a remarkable singer but also a gifted songwriter and composer. His music often explores themes of love, identity, and societal issues. With a voice that resonates with emotion, he has captured the hearts of fans both locally and internationally.',
    'votes': 0
  },
  {
    'name': 'Aseged Gebeyew',
    'image': 'https://img.youtube.com/vi/YxSFhM1O71Y/maxresdefault.jpg',
    'video': 'aNH0V_THQK0',
    'description':
    'Aseged Gebeyew is a dynamic dancer and performer with an innate ability to captivate audiences through movement. From traditional Ethiopian dance to modern contemporary styles, he has mastered a wide range of techniques that he seamlessly blends in his performances. A true storyteller, Aseged uses his body as a canvas to convey emotions and narratives. His dedication to his craft and passion for pushing boundaries have earned him recognition on various stages and platforms.',
    'votes': 0
  },
  {
    'name': 'Melat Abraham',
    'image': 'https://img.youtube.com/vi/lRVnnqlwcCQ/maxresdefault.jpg',
    'video': 'erRYk7FH0-8',
    'description':
    'Melat Abraham is an aspiring singer-songwriter who has been making waves with her soulful voice and thought-provoking lyrics. Her music often delves into introspective themes and personal experiences, creating a connection with listeners. Melat’s journey in music began when she started performing at local venues, and she has since evolved into an artist who uses her platform to inspire others. With a blend of genres and a passion for storytelling, she is carving her own path in the industry.',
    'votes': 0
  },
  {
    'name': 'Nafyad Berhanu',
    'image': 'https://img.youtube.com/vi/0-t6k_k3M5w/maxresdefault.jpg',
    'video': '0-t6k_k3M5w',
    'description':
    'Nafyad Berhanu is a versatile performer known for his powerful vocals and stage presence. Hailing from Ethiopia, he has been honing his singing skills since a young age. Nafyad’s performances are a fusion of traditional Ethiopian melodies and modern musical elements. His charismatic energy and ability to connect with audiences make him a standout artist. Nafyad’s dedication to preserving cultural heritage while embracing contemporary trends sets him apart in the music scene.',
    'votes': 0
  },
  {
    'name': 'Beza Gashaw',
    'image': 'https://img.youtube.com/vi/IbLCh9Oiqw0/maxresdefault.jpg',
    'video': 'IbLCh9Oiqw0',
    'description':
    'Beza Gashaw is an accomplished musician with a flair for creativity. With a background in classical music and jazz, she brings a unique perspective to the music industry. Beza’s compositions often reflect her passion for experimenting with different genres and pushing artistic boundaries. Her virtuoso skills on various instruments have garnered her recognition from both peers and mentors. Beza is committed to breaking stereotypes and inspiring a new generation of musicians.',
    'votes': 0
  },
  {
    'name': 'Efphrem Getachew',
    'image': 'https://img.youtube.com/vi/8Z6YPBRuqkM/maxresdefault.jpg',
    'video': 'xTFHifXa_cQ',
    'description':
    'Efphrem Getachew is a rising star in the world of entertainment. His magnetic stage presence and versatile acting skills have earned him roles in both film and theater. Efphrem’s commitment to storytelling and character development is evident in every performance. With a passion for the arts, he aims to address important social issues through his work. Efphrem believes that art has the power to provoke thought, challenge norms, and bring about positive change.',
    'votes': 0
  },
  {
    'name': 'Genet Abeshu',
    'image': 'https://img.youtube.com/vi/HnDkeRlKr6Q/maxresdefault.jpg',
    'video': 'HnDkeRlKr6Q',
    'description':
    'Genet Abeshu is a creative force in the world of fashion. As a designer, she blends traditional Ethiopian aesthetics with contemporary trends, creating unique and captivating pieces. Genet’s work is a reflection of her pride in her heritage and her desire to share it with the world. With an eye for detail and a commitment to craftsmanship, she brings elegance and innovation to every design. Genet aspires to make a lasting impact on the fashion industry.',
    'votes': 0
  },
  {
    'name': 'Melkamu Arega',
    'image': 'https://img.youtube.com/vi/SxEPcNDCmKI/maxresdefault.jpg',
    'video': 'BD7BEURsN-k',
    'description':
    'Melkamu Arega is a gifted visual artist who uses his work to convey powerful messages. His paintings and illustrations often explore themes of identity, culture, and social justice. Melkamu’s distinctive style blends realism with abstract elements, resulting in thought-provoking and visually striking pieces. Through his art, he aims to spark conversations and challenge perceptions. Melkamu believes that art has the ability to inspire change and bridge gaps between communities.',
    'votes': 0
  },
  {
    'name': 'Estifanos Mamo',
    'image': 'https://img.youtube.com/vi/mcjdopGql_M/maxresdefault.jpg',
    'video': 'mcjdopGql_M',
    'description':
    'Estifanos Mamo is an emerging poet who uses words to create vivid and emotional landscapes. His poetry touches on a wide range of topics, from personal experiences to societal issues. Estifanos’ performances are characterized by his evocative delivery and ability to connect with his audience. Through his words, he aims to inspire introspection and empathy. Estifanos believes that poetry has the power to convey complex emotions and foster a deeper understanding of the human experience.',
    'votes': 0
  },
  {
    'name': 'Hana Melese',
    'image': 'https://img.youtube.com/vi/4votuI0fIts/maxresdefault.jpg',
    'video': '4votuI0fIts',
    'description':
    'Hana Melese is a dynamic dancer and choreographer known for her innovative routines and captivating stage presence. From contemporary dance to experimental movement, she pushes the boundaries of choreography. Hana’s performances often convey a sense of storytelling, with each movement conveying an emotion or narrative. As an advocate for dance education, she believes in the transformative power of movement and its ability to communicate across cultures and languages.',
    'votes': 0
  },
  {
    'name': 'Eyob Abera',
    'image': 'https://img.youtube.com/vi/-POQzuByUU4/maxresdefault.jpg',
    'video': '-POQzuByUU4',
    'description':
    'Eyob Abera is a skilled magician who mesmerizes audiences with his mind-bending tricks and illusions. From close-up magic to grand stage performances, he has mastered a wide range of techniques. Eyob’s performances are not only visually stunning but also thought-provoking, often challenging perceptions of reality. With a passion for mystery and a dedication to his craft, he continues to innovate and push the boundaries of magic.',
    'votes': 0
  },
  {
    'name': 'Dagnachew Fekadu',
    'image': 'https://img.youtube.com/vi/AKd5XKknlCA/maxresdefault.jpg',
    'video': 'azGpa6AH4aM',
    'description':
    'Dagnachew Fekadu is a charismatic stand-up comedian who uses humor to address social issues and everyday life. With a quick wit and relatable anecdotes, he has the ability to make audiences laugh while also sparking conversations. Dagnachew’s performances often touch on topics such as cultural differences, relationships, and the human experience. His unique perspective and energetic delivery make him a favorite among comedy enthusiasts.',
    'votes': 0
  },
  // ... Add descriptions for other contestants
];



String cate = "Singing";

class Voting extends StatefulWidget {
  const Voting({Key? key}) : super(key: key);

  static _VotingState? of(BuildContext context) =>
      context.findAncestorStateOfType<_VotingState>();

  @override
  State<Voting> createState() => _VotingState();
}

double walletBalance = 0;

class _VotingState extends State<Voting> {
  String? selectedCategory = "Music";

  Future<Map<String, int>> fetchVoteCounts() async {
    final voteCounts = <String, int>{};

    final votesSnapshot = await FirebaseFirestore.instance.collection('votes').get();

    for (final vote in votesSnapshot.docs) {
      final contestantName = vote.id;
      // Check if the voteCount field exists in the document
      if (vote.data().containsKey('voteCount')) {
        final voteCount = vote['voteCount'];
        voteCounts[contestantName] = voteCount;
      } else {
        // Set the vote count to 0 if the field does not exist
        voteCounts[contestantName] = 0;
      }
    }

    return voteCounts;
  }

  late Map<String, int> voteCounts;

  Future<void> _refreshData() async {
    await fetchVoteCounts().then((counts) {
      setState(() {
        voteCounts = counts;

        for (var person in people) {
          final name = person['name'];
          if (voteCounts.containsKey(name)) {
            person['votes'] = voteCounts[name];
          } else {
            person['votes'] = 0;
          }
        }
      });
    });
  }

  void refreshData() => _refreshData();

  @override
  void initState() {
    super.initState();
    fetchVoteCounts().then((counts) {
      setState(() {
        voteCounts = counts;

        for (var person in people) {
          final name = person['name'];
          if (voteCounts.containsKey(name)) {
            person['votes'] = voteCounts[name];
          } else {
            person['votes'] = 0;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: themeProvider.selectedTheme == 'dark' ? Color(0xFF121212) :Colors.yellow,
          statusBarIconBrightness:
          themeProvider.selectedTheme == "dark"
              ? Brightness.light
              : Brightness.dark,
        ),
        backgroundColor: themeProvider.selectedTheme == "dark"
            ? Color(0xFF121212)
            : Colors.yellow,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 36, left: 8, right: 8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    "Vote",
                    style: TextStyle(
                      color: themeProvider.selectedTheme == "dark"
                          ? Colors.white
                          : Colors.black,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: themeProvider.selectedTheme == "dark"
          ? Color(0xFF121212)
          : Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 5, right: 5, bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: themeProvider.selectedTheme == "dark"
                          ? Color(0xFFFFFD00)
                          : Colors.yellow,
                    ),
                    child: Icon(
                      Icons.candlestick_chart_rounded,
                      size: 40,
                      color: themeProvider.selectedTheme == "dark"
                          ? Colors.black
                          : Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: CategoryScrollable(themeProvider: themeProvider),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 3, right: 3, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _refreshData,
                      child: ListView.builder(
                        itemCount: (people.length / 2).ceil() + 1,
                        itemBuilder: (context, index) {
                          if (index == (people.length / 2).ceil()) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 10, top: 50),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "Powered by Micro Sun Technologies",
                                style: TextStyle(
                                  color: themeProvider.selectedTheme == "dark"
                                      ? Colors.yellow
                                      : Colors.black,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w200,
                                  fontSize: 15,
                                ),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 30),
                              child: Row(
                                children: [0, 1].map((i) => Expanded(
                                  child: ShowCard(
                                    height: 150,
                                    width: double.infinity,
                                    link: people[index * 2 + i]['image'] ??
                                        '',
                                    isVotecard: true,
                                    category: cate,
                                    name:
                                    people[index * 2 + i]['name'] ?? '',
                                    votes:
                                    people[index * 2 + i]['votes'] ?? 0,
                                    description: people[index * 2 + i]
                                    ['description'] ??
                                        '',
                                    video:  people[index * 2 + i]['video'] ?? ''
                                  ),
                                )).toList(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class CategoryScrollable extends StatelessWidget {
  const CategoryScrollable({
    Key? key,
    required this.themeProvider,
  }) : super(key: key);

  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    // Define a list of maps that contains the data for each category
    final categories = [
      {'icon': Icons.music_note, 'text': 'Singing'},
      {'icon': Icons.music_note, 'text': 'Dancing'},
      {'icon': Icons.theater_comedy, 'text': 'Comedy'},
      {'icon': Icons.star_border_purple500_rounded, 'text': 'Magic'},
      {'icon': Icons.theater_comedy, 'text': 'Acting'},
      {'icon': Icons.create, 'text': 'Poetry'},
      {'icon': Icons.multitrack_audio_sharp, 'text': 'Instruments'},
      {'icon': Icons.theater_comedy, 'text': 'Impersonation'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:
      Row(children:
      categories.map((category) =>
          InkWell(onTap:
              () {
            Provider.of<CategoryModel>(context,
                listen:
                false).selectCategory(category['text'] as String);
          }, child:
          Container(margin:
          EdgeInsets.all(5), decoration:
          BoxDecoration(borderRadius:
          BorderRadius.circular(4), color:
          themeProvider.selectedTheme == "dark" ? Color(0xFFFFFD00) : Colors.yellow), child:
          Row(children:[
            Icon(category['icon'] as IconData,
                size:
                30,
                color:
                themeProvider.selectedTheme == "dark" ? Colors.black : Colors.black),
            Text(category['text'] as String,
                style:
                TextStyle(color:
                themeProvider.selectedTheme == "dark" ? Colors.black : Colors.black,
                    fontFamily:'Poppins',
                    fontWeight:
                    FontWeight.w200)),
          ])))
      ).toList()
      ),
    );
  }
}