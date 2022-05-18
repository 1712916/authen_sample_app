import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final List<String> children;
  final Function(int)? onChange;

  CustomSwitch({Key? key, required this.children, this.onChange}) : assert(children.length == 2);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  int _currentIndex = 0;
  double? _currentWidth = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      //todo: need handle rotate phone :3
      _currentWidth = (context.size!.width) / 2;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodyText2;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: List.generate(
            2,
                (index) => Expanded(
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.children[index],
                    style: textTheme?.copyWith(
                      color: _currentIndex == index ? Colors.white : Color(0XFF666666),
                    ),
                  ),
                ),
                onTap: () {
                  _currentIndex = index;
                  setState(() {});
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 5,
              decoration: const BoxDecoration(
                color: Color(0XFF666666),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(left: _currentIndex * (_currentWidth ?? 0)),
              width: _currentWidth,
              height: 5,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              onEnd: () {
                widget.onChange?.call(_currentIndex);
              },
            ),
          ],
        ),
      ],
    );
  }
}
