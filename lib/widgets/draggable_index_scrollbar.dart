import 'package:flutter/material.dart';

class DraggableIndexScrollbar extends StatefulWidget {
  final ScrollController controller;
  final int itemCount;
  final Widget child;
  final bool isSearching;
  final double thumbHeight;
  final double thumbWidth;
  final double trackMargin;

  const DraggableIndexScrollbar({
    super.key,
    required this.controller,
    required this.itemCount,
    required this.child,
    required this.isSearching,
    this.thumbHeight = 56,
    this.thumbWidth = 22,
    this.trackMargin = 0,
  });

  @override
  State<DraggableIndexScrollbar> createState() =>
      _DraggableIndexScrollbarState();
}

class _DraggableIndexScrollbarState extends State<DraggableIndexScrollbar>
    with SingleTickerProviderStateMixin {
  bool _dragging = false;
  bool _visible = false;
  double _thumbTop = 0;
  double _viewportHeight = 0;
  int _hideToken = 0;

  late final AnimationController _scaleController;
  late final Animation<double> _scale;

  double get _trackHeight => _viewportHeight - widget.thumbHeight;

  int get _currentIndex {
    if (!widget.controller.hasClients || widget.itemCount == 0) return 0;
    final max = widget.controller.position.maxScrollExtent;
    if (max <= 0) return 0;
    final fraction = widget.controller.offset / max;
    return (fraction * (widget.itemCount - 1)).round().clamp(
      0,
      widget.itemCount - 1,
    );
  }

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _scale = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _updateThumbFromScroll() {
    if (!widget.controller.hasClients || _viewportHeight == 0) return;
    final max = widget.controller.position.maxScrollExtent;
    final fraction = max <= 0
        ? 0.0
        : (widget.controller.offset / max).clamp(0.0, 1.0);
    setState(() => _thumbTop = fraction * _trackHeight);
  }

  void _showThumb() {
    _hideToken++;
    final token = _hideToken;
    setState(() => _visible = true);
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted && token == _hideToken && !_dragging) {
        setState(() => _visible = false);
      }
    });
  }

  void _onDragStart(DragStartDetails details) {
    setState(() {
      _dragging = true;
      _visible = true;
    });
    _scaleController.forward();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (!widget.controller.hasClients || _trackHeight <= 0) return;
    final newTop = (_thumbTop + details.delta.dy).clamp(0.0, _trackHeight);
    final fraction = newTop / _trackHeight;
    final max = widget.controller.position.maxScrollExtent;
    setState(() => _thumbTop = newTop);
    widget.controller.jumpTo(fraction * max);
  }

  void _onDragEnd(DragEndDetails details) {
    setState(() => _dragging = false);
    _scaleController.reverse();
    _showThumb();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        _viewportHeight = constraints.maxHeight;

        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (!_dragging) _updateThumbFromScroll();
            if (!_dragging) _showThumb();
            return false;
          },
          child: Stack(
            children: [
              widget.child,
              if (widget.itemCount >= 10)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 150),
                  right: widget.trackMargin,
                  top: _thumbTop,
                  child: AnimatedOpacity(
                    opacity: _visible ? 1 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: GestureDetector(
                      onVerticalDragStart: _onDragStart,
                      onVerticalDragUpdate: _onDragUpdate,
                      onVerticalDragEnd: _onDragEnd,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (_dragging && !widget.isSearching)
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${_currentIndex + 101}/${widget.itemCount + 100}',
                                style: TextStyle(
                                  color: theme.colorScheme.onPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ScaleTransition(
                            scale: Tween<double>(
                              begin: 1,
                              end: 1.15,
                            ).animate(_scale),
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: widget.thumbWidth,
                              height: widget.thumbHeight,
                              decoration: BoxDecoration(
                                color: _dragging
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.outline,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    widget.thumbHeight / 2,
                                  ),
                                  bottomLeft: Radius.circular(
                                    widget.thumbHeight / 2,
                                  ),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.15),
                                    blurRadius: 4,
                                    offset: const Offset(-1, 0),
                                  ),
                                ],
                              ),
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.drag_indicator,
                                size: 16,
                                color: _dragging
                                    ? theme.colorScheme.onPrimary
                                    : theme.colorScheme.surface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
