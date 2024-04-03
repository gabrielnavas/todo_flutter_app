import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todo_list_provider.dart';

class TodoItemForm extends StatefulWidget {
  Todo? todoToEdit;
  TodoItemForm({this.todoToEdit, super.key});

  @override
  State<TodoItemForm> createState() => _TodoItemFormState();
}

class _TodoItemFormState extends State<TodoItemForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Todo _todo = Todo.titleDescription(title: '', description: '');

  @override
  void initState() {
    super.initState();
    setTodoToEdit();
  }

  bool isUpdate() {
    return widget.todoToEdit != null;
  }

  void setTodoToEdit() {
    if (widget.todoToEdit != null) {
      setState(() {
        _todo = widget.todoToEdit!;
        _titleController.text = _todo.title;
        _descriptionController.text = _todo.description;
      });
    }
  }

  bool _verifyForm() {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return false;
    }

    _formKey.currentState?.save();
    return true;
  }

  void _onSubmit(BuildContext context) {
    if (!_verifyForm()) {
      return;
    }

    if (isUpdate()) {
      updateTodo();
    } else {
      createNewTodo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            key: const ValueKey('title'),
            controller: _titleController,
            decoration: const InputDecoration(
              label: Text('Título'),
            ),
            textInputAction: TextInputAction.next,
            autofocus: true,
            validator: (value) => Todo.validateTitle(value ?? ''),
            onChanged: (value) => setState(() => _todo.title = value),
            onSaved: (title) {
              if (title != null && title.isNotEmpty) {
                _todo.title = title;
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Descrição'),
            ),
            controller: _descriptionController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            minLines: 2,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (value) => _onSubmit(context),
            autofocus: true,
            validator: (value) => Todo.validateDescription(value ?? ''),
            onChanged: (value) => setState(() => _todo.description = value),
            onSaved: (description) {
              if (description != null && description.isNotEmpty) {
                _todo.description = description;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
              onPressed: () => _onSubmit(context),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                ),
              ),
              child: Text(
                isUpdate() ? 'Atualizar' : 'Adicionar',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          )
        ],
      ),
    );
  }

  void createNewTodo() {
    final Todo todo = Todo.titleDescription(
      title: _titleController.text,
      description: _descriptionController.text,
    );

    Provider.of<TodoListProvider>(context, listen: false).add(todo);
    Navigator.of(context).pop();
  }

  void updateTodo() {
    Provider.of<TodoListProvider>(context, listen: false).partialUpdate(_todo);
    Navigator.of(context).pop();
  }
}
