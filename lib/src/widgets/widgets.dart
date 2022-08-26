import 'package:flutter/material.dart';

import '../helpers/enums.dart';

Widget innerWidget(
  context,
  double additionalBottomPadding,
  fabLocation,
  EdgeInsetsGeometry padding,
  List<Widget> childs, [
  BarAnimation barAnimation = BarAnimation.fade,
]) {
  return Padding(
    padding: padding,
    child: ConstrainedBox(
      constraints: BoxConstraints(
          minHeight: kBottomNavigationBarHeight + additionalBottomPadding),
      child: Material(
        type: MaterialType.transparency,
        child: Padding(
          padding: EdgeInsets.only(
              bottom: 0,
              right: fabLocation == StylishBarFabLocation.end ? 72 : 0),
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: _container(childs),
          ),
        ),
      ),
    ),
  );
}

Widget _container(List<Widget> childs) {
  return DefaultTextStyle.merge(
    overflow: TextOverflow.ellipsis,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: childs,
    ),
  );
}
