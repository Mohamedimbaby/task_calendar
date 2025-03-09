import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';

class ProductivityChart extends StatefulWidget {
  const ProductivityChart({super.key});

  @override
  State<ProductivityChart> createState() => _ProductivityChartState();
}

class _ProductivityChartState extends State<ProductivityChart> {
  int? _selectedBarIndex;

  @override
  void initState() {
    super.initState();
    // April (index 3) is highlighted by default
    _selectedBarIndex = 3;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final months = [
      localizations.jan,
      localizations.feb,
      localizations.mar,
      localizations.apr,
      localizations.may,
      localizations.jun
    ];
    final values = [0.4, 0.65, 0.25, 0.56, 0.45, 0.35];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < months.length; i++)
                _buildBar(
                  value: values[i],
                  isSelected: i == _selectedBarIndex,
                  index: i,
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: months
              .map((month) => SizedBox(
                    width: 40,
                    child: Text(
                      month,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildBar({
    required double value,
    required bool isSelected,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBarIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (isSelected)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1F2C),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${(value * 100).toInt()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (isSelected) const SizedBox(height: 8),
          Container(
            width: 40,
            height: 180 * value,
            decoration: BoxDecoration(
              color:
                  isSelected ? const Color(0xFF1A1F2C) : AppColors.neutral200,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
