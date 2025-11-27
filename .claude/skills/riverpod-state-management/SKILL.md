---
name: riverpod-state-management
description: Expert Riverpod state management implementation for Flutter apps. Use when implementing state management with Riverpod, flutter_riverpod, hooks_riverpod, or riverpod_annotation. Covers providers, code generation, dependency injection, async data handling, and modern Riverpod 3.x+ patterns with latest features.
allowed-tools: Read, Edit, Write, Grep, Glob, Bash
---

# Riverpod State Management Skill

Expert assistance for implementing state management using Riverpod in Flutter applications.

## When to Use This Skill

- Setting up Riverpod in a Flutter project
- Creating and using providers:
  - Provider, StateProvider, FutureProvider, StreamProvider
  - NotifierProvider, AsyncNotifierProvider (via @riverpod)
- Using Riverpod code generation with riverpod_generator or build_runner
- Implementing dependency injection with Riverpod
- Managing async state and data fetching, API integration, mutations, or reactive state
- Using Riverpod with hooks (hooks_riverpod)
- State synchronization, caching, autoDispose, or memory management
- Performance issues with rebuilds, provider selection, or optimization
- Designing repository-based clean architecture
- Testing providers and widgets

## Core Principles (2025)

1. **Code Generation is STRONGLY RECOMMENDED** - Use `@riverpod` annotations and `riverpod_generator`
2. **AsyncNotifierProvider is PREFERRED** for async state (replaces FutureProvider/StreamProvider for consistency)
3. Notifier for Sync Mutable State
4. **AutoDispose by Default** - Codegen makes providers auto-dispose automatically
5. **Repository Pattern** - Separate data layer from state management
6. **Performance First** - Use `select()` to optimize rebuilds
7. Single Source of Truth

## Setup

### Dependencies
```yaml
dependencies:
  flutter_riverpod: ^3.0.0
  # OR for hooks support
  hooks_riverpod: ^3.0.0

dev_dependencies:
  riverpod_annotation: ^3.0.0
  build_runner: ^2.4.0
  riverpod_generator: ^3.0.0
  riverpod_lint: ^3.0.0
```

> Note on ref types: Riverpod 3.x codegen no longer generates `*Ref` typedefs (e.g., `MyProviderRef`). Use the base `Ref`/`AutoDisposeRef` in provider signatures (e.g., `MyType myProvider(Ref ref) => ...;`).

### Project Setup
```bash
# Add dependencies
flutter pub add flutter_riverpod
flutter pub add --dev riverpod_annotation build_runner riverpod_generator

# For code generation
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode for development
flutter pub run build_runner watch --delete-conflicting-outputs
```

### App Configuration
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(  // Required root widget
      child: MyApp(),
    ),
  );
}
```

## Provider Selection Guide

### Quick Decision Tree

**Immutable/Computed Values** - Use `Provider`:
```dart
@riverpod
String apiKey(Ref ref) => 'YOUR_API_KEY';

@riverpod
int totalPrice(Ref ref) {
  final cart = ref.watch(cartProvider);
  return cart.items.fold(0, (sum, item) => sum + item.price);
}
```

**Simple Synchronous State** - Use `NotifierProvider`:
```dart
@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;

  void increment() => state++;
  void decrement() => state = max(0, state - 1);
}
```

**Async Data with Mutations (PREFERRED 2025)** - Use `AsyncNotifierProvider`:
```dart
@riverpod
class TodoList extends _$TodoList {
  @override
  Future<List<Todo>> build() async {
    final repo = ref.watch(todoRepositoryProvider);
    return repo.fetchTodos();
  }

