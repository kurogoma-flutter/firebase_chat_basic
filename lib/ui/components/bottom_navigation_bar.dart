// import 'package:flutter/material.dart';
//
// import '../pages/chat_solo_page.dart';
// import '../pages/friends_list_page.dart';
// import '../pages/settings_page.dart';
//
// int pageIndex = 0;
//
// List<Widget> bottomNavigationPages = [
//   const MessageWidget(),
//   const ChatScreenOnly(),
//   const SettingsPage(),
// ];
//
// BottomNavigationBar buildBottomNavigationBar() {
//   return BottomNavigationBar(
//     currentIndex: pageIndex,
//     items: [
//       BottomNavigationBarItem(
//         icon: GestureDetector(
//           onTap: () {
//             setState(() {
//               pageIndex = 0;
//             });
//           },
//           child: const CircleAvatar(
//             radius: 30,
//             backgroundImage: AssetImage('assets/images/friends.png'),
//             backgroundColor: Colors.transparent,
//           ),
//         ),
//         label: 'ともだち',
//       ),
//       BottomNavigationBarItem(
//         icon: GestureDetector(
//           onTap: () {
//             setState(() {
//               pageIndex = 1;
//             });
//           },
//           child: const CircleAvatar(
//             radius: 30,
//             backgroundImage: AssetImage('assets/images/solo_man.png'),
//             backgroundColor: Colors.transparent,
//           ),
//         ),
//         label: 'あなた',
//       ),
//       BottomNavigationBarItem(
//         icon: GestureDetector(
//           onTap: () {
//             setState(() {
//               pageIndex = 2;
//             });
//           },
//           child: const CircleAvatar(
//             radius: 30,
//             backgroundImage: AssetImage('assets/images/setting_image.png'),
//             backgroundColor: Colors.transparent,
//           ),
//         ),
//         label: 'せってい',
//       ),
//     ],
//   );
// }
