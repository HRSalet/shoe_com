// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import '../../authentication/login.dart';
//
// class BodyProfile extends StatefulWidget {
//   const BodyProfile({Key? key}) : super(key: key);
//
//   @override
//   State<BodyProfile> createState() => _BodyProfileState();
// }
//
// class _BodyProfileState extends State<BodyProfile> {
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           width: width,
//           height: height,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10.0),
//                       child: Text(
//                         'Account',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0XFF1A2530),
//                         ),
//                       ),
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.person, size: 20),
//                       title: Text(
//                         'My Profile',
//                         style: TextStyle(fontWeight: FontWeight.w500),
//                       ),
//                       trailing: Icon(Icons.arrow_forward_ios, size: 20),
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.location_on, size: 20),
//                       title: Text(
//                         'Saved Addresses',
//                         style: TextStyle(fontWeight: FontWeight.w500),
//                       ),
//                       trailing: Icon(Icons.arrow_forward_ios, size: 20),
//                     ),
//                     GestureDetector(
//                       onTap: () {},
//                       child: ListTile(
//                         leading: Icon(Icons.language, size: 20),
//                         title: Text(
//                           'Select Language',
//                           style: TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                         trailing: Icon(Icons.arrow_forward_ios, size: 20),
//                       ),
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.account_balance_wallet, size: 20),
//                       title: Text(
//                         'Payment Info',
//                         style: TextStyle(fontWeight: FontWeight.w500),
//                       ),
//                       trailing: Icon(Icons.arrow_forward_ios, size: 20),
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.delete, size: 20),
//                       title: Text(
//                         'Delete Account',
//                         style: TextStyle(fontWeight: FontWeight.w500),
//                       ),
//                       trailing: Icon(Icons.arrow_forward_ios, size: 20),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton.extended(
//           label: Text('LOGOUT', style: TextStyle(fontWeight: FontWeight.bold)),
//           backgroundColor: Colors.red,
//           foregroundColor: Colors.white,
//           onPressed: _logout,
//           autofocus: true,
//           elevation: 5.0,
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       ),
//     );
//   }
//
//   Future<void> _logout() async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => LoginPage()),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../authentication/login.dart';

class BodyProfile extends StatefulWidget {
  const BodyProfile({Key? key}) : super(key: key);

  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  String _userName = "Account";

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  void _fetchUserName() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      setState(() {
        _userName = user.email!.split('@').first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Welcome! ${_userName}",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0XFF1A2530),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person, size: 24),
                  title: Text(
                    'My Profile',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  onTap: () => _navigateTo(context, 'Profile Screen'),
                ),
                ListTile(
                  leading: Icon(Icons.location_on, size: 24),
                  title: Text(
                    'Saved Addresses',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  onTap: () => _navigateTo(context, 'Saved Addresses Screen'),
                ),
                ListTile(
                  leading: Icon(Icons.language, size: 24),
                  title: Text(
                    'Select Language',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  onTap: _selectLanguage,
                ),
                ListTile(
                  leading: Icon(Icons.account_balance_wallet, size: 24),
                  title: Text(
                    'Payment Info',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  onTap: () => _navigateTo(context, 'Payment Info Screen'),
                ),
                ListTile(
                  leading: Icon(Icons.delete, size: 24, color: Colors.red),
                  title: Text(
                    'Delete Account',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.red,
                  ),
                  onTap: _confirmDeleteAccount,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text('LOGOUT', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          onPressed: _logout,
          elevation: 5.0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  void _navigateTo(BuildContext context, String screen) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Navigate to $screen')));
  }

  void _selectLanguage() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Select Language'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('English'),
                  onTap: () => _setLanguage('English'),
                ),
                ListTile(
                  title: Text('Spanish'),
                  onTap: () => _setLanguage('Spanish'),
                ),
                ListTile(
                  title: Text('French'),
                  onTap: () => _setLanguage('French'),
                ),
              ],
            ),
          ),
    );
  }

  void _setLanguage(String language) {
    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Language set to $language')));
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Delete Account'),
            content: Text(
              'Are you sure you want to delete your account? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text('Delete', style: TextStyle(color: Colors.red)),
                onPressed: _deleteAccount,
              ),
            ],
          ),
    );
  }

  Future<void> _deleteAccount() async {
    Navigator.pop(context);
    try {
      await FirebaseAuth.instance.currentUser?.delete();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
