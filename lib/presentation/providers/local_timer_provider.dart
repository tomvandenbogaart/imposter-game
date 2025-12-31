import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalTimerState {
  final Duration remaining;
  final Duration total;
  final bool isPaused;
  final bool isRunning;

  const LocalTimerState({
    this.remaining = Duration.zero,
    this.total = Duration.zero,
    this.isPaused = false,
    this.isRunning = false,
  });

  LocalTimerState copyWith({
    Duration? remaining,
    Duration? total,
    bool? isPaused,
    bool? isRunning,
  }) {
    return LocalTimerState(
      remaining: remaining ?? this.remaining,
      total: total ?? this.total,
      isPaused: isPaused ?? this.isPaused,
      isRunning: isRunning ?? this.isRunning,
    );
  }

  double get progress {
    if (total.inSeconds == 0) return 0;
    return remaining.inSeconds / total.inSeconds;
  }

  bool get isExpired => isRunning && remaining.inSeconds <= 0;

  String get formattedTime {
    final minutes = remaining.inMinutes;
    final seconds = remaining.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

class LocalTimerNotifier extends StateNotifier<LocalTimerState> {
  Timer? _timer;
  Duration _pausedRemaining = Duration.zero;

  LocalTimerNotifier() : super(const LocalTimerState());

  void startTimer(int durationSeconds) {
    _timer?.cancel();
    final total = Duration(seconds: durationSeconds);
    state = LocalTimerState(
      remaining: total,
      total: total,
      isPaused: false,
      isRunning: true,
    );
    _startTicking();
  }

  void _startTicking() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!state.isPaused && state.remaining.inSeconds > 0) {
        state = state.copyWith(
          remaining: Duration(seconds: state.remaining.inSeconds - 1),
        );
      }
      if (state.remaining.inSeconds <= 0) {
        _timer?.cancel();
      }
    });
  }

  void pauseTimer() {
    if (!state.isRunning || state.isPaused) return;
    _pausedRemaining = state.remaining;
    state = state.copyWith(isPaused: true);
  }

  void resumeTimer() {
    if (!state.isRunning || !state.isPaused) return;
    state = state.copyWith(
      isPaused: false,
      remaining: _pausedRemaining,
    );
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    state = const LocalTimerState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final localTimerProvider =
    StateNotifierProvider<LocalTimerNotifier, LocalTimerState>((ref) {
  return LocalTimerNotifier();
});
