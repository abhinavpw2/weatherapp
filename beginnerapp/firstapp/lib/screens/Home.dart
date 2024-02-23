import 'dart:ffi';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import '../widgets/listViewFunc.dart';

class Home extends StatelessWidget {
  Home({super.key});

  List<String> products = ["bed", "couch", "sofa", "mattress", "pillow"];
  List<String> products_details = [
    "kingsize bed",
    "kingsize couch",
    "kingsize sofa",
    "kingsize mattress",
    "kingsize pillow"
  ];
  List<int> prices = [5500, 3200, 2700, 2000, 500];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("widget".toUpperCase()),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          listViewFunc(
            widgetTitle: "keyboard".toUpperCase(),
            widgetSubtitle: "A4Tech Keyboard",
            frontIcon: Icons.keyboard,
            tileColour: Colors.blueGrey,
          ),
          listViewFunc(
            widgetTitle: "monitor".toUpperCase(),
            widgetSubtitle: "A4Tech Monitor",
            frontIcon: Icons.monitor,
            tileColour: Colors.grey,
          ),
          listViewFunc(
            widgetTitle: "webcam".toUpperCase(),
            widgetSubtitle: "A4Tech Camera",
            frontIcon: Icons.camera,
            tileColour: Colors.blueGrey,
          ),
          listViewFunc(
            widgetTitle: "webcam".toUpperCase(),
            widgetSubtitle: "A4Tech Camera",
            //frontIcon: Icons.camera,
            tileColour: Colors.grey,
          ),
        ],
      ),
      // backgroundColor: Colors.blueAccent.shade100,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add_rounded),
      //   backgroundColor: Colors.blue,
      //   elevation: 30.0,

      //   //  mini: true,
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   shape: CircularNotchedRectangle(),
      //   color: Colors.blue,
      //   notchMargin: 5.0,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Icon(Icons.home_outlined, size: 40, color: Colors.white),
      //       Icon(Icons.shopping_bag_outlined, size: 40, color: Colors.white),
      //       Icon(Icons.favorite_border_outlined, size: 40, color: Colors.white),
      //       Icon(Icons.settings_outlined, color: Colors.white, size: 40),
      //     ],
      //   ),
      // ),
      // appBar: AppBar(
      //   title: Text("navigation".toUpperCase()),
      // ),
      // drawer: Drawer(
      //   elevation: 140,
      //   child: ListView(
      //     children: [
      //       const UserAccountsDrawerHeader(
      //         accountEmail: Text("abhinavpw2@gmail.com"),
      //         accountName: Text("Abhinav"),
      //         currentAccountPicture:
      //             CircleAvatar(foregroundImage: AssetImage("images/abc.png")),
      //       ),
      //       ListTile(
      //           leading: Icon(Icons.home_rounded),
      //           title: Text("home".toUpperCase()),
      //           onTap: () {}),
      //       ListTile(
      //           leading: Icon(Icons.shopping_cart_rounded),
      //           title: Text("products".toUpperCase()),
      //           onTap: () {}),
      //       ListTile(
      //           leading: Icon(FontAwesomeIcons.solidHeart),
      //           title: Text("favourites".toUpperCase()),
      //           onTap: () {}),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Text("labels".toUpperCase()),
      //       ),
      //       ListTile(
      //           leading: Icon(Icons.label_rounded),
      //           title: Text("red".toUpperCase()),
      //           onTap: () {}),
      //       ListTile(
      //           leading: Icon(Icons.label_rounded),
      //           title: Text("green".toUpperCase()),
      //           onTap: () {}),
      //       ListTile(
      //           leading: Icon(Icons.label_rounded),
      //           title: Text("blue".toUpperCase()),
      //           onTap: () {}),
      //     ],
      //   ),
      // ),
      // body: Container(
      //   child: ListView.builder(
      //     itemCount: products.length,
      //     itemBuilder: (context, index) {
      //       return ListTile(
      //         leading:
      //             CircleAvatar(child: Text(products[index][0].toUpperCase())),
      //         title: Text(products[index].toUpperCase()),
      //         subtitle: Text(products_details[index].toUpperCase()),
      //         trailing: Text(prices[index].toString()),
      //       );
      //     },

      //     // itemExtent: 100.0,
      //     // reverse: false,
      //     // scrollDirection: Axis.vertical,
      //     // shrinkWrap: true,
      //     // children: [
      //     //   ListTile(
      //     //     leading: CircleAvatar(
      //     //       child: Icon(Icons.attach_money_sharp),
      //     //       backgroundColor: Colors.teal,
      //     //     ),
      //     //     title: Text("Sales".toUpperCase()),
      //     //     subtitle: Text("Total sales of the month"),
      //     //     trailing: Text("3500"),
      //     //     onTap: () {},
      //     //     shape: StadiumBorder(),
      //     //     tileColor: Colors.teal.shade50,
      //     //   ),
      //     //   ListTile(
      //     //     leading: Icon(Icons.people_alt_sharp),
      //     //     title: Text("customers".toUpperCase()),
      //     //     subtitle: Text("Total customers of the month"),
      //     //     trailing: Text("200"),
      //     //     onTap: () {},
      //     //   ),
      //     //   ListTile(
      //     //     leading: Icon(Icons.notes_sharp),
      //     //     title: Text("profit".toUpperCase()),
      //     //     subtitle: Text("Total profit of the month"),
      //     //     trailing: Text("3500"),
      //     //     onTap: () {},
      //     //   )
      //     // ],
      //   ),
      // ),
      // appBar: AppBar(
      //   title: Text("Rows and columns"),
      //   centerTitle: true,
      // ),
      // body: Container(
      //   child: Column(
      //     children: [
      //       Row(
      //         children: [
      //           Expanded(child: Image(image: AssetImage("images/abc.png"),width: 150,)),
      //           Expanded(flex: 3,child: Image(image: AssetImage("images/abc.png"),width: 150,)),
      //           Expanded(flex:4,child: Image(image: AssetImage("images/abc.png"),width: 150,)),
      //         ],
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Icon(Icons.star_sharp,size: 30,),
      //           Icon(Icons.star_sharp,size: 30,),
      //           Icon(Icons.star_sharp,size: 30,),
      //           Icon(Icons.star_sharp,size: 30,),
      //           Icon(Icons.star_border_sharp,size: 30,),
      //         ],
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      //         children: [
      //           Column(
      //             children: [
      //               Icon(
      //                 Icons.phone_android_sharp,
      //                 size: 35.0,
      //               ),
      //               Text("phone".toUpperCase())
      //             ],
      //           ),
      //           Column(
      //             children: [
      //               Icon(
      //                 Icons.message_sharp,
      //                 size: 35.0,
      //               ),
      //               Text("messages".toUpperCase())
      //             ],
      //           ),
      //           Column(
      //             children: [
      //               Icon(
      //                 Icons.share_sharp,
      //                 size: 35,
      //               ),
      //               Text("share".toUpperCase()),
      //             ],
      //           )
      //         ],
      //       ),
      //     ],
      //   ),
      // ),

      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.menu),
      //     onPressed: () {},
      //   ),
      //   title: Text("Menu"),
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(Icons.search),
      //       splashRadius: 17,
      //     ),
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(Icons.shopping_cart),
      //       splashRadius: 17,
      //     ),
      //     //IconButton(onPressed:  () {}, icon: Icon(Icons.restaurant_menu),splashRadius: 17,),
      //   ],
      //   elevation: 30,
      //   centerTitle: true,
      //   //titleSpacing: 20,
      //   backgroundColor: Colors.purple,
      //   shape: const RoundedRectangleBorder(
      //       borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
      //   flexibleSpace: const Image(
      //     image: NetworkImage(
      //         "https://images.unsplash.com/photo-1562499573-a3c6ee42ee83?auto=format&fit=crop&q=80&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&w=2624"),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text("Appbar",
      //           style:
      //               TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
      //       Text("Learning it",
      //           style: TextStyle(
      //               fontWeight: FontWeight.bold, color: Colors.purple))
      //     ],
      //   ),
      // )
      // // Center(
      // //   child: ElevatedButton.icon(
      // //     onPressed: () {},
      // //     icon: Icon(FontAwesomeIcons.hourglassStart),
      // //     label: Text("Begin"),
      // //     onLongPress: () {},
      // //     style: ElevatedButton.styleFrom(
      // //       padding: EdgeInsets.all(20.0),
      // //       fixedSize: Size(300.0, 80.0),
      // //       textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
      // //       backgroundColor: Colors.blueAccent,
      // //       foregroundColor: Colors.white,
      // //       elevation: 15.0,
      // //       shadowColor: Colors.blue,
      // //       side: BorderSide(
      // //           color: Colors.black, width: 3, style: BorderStyle.solid),
      // //       //alignment: Alignment.topCenter
      // //       shape: StadiumBorder(),
      // //     ),
      // //   ),
      // // ),
    );
  }
}
