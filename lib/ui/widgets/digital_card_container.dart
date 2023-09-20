import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/myipvc/card.dart';
import '../../providers/digital_card_provider.dart';
import '../views/error.dart';
import '../views/loading.dart';
import 'digital_card.dart';

class _CardSideNotifier extends StateNotifier<int> {
  _CardSideNotifier() : super(0);

  void set(int val) {
    state = val;
  }
}

final cardSideProvider = StateNotifierProvider<_CardSideNotifier, int>(
        (ref) => _CardSideNotifier()
);

class SingleChoice extends ConsumerWidget {
  const SingleChoice({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int cardSide = ref.watch(cardSideProvider);

    return SegmentedButton<int>(
      segments: const <ButtonSegment<int>>[
        ButtonSegment<int>(
          value: 0,
          label: Text('Frente'),
        ),
        ButtonSegment<int>(
          value: 1,
          label: Text('Verso'),
        )
      ],
      selected: <int>{cardSide},
      onSelectionChanged: (Set<int> newSelection) {
        ref.read(cardSideProvider.notifier).set(newSelection.first);
      },
    );
  }
}

class DigitalCardContainer extends ConsumerWidget {
  const DigitalCardContainer({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<MyIPVCCard> card = ref.watch(digitalCardProvider);

    return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 42.0,
                height: 4,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 32, 0, 16),
                child: SingleChoice(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 32),
                child: card.when(
                    loading: () => const LoadingView(),
                    error: (err, stack) => ErrorView(error: "$err"),
                    data: (card) {
                      return DigitalCard(data: card);
                    }
                ),
              ),
            ],
          ),
        )
    );
  }
}