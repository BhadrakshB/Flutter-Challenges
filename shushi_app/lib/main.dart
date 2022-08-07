import 'dart:developer' as devtools;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
      debugShowCheckedModeBanner: false,
      initialRoute: 'main-page',
      routes: {
        "main-page": (context) => const MyHomePage(),
        "second-page": (context) => NextPage(),
      },
    );
  }
}

enum Size { small, medium, large }

class NextPage extends StatefulWidget {
  NextPage({Key? key}) : super(key: key);

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    SushiItem currentSushi = args['sushi'];
    String picture = args['picture'];
    var size = MediaQuery.of(context).size;
    var selectedSize = Size.small;

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Icon(Icons.shopping_cart),
          SizedBox(
            width: 10,
          )
        ],
        centerTitle: true,
        title: Text(currentSushi.name),
      ),
      body: Stack(
        children: [
          Align(
            child: Container(
              height: 560,
              width: 330,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  begin: const Alignment(0, -0.5),
                  end: const Alignment(0, 1),
                  colors: [
                    Colors.blueGrey.shade900.withOpacity(0),
                    Colors.blueGrey.shade900,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 400,
            left: 100,
            child: Hero(
              tag: '$currentSushi.name',
              child: Center(
                child: ClipOval(
                  child: Image.network(
                    picture,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.35),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '\u{20B9}${currentSushi.price}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedSize = Size.small;
                        });
                      },
                      child: Text(
                        "S",
                        style: TextStyle(
                            color: selectedSize != Size.small
                                ? Colors.grey
                                : Colors.white),
                      ),
                    ),
                    TextButton(
                      style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedSize = Size.medium;
                        });
                      },
                      child: Text(
                        "M",
                        style: TextStyle(
                            color: selectedSize != Size.medium
                                ? Colors.grey
                                : Colors.white),
                      ),
                    ),
                    TextButton(
                      style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedSize = Size.large;
                        });
                      },
                      child: Text(
                        "L",
                        style: TextStyle(
                            color: selectedSize != Size.large
                                ? Colors.grey
                                : Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    toppingsWidget(toppings.elementAt(0).imgUrl),
                    toppingsWidget(toppings.elementAt(1).imgUrl),
                    toppingsWidget(toppings.elementAt(2).imgUrl),
                    toppingsWidget(toppings.elementAt(3).imgUrl),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.88),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.whatshot,
                color: Color(0xFF151f2b),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding toppingsWidget(String imgUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(5),
        height: 68,
        width: 68,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipOval(
          child: Image.network(
            imgUrl,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
      ),
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    pageController = PageController(
      viewportFraction: 0.5,
    );
    pageController.addListener(() {
      setState(() {
        _fraction = pageController.page ?? 0;
        _complete = _fraction;
        _fraction = _fraction.ceil() - _fraction;
      });
    });
  }

  double _fraction = 0.0;
  double _complete = 0.0;
  int currentIndex = 0;
  Size selectedSize = Size.small;

  PageController pageController = PageController();

  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(),
  );

  late AnimationController selectedSizeController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 500,
    ),
  );

  late AnimationController pageAnimationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 500),
  );

  Stream scrollProvider = Stream.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              child: Container(
                height: 650,
                width: 270,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(600),
                  gradient: LinearGradient(
                    begin: const Alignment(0, -0.5),
                    end: const Alignment(0, 1),
                    colors: [
                      Colors.blueGrey.shade900.withOpacity(0),
                      Colors.blueGrey.shade900,
                    ],
                  ),
                ),
              ),
            ),
            PageView.builder(
              allowImplicitScrolling: true,
              itemCount: sushiMenu.length,
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemBuilder: (context, index) {
                var childKey = GlobalKey();
                String src = sushiMenu.elementAt(index).imageUrl;
                // if (pageController.position.userScrollDirection ==
                //     ScrollDirection.reverse) {
                //   currentIndex = currentIndex < 0 ? index : index + 1;
                // } else if (pageController.position.userScrollDirection ==
                //     ScrollDirection.reverse) {
                //   currentIndex = currentIndex > 0 ? index : index - 1;
                // }

                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    "second-page",
                    arguments: {
                      'sushi': sushiMenu.elementAt(index),
                      'picture': src,
                    },
                  ),
                  child: Hero(
                    tag: '${sushiMenu.elementAt(index).name}',
                    child: Padding(
                      key: childKey,
                      padding: EdgeInsets.only(
                          top: index == currentIndex
                              ? 500 *
                                  (_fraction == 0
                                      ? _fraction
                                      : _fraction < 0.5
                                          ? _fraction
                                          : 1 - _fraction)
                              : index > currentIndex
                                  ? 500 *
                                      (_fraction > 0.5
                                          ? _fraction == 0
                                              ? 1
                                              : _fraction
                                          : 1)
                                  : index < currentIndex
                                      ? 500 *
                                          (_fraction > 0.5 ? 1 : 1 - _fraction)
                                      : 0),
                      child: Center(
                        child: ClipOval(
                          child: Image.network(
                            src,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: const Alignment(0, 0.60),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      sushiMenu.elementAt(currentIndex).name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) {
                        if (index <=
                            sushiMenu.elementAt(currentIndex).rating - 1) {
                          return Row(
                            children: const [
                              Icon(
                                Icons.star_rate_sharp,
                                size: 18,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 2,
                              )
                            ],
                          );
                        } else {
                          return Row(
                            children: const [
                              Icon(
                                Icons.star_rate_sharp,
                                size: 18,
                                color: Colors.white30,
                              ),
                              SizedBox(
                                width: 2,
                              )
                            ],
                          );
                        }
                      },
                    ).toList(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TweenAnimationBuilder(
                    tween: Tween<double>(
                      begin: sushiMenu
                          .elementAt(currentIndex - 1 == -1
                              ? currentIndex
                              : currentIndex - 1)
                          .price,
                      end: sushiMenu.elementAt(currentIndex).price,
                    ),
                    duration: const Duration(milliseconds: 400),
                    builder: (context, double value, child) {
                      return Text(
                        '\u{20B9}${value.ceil()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedSize = Size.small;
                            selectedSizeController.forward(from: 0);
                          });
                        },
                        child: Text(
                          "S",
                          style: TextStyle(
                              color: selectedSize != Size.small
                                  ? Colors.grey
                                  : Colors.white),
                        ),
                      ),
                      TextButton(
                        style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedSize = Size.medium;
                            selectedSizeController.forward(from: 0);
                          });
                        },
                        child: Text(
                          "M",
                          style: TextStyle(
                              color: selectedSize != Size.medium
                                  ? Colors.grey
                                  : Colors.white),
                        ),
                      ),
                      TextButton(
                        style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedSize = Size.large;
                            selectedSizeController.forward(from: 0);
                          });
                        },
                        child: Text(
                          "L",
                          style: TextStyle(
                              color: selectedSize != Size.large
                                  ? Colors.grey
                                  : Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: const Alignment(0, -0.90),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Order Manually",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.shopping_cart,
                            size: 32,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.location_on_sharp,
                          color: Colors.white,
                        ),
                        Text(
                          "Location, Location2",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class SushiItem {
  final String name;
  final int rating;
  final double price;
  final String imageUrl;

  SushiItem(
      {required this.name,
      required this.rating,
      required this.price,
      required this.imageUrl});
}

class Topping {
  final String name;
  final String imgUrl;

  Topping({required this.name, required this.imgUrl});
}

List<Topping> toppings = [
  Topping(
      name: 'Tuna (Maguro)',
      imgUrl:
          'https://images.unsplash.com/photo-1625668742946-4ade4980c01e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
  Topping(
      name: "Salmon Roe (Ikura)",
      imgUrl:
          "https://jw-webmagazine.com/wp-content/uploads/2022/02/Salmon.jpg"),
  Topping(
      name: "Sea Bream",
      imgUrl:
          "https://jw-webmagazine.com/wp-content/uploads/2022/02/Sea-Bream.jpg"),
  Topping(
      name: "Shrimp (Ebi)",
      imgUrl:
          "https://jw-webmagazine.com/wp-content/uploads/2022/02/Shrimp.jpg"),
];

List<SushiItem> sushiMenu = [
  SushiItem(
    name: 'Gunkan Maki2',
    rating: 4,
    price: 699,
    imageUrl:
        'https://images.unsplash.com/photo-1556906918-c3071bd11598?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
  ),
  SushiItem(
    name: 'Surf and Turf Roll',
    rating: 3,
    price: 399,
    imageUrl:
        'https://images.unsplash.com/photo-1616431575978-ad28681d658e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
  ),
  SushiItem(
    name: 'Tempura Roll',
    rating: 5,
    price: 1199,
    imageUrl:
        'https://images.unsplash.com/photo-1625938145312-c18f06f53be0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
  ),
  SushiItem(
    name: 'Rainbow Roll',
    rating: 3,
    price: 899,
    imageUrl:
        'https://images.unsplash.com/photo-1556906905-4f33f9367b6e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
  ),
  SushiItem(
    name: 'California Roll',
    rating: 4,
    price: 1199,
    imageUrl:
        'https://images.unsplash.com/photo-1626202372670-2102fab281db?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
  ),
  SushiItem(
    name: 'Unagi Sushi',
    rating: 5,
    price: 1299,
    imageUrl:
        'https://images.unsplash.com/photo-1616431575939-68c388586e99?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
  ),
  SushiItem(
    name: 'Gunkam Maki',
    rating: 3,
    price: 599,
    imageUrl:
        'https://images.unsplash.com/photo-1622134258105-d98468d64808?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=612&q=80',
  ),
  SushiItem(
    name: 'Surf and Sturf Roll',
    rating: 4,
    price: 999,
    imageUrl:
        'https://images.unsplash.com/photo-1588635655481-e1c4e86a378d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
  ),
  SushiItem(
    name: 'Tempural Roll',
    rating: 2,
    price: 699,
    imageUrl:
        'https://images.unsplash.com/photo-1558540718-b2303795e6e8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
  ),
  SushiItem(
    name: 'Rainbow Roll Surf',
    rating: 4,
    price: 799,
    imageUrl:
        'https://images.unsplash.com/photo-1563200049-063524a8ee59?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
  ),
  SushiItem(
    name: 'California Sushi',
    rating: 5,
    price: 1499,
    imageUrl:
        'https://images.unsplash.com/photo-1558250893-28ec1960069f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
  ),
];
