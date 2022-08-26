import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/helpers/enums.dart';
import '../model/bubble_item.dart';
import '../widgets/icon_widget.dart';
import '../widgets/label_widget.dart';

class BubbleNavigationTile extends StatelessWidget {
  const BubbleNavigationTile(
    this.item,
    this.opacity,
    this.animation,
    this.iconSize,
    this.unselectedIconColor,
    this.barStyle, {
    Key? key,
    this.onTap,
    this.flex,
    this.selected = false,
    this.indexLabel,
    this.ink = false,
    this.inkColor = Colors.grey,
    this.padding,
    this.fillStyle,
    this.radius,
    this.height,
    this.width,
  }) : super(key: key);

  final BubbleBarItem item;
  final Animation<double> animation;
  final double iconSize;
  final VoidCallback? onTap;
  final double? flex;
  final bool selected;
  final String? indexLabel;
  final double opacity;
  final bool ink;
  final Color? inkColor;
  final Color? unselectedIconColor;
  final EdgeInsets? padding;
  final BubbleBarStyle? barStyle;
  final BubbleFillStyle? fillStyle;
  final double? radius;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    ///Label Widget
    var label = LabelWidget(
      animation: animation,
      item: item,
      color: item.backgroundColor!,
    );

    var outlined = selected && fillStyle == BubbleFillStyle.outlined;
    var fill = selected && fillStyle == BubbleFillStyle.fill;

    return Semantics(
      container: true,
      header: true,
      selected: selected,
      child: Stack(
        children: [
          Padding(
            padding: padding!,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(radius ?? 52),
                left: Radius.circular(radius ?? 52),
              ),
              highlightColor: Colors.transparent,
              splashColor: ink ? inkColor : Colors.transparent,
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(radius ?? 52),
                    left: Radius.circular(radius ?? 52),
                  ),
                  border: Border.all(
                      width: outlined ? 1 : 0,
                      color: item.borderColor!,
                      style: outlined ? BorderStyle.solid : BorderStyle.none),
                  color: fill
                      ? item.backgroundColor!.withOpacity(opacity)
                      : Colors.transparent,
                ),
                child: barStyle == BubbleBarStyle.horizotnal
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        ///Add space around selected item
                        mainAxisAlignment: selected
                            ? MainAxisAlignment.spaceEvenly
                            : MainAxisAlignment.center,
                        children: items(label),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        ///Add space around selected item
                        mainAxisAlignment: selected
                            ? MainAxisAlignment.spaceEvenly
                            : MainAxisAlignment.center,
                        children: items(label),
                      ),
              ),
            ),
          ),
          Semantics(
            label: indexLabel,
          ),
        ],
      ),
    );
  }

  items(label) {
    return [
      const SizedBox.shrink(),
      IconWidget(
        animation: animation,
        iconSize: iconSize,
        selected: selected,
        unselectedIconColor: unselectedIconColor,
        item: item,
      ),
      AnimatedCrossFade(
        alignment: const Alignment(0, 0),
        firstChild: const SizedBox.shrink(),
        secondChild: label,
        duration: const Duration(milliseconds: 250),
        sizeCurve: Curves.fastOutSlowIn,
        firstCurve: Curves.fastOutSlowIn,
        secondCurve: Curves.fastOutSlowIn.flipped,
        crossFadeState:
            selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
    ];
  }
}
