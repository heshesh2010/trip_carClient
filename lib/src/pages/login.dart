import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/config/app_config.dart' as config;
import 'package:order_client_app/generated/i18n.dart';
import 'package:order_client_app/src/controllers/TeddyController.dart';
import 'package:order_client_app/src/controllers/user_controller.dart';
import 'package:order_client_app/src/elements/TrackingTextInputEmail.dart';
import 'package:order_client_app/src/elements/TrackingTextInputPass.dart';
import 'package:order_client_app/src/repository/user_repository.dart'
    as userRepo;
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends StateMVC<LoginWidget> {
  UserController con;
  String animationType = "idle";
  final passwordController = TextEditingController();
  TeddyController _teddyController;
  GlobalKey<FormState> _resetPassFirstFormKey = new GlobalKey<FormState>();

  final RoundedLoadingButtonController _btnControllerSave =
      new RoundedLoadingButtonController();
  final RoundedLoadingButtonController _btnControllerLogin =
      new RoundedLoadingButtonController();

  _LoginWidgetState() : super(UserController()) {
    con = controller;
  }
  @override
  void initState() {
    super.initState();
    if (userRepo.currentUser?.apiToken != null) {
      Navigator.of(context).pushReplacementNamed('Pages', arguments: 2);
    }
    this.initDynamicLinks();

    _teddyController = TeddyController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        key: con.scaffoldKey,
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Positioned(
              top: config.App(context).appHeight(10),
              child: Container(
                width: config.App(context).appWidth(84),
                height: config.App(context).appHeight(80),
                child: Text(
                  S.of(context).login,
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .merge(TextStyle(color: Theme.of(context).focusColor)),
                ),
              ),
            ),
            Positioned(
              top: 37,
              child: Center(
                child: Container(
                  height: 250,
                  width: 250,
                  //      padding: const EdgeInsets.only(left: 30.0, right:30.0),
                  child: FlareActor(
                    "assets/flare/Teddy.flr",
                    shouldClip: false,
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.contain,
                    controller: _teddyController,
                  ),
                ),
              ),
            ),
            Positioned(
              top: config.App(context).appHeight(40),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 50,
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                      )
                    ]),
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 27),
                width: config.App(context).appWidth(88),
//              height: config.App(context).appHeight(55),
                child: Form(
                  key: con.loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TrackingTextInputEmail(
                        onCaretMoved: (Offset caret) {
                          _teddyController.lookAt(caret);
                        },
                        con: con,
                      ),
                      TrackingTextInputPass(
                        onCaretMoved: (Offset caret) {
                          _teddyController.coverEyes(caret != null);
                          _teddyController.lookAt(null);
                        },
                        onTextChanged: (String value) {
                          _teddyController.setPassword(value);
                        },
                        con: con,
                      ),
                      RoundedLoadingButton(
                        child: Text(
                          S.of(context).login,
                          style: TextStyle(color: Theme.of(context).hintColor),
                        ),
                        controller: _btnControllerLogin,
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          _btnControllerLogin.stop();

                          con.login(_teddyController, _btnControllerLogin);
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      showDialogBox(context);
                    },
                    textColor: Theme.of(context).hintColor,
                    child: Text(S.of(context).i_forgot_password),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('SignUp');
                    },
                    textColor: Theme.of(context).hintColor,
                    child: Text(S.of(context).i_dont_have_an_account),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showDialogBox(BuildContext context, {Null Function() onChanged}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            title: Row(
              children: <Widget>[
                Icon(Icons.person),
                SizedBox(width: 10),
                Text(
                  'استرجاع كلمه المرور',
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),
            children: <Widget>[
              Form(
                key: _resetPassFirstFormKey,
                child: Column(
                  children: <Widget>[
                    new TextFormField(
                      style: TextStyle(color: Theme.of(context).hintColor),
                      keyboardType: TextInputType.emailAddress,
                      decoration: getInputDecoration(
                          hintText: S.of(context).email,
                          labelText: S.of(context).email),
                      validator: (input) => input.trim().length < 3
                          ? S.of(context).should_be_more_than_3_letters
                          : null,
                      onSaved: (input) => con.user.email = input,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RoundedLoadingButton(
                      color: Theme.of(context).accentColor,
                      onPressed: _submit,
                      controller: _btnControllerSave,
                      child: Text(
                        'حفظ',
                        style: TextStyle(color: Theme.of(context).hintColor),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('الغاء'),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
              SizedBox(height: 10),
            ],
          );
        });
  }

  InputDecoration getInputDecoration({String hintText, String labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.bodyText2.merge(
            TextStyle(color: Theme.of(context).focusColor),
          ),
      enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).hintColor)),
      labelStyle: Theme.of(context).textTheme.bodyText2.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
    );
  }

  void _submit() {
    if (_resetPassFirstFormKey.currentState.validate()) {
      _resetPassFirstFormKey.currentState.save();
      con.restPassFirstStep(con.user);
      Navigator.pop(context);
    }
  }

  void initDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      log('linkdata: $deepLink.path');
      FlushbarHelper.createError(message: deepLink.toString()).show(context);

      //   Navigator.pushNamed(context, deepLink.path);
    }

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        //    Navigator.pushNamed(context, deepLink.path);
        FlushbarHelper.createError(message: deepLink.toString()).show(context);
        log('linkdata: $deepLink.path');
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      log('onLinkError: $deepLink.path');

      print(e.message);
    });
  }
}
