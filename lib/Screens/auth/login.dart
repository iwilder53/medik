// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mediq/helpers/calculate_pixels.dart';
import 'package:mediq/helpers/snackbar.dart';
import 'package:mediq/navigation/arguments.dart';
import 'package:mediq/navigation/navigators.dart';
import 'package:mediq/navigation/routes.dart';

import 'package:otp_autofill/otp_autofill.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:mediq/packages/otp_timer_button-1.1.0/lib/otp_timer_button.dart';
import '../widgets/appbar_icon.dart';
import '../widgets/show_error.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpSent = false;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController smsCodeController = TextEditingController();
  late OTPTextEditController controller;
  late OTPInteractor _otpInteractor;
  late String verificationId;
  String phoneNumber = '';
  int? _resendToken;
  login(String phoneNumber) async {
    print(phoneNumber);
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 0),
        verificationCompleted: (PhoneAuthCredential credential) {
          pushReplacement(context, NamedRoute.homeScreen,
              arguments:
                  HomeScreenArguments(mobNumber: int.parse(phoneNumber)));
        },
        verificationFailed: (FirebaseAuthException e) =>
            {showError(e, context), login(phoneNumber)},
        codeSent: (String verificationId, int? resendToken) async {
          print('Code Sent');
          this.verificationId = verificationId;
          _resendToken = resendToken;
          otpSent = true;

          isLoading = false;
          setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        forceResendingToken: _resendToken);
  }

  String? validateMobile(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value == null) {
      return null;
    }
    if (value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }

    return null;
  }

  verifyPhoneNumber(String smsCode) async {
    // Create a PhoneAuthCredential with the code
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);
      pushReplacement(context, NamedRoute.homeScreen,
          arguments: HomeScreenArguments(mobNumber: int.parse(phoneNumber)));
    } on FirebaseAuthException catch (e) {
      otpSent = false;
      isLoading = false;

      setState(() {});
      showSnackBar(e.message.toString(), context);
    }
  }

  @override
  void initState() {
    _otpInteractor = OTPInteractor();
    _otpInteractor
        .getAppSignature()
        //ignore: avoid_print
        .then((value) => print('signature - $value'));

    controller = OTPTextEditController(
      codeLength: 6,
      errorHandler: (error) => showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(content: Text(error.toString()));
          })),
      //ignore: avoid_print
      onCodeReceive: (code) => {
        print('Your Application receive code - $code'),
        //  verifyPhoneNumber(code)
      },
      otpInteractor: _otpInteractor,
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{6})');
          return exp.stringMatch(code ?? '') ?? '';
        },
      );
  }

  @override
  Future<void> dispose() async {
    await controller.stopListen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dw = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 143, 121),
      appBar: appBar(dw),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(
                  vertical: dw * 0.1, horizontal: dw * 0.05),
              child: otpSent
                  ? Center(
                      child: ListView(
                        children: [
                          Text(
                            'Confirm OTP',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Divider(
                            color: Colors.transparent,
                            thickness: 0.0,
                          ),
                          Text(
                            'Enter OTP we just sent to your mobile number',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                          Form(
                            key: _formKey,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: dw * 0.05, vertical: dw * 0.04),
                                child: PinCodeTextField(
                                  autoDisposeControllers: false,
                                  appContext: context,
                                  enableActiveFill: true,
                                  length: 6,
                                  obscureText: false,
                                  obscuringCharacter: '*',
                                  animationType: AnimationType.fade,
                                  validator: (v) {
                                    if (v == null || v.characters.length != 6) {
                                      return "Enter 6 digits";
                                    } else {
                                      return null;
                                    }
                                  },
                                  pinTheme: PinTheme(
                                    errorBorderColor: Colors.white,
                                    activeColor: Colors.white,
                                    inactiveColor: Colors.white,
                                    activeFillColor: Colors.white,
                                    inactiveFillColor: Colors.white,
                                    selectedFillColor: Colors.white,
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(6.0),
                                    fieldWidth: dw * 0.1,
                                    // fieldHeight: dH * 0.06,
                                  ),
                                  textStyle: GoogleFonts.poppins(
                                      fontSize: 20, height: 1.6),
                                  // backgroundColor: Colors.blue.shade50,
                                  // enableActiveFill: true,
                                  //  errorAnimationController: errorController,
                                  controller: controller,
                                  keyboardType: TextInputType.number,

                                  onCompleted: (v) async {
                                    isLoading = true;
                                    setState(() {});
                                    await verifyPhoneNumber(
                                        controller.text.trim());
                                  },

                                  onChanged: (value) {},
                                  beforeTextPaste: (text) {
                                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                    return true;
                                  },
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              OtpTimerButton(
                                timerTextStyle: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                                height: 60,
                                onPressed: () {
                                  login(phoneNumber);
                                },
                                duration: 60,
                                text: const Text(
                                  'Resend',
                                  style: TextStyle(
                                      fontSize: 12,
                                      decoration: TextDecoration.underline,
                                      color: Colors.white),
                                ),
                                buttonType: ButtonType.text_button,
                                backgroundColor: Colors.orange,
                              ),
                            ],
                          ),
                          SvgPicture.asset('assets/images/otp.svg')
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: dw,
                              child: SvgPicture.asset(
                                  'assets/images/registerImage.svg'),
                            ),
                          ),
                          SizedBox(
                            height: getPixels(16, dw),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: getPixels(8, dw)),
                            child: Text(
                              'Lets Get\nStarted',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 38,
                                  height: 1.2,
                                  color: Colors.white),
                            ),
                          ),
                          /*   SizedBox(
                            height: dw * 0.04,
                          ), */
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getPixels(8, dw)),
                            child: Text(
                              'Enter your mobile number',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: dw,
                            height: dw * 0.22,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 4, 4, 0),
                                  width: dw * 0.7,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                  child: InternationalPhoneNumberInput(
                                    locale: 'IN',
                                    countries: const ['IN'],
                                    onInputChanged: (PhoneNumber number) {
                                      print(number.phoneNumber);
                                      phoneNumber =
                                          number.phoneNumber.toString();
                                      if (phoneNumber == 13) {
                                        FocusScope.of(context).unfocus();
                                      }
                                    },
                                    textFieldController: phoneNumberController,
                                    onInputValidated: (bool value) {
                                      print(value);
                                    },
                                    onSubmit: () =>
                                        FocusScope.of(context).unfocus(),
                                    selectorConfig: const SelectorConfig(
                                      //  leadingPadding: 8,
                                      trailingSpace: false,

                                      setSelectorButtonAsPrefixIcon: true,
                                      showFlags: false,
                                      selectorType:
                                          PhoneInputSelectorType.BOTTOM_SHEET,
                                    ),
                                    ignoreBlank: false,
                                    selectorButtonOnErrorPadding: 0.0,
                                    autoValidateMode: AutovalidateMode.disabled,
                                    selectorTextStyle: GoogleFonts.poppins(
                                        fontSize: 16,
                                        height: 1.2,
                                        fontWeight: FontWeight.w400),
                                    textStyle: GoogleFonts.roboto(
                                        height: 1.2,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    formatInput: false,
                                    maxLength: 10,
                                    validator: ((p0) => validateMobile(p0)),
                                    keyboardType: TextInputType.number,
                                    /*    const TextInputType.numberWithOptions(
                                            signed: true, decimal: true), */
                                    inputBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
                                    onSaved: (PhoneNumber number) async {},
                                  ),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  margin: EdgeInsets.only(top: 8.0),
                                  child: IconButton(
                                    splashRadius: 0.1,
                                    iconSize: getPixels(36, dw),
                                    onPressed: () async {
                                      if (phoneNumber.length != 13) {
                                        /*       showError(
                                              FirebaseAuthException(
                                                  code:
                                                      'Please Enter a Valid Number'),
                                              context); */
                                        showSnackBar(
                                            'Please Enter a Valid Number',
                                            context);

                                        return;
                                      }
                                      otpSent = true;
                                      setState(() {});
                                      await login(phoneNumber);
                                      setState(() {});
                                    },
                                    icon: Center(
                                        child: Image.asset(
                                      'assets/images/arrow.png',
                                      width: getPixels(17, dw),
                                    )),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
            ),
    );
  }

  AppBar appBar(double dw) {
    return AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 143, 121),
        elevation: 0,
        toolbarHeight: dw * 0.2,
        leadingWidth: dw,
        //centerTitle: true,
        leading: appbarIcon(dw));
  }
}
