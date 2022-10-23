// import 'package:cool_alert/cool_alert.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../constants/k_constants.dart';
// import '../enums/menu_action.dart';
// import '../services/auth/auth_service.dart';
// import '../services/auth/bloc/auth_bloc.dart';
// import '../services/auth/bloc/auth_event.dart';
// import '../services/cloud/firebase_cloud_storage.dart';
//
// class ActionToolBar extends StatefulWidget {
//   const ActionToolBar({super.key});
//
//   @override
//   State<ActionToolBar> createState() => _ActionToolBarState();
// }
//
// class _ActionToolBarState extends State<ActionToolBar> {
//   bool isGridView = true;
//
//   bool isTileView = false;
//   late final FirebaseCloudStorage _notesService;
//   String get userId => AuthService.firebase().currentUser!.id;
//
//   @override
//   void initState() {
//     _notesService = FirebaseCloudStorage();
//     // _notesService.open();
//     //Ensure DB OPEN NEGATES THE EXTRA CALL
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //BloC Listener for Logout
//     return Row(
//       children: [
//         IconButton(
//           onPressed: () {
//             setState(() {
//               isGridView = !isGridView;
//               //Show Snackbar
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: isGridView
//                       ? const Text(
//                           'Grid View',
//                           textAlign: TextAlign.center,
//                         )
//                       : const Text(
//                           'List View',
//                           textAlign: TextAlign.center,
//                         ),
//                   duration: const Duration(seconds: 1),
//                   backgroundColor: kJungleGreen.withOpacity(0.3),
//                 ),
//               );
//             });
//           },
//           //icon is grid or list
//           icon: isGridView
//               ? const Icon(Icons.view_module_rounded)
//               : const Icon(Icons.list),
//         ),
//         PopupMenuButton<MenuAction>(
//           itemBuilder: (context) => [
//             PopupMenuItem(
//               value: MenuAction.logout,
//               child: const Text('Logout'),
//               onTap: () {
//                 //Logout
//                 setState(() {
//                   CoolAlert.show(
//                     context: context,
//                     type: CoolAlertType.confirm,
//                     title: 'Logout',
//                     text: 'Are you sure you want to logout?',
//                     confirmBtnText: 'Yes',
//                     cancelBtnText: 'No',
//                     confirmBtnColor: kJungleGreen,
//                     onConfirmBtnTap: () {
//                       BlocProvider.of<AuthBloc>(context).add(( //Logout
//                           const AuthEventLogOut()));
//                       Navigator.of(context).pop();
//                     },
//                   );
//                 });
//               },
//             ),
//           ],
//           // rounded corners
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(10.0)),
//           ),
//           elevation: 10,
//           offset: const Offset(0, 50),
//           color: kJungleGreen,
//
//           onSelected: (value) async {
//             switch (value) {
//               case MenuAction.logout:
//                 final shouldLogout = await _buildButton(
//                   onTap: () {
//                     CoolAlert.show(
//                       context: context,
//                       type: CoolAlertType.confirm,
//                       title: 'Logout Test',
//                       text: 'Are you sure you want to logout?',
//                       confirmBtnText: 'Yes',
//                       cancelBtnText: 'No',
//                       confirmBtnColor: kJungleGreen,
//                       onConfirmBtnTap: () {
//                         setState(() {
//                           BlocProvider.of<AuthBloc>(context)
//                               .add(const AuthEventLogOut());
//                           Navigator.pop(context);
//                         });
//                       },
//                     );
//                   },
//                   text: 'Logout',
//                   color: kJungleGreen,
//                 );
//
//                 break;
//             }
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildButton(
//       {VoidCallback? onTap, required String text, Color? color}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10.0),
//       child: MaterialButton(
//         color: color,
//         minWidth: double.infinity,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         onPressed: onTap,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 15.0),
//           child: Text(
//             text,
//             style: TextStyle(
//               color: Colors.red,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
