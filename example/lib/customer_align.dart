
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class CustomerAlign extends SingleChildRenderObjectWidget {
  final Alignment alignment;

  const CustomerAlign({Key? key, Widget? child, this.alignment = Alignment.topLeft})
      : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CustomerAlignRenderBox(alignment: alignment);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant CustomerAlignRenderBox renderObject) {
    renderObject.alignment = alignment;
  }
}

class CustomerAlignRenderBox extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  Alignment alignment;

  CustomerAlignRenderBox({this.alignment = Alignment.topLeft});

  @override
  void performLayout() {
    if (child == null) {
      size = Size.zero;
    } else {
      size = constraints.constrain(Size.infinite);
      child!.layout(constraints.loosen(), parentUsesSize: true);
      BoxParentData parentData = child!.parentData as BoxParentData;
      parentData.offset = alignment.alongOffset(size - child!.size as Offset);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    if (child != null) {
      BoxParentData parentData = child!.parentData as BoxParentData;
      context.paintChild(child!, offset + parentData.offset);
    }
  }
}
