// // lib/personal_info_screen.dart
// import 'package:flutter/material.dart';
// import '../../themes/default/colors_standards.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';

// class PersonalInfo extends StatefulWidget {
//   final String name;
//   final String email;
//   final String dob;
//   final String password;

//   const PersonalInfo({
//     super.key,
//     required this.name,
//     required this.email,
//     required this.dob,
//     required this.password,
//   });

//   @override
//   _PersonalInfoState createState() => _PersonalInfoState();
// }

// class _PersonalInfoState extends State<PersonalInfo> {

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorsStandards.AppBackgroundColor,
//       appBar: AppBar(
//         title: TextStandard.Heading("Thông tin cá nhân", ColorsStandards.textColorInBackground1),
//         backgroundColor: ColorsStandards.AppBackgroundColor,
//       ),
//       body: Center(
//         child: SizedBox(
//           height: 570.0,
//           child: Stack(
//             alignment: Alignment.topCenter,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
//                 child: Container(
//                   width: double.infinity,
//                   height: 310.0,
//                   padding: const EdgeInsets.only(top: 70.0, left: 5.0, right: 5.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16.0),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 8.0,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Observer(
//                         builder: (_) => ListTile(
//                           title: TextStandard.Button("Họ tên", ColorsStandards.textColorInBackground1),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               TextStandard.Button(widget.name, ColorsStandards.textColorInBackground2),
//                               SizedBox(width: 8.0),
//                               Icon(Icons.arrow_forward_ios, size: 18.0),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Observer(
//                         builder: (_) => ListTile(
//                           title: TextStandard.Button("Email", ColorsStandards.textColorInBackground1),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               TextStandard.Button(widget.email, ColorsStandards.textColorInBackground2),
//                               SizedBox(width: 8.0),
//                               Icon(Icons.arrow_forward_ios, size: 18.0),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Observer(
//                         builder: (_) => ListTile(
//                           title: TextStandard.Button("Ngày sinh", ColorsStandards.textColorInBackground1),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               TextStandard.Button(widget.dob, ColorsStandards.textColorInBackground2),
//                               SizedBox(width: 8.0),
//                               Icon(Icons.arrow_forward_ios, size: 18.0),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Observer(
//                         builder: (_) => ListTile(
//                           title: TextStandard.Button("Mật khẩu", ColorsStandards.textColorInBackground1),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               TextStandard.Button(widget.password.replaceAll(RegExp(r'.'), '*'), ColorsStandards.textColorInBackground2),
//                               SizedBox(width: 8.0),
//                               Icon(Icons.arrow_forward_ios, size: 18.0),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 0,
//                 child: Stack(
//                   children: [
//                     Column(
//                       children: [
//                         CircleAvatar(
//                           backgroundImage: AssetImage('assets/icons/default_profile_pic.png'),
//                           radius: 50.0,
//                         ),
//                         SizedBox(height: 5.0),
//                         Observer(
//                           builder: (_) => TextStandard.BigTitle("", ColorsStandards.textColorInBackground1),
//                         ),
//                       ],
//                     ),
//                     Positioned(
//                       bottom: 35,
//                       right: 0,
//                       child: Container(
//                         child: Padding(
//                           padding: const EdgeInsets.all(0.0),
//                           child: Image.asset(
//                             "assets/icons/upload_profile_pic.png",
//                             width: 35,
//                             height: 35,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// lib/personal_info_screen.dart
import 'package:flutter/material.dart';
import '../../themes/default/colors_standards.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PersonalInfo extends StatefulWidget {
  final String name;
  final String email;
  final String dob;

  const PersonalInfo({
    super.key,
    required this.name,
    required this.email,
    required this.dob,
  });

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsStandards.AppBackgroundColor,
      appBar: AppBar(
        title: Text("Thông tin cá nhân"),
        backgroundColor: ColorsStandards.AppBackgroundColor,
      ),
      body: Center(
        child: SizedBox(
          height: 570.0,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
                child: Container(
                  width: double.infinity,
                  height: 310.0,
                  padding:
                      const EdgeInsets.only(top: 70.0, left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Observer(
                        builder: (_) => ListTile(
                          title: Text("Họ tên"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(widget.name),
                              SizedBox(width: 8.0),
                              Icon(Icons.arrow_forward_ios, size: 18.0),
                            ],
                          ),
                        ),
                      ),
                      Observer(
                        builder: (_) => ListTile(
                          title: Text("Email"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(widget.email),
                              SizedBox(width: 8.0),
                              Icon(Icons.arrow_forward_ios, size: 18.0),
                            ],
                          ),
                        ),
                      ),
                      Observer(
                        builder: (_) => ListTile(
                          title: Text("Ngày sinh"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(widget.dob),
                              SizedBox(width: 8.0),
                              Icon(Icons.arrow_forward_ios, size: 18.0),
                            ],
                          ),
                        ),
                      ),
                      Observer(
                        builder: (_) => const ListTile(
                          title: Text("Mật khẩu"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("********"),
                              SizedBox(width: 8.0),
                              Icon(Icons.arrow_forward_ios, size: 18.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/icons/default_profile_pic.png'),
                          radius: 50.0,
                        ),
                        SizedBox(height: 5.0),
                        Observer(
                          builder: (_) => Text("")
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 35,
                      right: 0,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Image.asset(
                            "assets/icons/upload_profile_pic.png",
                            width: 35,
                            height: 35,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
