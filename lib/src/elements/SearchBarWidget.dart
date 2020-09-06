import 'package:flutter/material.dart';
import 'package:trip_car_client/generated/i18n.dart';
import 'package:trip_car_client/src/elements/SearchWidget.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(SearchModal());
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: Theme.of(context).focusColor.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 0, left: 0),
              child: Icon(Icons.search, color: Theme.of(context).focusColor),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              S.of(context).search_for_restaurants_or_foods,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .merge(TextStyle(fontSize: 14)),
            )
          ],
        ),
      ),
    );
  }
}
