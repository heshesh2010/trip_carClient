import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:trip_car_client/generated/i18n.dart';
import 'package:trip_car_client/src/controllers/faq_controller.dart';
import 'package:trip_car_client/src/elements/CircularLoadingWidget.dart';
import 'package:trip_car_client/src/elements/DrawerWidget.dart';
import 'package:trip_car_client/src/elements/FaqItemWidget.dart';

class HelpWidget extends StatefulWidget {
  @override
  _HelpWidgetState createState() => _HelpWidgetState();
}

class _HelpWidgetState extends StateMVC<HelpWidget> {
  FaqController _con;

  _HelpWidgetState() : super(FaqController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return _con.faqs.isEmpty
        ? CircularLoadingWidget(height: 500)
        : DefaultTabController(
            length: _con.faqs.length,
            child: Scaffold(
              key: _con.scaffoldKey,
              drawer: DrawerWidget(),
              appBar: AppBar(
                backgroundColor: Theme.of(context).accentColor,
                elevation: 0,
                centerTitle: true,
                iconTheme: IconThemeData(color: Theme.of(context).hintColor),
                bottom: TabBar(
                  tabs: List.generate(_con.faqs.length, (index) {
                    return Tab(text: _con.faqs.elementAt(index).name ?? '');
                  }),
                  labelColor: Theme.of(context).hintColor,
                  unselectedLabelColor: Theme.of(context).unselectedWidgetColor,

                ),
                title: Text(
                  S.of(context).faq,
                  style: Theme.of(context).textTheme.title.merge(TextStyle(
                      letterSpacing: 1.3, color: Theme.of(context).focusColor)),
                ),
              ),
              body: RefreshIndicator(
                onRefresh: _con.refreshFaqs,
                child: TabBarView(
                  children: List.generate(_con.faqs.length, (index) {
                    return SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: _con.faqs.elementAt(index).faqs.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 15);
                            },
                            itemBuilder: (context, indexFaq) {
                              return FaqItemWidget(
                                  faq: _con.faqs
                                      .elementAt(index)
                                      .faqs
                                      .elementAt(indexFaq));
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
  }
}
