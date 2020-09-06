import 'dart:core';

import 'package:flutter/material.dart';

class App {
  BuildContext _context;
  double _height;
  double _width;
  double _heightPadding;
  double _widthPadding;

  App(_context) {
    this._context = _context;
    MediaQueryData _queryData = MediaQuery.of(this._context);
    _height = _queryData.size.height / 100.0;
    _width = _queryData.size.width / 100.0;
    _heightPadding = _height -
        ((_queryData.padding.top + _queryData.padding.bottom) / 100.0);
    _widthPadding =
        _width - (_queryData.padding.left + _queryData.padding.right) / 100.0;
  }

  double appHeight(double v) {
    return _height * v;
  }

  double appWidth(double v) {
    return _width * v;
  }

  double appVerticalPadding(double v) {
    return _heightPadding * v;
  }

  double appHorizontalPadding(double v) {
    return _widthPadding * v;
  }
}

class AppColors {
//  Color _mainColor = Color(0xFFFF4E6A);
  Color _mainColor = Color(0xFFf5ed04);
  Color _mainDarkColor = Color(0xFF121212);

  Color _secondColor = Color(0xFF121212);
  Color _secondDarkColor = Color(0xFFffffff);

  Color _accentColor = Color(0xFF121212);
  Color _accentDarkColor = Color(0xFFf5ed04);

  Color _nonActiveColorLight = Color(0xFF757575);
  Color _nonActiveColorDark = Color(0xFF121212);

  Color _shimmerLight = Colors.grey.shade100;
  Color _shimmerDark = Colors.grey.shade600;

  Color _greenLight = Colors.green.shade500;
  Color _greenDark = Color(0xFF757575);

  Color _blueLight = Colors.blue.shade500;
  Color _blueDark = Color(0xFF757575);
  Color mainColor(double opacity) {
    return this._mainColor.withOpacity(opacity);
  }

  Color secondColor(double opacity) {
    return this._secondColor.withOpacity(opacity);
  }

  Color accentColor(double opacity) {
    return this._accentColor.withOpacity(opacity);
  }

  Color mainDarkColor(double opacity) {
    return this._mainDarkColor.withOpacity(opacity);
  }

  Color secondDarkColor(double opacity) {
    return this._secondDarkColor.withOpacity(opacity);
  }

  Color accentDarkColor(double opacity) {
    return this._accentDarkColor.withOpacity(opacity);
  }

  Color nonActiveColorLight(double opacity) {
    return _nonActiveColorLight.withOpacity(opacity);
  }

  Color nonActiveColorDark(double opacity) {
    return _nonActiveColorDark.withOpacity(opacity);
  }

  Color shimmerLight(double opacity) {
    return _shimmerLight.withOpacity(opacity);
  }

  Color shimmerDark(double opacity) {
    return _shimmerDark.withOpacity(opacity);
  }

  Color greenDark(double opacity) {
    return _greenDark.withOpacity(opacity);
  }

  Color greenLight(double opacity) {
    return _greenLight.withOpacity(opacity);
  }

  Color blueDark(double opacity) {
    return _blueDark.withOpacity(opacity);
  }

  Color blueLight(double opacity) {
    return _blueLight.withOpacity(opacity);
  }
}