  Future<void> addTodo(String title) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(todoRepositoryProvider);
      await repo.createTodo(title);
      return repo.fetchTodos();
    });
  }

  Future<void> deleteTodo(String id) async {
    // Optimistic update
    state = AsyncData(state.value!.where((t) => t.id != id).toList());

    try {
      await ref.read(todoRepositoryProvider).deleteTodo(id);
    } catch (e) {
      ref.invalidateSelf(); // Rollback on error
    }
  }
}
```

**Real-time Streams Only** - Use `StreamProvider`:
```dart
@riverpod
Stream<User?> authState(Ref ref) {
  return FirebaseAuth.instance.authStateChanges();
}
```

**Key Rule**: Prefer AsyncNotifierProvider over FutureProvider/StreamProvider for better consistency and mutation support.

### File Template
Every provider file needs:
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filename.g.dart';  // REQUIRED

@riverpod
class MyProvider extends _$MyProvider {
  @override
  Future<Data> build() async => fetchData();
}
```

### Run Generator
```bash
# Watch mode (RECOMMENDED during development)
dart run build_runner watch -d

# One-time generation
dart run build_runner build --delete-conflicting-outputs
```

## Performance Optimization Patterns

### Use ref.select() for Specific Fields
```dart
// ❌ BAD: Rebuilds on ANY product change
final product = ref.watch(productProvider);
return Text('\$${product.price}');

// ✅ GOOD: Only rebuilds when price changes
final price = ref.watch(productProvider.select((p) => p.price));
return Text('\$$price');
```

### ref.watch() vs ref.select() vs ref.read() vs ref.listen()

**ref.watch()** - Subscribe to changes (use in build):
```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final todos = ref.watch(todoListProvider);
  return ListView(...);
}
```

**ref.select()** - Subscribe to specific property (optimize rebuilds):
```dart
final count = ref.watch(todoListProvider.select((todos) => todos.length));
final isAdult = ref.watch(personProvider.select((p) => p.age >= 18));
```

**ref.read()** - One-time read with NO subscription (event handlers only):
```dart
onPressed: () {
  ref.read(todoListProvider.notifier).addTodo('New task');
}

// ❌ NEVER use read() in build to "optimize" - it won't rebuild!
```

**ref.listen()** - Side effects (navigation, snackbars, logging):
```dart
ref.listen<AsyncValue<List<Todo>>>(
  todoListProvider,
  (previous, next) {
    next.whenOrNull(
      error: (error, stack) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      },
    );
  },
);
```

### Avoid Watching in Loops
```dart
// ❌ BAD: Causes performance issues
ListView.builder(
  itemBuilder: (context, index) {
    final todo = ref.watch(todoProvider(ids[index])); // DON'T!
    return ListTile(...);
  },
);

// ✅ GOOD: Separate widget for each item
class TodoItem extends ConsumerWidget {
  const TodoItem({required this.todoId});
  final String todoId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoProvider(todoId));
    return ListTile(title: Text(todo.title));
  }
}

class TodoList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ids = ref.watch(todoIdsProvider);
    return ListView.builder(
      itemCount: ids.length,
      itemBuilder: (context, index) => TodoItem(todoId: ids[index]),
    );
  }
}
```

### Create Derived Providers
```dart
// ✅ GOOD: Separate provider for computed state
@riverpod
List<Todo> filteredSortedTodos(Ref ref) {
  final todos = ref.watch(todoListProvider);
  final filter = ref.watch(filterProvider);
  final sortOrder = ref.watch(sortOrderProvider);

  final filtered = todos.where((t) => t.matches(filter)).toList();
  return filtered..sort(sortOrder.comparator);
}
```

## Repository Pattern Architecture

### 3-Layer Architecture

**1. Data Layer - Repository**:
```dart
@riverpod
TodoRepository todoRepository(Ref ref) {
  return TodoRepository(dio: ref.watch(dioProvider));
}

class TodoRepository {
  TodoRepository({required this.dio});
  final Dio dio;

  Future<List<Todo>> fetchTodos() async {
    final response = await dio.get('/todos');
    return (response.data as List)
      .map((json) => Todo.fromJson(json))
      .toList();
  }

  Future<Todo> createTodo(String title) async {
    final response = await dio.post('/todos', data: {'title': title});
    return Todo.fromJson(response.data);
  }

  Future<void> deleteTodo(String id) async {
    await dio.delete('/todos/$id');
  }
}
```

