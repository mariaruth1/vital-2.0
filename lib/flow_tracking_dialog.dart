import 'package:flutter/material.dart';

class FlowTrackingDialog extends StatefulWidget {
  final DateTime selectedDate;

  const FlowTrackingDialog({super.key, required this.selectedDate});

  @override
  State<FlowTrackingDialog> createState() => _FlowTrackingDialogState();
}

class _FlowTrackingDialogState extends State<FlowTrackingDialog> {
  int? selectedFlow;

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        MaterialLocalizations.of(context).formatShortDate(widget.selectedDate);

    return AlertDialog(
      backgroundColor: Colors.indigo.shade200,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(formattedDate,
              style: TextStyle(fontSize: 18, color: Colors.black54)),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close)),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: const Text(
              'Period:',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFlowOption(0, 12, Colors.red.shade300, 'Spotting'),
              _buildFlowOption(1, 16, Colors.red.shade400, 'Light'),
              _buildFlowOption(2, 20, Colors.red.shade600, 'Medium'),
              _buildFlowOption(3, 24, Colors.red.shade900, 'Heavy'),
            ],
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: selectedFlow != null
                    ? () {
                        Navigator.of(context).pop(selectedFlow);
                      }
                    : null, // Disable button if no selection is made
                child: const Text('Select'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFlowOption(int value, double size, Color colour, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFlow = value;
        });
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: selectedFlow == value ? Colors.white : Colors.indigo.shade100,
            child: Icon(
              Icons.water_drop,
              color: colour,
              size: size,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
                color: selectedFlow == value ? Colors.black87 : Colors.black26,
                fontWeight: FontWeight.w600,
                fontSize: 10),
          ),
        ],
      ),
    );
  }
}
