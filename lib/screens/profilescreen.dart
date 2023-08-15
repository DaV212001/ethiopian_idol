import 'package:flutter/material.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      {'text': 'Change profile', 'icon': Icons.person},
      {'text': 'Change pin', 'icon': Icons.vpn_key},
      {'text': 'Change language', 'icon': Icons.language},
      {'text': 'Security Question', 'icon': Icons.security},
      {'text': 'Biometric Authentication', 'icon': Icons.fingerprint},
      {'text': 'Invite friends', 'icon': Icons.person_add},
      {'text': 'FAQ', 'icon': Icons.help_outline},
      {'text': 'Feedback', 'icon': Icons.feedback},
      {'text': 'Contact Us', 'icon': Icons.contact_support},
      {'text': 'About', 'icon': Icons.info_outline},
      {'text': 'Share', 'icon': Icons.share}
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.person, size: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name', style:
                      TextStyle(color:
                      Colors.grey.shade800, fontFamily:
                      'Outfit-black', fontWeight:
                      FontWeight.w300, fontSize:
                      15)),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text('Audience', style:
                        TextStyle(color:
                        Colors.grey.shade800, fontFamily:
                        'Outfit-black', fontWeight:
                        FontWeight.w300, fontSize:
                        15)),
                      ),
                      Text('Phone Number', style:
                      TextStyle(color:
                      Colors.grey.shade800, fontFamily:
                      'Outfit-black', fontWeight:
                      FontWeight.w300, fontSize:
                      15)),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: ListView.separated(
                  padding: EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(items[index]['icon'] as IconData),
                      title: Text(items[index]['text'] as String, style:
                      TextStyle(color:
                      Colors.grey.shade800, fontFamily:
                      'Outfit-black', fontWeight:
                      FontWeight.w300, fontSize:
                      15)),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    indent: 72,
                    color: Colors.grey,
                  ),
                )

            ),
          ),
        ],
      ),
    );
  }
}