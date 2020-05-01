import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:order_client_app/generated/i18n.dart';
import 'package:order_client_app/src/controllers/TeddyController.dart';
import 'package:order_client_app/src/controllers/user_controller.dart';
import 'package:order_client_app/src/helpers/input_helper.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

typedef void CaretMoved(Offset globalCaretPosition);
typedef void TextChanged(String text);

// Helper widget to track caret position.
class TrackingTextInputPass extends StatefulWidget {
  TrackingTextInputPass({
    Key key,
    this.onCaretMoved,
    this.onTextChanged,
    this.con,
  }) : super(key: key);
  final CaretMoved onCaretMoved;
  final TextChanged onTextChanged;
  final UserController con;

  @override
  _TrackingTextInputPassState createState() => _TrackingTextInputPassState();
}

class _TrackingTextInputPassState extends State<TrackingTextInputPass> {
  final GlobalKey _fieldKey = GlobalKey();
  final TextEditingController _textController = TextEditingController();
  Timer _debounceTimer;
  @override
  initState() {
    _textController.addListener(() {
      // We debounce the listener as sometimes the caret position is updated after the listener
      // this assures us we get an accurate caret position.
      if (_debounceTimer?.isActive ?? false) _debounceTimer.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 100), () {
        if (_fieldKey.currentContext != null) {
          // Find the render editable in the field.
          final RenderObject fieldBox =
              _fieldKey.currentContext.findRenderObject();
          Offset caretPosition = getCaretPosition(fieldBox);

          if (widget.onCaretMoved != null) {
            widget.onCaretMoved(caretPosition);
          }
        }
      });
      if (widget.onTextChanged != null) {
        widget.onTextChanged(_textController.text);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: _textController,
        keyboardType: TextInputType.text,
        validator: (input) => input.length < 3
            ? S.of(context).should_be_more_than_3_letters
            : null,
        obscureText: widget.con.hidePassword,
        key: _fieldKey,
        textInputAction: TextInputAction.go,
        onSaved: (input) => widget.con.user.password = input,
        decoration: InputDecoration(
          labelText: S.of(context).password,
          labelStyle: TextStyle(color: Theme.of(context).hintColor),
          contentPadding: EdgeInsets.all(12),
          hintText: '••••••••••••',
          hintStyle:
              TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
          prefixIcon:
              Icon(Icons.lock_outline, color: Theme.of(context).hintColor),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                widget.con.hidePassword = !widget.con.hidePassword;
              });
            },
            color: Theme.of(context).focusColor,
            icon: Icon(widget.con.hidePassword
                ? Icons.visibility
                : Icons.visibility_off),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).focusColor.withOpacity(0.2))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).focusColor.withOpacity(0.5))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).focusColor.withOpacity(0.2))),
        ),
      ),
    );
  }
}
