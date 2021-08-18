import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:growth/routes/routes.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late PageController pageController;
  double pageOffset = 0;
  final currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page!;
      });
      print(pageOffset.truncate());
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var absHeight = MediaQuery.of(context).size.height;
    var absWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Container(
            height: absHeight,
            width: absWidth,
          ),
          SizedBox(
            height: absHeight,
            width: absWidth,
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 8,
                  child: PageView(
                    controller: pageController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (int index) =>
                        currentPageNotifier.value = index,
                    children: <Widget>[
                      Page(
                        title: "World Wide",
                        body:
                            "Our services are open to people from all over the world",
                        imagePath: "assets/images/about.png",
                        offset: pageOffset - 1,
                      ),
                      Page(
                        title: "Secure and Safe",
                        body: "Enjoy secure and safe services",
                        imagePath: "assets/images/get_funded.png",
                        offset: pageOffset - 2,
                      ),
                      Page(
                        title: "Absolutely Reliable",
                        body: "100% tested and trusted online banking",
                        imagePath: "assets/images/choose-us.png",
                        offset: pageOffset - 3,
                      ),
                    ],
                  ),
                ),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextButton(
                            onPressed: pageOffset.truncate() == 2
                                ? null
                                : () {
                                    Navigator.pushNamed(
                                        context, RouteNames.loginScreen);
                                  },
                            child: Text(
                              "Skip all",
                              style: TextStyle(
                                color: pageOffset.truncate() != 2
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int i) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  height: 13,
                                  width: 13,
                                  decoration: BoxDecoration(
                                    color: pageOffset == i
                                        ? Colors.blue
                                        : Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          TextButton(
                            onPressed: pageOffset != 2
                                ? null
                                : () {
                                    Navigator.pushNamed(
                                        context, RouteNames.loginScreen);
                                  },
                            child: Text(
                              "Get started",
                              style: TextStyle(
                                  color: pageOffset == 2
                                      ? Colors.blue
                                      : Colors.grey,
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          )
        ]));
  }
}

class Page extends StatelessWidget {
  final String imagePath;
  final String title;
  final String body;
  final double offset;

  const Page(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.body,
      required this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.09));
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Image.asset(
            imagePath,
            fit: BoxFit.fitWidth,
            height: 400.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
          child: Transform.translate(
            offset: Offset(-100 * gauss, 0),
            child: Opacity(
              opacity: 0.7,
              child: Text(body,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                  )),
            ),
          ),
        )
      ],
    );
  }
}