**2. Application Layer - State Management**:
```dart
@riverpod
class TodoList extends _$TodoList {
  @override
  Future<List<Todo>> build() async {
    final repository = ref.watch(todoRepositoryProvider);
    return repository.fetchTodos();
  }

  Future<void> addTodo(String title) async {
    final repository = ref.read(todoRepositoryProvider);

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await repository.createTodo(title);
      return repository.fetchTodos();
    });
  }
}
```

**3. Presentation Layer - UI**:
```dart
class TodoListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: todosAsync.when(
        data: (todos) => ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) => TodoTile(todos[index]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => ErrorView(error: error),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### Dependency Injection
```dart
// Services
@riverpod
Dio dio(Ref ref) {
  final dio = Dio(BaseOptions(baseUrl: 'https://api.example.com'));
  dio.interceptors.add(LogInterceptor());
  return dio;
}

@riverpod
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return await SharedPreferences.getInstance();
}

@riverpod
AuthService authService(Ref ref) {
  return AuthService(
    dio: ref.watch(dioProvider),
    storage: ref.watch(sharedPreferencesProvider).value!,
  );
}

// Repositories depend on services
@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepository(
    dio: ref.watch(dioProvider),
    authService: ref.watch(authServiceProvider),
  );
}

// State providers depend on repositories
@riverpod
class CurrentUser extends _$CurrentUser {
  @override
  Future<User?> build() async {
    final authService = ref.watch(authServiceProvider);
    final userId = await authService.getCurrentUserId();

    if (userId == null) return null;

    final repository = ref.watch(userRepositoryProvider);
    return repository.fetchUser(userId);
  }

  Future<void> logout() async {
    final authService = ref.read(authServiceProvider);
    await authService.logout();
    ref.invalidateSelf();
  }
}

```

## Family Providers (Parameterized)

Family providers are automatic with code generation when you add parameters:

```dart
// Simple family provider
@riverpod
Future<User> user(Ref ref, String id) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get('/users/$id');
  return User.fromJson(response.data);
}

// Usage
final user = ref.watch(userProvider('123'));

// Family with AsyncNotifier
@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  Future<User> build(String id) async {
    final repo = ref.watch(userRepositoryProvider);
    return repo.fetchUser(id);
  }

  Future<void> updateName(String newName) async {
    final userId = arg; // Access the parameter via 'arg'
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(userRepositoryProvider).updateUser(userId, name: newName);
      return ref.read(userRepositoryProvider).fetchUser(userId);
    });
  }
}

// Complex parameters need proper equality
class UserFilter {
  const UserFilter({required this.role, required this.active});
  final String role;
  final bool active;

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is UserFilter &&
    role == other.role &&
    active == other.active;

  @override
  int get hashCode => Object.hash(role, active);
}

@riverpod
Future<List<User>> filteredUsers(Ref ref, UserFilter filter) async {
  return fetchUsers(filter);
}
```

## AutoDispose and Caching

Code generation makes providers **auto-dispose by default**.

```dart
// Default: auto-dispose when no listeners
@riverpod
Future<String> data(Ref ref) async => fetchData();

// Keep alive permanently
@Riverpod(keepAlive: true)
Future<Config> config(Ref ref) async => loadConfig();

// Conditional keep alive - cache on success
@riverpod
Future<String> cachedData(Ref ref) async {
  final data = await fetchData();
  ref.keepAlive(); // Cache this result forever
  return data;
}

// Timed cache (5 minutes)
@riverpod
Future<String> timedCache(Ref ref) async {
  final data = await fetchData();
  final link = ref.keepAlive();
  Timer(const Duration(minutes: 5), link.close);
  return data;
}

