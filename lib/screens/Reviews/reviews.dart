import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:carwash_provider/assets/assets.dart';
import 'package:carwash_provider/components/constants.dart';
import 'package:carwash_provider/language/locale.dart';
import 'package:flutter/material.dart';

class Reviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
        // backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
      child: SafeArea(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              Container(
                color: Theme.of(context).backgroundColor,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      locale.dummyStore1!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 22),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      locale.dummyAddress1!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 80.0,
                          color: Theme.of(context).backgroundColor,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          alignment: Alignment.bottomLeft,
                          height: 80.0,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          color: Theme.of(context).primaryColor,
                          child: Text("Total 98 " + locale.peopleRated!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 12)),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: FadedScaleAnimation(
                            Container(
                              height: 40,
                              width: 90,
                              margin: EdgeInsets.only(left: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                  gradient: gradient,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: Row(
                                  children: [
                                    Text(
                                      locale.dummyRating!,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 23),
                                    ),
                                    Spacer(),
                                    Icon(Icons.star,
                                        size: 20, color: Colors.white)
                                  ],
                                ),
                              ),
                            ),
                            durationInMilliseconds: 400,
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      padding: EdgeInsets.only(bottom: 60),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        List profile = [
                          Assets.layer_10,
                          Assets.layer_12,
                          Assets.layer_13
                        ];
                        return Container(
                          color: Theme.of(context).backgroundColor,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      FadedScaleAnimation(
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundImage:
                                              AssetImage(profile[index]),
                                        ),
                                        durationInMilliseconds: 400,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            locale.dummyName1!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(fontSize: 13),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            locale.dummyDate1!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(fontSize: 10),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  FadedScaleAnimation(
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 13,
                                          color: Colors.orange,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 13,
                                          color: Colors.orange,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 13,
                                          color: Colors.orange,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 13,
                                          color: Colors.orange,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 13,
                                          color: Colors.orange,
                                        )
                                      ],
                                    ),
                                    durationInMilliseconds: 400,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  locale.lorem!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 12,
                                          color: Colors.grey[300],
                                          wordSpacing: 1.5),
                                ),
                              ),
                              Divider()
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
