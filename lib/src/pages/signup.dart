import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:trip_car_client/generated/i18n.dart';
import 'package:trip_car_client/src/controllers/user_controller.dart';
import 'package:trip_car_client/src/elements/showTosDialog.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends StateMVC<SignUpWidget> {
  _SignUpWidgetState() : super(UserController()) {
    _con = controller;
  }

  bool _agreedToTOS = true;
  UserController _con;
  final _controller = TextEditingController();
  final _registerPassController = TextEditingController();
  final _registerPassController2 = TextEditingController();
  final RoundedLoadingButtonController _btnControllerSave =
      new RoundedLoadingButtonController();

  FocusNode _focusNode1 = new FocusNode();
  FocusNode _focusNode2 = new FocusNode();
  FocusNode _focusNode3 = new FocusNode();
  FocusNode _focusNode4 = new FocusNode();
  FocusNode _focusNode5 = new FocusNode();
  FocusNode _focusNode6 = new FocusNode();

  final ScrollController listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    listScrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    FocusScope.of(context).requestFocus();
  }

  @override
  void dispose() {
    // other dispose methods
    _controller.dispose();
    _registerPassController.dispose();
    _registerPassController2.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
    _focusNode6.dispose();

    super.dispose();
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _submit() {
    _con.register(_btnControllerSave);
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Theme.of(context).focusColor),
          onPressed: () => Navigator.of(context).pushNamed('Login'),
        ),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).register,
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      key: _con.scaffoldKey,
      body: SingleChildScrollView(
        controller: listScrollController,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Form(
                key: _con.signUpFormKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      onSaved: (input) => _con.user.name = input,
                      validator: (input) => input.length < 3 || input.isEmpty
                          ? S.of(context).should_be_more_than_3_letters
                          : null,
                      decoration: InputDecoration(
                        labelText: S.of(context).nick_name,
                        labelStyle:
                            TextStyle(color: Theme.of(context).hintColor),
                        contentPadding: EdgeInsets.all(12),
                        hintText: S.of(context).john_doe,
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.person_outline,
                            color: Theme.of(context).hintColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.5))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                      ),
                      focusNode: _focusNode1,
                      onFieldSubmitted: (term) {
                        listScrollController.jumpTo(
                            listScrollController.position.maxScrollExtent);
                        _focusNode1.unfocus();
                        FocusScope.of(context).requestFocus(_focusNode2);
                      },
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      onSaved: (input) => _con.user.name = input,
                      validator: (input) => input.length < 3 || input.isEmpty
                          ? S.of(context).should_be_more_than_3_letters
                          : null,
                      decoration: InputDecoration(
                        labelText: S.of(context).full_name,
                        labelStyle:
                            TextStyle(color: Theme.of(context).hintColor),
                        contentPadding: EdgeInsets.all(12),
                        hintText: S.of(context).john_doe,
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.person_outline,
                            color: Theme.of(context).hintColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.5))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                      ),
                      focusNode: _focusNode2,
                      onFieldSubmitted: (term) {
                        listScrollController.jumpTo(
                            listScrollController.position.maxScrollExtent);
                        _focusNode2.unfocus();
                        FocusScope.of(context).requestFocus(_focusNode3);
                      },
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      onSaved: (input) => _con.user.mobile = input,
                      validator: (input) => input.length < 3
                          ? S.of(context).should_be_more_than_3_letters
                          : null,
                      decoration: InputDecoration(
                        labelText: S.of(context).mobile,
                        labelStyle:
                            TextStyle(color: Theme.of(context).hintColor),
                        contentPadding: EdgeInsets.all(12),
                        hintText: "0591111074",
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.phone_android,
                            color: Theme.of(context).hintColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.5))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                      ),
                      focusNode: _focusNode3,
                      onFieldSubmitted: (term) {
                        listScrollController.jumpTo(
                            listScrollController.position.maxScrollExtent);
                        _focusNode3.unfocus();
                        FocusScope.of(context).requestFocus(_focusNode4);
                      },
                    ),

                    SizedBox(height: 30),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (input) => _con.user.email = input,
                      validator: (input) => !input.contains('@')
                          ? S.of(context).should_be_a_valid_email
                          : null,
                      decoration: InputDecoration(
                        labelText: S.of(context).email,
                        labelStyle:
                            TextStyle(color: Theme.of(context).hintColor),
                        contentPadding: EdgeInsets.all(12),
                        hintText: 'name@gmail.com',
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.alternate_email,
                            color: Theme.of(context).hintColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.5))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                      ),
                      focusNode: _focusNode4,
                      onFieldSubmitted: (term) {
                        listScrollController.jumpTo(
                            listScrollController.position.maxScrollExtent);
                        _focusNode4.unfocus();
                        FocusScope.of(context).requestFocus(_focusNode5);
                      },
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _registerPassController,
                      obscureText: _con.hidePassword,
                      onSaved: (input) => _con.user.password = input,
                      validator: (input) => input.length < 6
                          ? S.of(context).should_be_more_than_6_letters
                          : null,
                      decoration: InputDecoration(
                        labelText: S.of(context).password,
                        labelStyle:
                            TextStyle(color: Theme.of(context).hintColor),
                        contentPadding: EdgeInsets.all(12),
                        hintText: 'ادخل كلمه المرور 6 خانات على الاقل ',
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.lock_outline,
                            color: Theme.of(context).hintColor),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _con.hidePassword = !_con.hidePassword;
                            });
                          },
                          color: Theme.of(context).focusColor,
                          icon: Icon(_con.hidePassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.5))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                      ),
                      focusNode: _focusNode5,
                      onFieldSubmitted: (term) {
                        listScrollController.jumpTo(
                            listScrollController.position.maxScrollExtent);
                        _focusNode5.unfocus();
                        FocusScope.of(context).requestFocus(_focusNode6);
                      },
                    ),

                    SizedBox(height: 30),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _registerPassController2,
                      obscureText: _con.hidePassword,
                      onSaved: (input) => _con.user.password = input,
                      validator: (value) {
                        if (value != _registerPassController.text) {
                          return S.of(context).pass_not_matched;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: S.of(context).password2,
                        labelStyle:
                            TextStyle(color: Theme.of(context).hintColor),
                        contentPadding: EdgeInsets.all(12),
                        hintText: ' 6 خانات على الاقل ',
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7)),
                        prefixIcon: Icon(Icons.lock_outline,
                            color: Theme.of(context).hintColor),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _con.hidePassword = !_con.hidePassword;
                            });
                          },
                          color: Theme.of(context).focusColor,
                          icon: Icon(_con.hidePassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.5))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            checkColor: Theme.of(context).hintColor,
                            activeColor: Theme.of(context).accentColor,
                            value: _agreedToTOS,
                            onChanged: _setAgreedToTOS,
                          ),
                          GestureDetector(
                              onTap: () => _setAgreedToTOS(!_agreedToTOS),
                              child: GestureDetector(
                                  child: Text(S.of(context).terms_approve,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Theme.of(context).hintColor)),
                                  onTap: () {
                                    showTosDialog(context, _con);
                                  })),
                        ],
                      ),
                    ),

                    RoundedLoadingButton(
                      controller: _btnControllerSave,
                      child: Text(
                        S.of(context).register,
                        style: TextStyle(color: Theme.of(context).hintColor),
                      ),
                      color: Theme.of(context).accentColor,
                      onPressed: _submittable()
                          ? _submit
                          : () {
                              _btnControllerSave.stop();
                              FlushbarHelper.createError(
                                      message: "يجب تعبئة كل البيانات")
                                  .show(context);
                            },
                    ),
                    SizedBox(height: 10),

//
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
