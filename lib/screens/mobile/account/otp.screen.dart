import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:uzum/screens/mobile/account/otp.screen.dart';
import 'package:uzum/screens/mobile/account/signup.screen.dart';

class Otp extends StatefulWidget {
  late String code;
  late String phone;

  Otp(String code, String phone, {Key? key}) {
    this.code = code;
    this.phone = phone;
  }

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  late String _verificationCode;

  late String _smsCode = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var _pinPutFocusNode;

  var _pinPutController;

  var _formKey;

  final _code1controller = TextEditingController();
  final _code2controller = TextEditingController();
  final _code3controller = TextEditingController();
  final _code4controller = TextEditingController();
  final _code5controller = TextEditingController();
  final _code6controller = TextEditingController();

  @override
  void initState() {
    _verifyPhone("${widget.code}${widget.phone}");
    super.initState();
  }

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
                      Icons.sms_sharp,
                      size: 100,
                      color: Colors.purple,
                    )),
                SizedBox(height: 10),
                Text(
                  "We're almost there!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Verifying ${widget.code}${widget.phone}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter the code sent to your provided phone number for verification",
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
                  width: 450,
                  padding:
                      EdgeInsets.only(top: 28, bottom: 28, right: 4, left: 4),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      // darkRoundedPinPut(),
                      Form(
                        key: _formKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _textFieldOtp(
                                first: true,
                                last: false,
                                editingController: _code1controller),
                            _textFieldOtp(
                                first: false,
                                last: false,
                                editingController: _code2controller),
                            _textFieldOtp(
                                first: false,
                                last: false,
                                editingController: _code3controller),
                            _textFieldOtp(
                                first: false,
                                last: false,
                                editingController: _code4controller),
                            _textFieldOtp(
                                first: false,
                                last: false,
                                editingController: _code5controller),
                            _textFieldOtp(
                                first: false,
                                last: true,
                                editingController: _code6controller),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      ElevatedButton(
                        child: Text("Verify", style: TextStyle(fontSize: 16)),
                        onPressed: () {
                          debugPrint("formKey: " + _formKey.toString());
                          _submit();
                        },
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.all(12.5)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24)))),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  "Did'nt receive any code?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black38),
                ),
                SizedBox(
                  height: 18,
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint('Resending code');
                  },
                  child: Text(
                    "Resend Code",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.purple),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _verifyPhone(String phone) async {
    debugPrint(phone);
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              debugPrint('user is logged in');
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint(e.message);
        },
        codeSent: (String verificationID, int? resendToken) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 60));
  }

  _textFieldOtp(
      {bool first = true,
      bool last = false,
      dynamic editingController = TextEditingController}) {
    return Container(
      height: 85,
      child: AspectRatio(
        aspectRatio: 0.7,
        child: TextFormField(
          controller: editingController,
          onChanged: (value) {
            setState(() {
              _smsCode = _smsCode + value;
              debugPrint("field:  ${editingController.text}");
            });
            debugPrint('smscode: ' + _smsCode);
            // debugPrint("value length: ${value.length}");
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          autofocus: true,
          readOnly: false,
          showCursor: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
              counter: Offstage(),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.purple, width: 2))),
        ),
      ),
    );
  }

  _submit() async {
    try {
      var smsCode = _code1controller.text +
          _code2controller.text +
          _code3controller.text +
          _code4controller.text +
          _code5controller.text +
          _code6controller.text;
      debugPrint('Code: ' + smsCode);
      // FirebaseAuth.instance
      //     .signInWithCredential(PhoneAuthProvider.credential(
      //         verificationId: _verificationCode, smsCode: smsCode))
      //     .then((value) async {
      //   if (value.user != null) {
      //     debugPrint('user is logged in');
      //   }
      // });
    } catch (e) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        padding: EdgeInsets.only(right: 50, left: 50),
        content: Text(
          'Invalid OTP',
          style: TextStyle(),
        ),
      ));
    }
  }

  Widget darkRoundedPinPut() {
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: const Color.fromRGBO(25, 21, 99, 1),
      borderRadius: BorderRadius.circular(20.0),
    );
    return PinPut(
      eachFieldWidth: 65.0,
      eachFieldHeight: 65.0,
      withCursor: true,
      fieldsCount: 6,
      focusNode: _pinPutFocusNode,
      controller: _pinPutController,
      onSubmit: (String pin) {
        // ScaffoldMessenger(
        //   child: Text("message:" + pin),
        // );
        debugPrint("message: " + pin);
        _smsCode = pin;
        _submit();
      },
      submittedFieldDecoration: pinPutDecoration,
      selectedFieldDecoration: pinPutDecoration,
      followingFieldDecoration: pinPutDecoration,
      pinAnimationType: PinAnimationType.scale,
      textStyle: const TextStyle(color: Colors.white, fontSize: 20.0),
    );
  }
}
