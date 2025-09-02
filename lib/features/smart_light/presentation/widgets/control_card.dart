import 'package:flutter/material.dart';

class ControlCard extends StatelessWidget {
  final String title;
  final Color color;
  final IconData iconData;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget? subtitle;

  const ControlCard({
    super.key,
    required this.title,
    required this.color,
    required this.iconData,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withAlpha(110),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(iconData, color: color, size: 30),
        ),
        subtitle: subtitle,
        title: Text(
          title,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
          activeTrackColor: color,
          inactiveThumbColor: colorScheme.onSurface.withOpacity(0.6),
          inactiveTrackColor: colorScheme.onSurface.withOpacity(0.12),
          trackOutlineColor: MaterialStateProperty.resolveWith<Color?>((
            Set<MaterialState> states,
          ) {
            if (states.contains(MaterialState.selected)) {
              return color.withOpacity(0.8);
            }
            return colorScheme.outline.withOpacity(0.3);
          }),
          trackOutlineWidth: MaterialStateProperty.all(1.5),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
