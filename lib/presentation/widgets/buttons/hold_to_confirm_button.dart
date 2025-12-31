import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class HoldToConfirmButton extends StatefulWidget {
  final String label;
  final Duration holdDuration;
  final VoidCallback onConfirmed;
  final bool isEnabled;
  final bool hapticFeedback;

  const HoldToConfirmButton({
    super.key,
    required this.label,
    required this.onConfirmed,
    this.holdDuration = const Duration(milliseconds: 1000),
    this.isEnabled = true,
    this.hapticFeedback = true,
  });

  @override
  State<HoldToConfirmButton> createState() => _HoldToConfirmButtonState();
}

class _HoldToConfirmButtonState extends State<HoldToConfirmButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHolding = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.holdDuration,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.hapticFeedback) {
          HapticFeedback.heavyImpact();
        }
        widget.onConfirmed();
        _controller.reset();
        setState(() => _isHolding = false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPointerDown(PointerDownEvent event) {
    if (!widget.isEnabled) return;
    setState(() => _isHolding = true);
    _controller.forward();
  }

  void _onPointerUp(PointerUpEvent event) {
    if (!_isHolding) return;
    _controller.reset();
    setState(() => _isHolding = false);
  }

  void _onPointerCancel(PointerCancelEvent event) {
    if (!_isHolding) return;
    _controller.reset();
    setState(() => _isHolding = false);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: 64,
            decoration: BoxDecoration(
              gradient: widget.isEnabled
                  ? AppColors.primaryGradient
                  : null,
              color: widget.isEnabled ? null : AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              boxShadow: widget.isEnabled && _isHolding
                  ? [
                      BoxShadow(
                        color: AppColors.orange.withValues(alpha: 0.6),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : widget.isEnabled
                      ? [
                          BoxShadow(
                            color: AppColors.orange.withValues(alpha: 0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
            ),
            child: Stack(
              children: [
                // Progress overlay
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          _controller.value,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                ),
                // Label
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_isHolding) ...[
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            value: _controller.value,
                            strokeWidth: 2,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.background,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Text(
                        _isHolding ? 'Hold...' : widget.label,
                        style: AppTypography.button.copyWith(
                          color: widget.isEnabled
                              ? AppColors.background
                              : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
