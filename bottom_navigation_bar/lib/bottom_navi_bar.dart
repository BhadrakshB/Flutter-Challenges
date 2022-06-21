import "package:flutter/material.dart";

// ignore: must_be_immutable
class BottomNaviBar extends StatefulWidget {
  final List<BottomNaviBarItem> items;
  final ValueSetter<int> onTap;
  int selectedIndex = 0;
  final Color backgroundColor;
  final double elevation;
  final double iconSize;

  BottomNaviBar({
    Key? key,
    required this.items,
    required this.onTap,
    this.selectedIndex = 0,
    this.backgroundColor = Colors.blue,
    this.elevation = 15,
    this.iconSize = 25,
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
        padding: const EdgeInsets.all(8.0),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  item: item,
                  isSelected: index == selectedIndex,
                  iconSize: widget.iconSize,
                ),
              );
            }).toList(),
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
  final double iconSize;

  const TileWidget(
      {Key? key,
      required this.item,
      required this.isSelected,
      required this.wrapColor,
      this.selectedIconColor = Colors.white,
      this.unselectedIconColor = Colors.black,
      this.iconSize = 25})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IconThemeData defaultIconTheme = IconThemeData(
      color: isSelected ? selectedIconColor : unselectedIconColor,
      size: iconSize,
    );
    return AnimatedContainer(
      height: 50,
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      width: isSelected ? 130 : 60,
      decoration: isSelected
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: wrapColor,
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: isSelected
            ? [
                IconTheme(
                  data: defaultIconTheme,
                  child: item.icon,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "${item.label}",
                    style: TextStyle(
                        color: isSelected
                            ? selectedIconColor
                            : unselectedIconColor),
                  ),
                )
              ].map((e) => Center(child: e)).toList()
            : [
                item.icon,
              ].map((e) => Center(child: e)).toList(),
      ),
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
