import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:trip_car_client/generated/i18n.dart';
import 'package:trip_car_client/src/controllers/user_controller.dart';

final RoundedLoadingButtonController _btnControllerSave =
    new RoundedLoadingButtonController();
final _registerPassController = TextEditingController();
final _registerPassController2 = TextEditingController();

void showRestPassDialog(BuildContext context, UserController _con) {
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
                S.of(context).reset,
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),
          children: <Widget>[
            Form(
              key: _con.resetPassFinalFormKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    onSaved: (input) => _con.user.code = input,
                    validator: (input) => input.length < 3 || input.isEmpty
                        ? S.of(context).should_be_more_than_3_letters
                        : null,
                    decoration: InputDecoration(
                      labelText: S.of(context).enter_code,
                      labelStyle: TextStyle(color: Theme.of(context).hintColor),
                      contentPadding: EdgeInsets.all(12),
                      hintText: S.of(context).john_doe,
                      hintStyle: TextStyle(
                          color: Theme.of(context).focusColor.withOpacity(0.7)),
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
                      labelStyle: TextStyle(color: Theme.of(context).hintColor),
                      contentPadding: EdgeInsets.all(12),
                      hintText: S.of(context).eight_digits_at_less,
                      hintStyle: TextStyle(
                          color: Theme.of(context).focusColor.withOpacity(0.7)),
                      prefixIcon: Icon(Icons.lock_outline,
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
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _registerPassController2,
                    obscureText: _con.hidePassword,
                    onSaved: (input) => _con.user.passwordConfirmation = input,
                    validator: (value) {
                      if (value != _registerPassController.text) {
                        return S.of(context).pass_not_matched;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: S.of(context).password2,
                      labelStyle: TextStyle(color: Theme.of(context).hintColor),
                      contentPadding: EdgeInsets.all(12),
                      hintText: S.of(context).eight_digits_at_less,
                      hintStyle: TextStyle(
                          color: Theme.of(context).focusColor.withOpacity(0.7)),
                      prefixIcon: Icon(Icons.lock_outline,
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
                    onPressed: () {
                      _con.restPassFinalStep(_btnControllerSave);
                    },
                    controller: _btnControllerSave,
                    child: Text(
                      S.of(context).submit,
                      style: TextStyle(color: Theme.of(context).hintColor),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(S.of(context).cancel),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
            SizedBox(height: 10),
          ],
        );
      });
}
