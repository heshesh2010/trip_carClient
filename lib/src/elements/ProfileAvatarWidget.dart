import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trip_car_client/src/models/user.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final User user;
  ProfileAvatarWidget({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 160,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 135,
                height: 135,
                child: CircleAvatar(
                    backgroundImage: user.media != null
                        ? CachedNetworkImageProvider(user.media.first.thumb)
                        : Image.asset('assets/img/default.png').image),
              ),
            ],
          ),
        ),
        Text(
          user.name,
          style: Theme.of(context).textTheme.headline,
        ),
        Text(
          user.address,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
