import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../providers/account_provider.dart';
import '../../../screens/mobile/account/otp.screen.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final ImagePicker _picker = ImagePicker();

  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  AccountProvider accountProvider = AccountProvider();
  late String _verificationCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black54,
                      size: 32,
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepPurple.shade50),
                    child: Icon(
                      Icons.phone_android_sharp,
                      size: 100,
                      color: Colors.purple,
                    )),
                SizedBox(height: 10),
                Text(
                  'Registration',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter your phone number, we'll send you a verification code so we can verify you",
                  style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 500,
                  padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        child: TextField(
                            controller: codeController,
                            enableSuggestions: true,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            decoration: InputDecoration(
                              hintText: '+234',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red)),
                            )),
                      ),
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red)),
                              // prefix:
                              suffix: Icon(
                                Icons.check,
                                color: Colors.green,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  child: Text("Get Code", style: TextStyle(fontSize: 16)),
                  onPressed: () {
                    // _verifyPhone(
                    //     "${codeController.text}${phoneController.text}");
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext ctx) => Otp(
                    //             codeController.text, phoneController.text)));
                    accountProvider.getUser(
                        "${codeController.text}${phoneController.text}");
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.all(12.5)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _verifyPhone(String phone) async {
    debugPrint(phone);
    //  await FirebaseAuth.instance.verifyPhoneNumber(
    //       phoneNumber: phone,
    //       verificationCompleted: (PhoneAuthCredential credential) async {
    //         await FirebaseAuth.instance
    //             .signInWithCredential(credential)
    //             .then((value) async {
    //           if (value.user != null) {
    //             debugPrint('user is logged in');
    //           }
    //         });
    //       },
    //       verificationFailed: (FirebaseAuthException e) {
    //         debugPrint(e.message);
    //       },
    //       codeSent: (String verificationID, int? resendToken) {
    //         setState(() {
    //           _verificationCode = verificationID;
    //         });
    //       },
    //       codeAutoRetrievalTimeout: (String verificationID) {
    //         setState(() {
    //           _verificationCode = verificationID;
    //         });
    //       },
    //       timeout: Duration(seconds: 60));
  }
}
