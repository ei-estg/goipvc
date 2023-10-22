import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goipvc/models/myipvc/exam.dart';
import 'package:goipvc/providers/exams_provider.dart';
import 'package:goipvc/ui/views/info.dart';
import 'package:goipvc/ui/widgets/exam_card.dart';

import 'error.dart';
import 'loading.dart';

class ExamsView extends ConsumerWidget {
  const ExamsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<MyIPVCExam>> exams = ref.watch(examsProvider);

    if(exams.isRefreshing){
      return const LoadingView();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exames"),
      ),
      body: exams.when(
        loading: () => const LoadingView(),
        error: (err, stack) => ErrorView(
          error: "$err",
          callback: () {exams = ref.refresh(examsProvider);},
        ),
        data: (exams) {
          if(exams.isEmpty) {
            return const InfoView(message: "Nenhum exame encontrado");
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListView(
                children: [
                  for(var exam in exams) ExamCard(exam: exam)
                ],
              ),
            );
          }
        }
      ),
    );
  }
}