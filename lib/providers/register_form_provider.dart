import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email    = '';
  String password = '';
  String name     = '';


  bool validateForm() {
  if (formKey.currentState!.validate()) {
    print('Form valid ... Proceeding with registration');
    print('Email: $email');
    print('Password: $password');
    print('Name: $name');
    return true;
  } else {
    print('Form not valid');
    return false;
  }

}
}