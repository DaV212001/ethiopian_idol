import 'dart:math';
import 'package:ethiopian_idol/components/footer.dart';
import 'package:ethiopian_idol/networking/youtube_fetcher.dart';
import 'package:ethiopian_idol/screens/categorieslistview.dart';
import 'package:ethiopian_idol/screens/contestantdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart' show Hero;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ethiopian_idol/main.dart';
import 'package:provider/provider.dart';
import 'package:ethiopian_idol/screens/judgedetails.dart';
import 'package:ethiopian_idol/screens/votingspecific.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<PlaylistItem>? videosList;

  @override
  void initState() {
    super.initState();
    fetchVideos().then((videos) {
      setState(() {
        videosList = videos;
        print('THE VIDEOS LIST CURRENTLY HAS ${videosList?.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final List<Map<String, dynamic>> categories = [
      {'name': 'Singing', 'icon': Icons.person, 'num': 220},
      {'name': 'Dancing', 'icon': Icons.person, 'num': 204},
      {'name': 'Comedy', 'icon': Icons.person, 'num': 356},
      {'name': 'Magic', 'icon': Icons.person, 'num': 98},
      {'name': 'Acting', 'icon': Icons.person, 'num': 178},
      {'name': 'Poetry reading', 'icon': Icons.person, 'num': 460},
      {'name': 'Instruments', 'icon': Icons.person, 'num': 560},
      {'name': 'Impersonation', 'icon': Icons.person, 'num': 280},
      {'name': 'Juggling', 'icon': Icons.person, 'num': 290},
      {'name': 'Acrobatics', 'icon': Icons.person, 'num': 134},
      {'name': 'Painting', 'icon': Icons.person, 'num': 117},
      {'name': 'Fashion show', 'icon': Icons.person, 'num': 194},
    ];

    final judgesList = [
      Judge(
        name: 'Sertse Feresehbhat',
        imageUrl:
            'https://th.bing.com/th/id/R.6f9471dbe4756649719dad6a9daf1a18?rik=EuUvQRLfQi8tpQ&pid=ImgRaw&r=0',
        bio:
            'Sertse Feresebehat is a 36-year old musician who was appointed as Deputy CEO of the Ethiopian Tourism Organization (ETO) by the Prime Minister on June 14, 20181. He replaced Yechale Mihret (PhD) and will also be serving as the Acting CEO of the Tourism Organization until a new head is assigned1. Sertse was born in Debrelibanos, a monastery just north of Addis Abeba, and obtained his bachelor’s degree in Musical Art from Addis Abeba University’s Yared School of Music1. He has previously served as the Vice President of the Ethiopian Musicians Association and was a judge in the television show, Ethiopian Idol1. He is also one of the founding members of the ‘Retrieve Ethio Big Band’ with Feleke Hailu, another notable musician. There are also some interviews with him on YouTube, such as an interview with Dejaf TV2 and a video by Bisrat News',
      ),
      Judge(
        name: 'Nebeyu Baye',
        imageUrl:
            'https://th.bing.com/th/id/R.70259318d0d485226d7c5c5ce57b7771?rik=zKucwi97gTZxwg&pid=ImgRaw&r=0',
        bio:
            'Nebiyu Baye is an Assistant Professor and a poet. He has given a message at a book graduation and recited poetry. He has also recited a poem called “Addis Alem” at the “Wisdom to Live” forum in Addis Ababa on February 2, 2010',
      ),
      Judge(
        name: 'Serawit Fekre',
        imageUrl: 'https://yageru.com/images/artists/a309.jpg',
        bio:
            'Serawit Fikre is an Ethiopian film actor and director. He was born in the capital city Addis Ababa in 1970 and started his education at Kebena primary and secondary school12. He has directed many films such as “Semayawiw Feres” and “Hiroshima”. He is best known for his soap advertisement with Mulalem Tadese.',
      ),
      Judge(
        name: 'Zinash Olani',
        imageUrl: 'https://i.postimg.cc/LXPcD74T/Screenshot-123.png',
        bio: 'Zinash Olani is an Ethiopian Idol judge',
      ),
    ];

    return Scaffold(
      backgroundColor: themeProvider.selectedTheme == 'dark'
          ? Color(0xFF121212)
          : Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: themeProvider.selectedTheme == 'dark'
                ? Color(0xFF121212)
                : Colors.yellow,
            statusBarIconBrightness: themeProvider.selectedTheme == 'dark'
                ? Brightness.light
                : Brightness.dark),
        backgroundColor: themeProvider.selectedTheme == 'dark'
            ? Color(0xFF121212)
            : Colors.yellow,
        elevation: 0,
        flexibleSpace: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                    backgroundColor: themeProvider.selectedTheme == 'dark'
                        ? Color(0xFF121212)
                        : Colors.black,
                    radius: 15,
                    child: Image.asset('images/logouse.png')),
                Text(
                  'Ethiopian Idol',
                  style: TextStyle(
                      color: themeProvider.selectedTheme == 'dark'
                          ? Color(0xFFFFFD00)
                          : Colors.grey.shade800,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 15,
                  child: Image.asset('images/ebc.png'),
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.only(top: 20.0, left: 30, right: 30),
              child: Text('Popular',
                  style: TextStyle(
                      color: themeProvider.selectedTheme == 'dark'
                          ? Color(0xFFFFFD00)
                          : Colors.grey.shade800,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 25))),
          SizedBox(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.only(bottom: 30),
              alignment: Alignment.center,
              height: 350,
              child: CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 350,
                    disableCenter: true,
                    viewportFraction: 0.6,
                    enlargeCenterPage: true,
                    autoPlay: true,
                  ),
                  itemBuilder:
                      (BuildContext context, int index, pageViewIndex) {
                    if (videosList == null) {
                      return Shimmer.fromColors(
                        baseColor: Color(0xFFFFFD00),
                        highlightColor: Colors.blue[300]!,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.white,
                        ),
                      );
                    }
                    return Container(
                      padding: EdgeInsets.zero,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContestantDetailsPage(
                                  video: videosList![index]),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                              videosList?[index]
                                      .snippet
                                      ?.thumbnails
                                      ?.high
                                      ?.url ??
                                  'default_image_url',
                              fit: BoxFit.cover, errorBuilder:
                                  (BuildContext context, Object exception,
                                      StackTrace? stackTrace) {
                            return Shimmer.fromColors(
                              baseColor: Color(0xFFFFFD00),
                              highlightColor: Colors.blue[300]!,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.white,
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  },
                  itemCount: videosList?.length ?? 0)),
          Divider(
            indent: 80,
            endIndent: 80,
            thickness: 1,
            color: themeProvider.selectedTheme == 'dark'
                ? Color(0xFFFFFD00)
                : Colors.blue,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
                padding: EdgeInsets.all(30),
                child: Text('Categories',
                    style: TextStyle(
                        color: themeProvider.selectedTheme == 'dark'
                            ? Color(0xFFFFFD00)
                            : Colors.grey.shade800,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 25))),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CategoriesList();
                }));
              },
              child: Container(
                height: 40,
                width: 90,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2.5)),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Center(
                    child: Text(
                  'View All',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            )
          ]),
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 30),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var category in categories)
                  _buildCategoryCard(
                      category['name'], category['icon'], category['num']),
              ],
            ),
          ),
          Divider(
            indent: 80,
            endIndent: 80,
            color: themeProvider.selectedTheme == 'dark'
                ? Color(0xFFFFFD00)
                : Colors.blue,
            thickness: 1,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
                padding: EdgeInsets.all(30),
                child: Text('Most Voted',
                    style: TextStyle(
                        color: themeProvider.selectedTheme == 'dark'
                            ? Color(0xFFFFFD00)
                            : Colors.grey.shade800,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 25))),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Votingspecific(name: 'Most Voted');
                }));
              },
              child: Container(
                height: 40,
                width: 90,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2.5)),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Center(
                    child: Text(
                  'View All',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            )
          ]),
          Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: InfiniteScroll(videosList: videosList)),
          Divider(
            indent: 80,
            endIndent: 80,
            color: themeProvider.selectedTheme == 'dark'
                ? Color(0xFFFFFD00)
                : Colors.blue,
            thickness: 1,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
                padding: EdgeInsets.all(30),
                child: Text('Funny',
                    style: TextStyle(
                        color: themeProvider.selectedTheme == 'dark'
                            ? Color(0xFFFFFD00)
                            : Colors.grey.shade800,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 25))),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Votingspecific(name: 'Funny');
                }));
              },
              child: Container(
                height: 40,
                width: 90,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2.5)),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Center(
                    child: Text(
                  'View All',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            )
          ]),
          Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: InfiniteScroll(videosList: videosList)),
          Divider(
            indent: 80,
            endIndent: 80,
            color: themeProvider.selectedTheme == 'dark'
                ? Color(0xFFFFFD00)
                : Colors.blue,
            thickness: 1,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
                padding: EdgeInsets.all(30),
                child: Text('Random',
                    style: TextStyle(
                        color: themeProvider.selectedTheme == 'dark'
                            ? Color(0xFFFFFD00)
                            : Colors.grey.shade800,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 25))),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Votingspecific(name: 'Random');
                }));
              },
              child: Container(
                height: 40,
                width: 90,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2.5)),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Center(
                    child: Text(
                  'View All',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            )
          ]),
          Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: InfiniteScroll(videosList: videosList)),
          Divider(
            indent: 80,
            endIndent: 80,
            color: themeProvider.selectedTheme == 'dark'
                ? Color(0xFFFFFD00)
                : Colors.blue,
            thickness: 1,
          ),
          Padding(
              padding: EdgeInsets.only(top: 20.0, left: 30, right: 30),
              child: Center(
                child: Text('Judges',
                    style: TextStyle(
                        color: themeProvider.selectedTheme == 'dark'
                            ? Color(0xFFFFFD00)
                            : Colors.grey.shade800,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 25)),
              )),
          Container(
              padding: EdgeInsets.only(top: 30, bottom: 50),
              alignment: Alignment.center,
              height: 350,
              child: CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 350,
                    disableCenter: true,
                    viewportFraction: 0.6,
                    enlargeCenterPage: true,
                    autoPlay: true,
                  ),
                  itemBuilder:
                      (BuildContext context, int index, pageViewIndex) {
                    if (judgesList == null) {
                      return Shimmer.fromColors(
                        baseColor: Color(0xFFFFFD00),
                        highlightColor: Colors.blue[300]!,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.white,
                        ),
                      );
                    }
                    return Container(
                      padding: EdgeInsets.zero,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  JudgeDetailsPage(judge: judgesList![index]),
                            ),
                          );
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                                judgesList?[index].imageUrl ??
                                    'default_image_url',
                                fit: BoxFit.cover, errorBuilder:
                                    (BuildContext context, Object exception,
                                        StackTrace? stackTrace) {
                              return Shimmer.fromColors(
                                baseColor: Color(0xFFFFFD00),
                                highlightColor: Colors.blue[300]!,
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: Colors.white,
                                ),
                              );
                            })),
                      ),
                    );
                  },
                  itemCount: judgesList?.length ?? 0)),
          FooterCustom(themeProvider: themeProvider)
        ]),
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, int count) {
    String imageUrl;
    switch (title) {
      case 'Singing':
        imageUrl =
            'https://media.istockphoto.com/photos/singing-picture-id157281774?k=6&m=157281774&s=170667a&w=0&h=SLSfJm-Upu5StntLhTFkkwTtL1BVJDAUIn1gypOqB50=';
        break;
      case 'Dancing':
        imageUrl =
            'https://th.bing.com/th/id/R.ead8465f2736d223db14c7818f17e2ff?rik=vkmE8Q5L%2b5ZLQA&riu=http%3a%2f%2fimages5.fanpop.com%2fimage%2fphotos%2f31100000%2fDance-in-the-rain-passion-for-dancing-31143402-400-672.jpg&ehk=J9hfcOKUwQNFTeQ1c3qfLEWiu%2fMSv4Iny0cfpOElDi4%3d&risl=&pid=ImgRaw&r=0';
        break;
      case 'Comedy':
        imageUrl =
            'https://th.bing.com/th/id/R.b9ec34ef3b683a92e08e24eb5efdda3f?rik=t2hSba9SxYX3zQ&riu=http%3a%2f%2fiulianionescu.com%2fwp-content%2fuploads%2fstandup-comedy.jpg&ehk=DmmPxwlL5drCarHAgH0tQeaOhWB%2btsNtToQLKtURikM%3d&risl=&pid=ImgRaw&r=0';
        break;
      case 'Magic':
        imageUrl =
            'https://th.bing.com/th/id/OIP.JCil55ZqASP8-eDzlIAE-QHaDt?pid=ImgDet&rs=1';
        break;
      case 'Acting':
        imageUrl =
            'https://th.bing.com/th/id/R.b09633ab91e2b9d8396ffb1ef334a987?rik=Q5c%2fxISAqa%2bQ3Q&riu=http%3a%2f%2fimage3.photobiz.com%2f530%2f30_20160429101229_4278018_xlarge.jpg&ehk=jhODXy%2bqOfOnTS3y32H9jJ69r677fyFx8MOtVUzuYEE%3d&risl=&pid=ImgRaw&r=0';
        break;
      case 'Poetry reading':
        imageUrl =
            'https://th.bing.com/th/id/R.07d86b5790799e0429c52d6065984896?rik=n332DEIDJNIGpQ&riu=http%3a%2f%2fdefinitelybeautiful.com%2fwp-content%2fuploads%2f2019%2f07%2fqtq80-MfTL1M-640x427.jpeg&ehk=CFYqg6f%2fz4Ihc88rj0E8DUFAW6dpoArVld98Vpi4aww%3d&risl=&pid=ImgRaw&r=0';
        break;
      case 'Instruments':
        imageUrl =
            'https://th.bing.com/th/id/R.8c6aeee1a004754492a7ac47abcfeebd?rik=o3674igxPUYbfw&riu=http%3a%2f%2fwww.unk.edu%2facademics%2fmusic%2f_images%2fmusic-perf-comprehensive-instrumental-retated.jpg&ehk=tfqUdjLgiGmBJIcT0s9z4sKfvSdnUASUUFs3exa1Ahw%3d&risl=&pid=ImgRaw&r=0';
        break;
      case 'Impersonation':
        imageUrl =
            'https://th.bing.com/th/id/OIP.LzQ7k0Yb3IgswuvH_2c5cAHaGJ?pid=ImgDet&rs=1';
        break;
      case 'Juggling':
        imageUrl =
            'https://th.bing.com/th/id/R.417458637d781d9033c0d3c715f86b9e?rik=%2fRUVklNH%2fdloGg&pid=ImgRaw&r=0';
        break;
      case 'Acrobatics':
        imageUrl =
            'https://th.bing.com/th/id/R.d1d750708f3b3a05fee79d85de72f15a?rik=tih%2bRg3oYy9%2bHw&riu=http%3a%2f%2fwydancecentre.com%2fwp-content%2fuploads%2f2017%2f01%2facr2.jpg&ehk=koQ7HrvpTCrHly0Zdl%2fgUIryOCeumbETcrcDl9CMHPw%3d&risl=&pid=ImgRaw&r=0';
        break;
      case 'Painting':
        imageUrl =
            'https://th.bing.com/th/id/OIP.LfpVt1J6JEfejjq0zNa15QHaDp?pid=ImgDet&rs=1';
        break;
      case 'Fashion show':
        imageUrl =
            'https://th.bing.com/th/id/R.5f5bb189ae99e88c08d4945a7d978fb2?rik=ZATfunWqoQ4I%2fA&pid=ImgRaw&r=0';
        break;
      default:
        imageUrl = 'https://picsum.photos/150';
    }

    bool _isLoading = true;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const CategoriesList();
          }));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue,
                  themeProvider.selectedTheme == 'dark'
                      ? Color(0xFF121212)
                      : Colors.white,
                ],
              )),
          width: 130,
          height: 200,
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  child: Hero(
                    tag: title,
                    child: Stack(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                frameBuilder: (BuildContext context,
                                    Widget child,
                                    int? frame,
                                    bool wasSynchronouslyLoaded) {
                                  if (frame == null) {
                                    return Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFFFFFD00),
                                          Color(0xFFBCE0FB),
                                        ],
                                      )),
                                    );
                                  }
                                  return child;
                                },
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    icon,
                                    size: 16,
                                    color: Color(0xFFFFFD00),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '$count',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: themeProvider.selectedTheme == 'dark'
                            ? Colors.white
                            : Colors.black,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w200),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThumbnailCard extends StatelessWidget {
  final String? imageUrl;

  ThumbnailCard({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 130,
        height: 200,
        child: Column(
          children: [
            Container(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: imageUrl != null
                    ? Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : Shimmer.fromColors(
                        baseColor: Colors.blue.shade100,
                        highlightColor: Colors.blue[300]!,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfiniteScroll extends StatefulWidget {
  final List<PlaylistItem>? videosList;

  InfiniteScroll({required this.videosList});

  @override
  _InfiniteScrollState createState() => _InfiniteScrollState();
}

class _InfiniteScrollState extends State<InfiniteScroll> {
  final int _initialItemCount = 5;
  int _currentItemCount = 0;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _currentItemCount = _initialItemCount;
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _currentItemCount += _initialItemCount;
      });
    }
  }

  Future<List<PlaylistItem>?> _getVideosList() async {
    return widget.videosList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getVideosList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                min(_currentItemCount, widget.videosList!.length),
                (index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContestantDetailsPage(
                            video: widget.videosList![index]),
                      ),
                    );
                  },
                  child: ThumbnailCard(
                    imageUrl: widget
                        .videosList?[index].snippet?.thumbnails?.high?.url,
                  ),
                ),
              ),
            ),
          );
        } else {
          return Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.lightBlueAccent,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              color: Colors.white,
            ),
          );
        }
      },
    );
  }
}