// Manual disposal - cleanup resources
@riverpod
Stream<int> websocket(Ref ref) {
  final client = WebSocketClient();

  ref.onDispose(() {
    client.close(); // Cleanup when provider is disposed
  });

  return client.stream;
}
```

## Error Handling

### Comprehensive Error Handling
```dart
@riverpod
class TodoList extends _$TodoList {
  @override
  Future<List<Todo>> build() async {
    try {
      final repository = ref.watch(todoRepositoryProvider);
      return await repository.fetchTodos();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        ref.read(authServiceProvider).logout();
        throw UnauthorizedException();
      }
      throw NetworkException(e.message);
    } catch (e) {
      throw UnexpectedException(e.toString());
    }
  }

  Future<void> addTodo(String title) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(todoRepositoryProvider);
      await repository.createTodo(title);
      return repository.fetchTodos();
    });
  }
}
```

### UI Error Handling
```dart
// Using .when()
todosAsync.when(
  data: (todos) => ListView.builder(...),
  loading: () => const Center(child: CircularProgressIndicator()),
  error: (error, stack) {
    if (error is NetworkException) {
      return ErrorView(
        message: 'Network error. Check your connection.',
        onRetry: () => ref.invalidate(todoListProvider),
      );
    }
    if (error is UnauthorizedException) {
      return const ErrorView(message: 'Please log in again.');
    }
    return ErrorView(message: 'Error: $error');
  },
);

// Listen for errors (side effects)
ref.listen<AsyncValue<List<Todo>>>(
  todoListProvider,
  (previous, next) {
    next.whenOrNull(
      error: (error, stack) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  },
);
```

## Testing

### Provider Testing
```dart
test('TodoList fetches todos correctly', () async {
  final container = ProviderContainer.test(
    overrides: [
      todoRepositoryProvider.overrideWithValue(MockTodoRepository()),
    ],
  );

  final todos = await container.read(todoListProvider.future);

  expect(todos.length, 2);
  expect(todos[0].title, 'Test Todo 1');
});

test('TodoList adds todo correctly', () async {
  final mockRepo = MockTodoRepository();
  final container = ProviderContainer.test(
    overrides: [
      todoRepositoryProvider.overrideWithValue(mockRepo),
    ],
  );

  await container.read(todoListProvider.notifier).addTodo('New Todo');

  verify(() => mockRepo.createTodo('New Todo')).called(1);
});
```

### Widget Testing
```dart
testWidgets('TodoListScreen displays todos', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        todoRepositoryProvider.overrideWithValue(MockTodoRepository()),
      ],
      child: const MaterialApp(home: TodoListScreen()),
    ),
  );

  await tester.pumpAndSettle();

  expect(find.text('Test Todo 1'), findsOneWidget);
  expect(find.text('Test Todo 2'), findsOneWidget);
});
```

## Common Anti-Patterns to AVOID

### Performance Pitfalls
```dart
// ❌ Using ref.read() to avoid rebuilds
final todos = ref.read(todoListProvider); // Won't rebuild!

// ✅ Use ref.watch() or ref.select()
final count = ref.watch(todoListProvider.select((todos) => todos.length));
```

### Memory Leaks
```dart
// ❌ Not disposing resources
@riverpod
Stream<int> badWebsocket(Ref ref) {
  final client = WebSocketClient();
  return client.stream; // Never closed!
}

// ✅ Dispose resources
@riverpod
Stream<int> goodWebsocket(Ref ref) {
  final client = WebSocketClient();
  ref.onDispose(() => client.close());
  return client.stream;
}
```

### Multiple Sources of Truth
```dart
// ❌ BAD: Which is the source of truth?
class BadWidget extends StatefulWidget {
  int localCount = 0; // Local state

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerCount = ref.watch(counterProvider); // Provider state
    return Text('$localCount vs $providerCount'); // Confusing!
  }
}

// ✅ GOOD: Single source of truth
class GoodWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Text('$count');
  }
}
```

### Not Invalidating Dependent Providers
```dart
// ❌ BAD
Future<void> logout() async {
  state = null;
  // Other providers still have old user data!
}

// ✅ GOOD: Invalidate dependent providers
Future<void> logout() async {
  state = null;
  ref.invalidate(userProfileProvider);
  ref.invalidate(userSettingsProvider);
  ref.invalidate(userNotificationsProvider);
}

