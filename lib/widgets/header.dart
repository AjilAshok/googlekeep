import 'package:flutter/material.dart';

class header extends StatelessWidget {
  const header({
    Key? key,
    required this.drawerkey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> drawerkey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10, left: 10),
      child: 
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            GestureDetector(
              onTap: () {
                drawerkey.currentState!.openDrawer();
              },
              child: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Search your notes ",
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
            Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.grid_view,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://pbs.twimg.com/profile_images/864104988146114560/MSWTWwno_400x400.jpg"),
                            fit: BoxFit.cover)),
                  )
                ]),
          
        ],
      ),
    );
  }
}
