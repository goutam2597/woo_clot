import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final bool clearOnSubmitted;
  const SearchBarWidget({
    super.key,
    this.onSubmitted,
    this.onChanged,
    this.clearOnSubmitted = false,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _controller,
        onSubmitted: (v) {
          widget.onSubmitted?.call(v);
          if (widget.clearOnSubmitted) {
            _controller.clear();
          }
        },
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: 'Search any Product',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: const Icon(Icons.camera_alt),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
