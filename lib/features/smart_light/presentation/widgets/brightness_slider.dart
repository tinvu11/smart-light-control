import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smartlight/features/smart_light/application/led_controller_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class BrightnessSlider extends ConsumerWidget {
  const BrightnessSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final ledState = ref.watch(ledControlProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ledState.when(
        data: (ledControl) {
          final isSliderActive =
              ledControl.control.nutNguon == '1' &&
              !(ledControl.control.nutTuDongSang == '1');
          return Row(
            children: [
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: colorScheme.primary,
                    inactiveTrackColor: Colors.grey.shade800,
                    thumbColor: colorScheme.primary,
                    overlayColor: colorScheme.primary.withOpacity(0.1),
                    trackHeight: 8.0,
                  ),
                  child: Slider(
                    padding: EdgeInsets.zero,
                    value: double.parse(ledControl.control.doSangCuaDen),
                    min: 0,
                    max: 100,
                    onChanged: isSliderActive ? (value) {} : null,
                    onChangeEnd: (value) {
                      ref
                          .read(ledControllerProvider.notifier)
                          .changeBrightness(value.toInt());
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${ledControl.control.doSangCuaDen}%',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        },
        loading: () => const SizedBox(),
        error: (e, s) => const Text('Error'),
      ),
    );
  }
}