// ✅ EVEN BETTER: Make providers watch auth
@riverpod
Future<UserProfile> userProfile(Ref ref) async {
  final user = ref.watch(authProvider);
  if (user == null) throw UnauthenticatedException();
  return fetchUserProfile(user.id); // Auto-refetches when user changes
}
```

## Consuming Providers

### In Widgets

```dart
// ConsumerWidget (recommended)
class CounterWidget extends ConsumerWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);

    return Column(
      children: [
        Text('Count: $count'),
        ElevatedButton(
          onPressed: () => ref.read(counterProvider.notifier).increment(),
          child: const Text('Increment'),
        ),
      ],
    );
  }
}

// Consumer (for part of widget tree)
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final count = ref.watch(counterProvider);
        return Text('Count: $count');
      },
    );
  }
}

// ConsumerStatefulWidget
class CounterPage extends ConsumerStatefulWidget {
  const CounterPage({super.key});

  @override
  ConsumerState<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends ConsumerState<CounterPage> {
  @override
  void initState() {
    super.initState();
    // Can use ref here
    ref.read(counterProvider);
  }

  @override
  Widget build(BuildContext context) {
    final count = ref.watch(counterProvider);
    return Text('Count: $count');
  }
}
```


## Async Data Handling

### AsyncValue Pattern

```dart
@riverpod
class TodoList extends _$TodoList {
  @override
  Future<List<Todo>> build() async {
    return _fetchTodos();
  }

  Future<List<Todo>> _fetchTodos() async {
    final repository = ref.read(todoRepositoryProvider);
    return repository.fetchTodos();
  }
}

// In widget
class TodoListWidget extends ConsumerWidget {
  const TodoListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTodos = ref.watch(todoListProvider);

    return asyncTodos.when(
      data: (todos) => ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) => TodoItem(todo: todos[index]),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}

// Alternative pattern matching
asyncTodos.when(
  data: (todos) => /* success */,
  loading: () => /* loading */,
  error: (error, stack) => /* error */,
);

// Map for custom handling
asyncTodos.maybeWhen(
  data: (todos) => /* success */,
  orElse: () => const SizedBox(),
);
```

### Manual State Updates

```dart
@riverpod
class TodoList extends _$TodoList {
  @override
  Future<List<Todo>> build() async {
    return _fetchTodos();
  }

  Future<void> addTodo(Todo todo) async {
    // Set loading
    state = const AsyncValue.loading();

    // Use AsyncValue.guard to handle errors
    state = await AsyncValue.guard(() async {
      final repository = ref.read(todoRepositoryProvider);
      await repository.addTodo(todo);
      return _fetchTodos();
    });
  }

  // Or handle manually
  Future<void> removeTodo(String id) async {
    final previousState = state;

    state = const AsyncValue.loading();

    try {
      final repository = ref.read(todoRepositoryProvider);
      await repository.removeTodo(id);
      state = AsyncValue.data(await _fetchTodos());
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      // Optionally restore previous state
      // state = previousState;
    }
  }

