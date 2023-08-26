import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ethiopian_idol/screens/homepage.dart';
import 'package:ethiopian_idol/main.dart';
import 'package:provider/provider.dart';


class CategoriesList extends StatefulWidget {

  const CategoriesList({
    Key? key,
  }) ;

  @override
  CategoriesListState createState() => CategoriesListState();
}

class CategoriesListState extends State<CategoriesList> {
  final List<Map<String, dynamic>> categoryList = [
    {
      "name": "Singing",
      "imageUrl":
      "https://media.istockphoto.com/photos/singing-picture-id157281774?k=6&m=157281774&s=170667a&w=0&h=SLSfJm-Upu5StntLhTFkkwTtL1BVJDAUIn1gypOqB50=",
      "num": 220
    },
    {
      "name": "Dancing",
      "imageUrl":
      "https://th.bing.com/th/id/R.ead8465f2736d223db14c7818f17e2ff?rik=vkmE8Q5L%2b5ZLQA&riu=http%3a%2f%2fimages5.fanpop.com%2fimage%2fphotos%2f31100000%2fDance-in-the-rain-passion-for-dancing-31143402-400-672.jpg&ehk=J9hfcOKUwQNFTeQ1c3qfLEWiu%2fMSv4Iny0cfpOElDi4%3d&risl=&pid=ImgRaw&r=0",
      "num": 204
    },
    {
      "name": "Comedy",
      "imageUrl":
      "https://th.bing.com/th/id/R.b9ec34ef3b683a92e08e24eb5efdda3f?rik=t2hSba9SxYX3zQ&riu=http%3a%2f%2fiulianionescu.com%2fwp-content%2fuploads%2fstandup-comedy.jpg&ehk=DmmPxwlL5drCarHAgH0tQeaOhWB%2btsNtToQLKtURikM%3d&risl=&pid=ImgRaw&r=0",
      "num": 356
    },


    {
    "name":"Magic",
    "imageUrl" : "https://th.bing.com/th/id/OIP.JCil55ZqASP8-eDzlIAE-QHaDt?pid=ImgDet&rs=1",
      "num": 98

    },


    {
    "name":"Acting",
    "imageUrl" : "https://th.bing.com/th/id/R.b09633ab91e2b9d8396ffb1ef334a987?rik=Q5c%2fxISAqa%2bQ3Q&riu=http%3a%2f%2fimage3.photobiz.com%2f530%2f30_20160429101229_4278018_xlarge.jpg&ehk=jhODXy%2bqOfOnTS3y32H9jJ69r677fyFx8MOtVUzuYEE%3d&risl=&pid=ImgRaw&r=0",
      "num": 178

    },


    {
    "name":"Poetry reading",
    "imageUrl" : "https://th.bing.com/th/id/R.07d86b5790799e0429c52d6065984896?rik=n332DEIDJNIGpQ&riu=http%3a%2f%2fdefinitelybeautiful.com%2fwp-content%2fuploads%2f2019%2f07%2fqtq80-MfTL1M-640x427.jpeg&ehk=CFYqg6f%2fz4Ihc88rj0E8DUFAW6dpoArVld98Vpi4aww%3d&risl=&pid=ImgRaw&r=0",
      "num": 460

    },


    {
    "name":"Instruments",
    "imageUrl" : "https://th.bing.com/th/id/R.8c6aeee1a004754492a7ac47abcfeebd?rik=o3674igxPUYbfw&riu=http%3a%2f%2fwww.unk.edu%2facademics%2fmusic%2f_images%2fmusic-perf-comprehensive-instrumental-retated.jpg&ehk=tfqUdjLgiGmBJIcT0s9z4sKfvSdnUASUUFs3exa1Ahw%3d&risl=&pid=ImgRaw&r=0",
      "num": 560

    },


    {
    "name":"Impersonation",
    "imageUrl" : "https://th.bing.com/th/id/OIP.LzQ7k0Yb3IgswuvH_2c5cAHaGJ?pid=ImgDet&rs=1",
      "num": 280

    },


    {
    "name":"Juggling",
    "imageUrl" : "https://th.bing.com/th/id/R.417458637d781d9033c0d3c715f86b9e?rik=%2fRUVklNH%2fdloGg&pid=ImgRaw&r=0",
      "num": 290

    },


    {
    "name":"Acrobatics",
    "imageUrl" : "https://th.bing.com/th/id/R.d1d750708f3b3a05fee79d85de72f15a?rik=tih%2bRg3oYy9%2bHw&riu=http%3a%2f%2fwydancecentre.com%2fwp-content%2fuploads%2f2017%2f01%2facr2.jpg&ehk=koQ7HrvpTCrHly0Zdl%2fgUIryOCeumbETcrcDl9CMHPw%3d&risl=&pid=ImgRaw&r=0",
      "num": 134

    },


    {
    "name":"Painting or drawing",
    "imageUrl" : "https://th.bing.com/th/id/OIP.LfpVt1J6JEfejjq0zNa15QHaDp?pid=ImgDet&rs=1",
      "num": 117

    },


    {
    "name":"Fashion show",
    "imageUrl" : "https://th.bing.com/th/id/R.5f5bb189ae99e88c08d4945a7d978fb2?rik=ZATfunWqoQ4I%2fA&pid=ImgRaw&r=0",
      "num": 194

    }

    // add more categories here
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.selectedTheme=='dark'? Color(0xFF121212): Colors.white,
      appBar: AppBar(
        backgroundColor: themeProvider.selectedTheme == 'dark' ? Color(0xFF121212) : Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        title: Text('Categories', style: TextStyle(color: themeProvider.selectedTheme=='dark'?Colors.yellow:Colors.black),),
      ),
      body: categoryList.isEmpty
          ? Container(
        color: const Color(0xFFFFFFFF),
        child: const Center(
          child: Text('Oops! the categories don\'t exist :('),
        ),
      )
          : Container(
          color: themeProvider.selectedTheme=='dark'?Color(0xFF121212):Color(0xFFFFFFFF),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: categoryList.length,
                            itemBuilder:
                                (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  color: themeProvider.selectedTheme=='dark'?Color(0xFF121212):Color(0xFFFFFFFF),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(
                                      top: 0.0,
                                      bottom: 3.0,
                                      left: 10,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  right:
                                                  10.0),
                                              child:
                                              Container(
                                                height: 135,
                                                width: 120,
                                                child:
                                                Hero(
                                                  tag:
                                                  '${categoryList[index]['name']}',
                                                  child:
                                                  Stack(
                                                    children:[ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(10.0),
                                                      child:
                                                      Image.network(categoryList[index]['imageUrl']!,
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent? loadingProgress) {
                                                          if (loadingProgress == null) return child;
                                                          return Shimmer.fromColors(baseColor: Colors.blue[300]!, highlightColor: Colors.blue[100]!,child:SizedBox(width:85,height:130));
                                                        },
                                                        errorBuilder:(context, error, stackTrace) => Shimmer.fromColors(baseColor: Colors.blue[300]!, highlightColor: Colors.blue[100]!,child:SizedBox(width:85,height:130)),
                                                      ),
                                                    ),]
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    categoryList[
                                                    index][
                                                    'name']!,
                                                    style:
                                                     TextStyle(
                                                      color: themeProvider.selectedTheme=='dark'?Colors.white:Colors.black,
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 15,
                                                        overflow:
                                                        TextOverflow.ellipsis),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.person, color: themeProvider.selectedTheme=='dark'?Colors.yellow:Colors.black,),
                                                      Text(categoryList[index]["num"].toString(), style: TextStyle(color: themeProvider.selectedTheme=='dark'?Colors.yellow:Colors.black),),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Divider(
                                          color:
                                          Colors.black54,
                                          thickness: 1,
                                          endIndent: 20,
                                          indent: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}










