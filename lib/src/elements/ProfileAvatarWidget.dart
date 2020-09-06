import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trip_car_client/src/models/user_entity.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final UserDataUser user;
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
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: user?.image ?? "",
                    imageBuilder: (context, imageProvider) => Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading2.gif',
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          user.username,
          style: Theme.of(context).textTheme.headline,
        ),
        Text(
          user.email,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
