import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Color backgroundColor;
  final Color itemColor;
  final List<CustomBottomNavigationBarItem> children;
  final Function(int) onChange;
  final int currentIndex;

  const CustomBottomNavigationBar({
    Key key,
    this.backgroundColor,
    this.itemColor,
    this.onChange,
    this.currentIndex,
    @required this.children,
  }) : super(key: key);
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  void _changeIndex(int index) {
    if (widget.onChange != null) {
      widget.onChange(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: widget.backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.children.map((item) {
          Color color = item.color ?? widget.itemColor;
          IconData icon = item.icon;
          String label = item.label;
          int index = widget.children.indexOf(item);
          return GestureDetector(
            onTap: () {
              _changeIndex(index);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: widget.currentIndex == index
                  ? MediaQuery.of(context).size.width / widget.children.length +
                      20
                  : 50,
              padding: EdgeInsets.only(left: 10, right: 10),
              margin: EdgeInsets.only(top: 10, bottom: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.currentIndex == index
                    ? color.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    icon,
                    size: 20,
                    color: widget.currentIndex == index
                        ? color
                        : color.withOpacity(0.7),
                  ),
                  widget.currentIndex == index
                      ? Expanded(
                          flex: 2,
                          child: Text(
                            label ?? '',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: widget.currentIndex == index
                                  ? color
                                  : color.withOpacity(0.7),
                              fontWeight: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CustomBottomNavigationBarItem {
  final IconData icon;
  final String label;
  final Color color;

  CustomBottomNavigationBarItem(
      {@required this.icon, @required this.label, @required this.color});
}
