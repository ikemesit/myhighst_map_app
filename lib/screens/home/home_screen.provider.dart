import 'package:hooks_riverpod/hooks_riverpod.dart';

enum SlideUpPanelStatus { opened, snapped, closed }

class SlideUpPanelState extends StateNotifier<SlideUpPanelStatus> {
  SlideUpPanelState() : super(SlideUpPanelStatus.closed);

  void open() => state = SlideUpPanelStatus.opened;

  void close() => state = SlideUpPanelStatus.closed;

  void snap() => state = SlideUpPanelStatus.snapped;
}

final slideUpStateProvider =
    StateNotifierProvider<SlideUpPanelState, SlideUpPanelStatus>(
  (ref) => SlideUpPanelState(),
);

final showDestinationSearchPanelProvider = StateProvider<bool>((ref) => false);

// class ShowDestinationSearchPanelState extends StateNotifier<bool> {
//   ShowDestinationSearchPanelState() : super(false);
// }
//
// final showDestinationSearchPanelProvider =
//     StateNotifierProvider<ShowDestinationSearchPanelState, bool>(
//         (ref) => ShowDestinationSearchPanelState());
