// ignore_for_file: use_build_context_synchronously

import 'package:elcriticoapp/components/scaffold/app_scaffold.dart';
import 'package:elcriticoapp/models/movie.dart';
import 'package:elcriticoapp/models/review.dart';
import 'package:elcriticoapp/services/auth_service.dart';
import 'package:elcriticoapp/services/review_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewReview extends StatefulWidget {
  final Movie movie;
  final Review? review;
  const NewReview({
    super.key,
    required this.movie,
    this.review,
  });

  @override
  NewReviewState createState() {
    return NewReviewState();
  }
}

class NewReviewState extends State<NewReview> {
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController(
      text: widget.review?.title ?? "",
    );
    final TextEditingController reviewController = TextEditingController(
      text: widget.review?.content ?? "",
    );
    final TextEditingController scoreController = TextEditingController(
      text: '${widget.review?.score ?? 0}',
    );

    final TextTheme typography = Theme.of(context).textTheme;
    final ColorScheme palette = Theme.of(context).colorScheme;
    return AppScaffold(
      pageTitle: widget.review == null ? 'Nova análise' : 'Editar review',
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 24,
        ),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  labelStyle: typography.bodySmall,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O título não pode ser vazio';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 18,
              ),
              Scrollbar(
                controller: _scrollController,
                child: TextFormField(
                  minLines: 4,
                  controller: reviewController,
                  maxLines: 8,
                  scrollController: _scrollController,
                  decoration: InputDecoration(
                    labelText: 'Análise',
                    labelStyle: typography.bodySmall,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              TextFormField(
                controller: scoreController,
                validator: (value) {
                  int? val = int.tryParse(value ?? '');
                  if (val == null) {
                    return 'Você deve adicionar uma nota de 0 a 100.';
                  }
                  if (val < 0 || val > 100) {
                    return 'A nota deve estar entre 0 e 100';
                  }
                  return null;
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Nota',
                  labelStyle: typography.bodySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final bool response = await postReview(
                        Review(
                          movieID: '${widget.movie.id}',
                          score: int.tryParse(scoreController.text)!,
                          user: '${AuthService().user!.id}',
                          content: reviewController.text,
                          title: titleController.text,
                        ),
                      );
                      if (response == true) {
                        Navigator.pop(context);
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          elevation: 1,
                          backgroundColor: palette.errorContainer,
                          content: const Text(
                            'Não foi possível postar a análise.',
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Postar Review'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
