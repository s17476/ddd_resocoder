import 'package:ddd_resocoder/domain/notes/value_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kt_dart/kt.dart';
import 'package:provider/provider.dart';

import '../../../../application/notes/note_form/note_form_bloc.dart';
import '../misc/build_context_x.dart';
import '../misc/todo_item_presentation_classes.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteFormBloc, NoteFormState>(
      listenWhen: (previous, current) =>
          previous.note.todos.isFull != current.note.todos.isFull,
      listener: (context, state) {
        if (state.note.todos.isFull) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 5),
                content: Row(
                  children: [
                    const Icon(
                      Icons.monetization_on,
                      color: Colors.amber,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Expanded(
                      child: Text('Get premium to add more todo\'s.'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'BUY NOW',
                        style: TextStyle(
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
        }
      },
      builder: (context, state) {
        return Consumer<FormTodos>(
          builder: (context, formTodos, child) => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: formTodos.value.size,
            itemBuilder: (context, index) => TodoTile(
              key: ValueKey(context.formTodos[index].id),
              index: index,
            ),
          ),
        );
      },
    );
  }
}

class TodoTile extends HookWidget {
  final int index;

  const TodoTile({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final todo = context.formTodos.getOrElse(
      index,
      (_) => TodoItemPrimitive.empty(),
    );

    final textEditingController = useTextEditingController(text: todo.name);

    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        top: 2,
        bottom: 2,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.2,
          children: [
            SlidableAction(
              onPressed: (_) {
                context.formTodos = context.formTodos.minusElement(todo);
                context.read<NoteFormBloc>().add(
                      NoteFormEvent.todosChanged(context.formTodos),
                    );
              },
              backgroundColor: Theme.of(context).errorColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: Checkbox(
              value: todo.done,
              onChanged: (value) {
                context.formTodos = context.formTodos.map(
                  (listTodo) =>
                      listTodo == todo ? todo.copyWith(done: value!) : listTodo,
                );
                context
                    .read<NoteFormBloc>()
                    .add(NoteFormEvent.todosChanged(context.formTodos));
              },
            ),
            title: TextFormField(
              controller: textEditingController,
              decoration: const InputDecoration(
                hintText: 'Todo',
                border: InputBorder.none,
                counterText: '',
              ),
              maxLength: TodoName.maxLength,
              onChanged: (value) {
                context.formTodos = context.formTodos.map(
                  (listTodo) =>
                      listTodo == todo ? todo.copyWith(name: value) : listTodo,
                );
                context
                    .read<NoteFormBloc>()
                    .add(NoteFormEvent.todosChanged(context.formTodos));
              },
              validator: (_) {
                return context.read<NoteFormBloc>().state.note.todos.value.fold(
                      (_) => null,
                      (todoList) => todoList[index].name.value.fold(
                            (failure) => failure.maybeMap(
                              orElse: () => null,
                              empty: (_) => 'Cannot be empty',
                              exceedingLenght: (_) => 'Too long',
                              multiline: (_) =>
                                  'Has not to be in a single line',
                            ),
                            (_) => null,
                          ),
                    );
              },
            ),
          ),
        ),
      ),
    );
  }
}
