import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:order_client_app/generated/i18n.dart';
import 'package:order_client_app/src/controllers/settings_controller.dart';
import 'package:order_client_app/src/elements/CircularLoadingWidget.dart';
import 'package:order_client_app/src/elements/ProfileSettingsDialog.dart';
import 'package:order_client_app/src/elements/SearchBarWidget.dart';
import 'package:order_client_app/src/helpers/helper.dart';

class SettingsWidget extends StatefulWidget {
  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends StateMVC<SettingsWidget> {
  SettingsController _con;

  _SettingsWidgetState() : super(SettingsController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            S.of(context).settings,
            style: Theme.of(context)
                .textTheme
                .title
                .merge(TextStyle(letterSpacing: 1.3)),
          ),
        ),
        body: _con.user.id == null
            ? CircularLoadingWidget(height: 500)
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 7),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SearchBarWidget(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  _con.user.name,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.display2,
                                ),
                                Text(
                                  _con.user.email,
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),

                          _con.isLoading?
                                SizedBox(
                        width: 55,
                        height: 55,
                        child: RefreshProgressIndicator(),
                      ):
                          SizedBox(
                              width: 55,
                              height: 55,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(300),
                                onTap: () {
                                  _openImagePickerModal(context);
                                },
                                child: 
                                
                                CircleAvatar(
                                  backgroundImage: _con.user.media != null
                                      ? CachedNetworkImageProvider(
                                          _con.user.media.first.thumb)
                                      : Image.asset('assets/img/default.png')
                                          .image,
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.15),
                              offset: Offset(0, 3),
                              blurRadius: 10)
                        ],
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        primary: false,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text(
                              S.of(context).profile_settings,
                              style: Theme.of(context).textTheme.body2,
                            ),
                            trailing: ButtonTheme(
                              padding: EdgeInsets.all(0),
                              minWidth: 50.0,
                              height: 25.0,
                              child: ProfileSettingsDialog(
                                user: _con.user,
                                onChanged: () {
                                  _con.updateUser();
                            
                                    _con.isLoading=true;
                                 
                                },
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: () {},
                            dense: true,
                            title: Text(
                              S.of(context).full_name,
                              style: Theme.of(context).textTheme.body1,
                            ),
                            trailing: Text(
                              _con.user.name,
                              style: TextStyle(
                                  color: Theme.of(context).focusColor),
                            ),
                          ),
                          ListTile(
                            onTap: () {},
                            dense: true,
                            title: Text(
                              S.of(context).email,
                              style: Theme.of(context).textTheme.body1,
                            ),
                            trailing: Text(
                              _con.user.email,
                              style: TextStyle(
                                  color: Theme.of(context).focusColor),
                            ),
                          ),
                          ListTile(
                            onTap: () {},
                            dense: true,
                            title: Text(
                              S.of(context).phone,
                              style: Theme.of(context).textTheme.body1,
                            ),
                            trailing: Text(
                              _con.user.phone,
                              style: TextStyle(
                                  color: Theme.of(context).focusColor),
                            ),
                          ),
                          ListTile(
                            onTap: () {},
                            dense: true,
                            title: Text(
                              S.of(context).address,
                              style: Theme.of(context).textTheme.body1,
                            ),
                            trailing: Text(
                              Helper.limitString(_con.user.address),
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(
                                  color: Theme.of(context).focusColor),
                            ),
                          ),
                          ListTile(
                            onTap: () {},
                            dense: true,
                            title: Text(
                              S.of(context).about,
                              style: Theme.of(context).textTheme.body1,
                            ),
                            trailing: Text(
                              Helper.limitString(_con.user.bio),
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(
                                  color: Theme.of(context).focusColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }

  Future _openImagePickerModal(
    BuildContext context,
  ) async {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context) {
          return Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(40.0),
                    topRight: const Radius.circular(40.0))),
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'اختر صورة',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        //          color: colorStyles["primary"], // button color
                        child: InkWell(
                          splashColor: Colors.red, // inkwell color
                          child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Icon(FontAwesomeIcons.image)),
                          onTap: () {
                            _getImage(context, ImageSource.gallery);
                          },
                        ),
                      ),
                    ),
                    ClipOval(
                      child: Material(
                        //         color: colorStyles["primary"], // button color
                        child: InkWell(
                          splashColor: Colors.red, // inkwell color
                          child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Icon(FontAwesomeIcons.camera)),
                          onTap: () {
                            _getImage(context, ImageSource.camera);
                          },
                        ),
                      ),
                    ),
                    // FlatButton(
                    //   color: Colors.red,
                    //   textColor: flatButtonColor,
                    //   child: Text('Use Camera'),
                    //   onPressed: () {
                    //     _getImage(context, index, ImageSource.camera);
                    //   },
                    // ),
                    // FlatButton(
                    //   color: Colors.red,
                    //   textColor: flatButtonColor,
                    //   child: Text('Use Gallery'),
                    //   onPressed: () {
                    //     _getImage(context, index, ImageSource.gallery);
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void _getImage(BuildContext context, ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _con.user.profileImage64 = image;
        _con.updateUser();
      });
    }
    Navigator.pop(context);
  }
}
