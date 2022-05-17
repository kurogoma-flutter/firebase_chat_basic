import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            context.go('/home/2');
          },
        ),
        title: const Text('プロフィール画面'),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: size.height * 0.08,
                  width: size.width,
                  color: Colors.blueAccent,
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.04, left: 12),
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/ufo2.png"),
                    ),
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: size.width * 0.58, top: size.height * 0.09),
                  width: 150,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('プロフィール編集'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 1.5, color: Colors.blueAccent),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'ユーザー名',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '@ユーザーID',
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'コメントコメントコメントコメントコメントコメントコメントコメントコメントコメントコメント',
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 18),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '2022/01/25 から始めています',
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: size.width,
              height: 300,
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black45,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        color: Colors.transparent,
                      ),
                      tabs: [
                        Tab(text: "ともだち"),
                        Tab(text: "おすすめ"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(physics: NeverScrollableScrollPhysics(), children: [
                        ListView(
                          children: const [
                            ListTile(
                              title: Text('サンプル'),
                            ),
                            ListTile(
                              title: Text('サンプル'),
                            ),
                            ListTile(
                              title: Text('サンプル'),
                            ),
                            ListTile(
                              title: Text('サンプル'),
                            ),
                            ListTile(
                              title: Text('サンプル'),
                            ),
                            ListTile(
                              title: Text('サンプル'),
                            ),
                          ],
                        ),
                        ListView(
                          children: const [
                            ListTile(
                              title: Text('サンプル'),
                            ),
                            ListTile(
                              title: Text('サンプル'),
                            ),
                            ListTile(
                              title: Text('サンプル'),
                            ),
                            ListTile(
                              title: Text('サンプル'),
                            ),
                            ListTile(
                              title: Text('サンプル'),
                            ),
                            ListTile(
                              title: Text('サンプル'),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
