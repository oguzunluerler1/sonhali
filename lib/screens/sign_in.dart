import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'musteri/musteri_hesap_olusturma_view.dart';
import 'musteri/musteri_hesap_resetleme_view.dart';
import 'musteri/my_home_page.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
//*build fonksiyonu içinde tanımlayınca klavye açılıp hemen kapanıyordu ve textler kendi kendine siliniyordu. State içine alınca düzeldi.
  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //*Alttaki Form içindeki girilen değerlerin kontrolü için bir tane key tanımlıyoruz.

    return SafeArea(
      child: Scaffold(
//*Klavye ekranı yukarı ittiriyordu. Onun için koydum.
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/signintop.png'),
                ),
              ),
            ),
            Form(
//*Yukarıda tanımladığımız anahtarı Form widgetının key propertisine atıyoruz.
              key: _signInFormKey,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
//*Burada emailvalidator paketi ile kontrol yapıyoruz. Girilen değer null değilse ve email formatına uyuyorsa okey veriyor yoksa hata döndürüyor.
                          if (value != null &&
                              !EmailValidator.validate(value)) {
                            return 'Lütfen Geçerli bir adres giriniz';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.purple,
                          ),
                          hintText: 'Emailinizi giriniz',
                          hintStyle: TextStyle(color: Colors.purple.shade200),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple.shade200)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value != null && value.length < 6) {
                            return 'Şifreniz en az 6 karakter olmalıdır';
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.purple,
                            ),
                            hintStyle: TextStyle(color: Colors.purple.shade200),
                            hintText: 'Şifrenizi giriniz.',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.purple.shade200)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple.shade200, width: 4))),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MusteriHesapResetleme(),
                                ));
                          },
                          child: Text(
                            'Şifremi unuttum.',
                            style: TextStyle(
                                color: Colors.purple,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.purple,
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.4, 40)),
                        onPressed: () async {
                          if (_signInFormKey.currentState!.validate()) {
                            try {
                              final user = await Provider.of<Auth>(context,
                                      listen: false)
                                  .signInWithEmailAndPassword(
                                      _emailController.text,
                                      _passwordController.text);

                              print(user?.uid);

                              if (user != null && !user.emailVerified) {
                                await _showMyDialog();
                                await Provider.of<Auth>(context, listen: false)
                                    .signOut();
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyHomePage(),
                                    ));
                              }
                            } on FirebaseAuthException catch (e) {
                              _showErrorDialog(e.code);
                            } catch (e) {
                              _showErrorDialog(e.toString());
                            }
                          }
                        },
                        child: Text(
                          'Giriş',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 25),
                      //*paket kullanarak istediğim buttonları tanımladım çok da pratik oldu.
                      /* SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: SignInButton(
                          shape: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple.shade200)),
                          Buttons.Google,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ), */
                      OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        MusteriHesapOlusturma())));
                          },
                          child: Text('Yeni Kullanıcı? Hesap Oluştur'))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Image(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/signinbottom.png')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ONAY GEREKİYOR'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Merhaba, lütfen mailinizi kontrol ediniz,'),
                Text('Onay linkini tıklayıp tekrar giriş yapmalısınız.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ANLADIM'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignIn(),
                    ));
              },
            ),
          ],
        );
      },
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
}
