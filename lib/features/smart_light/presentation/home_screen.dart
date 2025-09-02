import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smartlight/features/smart_light/application/led_controller_provider.dart';
import 'package:flutter_smartlight/features/smart_light/presentation/widgets/chart_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'widgets/brightness_slider.dart';
import 'widgets/control_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ledState = ref.watch(ledControlProvider);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SmartLight',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: ledState.when(
        data: (ledControl) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            child: Column(
              children: [
                const ChartCard(), // Tạm thời comment để tránh lỗi
                const SizedBox(height: 25),
                const BrightnessSlider(),
                const SizedBox(height: 25),

                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      ControlCard(
                        title: 'Light',
                        color: Colors.orange,
                        iconData: Icons.lightbulb,
                        value: ledControl.control.nutNguon == '1',
                        onChanged: (value) => ref
                            .read(ledControllerProvider.notifier)
                            .toggleLight(value),
                      ),
                      Divider(color: Colors.grey.shade800),
                      ControlCard(
                        title: "Brightness Auto",
                        color: Colors.lightGreen,
                        iconData: Icons.sunny,
                        value: ledControl.control.nutTuDongSang == '1',
                        onChanged: (value) => ref
                            .read(ledControllerProvider.notifier)
                            .toggleAutoBrightness(value),
                      ),
                      Divider(color: Colors.grey.shade800),
                      ControlCard(
                        title: "Promodoro",
                        color: Colors.red,
                        iconData: Icons.offline_bolt,
                        value: ledControl.promodoro.isNotifiOn == '1',
                        onChanged: (value) => ref
                            .read(ledControllerProvider.notifier)
                            .togglePromodoro(value),
                        subtitle: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return PromodoroTime(
                                  ref: ref,
                                  timeBreak: int.parse(
                                    ledControl.promodoro.timeBreak,
                                  ),
                                  timeWork: int.parse(
                                    ledControl.promodoro.timeWork,
                                  ),
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text('Work: ${ledControl.promodoro.timeWork}'),
                              SizedBox(width: 10),
                              Text('Break: ${ledControl.promodoro.timeBreak}'),
                            ],
                          ),
                        ),
                      ),
                      Divider(color: Colors.grey.shade800),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),

                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.purple.withAlpha(110),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.color_lens,
                              color: Colors.purple,
                              size: 30,
                            ),
                          ),
                          title: Text(
                            'Color',
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),

                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: ledControl.control.nutDoiMau == '1'
                                    ? 'Yellow'
                                    : 'White',
                                borderRadius: BorderRadius.circular(8),
                                elevation: 8,
                                dropdownColor: colorScheme.surface,
                                icon: const SizedBox.shrink(),
                                style: TextStyle(
                                  color: colorScheme.onSurface,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                items: [
                                  DropdownMenuItem<String>(
                                    value: 'Yellow',
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text('Yellow'),
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'White',
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text('White'),
                                      ],
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value == 'Yellow') {
                                    ref
                                        .read(ledControllerProvider.notifier)
                                        .changeColor(1);
                                  } else if (value == 'White') {
                                    ref
                                        .read(ledControllerProvider.notifier)
                                        .changeColor(0);
                                  }
                                },
                              ),
                            ),
                          ),
                          // subtitle: Text('50%'),
                          // trailing: DropdownButton(items: items, onChanged: onChanged),
                        ),
                      ),

                      // PromodoroCard(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Đang kết nối với Firebase...'),
            ],
          ),
        ),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class PromodoroTime extends StatefulWidget {
  final WidgetRef ref;
  final int timeWork;
  final int timeBreak;
  const PromodoroTime({
    super.key,
    required this.ref,
    required this.timeBreak,
    required this.timeWork,
  });

  @override
  State<PromodoroTime> createState() => _PromodoroTimeState();
}

class _PromodoroTimeState extends State<PromodoroTime> {
  late int _selectedTimeWork;
  late int _selectedTimeBreak;

  @override
  void initState() {
    super.initState();
    _selectedTimeWork = widget.timeWork;
    _selectedTimeBreak = widget.timeBreak;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AlertDialog(
      backgroundColor: colorScheme.secondary,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Work',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 60),
              Text(
                'Break',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberPicker(
                value: _selectedTimeWork,
                minValue: 0,
                maxValue: 100,
                step: 5,
                selectedTextStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedTimeWork = value;
                  });
                },
              ),
              NumberPicker(
                value: _selectedTimeBreak,
                minValue: 0,
                maxValue: 50,
                step: 5,
                selectedTextStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedTimeBreak = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            widget.ref
                .read(ledControllerProvider.notifier)
                .changePromodoro(
                  timeWork: _selectedTimeWork,
                  timeBreak: _selectedTimeBreak,
                );
            Navigator.pop(context);
          },
          child: const Text("Ok"),
        ),
      ],
    );
  }
}
