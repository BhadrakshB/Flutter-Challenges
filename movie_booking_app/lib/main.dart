import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, viewportFraction: 0.75);
    backgroundPageController = PageController(
      initialPage: 0,
    );

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  PageController pageController = PageController();
  PageController backgroundPageController = PageController();

  int selectedMovie = 0;
  bool isSelected = false;
  bool flipper = false;

  late StreamController streamController = StreamController();
  late Stream myStream = streamController.stream;
  late AnimationController controller;
  Duration time = const Duration(milliseconds: 500);
  DateTime selectedDate = DateTime.now();

  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: backgroundPageController,
            itemCount: _movies.length,
            itemBuilder: (context, index) {
              return Image.network(
                _movies.elementAt(index).imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    streamController.sink.add(loadingProgress);
                    return Center(
                      child: CircularProgressIndicator(
                          value: loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!),
                    );
                  } else {
                    streamController.sink.add("Loaded");
                    streamController.close;
                    streamController.done;
                    return ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: child);
                  }
                },
              );
            },
          ),
          AnimatedAlign(
            duration: time,
            alignment: Alignment(0, isSelected ? 1 : 0.55),
            child: StreamBuilder(
              stream: myStream,
              builder: (context, snapshot) {
                if (snapshot.data == "Loaded") {
                  return AnimatedContainer(
                      padding: const EdgeInsets.only(top: 0),
                      duration: time,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(isSelected ? 0 : 10),
                      ),
                      height: isSelected ? 700 : 550,
                      width:
                          isSelected ? MediaQuery.of(context).size.width : 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AnimatedCrossFade(
                            duration: time,
                            crossFadeState: isSelected
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            firstChild: const SizedBox(),
                            secondChild: SizedBox(
                              height: 225,
                              width: 200,
                              child: Wrap(
                                children: List.generate(
                                  _movies.elementAt(selectedMovie).totalTickets,
                                  (index) => Container(
                                    margin: const EdgeInsets.all(3),
                                    key: Key(index.toString()),
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              _movies.elementAt(selectedMovie).name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              ),
                            ),
                          ),
                          AnimatedCrossFade(
                            crossFadeState: isSelected
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            duration: time,
                            firstChild: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.location_on),
                                Text(
                                  _movies.elementAt(selectedMovie).theaterName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            secondChild: const SizedBox(),
                          ),
                          AnimatedBuilder(
                            animation: controller,
                            builder: (context, child) {
                              return SizedBox(
                                height: 15 + 170 * (controller.value),
                              );
                            },
                          ),
                          AnimatedCrossFade(
                            crossFadeState: isSelected
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            duration: time,
                            firstChild: SizedBox(
                              height: 150,
                              width: 300,
                              child: CupertinoDatePicker(
                                maximumDate: DateTime(2022, 8, 30),
                                minimumDate: DateTime.now(),
                                use24hFormat: true,
                                dateOrder: DatePickerDateOrder.dmy,
                                onDateTimeChanged: (date) {
                                  selectedDate = date;
                                },
                              ),
                            ),
                            secondChild: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "DATE",
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                      Text(
                                        "${months.elementAt(selectedDate.month - 1)} ${selectedDate.day}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "CINEMA",
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                      Text(
                                        _movies
                                            .elementAt(selectedMovie)
                                            .theaterName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Quantity",
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                      const Text(
                                        '2',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "\u{20B9}${_movies.elementAt(selectedMovie).ticketPrice}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextButton(
                            onPressed: () {
                              if (!isSelected) {
                                setState(() {
                                  isSelected = true;
                                  flipper = true;
                                  pageController =
                                      PageController(viewportFraction: 1);
                                  controller.stop;
                                  controller.forward(from: 0);
                                  log(controller.value.toString());
                                });
                              }
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.pink,
                                minimumSize: Size(
                                    isSelected
                                        ? MediaQuery.of(context).size.width
                                        : 300,
                                    50)),
                            child: Text(
                              isSelected ? 'Pay' : 'Book',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ));
                } else {
                  return const Center();
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            height: 420,
            child: PageView.builder(
              physics: isSelected
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
              controller: pageController,
              itemCount: _movies.length,
              onPageChanged: (value) {
                setState(() {
                  backgroundPageController.jumpToPage(value);
                  selectedMovie = value;
                });
              },
              itemBuilder: (context, index) {
                return imageCard(
                  _movies.elementAt(index).imageUrl,
                );
              },
            ),
          ),
          Positioned(
            top: 30,
            left: 5,
            child: AnimatedOpacity(
              duration: time,
              opacity: isSelected ? 1 : 0,
              child: IconButton(
                onPressed: () => setState(() {
                  isSelected = false;
                  controller.stop();
                  controller.reverse(from: 1);
                  log(controller.value.toString());
                  Future.delayed(
                    time,
                    () {
                      setState(() {
                        flipper = false;
                        pageController = PageController(viewportFraction: 0.75);
                      });
                    },
                  );
                }),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  imageCard(String url) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Transform(
          alignment: Alignment(0, 0 + -0.8 * (controller.value)),
          transform: Matrix4(
            1,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            1,
          )
            ..rotateX((controller.value) * math.pi / 2)
            ..setEntry(3, 2, 0.002),
          child: child),
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: flipper ? 69 : 20, vertical: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SizedBox(
            height: 100,
            child: Image.network(
              url,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class Movie {
  final String name;
  final String theaterName;
  final String imageUrl;
  final DateTime? date;
  final int totalTickets;
  final double ticketPrice;

  Movie({
    this.name = '',
    this.theaterName = '',
    this.imageUrl = '',
    this.date,
    this.totalTickets = 90,
    this.ticketPrice = 60,
  });
}

final List<Movie> _movies = [
  Movie(
    name: 'Avengers Infinity war',
    imageUrl:
        'https://cdna.artstation.com/p/assets/images/images/018/256/764/large/george-britton-infinitywarposterv2.jpg',
    theaterName: 'PVR Cinemas',
  ),
  Movie(
    name: 'Mortal Kombat',
    imageUrl:
        'https://oyster.ignimgs.com/wordpress/stg.ign.com/2021/02/MK_VERT_MAIN_2764x4096_INTL.jpg',
    theaterName: 'Cineplanet',
  ),
  Movie(
    name: 'Godzilla vs Kong',
    imageUrl:
        'https://cdn.flickeringmyth.com/wp-content/uploads/2021/03/Godzilla-vs-Kong-Dolby-600x889.jpg',
    theaterName: 'Cineplanet',
  ),
  Movie(
    name: 'Avatar: The Way of Water',
    imageUrl:
        "https://www.joblo.com/wp-content/uploads/2022/01/avatar-2-poster-400x600.jpg",
    theaterName: 'PVR Cinemas',
  ),
];
