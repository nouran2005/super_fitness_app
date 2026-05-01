import 'package:flutter/material.dart';

class HorizontalWheelPicker extends StatefulWidget {
  final List<int> items;
  final int initialValue;
  final String label;
  final Function(int) onChanged;
  final double selectedFontSize;
  final double unselectedFontSize;
  final double viewportFraction;

  const HorizontalWheelPicker({
    super.key,
    required this.items,
    required this.initialValue,
    required this.label,
    required this.onChanged,
    this.selectedFontSize = 25,
    this.unselectedFontSize = 13,
    this.viewportFraction = 0.17,
  });

  @override
  State<HorizontalWheelPicker> createState() => _HorizontalWheelPickerState();
}

class _HorizontalWheelPickerState extends State<HorizontalWheelPicker> {
  late PageController controller;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.items.indexOf(widget.initialValue);
    controller = PageController(
      viewportFraction: widget.viewportFraction,
      initialPage: currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: controller,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
              widget.onChanged(widget.items[index]);
            },
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final isSelected = index == currentIndex;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.center,
                child: Text(
                  widget.items[index].toString(),
                  style: TextStyle(
                    fontSize: isSelected
                        ? widget.selectedFontSize
                        : widget.unselectedFontSize,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),

          Positioned(
            top: 5,
            child: Text(
              widget.label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14,
              ),
            ),
          ),

          Positioned(
            bottom: 5,
            child: Icon(
              Icons.arrow_drop_up,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
