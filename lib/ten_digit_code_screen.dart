import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:reside_ease/widgets/bottom_navigation.dart';

class TenDigitCodeScreen extends StatefulWidget {
  const TenDigitCodeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return TenDigitCodeScreenState();
  }
}

class TenDigitCodeScreenState extends State<TenDigitCodeScreen> {
  // create a form key
  final _formKey = GlobalKey<FormState>();

  // create a text editing controller
  final _tenDigitController = TextEditingController();

  // create a focus node
  final _tenDigitFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _tenDigitFocusNode.addListener(() {
      if (_tenDigitFocusNode.hasFocus) {
        _tenDigitController.clear();
      }
    });
  }

  @override
  void dispose() {
    _tenDigitController.dispose();

    // dispose the focus nodes
    _tenDigitFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // create
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 180,
              ),
              const Text(
                'Enter Code',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Enter the security code shared by the administrator',
              ),
              const SizedBox(
                height: 50.0,
              ),
              PinCodeTextField(
                appContext: context,
                length: 10,
                obscureText: false,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  borderWidth: 1,
                  fieldHeight: 35,
                  fieldWidth: 35,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.blue.shade200,
                  activeColor: Colors.black, // color when the field is active
                  // selectedColor:
                  //     Colors.black, // color when the field is selected
                  inactiveColor: Colors.black,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {
                  print(value);
                  setState(
                    () {
                      _tenDigitController.text = value;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 32.0,
              ),
              const SizedBox(),
              OutlinedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // navigate to the home screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ParentWidget(),
                      ),
                    );
                  }
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  side: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
