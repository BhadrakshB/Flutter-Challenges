import "package:flutter/material.dart";

// ignore: must_be_immutable
class BottomNaviBar extends StatefulWidget {
  final List<BottomNaviBarItem> items;
  final ValueSetter<int> onTap;
  int selectedIndex = 0;
  final Color backgroundColor;
  final double elevation;
  final double iconSize;
  final bool isReversed;
  final Color selectedIconColor;
  final Color unselectedIconColor;
  final Color selectedLabelColor;
  final Color unselectedLabelColor;

  BottomNaviBar({
    Key? key,
    required this.items,
    required this.onTap,
    required this.isReversed,
    this.selectedIndex = 0,
    this.backgroundColor = Colors.blue,
    this.elevation = 15,
    this.iconSize = 25,
    this.selectedIconColor = Colors.white,
    this.unselectedIconColor = Colors.black,
    this.selectedLabelColor = Colors.white,
    this.unselectedLabelColor = Colors.black,
  }) : super(key: key);

  @override
  State<BottomNaviBar> createState() => _BottomNaviBarState();
}

class _BottomNaviBarState extends State<BottomNaviBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.elevation,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
        ),
        child: Center(
          child: Column(
            children: [
              AnimatedAlign(
                alignment: Alignment(
                  -1 + (2 / (widget.items.length - 1) * selectedIndex),
                  0,
                ),
                duration: const Duration(milliseconds: 250),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.blue),
                  height: 3,
                  width:
                      MediaQuery.of(context).size.width / widget.items.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: widget.items.map((item) {
                    int index = widget.items.indexOf(item);

                    return InkWell(
                      onTap: () {
                        setState(() {
                          widget.onTap(index);
                          selectedIndex = index;
                        });
                      },
                      child: TileWidget(
                        key: Key(index.toString()),
                        wrapColor: Colors.blue,
                        isReversed: widget.isReversed,
                        item: item,
                        isSelected: index == selectedIndex,
                        iconSize: widget.iconSize,
                        selectedIconColor: widget.selectedIconColor,
                        unselectedIconColor: widget.unselectedIconColor,
                        selectedLabelColor: widget.selectedLabelColor,
                        unselectedLabelColor: widget.unselectedLabelColor,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TileWidget extends StatelessWidget {
  final BottomNaviBarItem item;
  final bool isSelected;
  final Color wrapColor;
  final Color selectedIconColor;
  final Color unselectedIconColor;
  final Color selectedLabelColor;
  final Color unselectedLabelColor;
  final double iconSize;
  final bool isReversed;

  const TileWidget(
      {Key? key,
      required this.item,
      required this.isSelected,
      required this.wrapColor,
      required this.isReversed,
      this.selectedIconColor = Colors.white,
      this.unselectedIconColor = Colors.black,
      this.selectedLabelColor = Colors.white,
      this.unselectedLabelColor = Colors.black,
      this.iconSize = 25})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IconThemeData defaultIconTheme = IconThemeData(
      color: isSelected ? selectedIconColor : unselectedIconColor,
      size: iconSize,
    );
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        AnimatedOpacity(
          opacity: isSelected ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 250),
          child: isReversed
              ? IconTheme(data: defaultIconTheme, child: item.icon)
              : Text(
                  item.label ?? "",
                  style: TextStyle(
                      color: isReversed
                          ? selectedLabelColor
                          : unselectedLabelColor),
                ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          top: isSelected ? 0 : 40,
          child: Container(
            child: isReversed
                ? Text(
                    item.label ?? "",
                    style: TextStyle(
                        color: isReversed
                            ? selectedLabelColor
                            : unselectedLabelColor),
                  )
                : IconTheme(
                    data: defaultIconTheme,
                    child: item.icon,
                  ),
          ),
        ),
      ],
    );
  }
}

class BottomNaviBarItem extends BottomNavigationBarItem {
  BottomNaviBarItem({
    required super.icon,
    required super.label,
    this.selectedIconColor = Colors.white,
    this.unselectedIconColor = Colors.black,
  });

  final Color selectedIconColor;
  final Color unselectedIconColor;
}
