import 'dart:async';
import 'package:flutter/material.dart';

enum SnackbarType { success, error, warning, info }

class CustomSnackbar {
  static final List<_SnackbarRequest> _queue = [];
  static bool _isShowing = false;

  static void show({
    required BuildContext context,
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
    bool topPosition = false,
  }) {
    _queue.add(_SnackbarRequest(
      context: context,
      message: message,
      type: type,
      duration: duration,
      topPosition: topPosition,
    ));

    if (!_isShowing) {
      _showNext();
    }
  }

  static void _showNext() {
    if (_queue.isEmpty) {
      _isShowing = false;
      return;
    }

    _isShowing = true;
    final request = _queue.removeAt(0);

    final colors = _getColors(request.type);

    final overlay = Overlay.of(request.context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => _AnimatedSnackbar(
        message: request.message,
        backgroundGradient: colors['bgGradient']!,
        textColor: colors['text']!,
        icon: colors['icon']!,
        duration: request.duration,
        topPosition: request.topPosition,
        type: request.type,
        onClose: () {
          entry.remove();
          Future.delayed(const Duration(milliseconds: 200), _showNext);
        },
      ),
    );

    overlay.insert(entry);
  }

  static Map<String, dynamic> _getColors(SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return {
          'bgGradient': LinearGradient(
              colors: [Colors.green.shade600, Colors.green.shade400]),
          'text': Colors.white,
          'icon': Icons.check_circle
        };
      case SnackbarType.error:
        return {
          'bgGradient': LinearGradient(
              colors: [Colors.red.shade600, Colors.red.shade400]),
          'text': Colors.white,
          'icon': Icons.error
        };
      case SnackbarType.warning:
        return {
          'bgGradient': LinearGradient(
              colors: [Colors.orange.shade700, Colors.orange.shade500]),
          'text': Colors.white,
          'icon': Icons.warning
        };
      case SnackbarType.info:
      default:
        return {
          'bgGradient': LinearGradient(
              colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade600]),
          'text': Colors.white,
          'icon': Icons.info
        };
    }
  }
}

class _SnackbarRequest {
  final BuildContext context;
  final String message;
  final SnackbarType type;
  final Duration duration;
  final bool topPosition;

  _SnackbarRequest({
    required this.context,
    required this.message,
    required this.type,
    required this.duration,
    required this.topPosition,
  });
}

class _AnimatedSnackbar extends StatefulWidget {
  final String message;
  final LinearGradient backgroundGradient;
  final Color textColor;
  final IconData icon;
  final Duration duration;
  final bool topPosition;
  final SnackbarType type;
  final VoidCallback onClose;

  const _AnimatedSnackbar({
    Key? key,
    required this.message,
    required this.backgroundGradient,
    required this.textColor,
    required this.icon,
    required this.duration,
    required this.topPosition,
    required this.type,
    required this.onClose,
  }) : super(key: key);

  @override
  State<_AnimatedSnackbar> createState() => _AnimatedSnackbarState();
}

class _AnimatedSnackbarState extends State<_AnimatedSnackbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _shakeAnimation;

  int remainingSeconds = 0;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();

    remainingSeconds = widget.duration.inSeconds;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: widget.topPosition ? const Offset(0, -1) : const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    // اهتزاز للخطأ
    _shakeAnimation = Tween<double>(begin: 0, end: 10)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_controller);

    _controller.forward();

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          remainingSeconds--;
        });
      }
      if (remainingSeconds <= 0) {
        _closeSnackbar();
      }
    });
  }

  void _closeSnackbar() {
    countdownTimer?.cancel();
    _controller.reverse().then((_) {
      widget.onClose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.topPosition ? 40 : null,
      bottom: widget.topPosition ? null : 30,
      left: 20,
      right: 20,
      child: GestureDetector(
        onVerticalDragEnd: (_) => _closeSnackbar(),
        child: SlideTransition(
          position: _slideAnimation,
          child: Material(
            color: Colors.transparent,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                double offsetX = 0;
                if (widget.type == SnackbarType.error &&
                    _controller.status == AnimationStatus.completed) {
                  offsetX = _shakeAnimation.value;
                }
                return Transform.translate(
                  offset: Offset(offsetX, 0),
                  child: child,
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: widget.backgroundGradient,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(widget.icon, color: widget.textColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: TextStyle(
                          color: widget.textColor,
                          fontSize: 14,
                        ),
                        softWrap: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "$remainingSeconds",
                      style: TextStyle(
                        color: widget.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _closeSnackbar,
                      child: Icon(
                        Icons.close,
                        color: widget.textColor,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }
}
