import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final bool isFavorite;
  final Function(bool) onFavoriteChanged;
  final double size;

  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onFavoriteChanged,
    this.size = 25,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _isFavorite;
  late double _size;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
    _size = widget.size;
  }

  @override
  void didUpdateWidget(covariant FavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFavorite != widget.isFavorite) {
      _isFavorite = widget.isFavorite;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFavorite = !_isFavorite;
          widget.onFavoriteChanged(_isFavorite);
        });
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Icon(
          key: ValueKey<bool>(_isFavorite),
          Icons.favorite,
          color: (_isFavorite ? const Color(0xFF1ce783) : Colors.white)
              .withValues(alpha: 0.8),
          size: _size,
        ),
      ),
    );
  }
}
