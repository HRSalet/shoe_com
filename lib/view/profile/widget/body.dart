import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:sneakers_app/controller/language_change_controller.dart';

import '../../../animation/fadeanimation.dart';
import '../../../theme/custom_app_theme.dart';
import '../../authentication/login.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

enum language { english, hindi, gujarati }

class _ProfileBodyState extends State<ProfileBody> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      _emailController.text = user.email ?? "";
      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(user.uid).get();
      if (userDoc.exists) {
        _nameController.text = userDoc['name'] ?? "";
        _phoneController.text = userDoc['phoneNo'] ?? "";
        _dobController.text = userDoc['dateOfBirth'] ?? "";
        _addressController.text = userDoc['address'] ?? "";
      }
    }
  }

  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _updateUserDetails() async {
    final user = _auth.currentUser;
    if (user == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _firestore.collection('Users').doc(user.uid).update({
        'name': _nameController.text.trim(),
        'phoneNo': _phoneController.text.trim(),
        'dateOfBirth': _dobController.text.trim(),
        'address': _addressController.text.trim(),
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Profile updated successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: ${e.toString()}')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Future<void> _deleteAccount() async {
    Navigator.pop(context);
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('No user is logged in')));
      return;
    }
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .delete();

      await user.delete();
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            topText(width, height),
            Divider(color: Colors.grey),
            const SizedBox(height: 15),
            mainProfile(),
            const SizedBox(height: 20),
            _isLoading
                ? Center(child: SpinKitCircle(color: Colors.black, size: 40))
                : lastButton(),
          ],
        ),
      ),
    );
  }

  topText(width, height) {
    return SizedBox(
      width: width,
      height: height / 14,
      child: FadeAnimation(
        delay: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                AppLocalizations.of(context)!.my_profile,
                style: AppThemes.bagTitle,
              ),
            ),
            Consumer<LanguageChangeController>(
              builder: (context, provider, child) {
                return PopupMenuButton<language>(
                  icon: Icon(
                    Icons.translate_rounded,
                    color: Colors.black,
                    size: 28,
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 8, // Shadow effect
                  onSelected: (language selectedLanguage) {
                    switch (selectedLanguage) {
                      case language.english:
                        provider.changeLanguage(Locale('en'));
                        break;
                      case language.hindi:
                        provider.changeLanguage(Locale('hi'));
                        break;
                      case language.gujarati:
                        provider.changeLanguage(Locale('gu'));
                        break;
                    }
                  },
                  itemBuilder:
                      (BuildContext context) => <PopupMenuEntry<language>>[
                        _buildMenuItem(language.english, "English"),
                        _buildMenuItem(language.hindi, "हिन्दी"),
                        _buildMenuItem(language.gujarati, "ગુજરાતી"),
                      ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<language> _buildMenuItem(language value, String text) {
    return PopupMenuItem<language>(
      value: value,
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  mainProfile() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.name,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              enabled: false,
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.email,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              enabled: false,
            ),
            const SizedBox(height: 15),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.phone_number,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.please_enter_your_phone;
                } else if (value.length != 10) {
                  return AppLocalizations.of(context)!.phone_warning;
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _dobController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.dob,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.address,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  lastButton() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _updateUserDetails,
          child: Text(
            AppLocalizations.of(context)!.save_changes,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(150, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 8.0,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _logout,
          child: Text(
            AppLocalizations.of(context)!.logout,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(150, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 8.0,
            backgroundColor: Colors.orangeAccent,
            foregroundColor: Colors.white,
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          //onPressed: _deleteAccount,
          onPressed: () {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              text:
                  'Once you delete your account, you will no longer be able to access it or any of its associated data. Are you sure?',
              title: 'Delete Account',
              confirmBtnText: 'Yes',
              confirmBtnColor: Colors.red,
              onConfirmBtnTap: _deleteAccount,
              animType: QuickAlertAnimType.slideInUp,
            );
          },
          child: Text(
            AppLocalizations.of(context)!.delete,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(150, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 8.0,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
