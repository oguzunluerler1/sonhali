import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';

class MusteriHesapResetleme extends StatefulWidget {
  MusteriHesapResetleme({Key? key}) : super(key: key);

  @override
  State<MusteriHesapResetleme> createState() => _MusteriHesapResetlemeState();
}

class _MusteriHesapResetlemeState extends State<MusteriHesapResetleme> {
  @override
  Widget build(BuildContext context) {
    final _resetFormKey = GlobalKey<FormState>();
    TextEditingController _emailController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _resetFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Şifre Yenileme', style: TextStyle(fontSize: 25)),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (!EmailValidator.validate(value!)) {
                    return 'Lütfen Geçerli bir adres giriniz';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'E-mail',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_resetFormKey.currentState!.validate()) {
                    try {
                      await Provider.of<Auth>(context, listen: false)
                          .sendPasswordResetEmail(_emailController.text);

                      await _showResetPasswordDialog();

                      Navigator.pop(context);
                    } on FirebaseAuthException catch (e) {
                      _showErrorDialog(e.code);
                    } catch (e) {
                      _showErrorDialog(e.toString());
                    }
                  }
                },
                child: Text('Gönder'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showErrorDialog(String errorText) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('BİR HATA OLUŞTU'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(errorText),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showResetPasswordDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ŞİFRE YENİLEME'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Merhaba, lütfen mailinizi kontrol ediniz,'),
                Text('Linki tıklayarak şifrenizi yenileyiniz.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ANLADIM'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
