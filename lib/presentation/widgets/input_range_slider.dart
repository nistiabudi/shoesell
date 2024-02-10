import 'package:eshoes_clean_arch/presentation/blocs/filter/filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputRangeSlider extends StatefulWidget {
  final double initMin;
  final double initMax;
  const InputRangeSlider({
    super.key,
    required this.initMax,
    required this.initMin,
  });
  @override
  State<InputRangeSlider> createState() => _InputRangeSlider();
}

class _InputRangeSlider extends State<InputRangeSlider> {
  final double max = 10000;
  final double min = 0;
  late RangeValues _rangeValues;

  @override
  void initState() {
    _rangeValues = RangeValues(widget.initMin, widget.initMax);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant InputRangeSlider oldWidget) {
    _rangeValues = RangeValues(widget.initMin, widget.initMax);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: _rangeValues,
      max: max,
      divisions: 10,
      activeColor: Colors.black87,
      labels: RangeLabels(
        _rangeValues.start.round().toString(),
        _rangeValues.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        if (values.start < values.end) {
          setState(() {
            _rangeValues = values;
            context
                .read<FilterCubit>()
                .updateRange(_rangeValues.start, _rangeValues.end);
          });
        }
      },
    );
  }
}
