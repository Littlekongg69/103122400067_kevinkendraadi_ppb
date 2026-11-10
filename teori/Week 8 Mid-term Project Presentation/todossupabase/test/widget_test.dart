import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todossupabase/controllers/todo_controller.dart';
import 'package:todossupabase/models/todo_model.dart';
import 'package:todossupabase/pages/todo_page.dart';
import 'package:todossupabase/services/todo_service.dart';

class FakeTodoService extends TodoApiService {
  @override
  Future<List<TodoModel>> fetchTodos() async {
    return [
      TodoModel(
        id: 1,
        name: 'Belajar Flutter',
        description: 'Testing Supabase',
        isDone: false,
      ),
    ];
  }
}

void main() {
  testWidgets('TodoPage smoke test displays todos list', (WidgetTester tester) async {
    dotenv.loadFromString(envString: '''
SUPABASE_URL=https://dummy.supabase.co
SUPABASE_ANON_KEY=dummy_key
SUPABASE_TODOS_TABLE=todos
''');

    final fakeController = TodoController(FakeTodoService());

    await tester.pumpWidget(
      MaterialApp(
        home: TodoPage(controller: fakeController),
      ),
    );

    await tester.pump();

    expect(find.text('Todos API Supabase'), findsOneWidget);
    expect(find.text('Belajar Flutter'), findsOneWidget);
    expect(find.text('Testing Supabase'), findsOneWidget);
  });
}
