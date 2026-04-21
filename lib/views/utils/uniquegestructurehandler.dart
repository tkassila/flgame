
// Source - https://stackoverflow.com/a/56168334
// Posted by Egor, modified by community. See post 'Timeline' for change history
// Retrieved 2026-03-20, License - CC BY-SA 4.0

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class UniversalTapHandler extends RawGestureDetector {
  UniversalTapHandler({super.key, 
    required GestureTapCallback onTap,
    required Widget child,
  }):
        super(
        gestures: <Type, GestureRecognizerFactory>{
          _UniversalPointerHandler: GestureRecognizerFactoryWithHandlers<_UniversalPointerHandler>(
                () => _UniversalPointerHandler(onTap: onTap),
                (_) {},
          ),
        },
        child: child,
      ) {
    // TODO: implement UniversalTapHandler
    throw UnimplementedError();
  }
}

class _UniversalPointerHandler extends OneSequenceGestureRecognizer {
  _UniversalPointerHandler({
    required this.onTap,
  }): super();

  final GestureTapCallback onTap;

  final _maxDistance = 18; // as in official recognizer by default
  Offset? _startPosition;

  void _reset() {
    _startPosition = null;
  }

  @override
  void addPointer(PointerDownEvent event) {
    _startPosition = event.position;
    startTrackingPointer(event.pointer);
    resolve(GestureDisposition.accepted);
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerUpEvent) {
      stopTrackingPointer(event.pointer);
      if (_startPosition != null) {
        onTap();
      }
    }
    if (event is PointerMoveEvent && _startPosition != null) {
      if ((event.position - _startPosition!).distance > _maxDistance) {
        rejectGesture(event.pointer);
        _reset();
      }
    }
    if (event is PointerCancelEvent || event is PointerExitEvent || event is PointerRemovedEvent) {
      _reset();
    }
  }

  @override
  void resolve(GestureDisposition disposition) {
    if (disposition == GestureDisposition.rejected) {
      _reset();
    }
    super.resolve(disposition);
  }

  @override
  void didStopTrackingLastPointer(int pointer) {}

  @override
  String get debugDescription => "_UniversalPointerHandler: Custom Gesture Recognizer";
}
