import 'package:dio/dio.dart';

import '../env/env_config.dart';
import '../models/todo_model.dart';

class TodoApiService {
  final String _baseUrl;
  final String _anonKey;
  final String _table;

  late final Dio _dio;

  TodoApiService({Dio? dio})
      : _baseUrl = EnvConfig.supabaseUrl,
        _anonKey = EnvConfig.supabaseAnonKey,
        _table = EnvConfig.todosTable {
    _dio = dio ??
        Dio(
          BaseOptions(
            baseUrl: _baseUrl,
            headers: {
              'apikey': _anonKey,
              'Authorization': 'Bearer $_anonKey',
              'Content-Type': 'application/json',
            },
          ),
        );
  }

  String _extractDioError(DioException e, String action) {
    final responseData = e.response?.data;
    if (responseData is Map && responseData['message'] != null) {
      final msg = responseData['message'];
      final details = responseData['details'];
      return details != null && details.toString().isNotEmpty
          ? '$msg ($details)'
          : '$msg';
    }
    return '${e.response?.statusCode ?? ''} - ${e.message}';
  }

  /// GET /rest/v1/todos?select=*
  Future<List<TodoModel>> fetchTodos() async {
    try {
      final response = await _dio.get(
        '/rest/v1/$_table',
        queryParameters: {'select': '*', 'order': 'id.asc'},
      );

      final data = response.data as List<dynamic>;
      return data
          .map((e) => TodoModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } on DioException catch (e) {
      throw Exception('Dio Error (fetchTodos): ${_extractDioError(e, 'fetchTodos')}');
    } catch (e) {
      throw Exception('Error fetchTodos: $e');
    }
  }

  /// POST /rest/v1/todos -> name + description
  Future<TodoModel> addTodo({
    required String name,
    required String description,
  }) async {
    try {
      final response = await _dio.post(
        '/rest/v1/$_table',
        data: {
          'name': name,
          'description': description,
          'is_done': false,
        },
        options: Options(
          headers: {'Prefer': 'return=representation'},
        ),
      );

      final list = response.data as List<dynamic>;
      return TodoModel.fromJson(Map<String, dynamic>.from(list.first as Map));
    } on DioException catch (e) {
      throw Exception('Dio Error (addTodo): ${_extractDioError(e, 'addTodo')}');
    } catch (e) {
      throw Exception('Error addTodo: $e');
    }
  }

  /// PATCH /rest/v1/todos?id=eq.`id` -> toggle is_done
  Future<TodoModel> toggleTodo(int id, bool isDone) async {
    try {
      final response = await _dio.patch(
        '/rest/v1/$_table',
        queryParameters: {'id': 'eq.$id'},
        data: {
          'is_done': isDone,
        },
        options: Options(
          headers: {'Prefer': 'return=representation'},
        ),
      );

      final list = response.data as List<dynamic>;
      return TodoModel.fromJson(Map<String, dynamic>.from(list.first as Map));
    } on DioException catch (e) {
      throw Exception('Dio Error (toggleTodo): ${_extractDioError(e, 'toggleTodo')}');
    } catch (e) {
      throw Exception('Error toggleTodo: $e');
    }
  }

  /// DELETE /rest/v1/todos?id=eq.`id`
  Future<void> deleteTodo(int id) async {
    try {
      final response = await _dio.delete(
        '/rest/v1/$_table',
        queryParameters: {'id': 'eq.$id'},
      );

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw Exception('Supabase Delete Error Code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio Error (deleteTodo): ${_extractDioError(e, 'deleteTodo')}');
    } catch (e) {
      throw Exception('Error deleteTodo: $e');
    }
  }
}
