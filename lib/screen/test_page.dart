import 'package:flutter/material.dart';

class FristPage extends StatelessWidget {
  FristPage({super.key});
  GlobalKey<ScaffoldState> _scaffoldKEY = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKEY,
        drawer: Drawer(
          backgroundColor: Colors.white,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFffffff), Color(0xFF008ae6)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'asset/image/student.png',
                      height: 70,
                      width: 220,
                    ),
                    IconButton(
                      onPressed: () {
                        _scaffoldKEY.currentState!.openDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: Color(0xFF008ae6),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 80,
                  width: 470,
                  decoration: BoxDecoration(
                      color: Color(0xFF008ae6),
                      border: Border(
                          bottom: BorderSide(color: Color(0xFF005ce6)),
                          right: BorderSide(color: Color(0xFF005ce6)))),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(radius: 33, backgroundColor: Colors.white),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Md Mamun Islam Mim',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Text(
                            'Flutter Developer',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Batch: 1',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Code: 20230502',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: SizedBox(
                          height: 125,
                          width: 125,
                          child: Card(
                              color: Colors.white,
                              elevation: 12,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'asset/image/student.png',
                                    height: 70,
                                    width: 100,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Student Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF008ae6)),
                                  ),
                                  //Text('Name',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF002699)))
                                ],
                              ))),
                    ),
                    InkWell(
                      onTap: () {},
                      child: SizedBox(
                        height: 125,
                        width: 125,
                        child: Card(
                            color: Colors.white,
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 70,
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Student Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF008ae6)),
                                ),
                                //Text('Name',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF002699)))
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: SizedBox(
                        height: 125,
                        width: 125,
                        child: Card(
                            color: Colors.white,
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 70,
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Student Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF008ae6)),
                                ),
                                //Text('Name',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF002699)))
                              ],
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: SizedBox(
                        height: 125,
                        width: 125,
                        child: Card(
                            color: Colors.white,
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 70,
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Student Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF008ae6)),
                                ),
                                //Text('Name',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF002699)))
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Batch:2 ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Code: 20230825',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  InkWell(
                    onTap: () {},
                    child: SizedBox(
                        height: 125,
                        width: 125,
                        child: Card(
                            color: Colors.white,
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 70,
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Student Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF008ae6)),
                                ),
                                //Text('Name',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF002699)))
                              ],
                            ))),
                  ),
                  InkWell(
                    onTap: () {},
                    child: SizedBox(
                        height: 125,
                        width: 125,
                        child: Card(
                            color: Colors.white,
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 70,
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Student Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF008ae6)),
                                ),
                                //Text('Name',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF002699)))
                              ],
                            ))),
                  ),
                  InkWell(
                    onTap: () {},
                    child: SizedBox(
                        height: 125,
                        width: 125,
                        child: Card(
                            color: Colors.white,
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 70,
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Student Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF008ae6)),
                                ),
                                //Text('Name',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF002699)))
                              ],
                            ))),
                  ),
                  InkWell(
                    onTap: () {},
                    child: SizedBox(
                        height: 125,
                        width: 125,
                        child: Card(
                            color: Colors.white,
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  height: 70,
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Student Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF008ae6)),
                                ),
                                //Text('Name',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF002699)))
                              ],
                            ))),
                  ),
                ]),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  'Our Activities',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                            radius: 35,
                            backgroundColor: Color(0xFFccd9ff),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.book_online,
                                color: Color(0xFF008ae6),
                              ),
                              iconSize: 35,
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Class Videos',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                            radius: 35,
                            backgroundColor: Color(0xFFccd9ff),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.assignment,
                                color: Color(0xFF008ae6),
                              ),
                              iconSize: 35,
                            )),
                        SizedBox(height: 8),
                        Text(
                          'Assingment',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                            radius: 35,
                            backgroundColor: Color(0xFFccd9ff),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.link,
                                color: Color(0xFF008ae6),
                              ),
                              iconSize: 35,
                            )),
                        SizedBox(height: 8),
                        Text(
                          'Class Link ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                            radius: 35,
                            backgroundColor: Color(0xFFccd9ff),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.notifications,
                                color: Color(0xFF008ae6),
                              ),
                              iconSize: 35,
                            )),
                        SizedBox(height: 8),
                        Text(
                          'Notice',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                            radius: 35,
                            backgroundColor: Color(0xFFccd9ff),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit_calendar_outlined,
                                color: Color(0xFF008ae6),
                              ),
                              iconSize: 35,
                            )),
                        SizedBox(height: 8),
                        Text(
                          'Result',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                            radius: 35,
                            backgroundColor: Color(0xFFccd9ff),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.spatial_audio_outlined,
                                color: Color(0xFF008ae6),
                              ),
                              iconSize: 35,
                            )),
                        SizedBox(height: 8),
                        Text(
                          'Communication',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