  Future<List<Todo>> _fetchTodos() async {
    final repository = ref.read(todoRepositoryProvider);
    return repository.fetchTodos();
  }
}
```

## Advanced Patterns

### Combining Providers

```dart
@riverpod
Future<UserProfile> userProfile(UserProfileRef ref, String userId) async {
  final user = await ref.watch(userProvider(userId).future);
  final settings = await ref.watch(userSettingsProvider(userId).future);

  return UserProfile(
    user: user,
    settings: settings,
  );
}

// Select specific parts
@riverpod
String userName(UserNameRef ref, String userId) {
  return ref.watch(
    userProvider(userId).select((user) => user.name),
  );
}
```

### Provider Scope Override

```dart
// For testing or feature-specific overrides
void main() {
  runApp(
    ProviderScope(
      overrides: [
        todoRepositoryProvider.overrideWith(
          (ref) => MockTodoRepository(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
```


## Project Structure (following clean architecture with MVVM pattern)
```
lib/
  core/
    services/                   # Dio, Firebase (Firestore), Secure Storage
    utils/                      # Helpers, Design tokens
    widgets/                    # Shared widgets
  features/
    auth/
      data/
        dtos/                   # JSON annotated dtos from datasources
        repositories/           # Provider, wire to datasources 
        datasources/            # Data providers (Wrapper to API services / Local services) 
      domain/
        entities/               # Business Entity (Model)
      presentation/
        viewmodel/
          notifiers/            # Notifiers (View model)
          states/               # Freezed UI states
        screens/                # Screen (View)
        widgets/
          mobile/               # Widgets tailored for mobile
          web/                  # Widgets tailored for web
  main.dart                     # App entry point
```

## Common Patterns

### Repository Pattern
```dart
@riverpod
TodoRepository todoRepository(TodoRepositoryRef ref) {
  return TodoRepositoryImpl();
}

@riverpod
class TodoList extends _$TodoList {
  @override
  Future<List<Todo>> build() {
    final repository = ref.watch(todoRepositoryProvider);
    return repository.fetchTodos();
  }

  Future<void> addTodo(String title) async {
    final repository = ref.read(todoRepositoryProvider);
    await repository.addTodo(title);
    ref.invalidateSelf();  // Refresh data
  }
}
```

### Form State
```dart
@riverpod
class LoginForm extends _$LoginForm {
  @override
  LoginFormState build() {
    return const LoginFormState();
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  Future<void> submit() async {
    if (!state.isValid) return;

    state = state.copyWith(isLoading: true);

    try {
      final auth = ref.read(authServiceProvider);
      await auth.login(state.email, state.password);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

@freezed
class LoginFormState with _$LoginFormState {
  const factory LoginFormState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    String? error,
  }) = _LoginFormState;

  const LoginFormState._();

  bool get isValid => email.isNotEmpty && password.length >= 6;
}
```

## Common Issues

### Issue: Provider not found
**Solution:** Ensure ProviderScope wraps your app
```dart
void main() {
  runApp(const ProviderScope(child: MyApp()));
}
```

### Issue: Cannot read provider during build
**Solution:** Use ref.watch instead of ref.read
```dart
// Wrong
final value = ref.read(provider);

// Correct
final value = ref.watch(provider);
```

### Issue: Provider not updating
**Solution:** Check if you're reading instead of watching
```dart
// Use watch for reactive updates
final value = ref.watch(provider);
```

## Instructions for Use

When the user is working with Riverpod:

1. **Always recommend code generation** with `@riverpod` annotations
2. **Prefer AsyncNotifierProvider** over FutureProvider/StreamProvider for async state
3. **Optimize performance** by suggesting `select()` when watching specific fields
4. **Follow repository pattern** for clean architecture
5. **Use proper error handling** with AsyncValue.guard() and .when()
6. **Leverage auto-dispose** to prevent memory leaks
7. **Point out anti-patterns** if you see them in user code
8. **Provide complete, working examples** with proper imports
9. **Prefer Notifier over StateNotifier** for new code
10. **Use ConsumerWidget** instead of StatelessWidget for reactive UI
11. **Keep providers small and focused** (single responsibility)
12. **Use ref.listen** for side effects (navigation, snackbars)
13. **Override providers in ProviderScope** for testing
14. **Use family providers** for parameterized providers
15. **Invalidate providers** to refresh data instead of manual updates
16. **Separate business logic** from UI (providers should be UI-agnostic)


## Resources

- **Official Docs:** https://riverpod.dev
- **Code Generation:** https://riverpod.dev/docs/concepts/about_code_generation
- **Migration Guide:** https://riverpod.dev/docs/migration/from_provider
- **Examples:** https://github.com/rrousselGit/riverpod/tree/master/examples


This skill focuses on Riverpod 3.x+ patterns with emphasis on code generation and latest features. For Flutter-specific UI patterns, use the flutter-developer skill. For alternative state management, see the bloc-state-management skill.
