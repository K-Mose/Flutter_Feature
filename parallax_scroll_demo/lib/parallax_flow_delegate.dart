import 'package:flutter/material.dart';

class ParallaxFlowDelegate extends FlowDelegate{
  ParallaxFlowDelegate({
    required this.id,
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
    // ScrollPosition이 바뀔 때 마다 다시 그리도록 scrollable.position 전달
  }) : super(repaint: scrollable.position);

  final int id;
  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    // 스크롤되는 화면에서 이미지의 offset을 받아옴
    final listItemOffset = listItemBox.localToGlobal(
      listItemBox.size.centerLeft(Offset.zero),
      ancestor: scrollableBox
    );
    print("$id :: $listItemOffset // ${listItemOffset.dy}");

    // 스크롤 방향인 vertical, viewportDimension은 스크롤링 되는 수직 크기
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction = (listItemOffset.dy / viewportDimension).clamp(0.0, 1);

    // 스크롤 비율로 이미지 스크롤 계산
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // 사진의 정렬을 offset에 맞춰서 변환시킴
    final backgroundSize = (backgroundImageKey.currentContext!.findRenderObject() as RenderBox).size;
    final listItemSize = context.size;
    final childRect = verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // 배경에 이미지를 그림
    context.paintChild(
      0,
      transform: Transform.translate(offset: Offset(0.0, childRect.top)).transform
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
      listItemContext != oldDelegate.listItemContext ||
      backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}