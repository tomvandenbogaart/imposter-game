import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class PlayerNameInput extends StatefulWidget {
  final int index;
  final String name;
  final ValueChanged<String> onChanged;
  final VoidCallback? onRemove;
  final bool canRemove;
  final bool showDragHandle;

  const PlayerNameInput({
    super.key,
    required this.index,
    required this.name,
    required this.onChanged,
    this.onRemove,
    this.canRemove = true,
    this.showDragHandle = true,
  });

  @override
  State<PlayerNameInput> createState() => _PlayerNameInputState();
}

class _PlayerNameInputState extends State<PlayerNameInput> {
  late TextEditingController _controller;
  bool _hasBeenEdited = false;

  @override
  void initState() {
    super.initState();
    // Check if name is default "Player X" format
    final isDefaultName = widget.name == 'Player ${widget.index + 1}';
    _controller = TextEditingController(text: isDefaultName ? '' : widget.name);
    _hasBeenEdited = !isDefaultName && widget.name.isNotEmpty;
  }

  @override
  void didUpdateWidget(PlayerNameInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only update if the name changed externally and wasn't edited by user
    if (oldWidget.name != widget.name && !_hasBeenEdited) {
      final isDefaultName = widget.name == 'Player ${widget.index + 1}';
      _controller.text = isDefaultName ? '' : widget.name;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            if (widget.showDragHandle) ...[
              ReorderableDragStartListener(
                index: widget.index,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: const Icon(
                    Icons.drag_handle,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ] else ...[
              const SizedBox(width: 16),
            ],
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '${widget.index + 1}',
                  style: AppTypography.buttonSmall.copyWith(
                    color: AppColors.background,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  _hasBeenEdited = true;
                  // If empty, use default name for storage
                  final nameToStore = value.isEmpty
                      ? 'Player ${widget.index + 1}'
                      : value;
                  widget.onChanged(nameToStore);
                },
                style: AppTypography.playerName,
                cursorColor: AppColors.cyan,
                decoration: InputDecoration(
                  hintText: 'Player ${widget.index + 1}',
                  hintStyle: AppTypography.playerName.copyWith(
                    color: AppColors.textMuted,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
                textCapitalization: TextCapitalization.words,
                maxLength: 20,
                buildCounter: (context,
                        {required currentLength,
                        required isFocused,
                        maxLength}) =>
                    null,
              ),
            ),
            if (widget.canRemove && widget.onRemove != null)
              IconButton(
                onPressed: widget.onRemove,
                icon: const Icon(
                  Icons.close,
                  color: AppColors.textMuted,
                  size: 20,
                ),
              )
            else
              const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
