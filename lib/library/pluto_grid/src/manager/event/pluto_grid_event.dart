import 'package:accessibility_audit/library/pluto_grid/pluto_grid_plus.dart';

enum PlutoGridEventType {
  normal,
  throttleTrailing,
  throttleLeading,
  debounce;

  bool get isNormal => this == PlutoGridEventType.normal;

  bool get isThrottleTrailing => this == PlutoGridEventType.throttleTrailing;

  bool get isThrottleLeading => this == PlutoGridEventType.throttleLeading;

  bool get isDebounce => this == PlutoGridEventType.debounce;
}

abstract class PlutoGridEvent {
  PlutoGridEvent({
    this.type = PlutoGridEventType.normal,
    this.duration,
  }) : assert(
          type.isNormal || duration != null,
          'If type is normal or type is not normal then duration is required.',
        );

  final PlutoGridEventType type;

  final Duration? duration;

  void handler(PlutoGridStateManager stateManager);
}
