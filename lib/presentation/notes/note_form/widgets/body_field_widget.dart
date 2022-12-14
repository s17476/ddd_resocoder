import 'package:ddd_resocoder/application/notes/note_form/note_form_bloc.dart';
import 'package:ddd_resocoder/domain/notes/value_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BodyField extends HookWidget {
  const BodyField({super.key});

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();
    return BlocListener<NoteFormBloc, NoteFormState>(
      listenWhen: (previous, current) =>
          previous.isEditing != current.isEditing,
      listener: (context, state) {
        textEditingController.text = state.note.body.getOrCrasch();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          controller: textEditingController,
          decoration: const InputDecoration(
            labelText: 'Note',
            counterText: '',
          ),
          maxLength: NoteBody.maxLength,
          maxLines: null,
          minLines: 5,
          onChanged: (value) => context.read<NoteFormBloc>().add(
                NoteFormEvent.bodyChanged(value),
              ),
          validator: (_) {
            return context.watch<NoteFormBloc>().state.note.body.value.fold(
                  (f) => f.maybeMap(
                    orElse: () => null,
                    empty: (f) => 'Cannot be empty',
                    exceedingLenght: (f) => 'Exceeding length, max: ${f.max}',
                  ),
                  (r) => null,
                );
          },
        ),
      ),
    );
  }
}
