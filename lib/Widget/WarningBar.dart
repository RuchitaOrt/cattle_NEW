import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class StickyWarningBar extends StatefulWidget {
  final String message;
  final String actionText;
  final VoidCallback onPressed;

  const StickyWarningBar({
    super.key,
    required this.message,
    required this.actionText,
    required this.onPressed,
  });

  @override
  State<StickyWarningBar> createState() => _StickyWarningBarState();
}

class _StickyWarningBarState extends State<StickyWarningBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // from bottom
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Start the animation with delay
    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              color: CattleColors.errorColor,
              border: Border.all(color: CattleColors.errorStrokeColor),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                )
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.error, color: CattleColors.error600Color),
                const SizedBox(width:4),
                Expanded(
                  child: Text(
                    widget.message,
                    style: const TextStyle(color:  CattleColors.error600Color,fontSize: 12),
                  ),
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal*27,
                  height: SizeConfig.blockSizeVertical*5,
                  child: ElevatedButton(
                    onPressed: widget.onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  CattleColors.error600Color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(widget.actionText,style: TextStyle(color: CattleColors.white,fontSize: 12),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

