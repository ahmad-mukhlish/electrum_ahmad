Hey friend! 👋

Let me guess — you’re building a Flutter app and you need a backend. You’ve heard Firebase is amazing, but the setup looks… complicated. Authentication, Firestore, real-time listeners, state management — it’s a lot to handle.

Well, I’ve got good news. With Riverpod 3.0, Firebase integration becomes stupidly simple. I’m talking “set it up once and forget about it” simple.

Today, I’m going to show you exactly how to build a production-ready Firebase + Riverpod setup that handles authentication, Firestore operations, and real-time data like a boss. No headaches, no confusion, just clean code that works.

Let’s dive in! 🚀

## Why Firebase + Riverpod 3.0 Is a Match Made in Heaven

Before we start coding, let me tell you why this combo is absolutely killer:

**Firebase gives you:**

-   Authentication out of the box (Google, email, Apple, etc.)
-   Real-time database that syncs across devices instantly
-   Cloud storage for files and images
-   Push notifications ready to go
-   Analytics and crash reporting built-in

**Riverpod 3.0 gives you:**

-   Clean separation of concerns
-   Automatic caching and state management
-   Easy testing and mocking
-   Type-safe providers that catch bugs at compile time

Together? They’re unstoppable. Let’s build something awesome.

## Step 1: Firebase Setup (The Boring Part, But We’ll Make It Quick)

First, let’s get Firebase configured. I promise this is the only tedious part.

**Install FlutterFire CLI:**

dart pub global activate flutterfire_cli

**Configure Firebase for your project:**

flutterfire configure

This will walk you through creating a Firebase project and generating the config files automatically. Choose your platforms (iOS, Android, Web) and let it do its magic.

**Add dependencies to pubspec.yaml:**

dependencies:  
flutter:  
sdk: flutter

# State Management
flutter_riverpod: ^2.5.1  
riverpod_annotation: ^2.3.5

# Firebase
firebase_core: ^2.24.2  
firebase_auth: ^4.16.0  
cloud_firestore: ^4.14.0  
firebase_storage: ^11.6.0

# Code Generation
freezed_annotation: ^2.4.1  
json_annotation: ^4.8.1

dev_dependencies:
# Code Generation
build_runner: ^2.4.8  
riverpod_generator: ^2.3.10  
freezed: ^2.4.6  
json_serializable: ^6.7.1

Run  `flutter pub get`  and you're golden!

## Step 2: Initialize Firebase in Your App

Let’s set up Firebase initialization the right way:

// lib/main.dart  
import 'package:flutter/material.dart';  
import 'package:flutter_riverpod/flutter_riverpod.dart';  
import 'package:firebase_core/firebase_core.dart';  
import 'firebase_options.dart';

void main() async {  
WidgetsFlutterBinding.ensureInitialized();

// Initialize Firebase  
await Firebase.initializeApp(  
options: DefaultFirebaseOptions.currentPlatform,  
);

runApp(  
const ProviderScope(  
child: MyApp(),  
),  
);  
}

class MyApp extends StatelessWidget {  
const MyApp({super.key});

@override  
Widget build(BuildContext context) {  
return MaterialApp(  
title: 'Firebase + Riverpod',  
theme: ThemeData(  
primarySwatch: Colors.blue,  
useMaterial3: true,  
),  
home: const AuthWrapper(),  
);  
}  
}

## Step 3: Firebase Authentication with Riverpod (The Fun Begins!)

Now let’s create a beautiful authentication system. This is where Riverpod really shines.

**User Model:**

// lib/models/app_user.dart  
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';  
part 'app_user.g.dart';

@freezed  
class AppUser with _$AppUser {  
const factory AppUser({  
required String uid,  
required String email,  
String? displayName,  
String? photoUrl,  
}) = _AppUser;

factory AppUser.fromJson(Map<String, dynamic> json) =>  
_$AppUserFromJson(json);  
}

**Firebase Auth Service:**

// lib/services/firebase_auth_service.dart  
import 'package:firebase_auth/firebase_auth.dart';  
import 'package:riverpod_annotation/riverpod_annotation.dart';  
import '../models/app_user.dart';

part 'firebase_auth_service.g.dart';

@riverpod  
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) {  
return FirebaseAuth.instance;  
}

@riverpod  
class FirebaseAuthService extends _$FirebaseAuthService {  
@override  
FutureOr<void> build() {  
// Initialize if needed  
}

Future<AppUser> signInWithEmail(String email, String password) async {  
try {  
final userCredential = await ref.read(firebaseAuthProvider).signInWithEmailAndPassword(  
email: email,  
password: password,  
);

      return _userFromFirebase(userCredential.user!);  
    } on FirebaseAuthException catch (e) {  
      throw _handleAuthException(e);  
    }  
}

Future<AppUser> signUpWithEmail(String email, String password, String displayName) async {  
try {  
final userCredential = await ref.read(firebaseAuthProvider).createUserWithEmailAndPassword(  
email: email,  
password: password,  
);

      // Update display name  
      await userCredential.user?.updateDisplayName(displayName);  
        
      return _userFromFirebase(userCredential.user!);  
    } on FirebaseAuthException catch (e) {  
      throw _handleAuthException(e);  
    }  
}

Future<void> signOut() async {  
await ref.read(firebaseAuthProvider).signOut();  
}

Future<void> resetPassword(String email) async {  
try {  
await ref.read(firebaseAuthProvider).sendPasswordResetEmail(email: email);  
} on FirebaseAuthException catch (e) {  
throw _handleAuthException(e);  
}  
}

AppUser _userFromFirebase(User user) {  
return AppUser(  
uid: user.uid,  
email: user.email!,  
displayName: user.displayName,  
photoUrl: user.photoURL,  
);  
}

String _handleAuthException(FirebaseAuthException e) {  
switch (e.code) {  
case 'user-not-found':  
return 'No user found with this email.';  
case 'wrong-password':  
return 'Wrong password provided.';  
case 'email-already-in-use':  
return 'An account already exists with this email.';  
case 'invalid-email':  
return 'The email address is invalid.';  
case 'weak-password':  
return 'The password is too weak.';  
default:  
return 'An error occurred. Please try again.';  
}  
}  
}

**Auth State Provider (The Magic!):**

This provider automatically tracks the authentication state:

// lib/providers/auth_provider.dart  
import 'package:firebase_auth/firebase_auth.dart';  
import 'package:riverpod_annotation/riverpod_annotation.dart';  
import '../models/app_user.dart';  
import '../services/firebase_auth_service.dart';

part 'auth_provider.g.dart';

// Stream provider that listens to auth state changes  
@riverpod  
Stream<User?> authStateChanges(AuthStateChangesRef ref) {  
return ref.watch(firebaseAuthProvider).authStateChanges();  
}

// Current user provider  
@riverpod  
Stream<AppUser?> currentUser(CurrentUserRef ref) {  
return ref.watch(authStateChangesProvider).when(  
data: (user) async* {  
if (user != null) {  
yield AppUser(  
uid: user.uid,  
email: user.email!,  
displayName: user.displayName,  
photoUrl: user.photoURL,  
);  
} else {  
yield null;  
}  
},  
loading: () => const Stream.empty(),  
error: (_, __) => const Stream.empty(),  
);  
}

**Login Screen:**

// lib/screens/login_screen.dart  
import 'package:flutter/material.dart';  
import 'package:flutter_riverpod/flutter_riverpod.dart';  
import '../services/firebase_auth_service.dart';

class LoginScreen extends ConsumerStatefulWidget {  
const LoginScreen({super.key});

@override  
ConsumerState<LoginScreen> createState() => _LoginScreenState();  
}

class _LoginScreenState extends ConsumerState<LoginScreen> {  
final _emailController = TextEditingController();  
final _passwordController = TextEditingController();  
final _formKey = GlobalKey<FormState>();  
bool _isLoading = false;

@override  
void dispose() {  
_emailController.dispose();  
_passwordController.dispose();  
super.dispose();  
}

Future<void> _handleLogin() async {  
if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);  
  
    try {  
      await ref.read(firebaseAuthServiceProvider.notifier).signInWithEmail(  
        _emailController.text.trim(),  
        _passwordController.text,  
      );  
        
      if (mounted) {  
        // Navigation will be handled by AuthWrapper  
      }  
    } catch (e) {  
      if (mounted) {  
        ScaffoldMessenger.of(context).showSnackBar(  
          SnackBar(  
            content: Text(e.toString()),  
            backgroundColor: Colors.red,  
          ),  
        );  
      }  
    } finally {  
      if (mounted) {  
        setState(() => _isLoading = false);  
      }  
    }  
}

@override  
Widget build(BuildContext context) {  
return Scaffold(  
body: SafeArea(  
child: Center(  
child: SingleChildScrollView(  
padding: const EdgeInsets.all(24.0),  
child: Form(  
key: _formKey,  
child: Column(  
mainAxisAlignment: MainAxisAlignment.center,  
crossAxisAlignment: CrossAxisAlignment.stretch,  
children: [  
Icon(  
Icons.firebase,  
size: 80,  
color: Theme.of(context).primaryColor,  
),  
const SizedBox(height: 24),  
Text(  
'Welcome Back!',  
style: Theme.of(context).textTheme.headlineMedium?.copyWith(  
fontWeight: FontWeight.bold,  
),  
textAlign: TextAlign.center,  
),  
const SizedBox(height: 8),  
Text(  
'Sign in to continue',  
style: Theme.of(context).textTheme.bodyLarge?.copyWith(  
color: Colors.grey,  
),  
textAlign: TextAlign.center,  
),  
const SizedBox(height: 48),  
TextFormField(  
controller: _emailController,  
decoration: const InputDecoration(  
labelText: 'Email',  
border: OutlineInputBorder(),  
prefixIcon: Icon(Icons.email_outlined),  
),  
keyboardType: TextInputType.emailAddress,  
validator: (value) {  
if (value == null || value.isEmpty) {  
return 'Please enter your email';  
}  
if (!value.contains('@')) {  
return 'Please enter a valid email';  
}  
return null;  
},  
),  
const SizedBox(height: 16),  
TextFormField(  
controller: _passwordController,  
decoration: const InputDecoration(  
labelText: 'Password',  
border: OutlineInputBorder(),  
prefixIcon: Icon(Icons.lock_outline),  
),  
obscureText: true,  
validator: (value) {  
if (value == null || value.isEmpty) {  
return 'Please enter your password';  
}  
if (value.length < 6) {  
return 'Password must be at least 6 characters';  
}  
return null;  
},  
),  
const SizedBox(height: 24),  
ElevatedButton(  
onPressed: _isLoading ? null : _handleLogin,  
style: ElevatedButton.styleFrom(  
padding: const EdgeInsets.symmetric(vertical: 16),  
),  
child: _isLoading  
? const SizedBox(  
height: 20,  
width: 20,  
child: CircularProgressIndicator(strokeWidth: 2),  
)  
: const Text('Sign In'),  
),  
const SizedBox(height: 16),  
TextButton(  
onPressed: () {  
// Navigate to signup screen  
},  
child: const Text("Don't have an account? Sign up"),  
),  
],  
),  
),  
),  
),  
),  
);  
}  
}

**Auth Wrapper (Automatic Navigation!):**

This widget automatically shows the right screen based on auth state:

// lib/screens/auth_wrapper.dart  
import 'package:flutter/material.dart';  
import 'package:flutter_riverpod/flutter_riverpod.dart';  
import '../providers/auth_provider.dart';  
import 'login_screen.dart';  
import 'home_screen.dart';

class AuthWrapper extends ConsumerWidget {  
const AuthWrapper({super.key});

@override  
Widget build(BuildContext context, WidgetRef ref) {  
final authState = ref.watch(authStateChangesProvider);

    return authState.when(  
      data: (user) {  
        if (user != null) {  
          return const HomeScreen();  
        } else {  
          return const LoginScreen();  
        }  
      },  
      loading: () => const Scaffold(  
        body: Center(  
          child: CircularProgressIndicator(),  
        ),  
      ),  
      error: (error, stack) => Scaffold(  
        body: Center(  
          child: Text('Error: $error'),  
        ),  
      ),  
    );  
}  
}

## Step 4: Firestore Integration (Where It Gets Really Cool)

Now let’s add Firestore for real-time data. We’ll create a simple task management system.

**Task Model:**

// lib/models/task.dart  
import 'package:freezed_annotation/freezed_annotation.dart';  
import 'package:cloud_firestore/cloud_firestore.dart';

part 'task.freezed.dart';  
part 'task.g.dart';

@freezed  
class Task with _$Task {  
const factory Task({  
required String id,  
required String title,  
required String description,  
required bool isCompleted,  
required String userId,  
@JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)  
required DateTime createdAt,  
}) = _Task;

factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);  
}

DateTime _timestampFromJson(Timestamp timestamp) => timestamp.toDate();  
Timestamp _timestampToJson(DateTime date) => Timestamp.fromDate(date);

**Firestore Service:**

// lib/services/firestore_service.dart  
import 'package:cloud_firestore/cloud_firestore.dart';  
import 'package:riverpod_annotation/riverpod_annotation.dart';  
import '../models/task.dart';

part 'firestore_service.g.dart';

@riverpod  
FirebaseFirestore firestore(FirestoreRef ref) {  
return FirebaseFirestore.instance;  
}

@riverpod  
class FirestoreService extends _$FirestoreService {  
@override  
FutureOr<void> build() {  
// Initialize if needed  
}

// Create a new task  
Future<String> createTask({  
required String userId,  
required String title,  
required String description,  
}) async {  
final docRef = ref.read(firestoreProvider).collection('tasks').doc();

    final task = Task(  
      id: docRef.id,  
      title: title,  
      description: description,  
      isCompleted: false,  
      userId: userId,  
      createdAt: DateTime.now(),  
    );  
  
    await docRef.set(task.toJson());  
    return docRef.id;  
}

// Update task  
Future<void> updateTask(String taskId, Map<String, dynamic> data) async {  
await ref.read(firestoreProvider)  
.collection('tasks')  
.doc(taskId)  
.update(data);  
}

// Delete task  
Future<void> deleteTask(String taskId) async {  
await ref.read(firestoreProvider)  
.collection('tasks')  
.doc(taskId)  
.delete();  
}

// Toggle task completion  
Future<void> toggleTaskCompletion(String taskId, bool isCompleted) async {  
await updateTask(taskId, {'isCompleted': !isCompleted});  
}  
}

**Real-time Tasks Provider (This Is Magic!):**

This provider automatically updates when Firestore data changes:

// lib/providers/tasks_provider.dart  
import 'package:cloud_firestore/cloud_firestore.dart';  
import 'package:riverpod_annotation/riverpod_annotation.dart';  
import '../models/task.dart';  
import '../services/firestore_service.dart';  
import 'auth_provider.dart';

part 'tasks_provider.g.dart';

// Stream provider for real-time tasks  
@riverpod  
Stream<List<Task>> userTasks(UserTasksRef ref) {  
final user = ref.watch(currentUserProvider).value;

if (user == null) {  
return Stream.value([]);  
}

return ref  
.watch(firestoreProvider)  
.collection('tasks')  
.where('userId', isEqualTo: user.uid)  
.orderBy('createdAt', descending: true)  
.snapshots()  
.map((snapshot) {  
return snapshot.docs.map((doc) {  
return Task.fromJson({...doc.data(), 'id': doc.id});  
}).toList();  
});  
}

// Filtered tasks providers  
@riverpod  
Stream<List<Task>> activeTasks(ActiveTasksRef ref) {  
return ref.watch(userTasksProvider).when(  
data: (tasks) => Stream.value(  
tasks.where((task) => !task.isCompleted).toList(),  
),  
loading: () => Stream.value([]),  
error: (_, __) => Stream.value([]),  
);  
}

@riverpod  
Stream<List<Task>> completedTasks(CompletedTasksRef ref) {  
return ref.watch(userTasksProvider).when(  
data: (tasks) => Stream.value(  
tasks.where((task) => task.isCompleted).toList(),  
),  
loading: () => Stream.value([]),  
error: (_, __) => Stream.value([]),  
);  
}

**Home Screen with Real-time Tasks:**

// lib/screens/home_screen.dart  
import 'package:flutter/material.dart';  
import 'package:flutter_riverpod/flutter_riverpod.dart';  
import '../providers/auth_provider.dart';  
import '../providers/tasks_provider.dart';  
import '../services/firebase_auth_service.dart';  
import '../services/firestore_service.dart';

class HomeScreen extends ConsumerWidget {  
const HomeScreen({super.key});

@override  
Widget build(BuildContext context, WidgetRef ref) {  
final userAsync = ref.watch(currentUserProvider);  
final tasksAsync = ref.watch(userTasksProvider);

    return Scaffold(  
      appBar: AppBar(  
        title: const Text('My Tasks'),  
        actions: [  
          IconButton(  
            icon: const Icon(Icons.logout),  
            onPressed: () async {  
              await ref.read(firebaseAuthServiceProvider.notifier).signOut();  
            },  
          ),  
        ],  
      ),  
      body: userAsync.when(  
        data: (user) {  
          if (user == null) return const SizedBox.shrink();  
  
          return Column(  
            children: [  
              Padding(  
                padding: const EdgeInsets.all(16.0),  
                child: Text(  
                  'Welcome, ${user.displayName ?? user.email}!',  
                  style: Theme.of(context).textTheme.titleLarge,  
                ),  
              ),  
              Expanded(  
                child: tasksAsync.when(  
                  data: (tasks) {  
                    if (tasks.isEmpty) {  
                      return Center(  
                        child: Column(  
                          mainAxisAlignment: MainAxisAlignment.center,  
                          children: [  
                            Icon(  
                              Icons.task_outlined,  
                              size: 64,  
                              color: Colors.grey[400],  
                            ),  
                            const SizedBox(height: 16),  
                            Text(  
                              'No tasks yet',  
                              style: TextStyle(  
                                fontSize: 18,  
                                color: Colors.grey[600],  
                              ),  
                            ),  
                            const SizedBox(height: 8),  
                            Text(  
                              'Tap the + button to create one',  
                              style: TextStyle(  
                                color: Colors.grey[500],  
                              ),  
                            ),  
                          ],  
                        ),  
                      );  
                    }  
  
                    return ListView.builder(  
                      padding: const EdgeInsets.all(16),  
                      itemCount: tasks.length,  
                      itemBuilder: (context, index) {  
                        final task = tasks[index];  
                        return Card(  
                          margin: const EdgeInsets.only(bottom: 12),  
                          child: ListTile(  
                            leading: Checkbox(  
                              value: task.isCompleted,  
                              onChanged: (_) {  
                                ref  
                                    .read(firestoreServiceProvider.notifier)  
                                    .toggleTaskCompletion(  
                                      task.id,  
                                      task.isCompleted,  
                                    );  
                              },  
                            ),  
                            title: Text(  
                              task.title,  
                              style: TextStyle(  
                                decoration: task.isCompleted  
                                    ? TextDecoration.lineThrough  
                                    : null,  
                              ),  
                            ),  
                            subtitle: Text(task.description),  
                            trailing: IconButton(  
                              icon: const Icon(Icons.delete_outline),  
                              onPressed: () {  
                                ref  
                                    .read(firestoreServiceProvider.notifier)  
                                    .deleteTask(task.id);  
                              },  
                            ),  
                          ),  
                        );  
                      },  
                    );  
                  },  
                  loading: () => const Center(  
                    child: CircularProgressIndicator(),  
                  ),  
                  error: (error, stack) => Center(  
                    child: Text('Error: $error'),  
                  ),  
                ),  
              ),  
            ],  
          );  
        },  
        loading: () => const Center(child: CircularProgressIndicator()),  
        error: (error, stack) => Center(child: Text('Error: $error')),  
      ),  
      floatingActionButton: FloatingActionButton(  
        onPressed: () => _showAddTaskDialog(context, ref),  
        child: const Icon(Icons.add),  
      ),  
    );  
}

void _showAddTaskDialog(BuildContext context, WidgetRef ref) {  
final titleController = TextEditingController();  
final descriptionController = TextEditingController();

    showDialog(  
      context: context,  
      builder: (context) => AlertDialog(  
        title: const Text('New Task'),  
        content: Column(  
          mainAxisSize: MainAxisSize.min,  
          children: [  
            TextField(  
              controller: titleController,  
              decoration: const InputDecoration(  
                labelText: 'Title',  
                border: OutlineInputBorder(),  
              ),  
            ),  
            const SizedBox(height: 16),  
            TextField(  
              controller: descriptionController,  
              decoration: const InputDecoration(  
                labelText: 'Description',  
                border: OutlineInputBorder(),  
              ),  
              maxLines: 3,  
            ),  
          ],  
        ),  
        actions: [  
          TextButton(  
            onPressed: () => Navigator.pop(context),  
            child: const Text('Cancel'),  
          ),  
          ElevatedButton(  
            onPressed: () async {  
              final user = ref.read(currentUserProvider).value;  
              if (user != null && titleController.text.isNotEmpty) {  
                await ref.read(firestoreServiceProvider.notifier).createTask(  
                  userId: user.uid,  
                  title: titleController.text,  
                  description: descriptionController.text,  
                );  
                if (context.mounted) {  
                  Navigator.pop(context);  
                }  
              }  
            },  
            child: const Text('Add'),  
          ),  
        ],  
      ),  
    );  
}  
}

## Step 5: Generate Code

Don’t forget to generate all the provider code:

flutter pub run build_runner build --delete-conflicting-outputs
```  
  
## Pro Tips for Firebase + Riverpod  
  
Here are some golden nuggets I've learned the hard way:  
  
**1. Security Rules Are Critical**  
  
Set up proper Firestore security rules:  
```  
rules_version = '2';  
service cloud.firestore {  
match /databases/{database}/documents {  
match /tasks/{taskId} {  
allow read, write: if request.auth != null   
&& request.auth.uid == resource.data.userId;  
allow create: if request.auth != null   
&& request.auth.uid == request.resource.data.userId;  
}  
}  
}

**2. Use StreamProviders for Real-time Data**

They automatically handle subscription and unsubscription:

@riverpod  
Stream<List<Task>> userTasks(UserTasksRef ref) {  
// Stream automatically manages listeners  
return firestore.collection('tasks').snapshots().map(...);  
}

**3. Handle Offline Mode**

Enable offline persistence:

await FirebaseFirestore.instance.settings = const Settings( persistenceEnabled: true,  
cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,);

**4. Batch Operations for Multiple Writes**

Future<void> batchCreateTasks(List<Task> tasks) async {  
final batch = ref.read(firestoreProvider).batch();

for (final task in tasks) {  
final docRef = ref.read(firestoreProvider).collection('tasks').doc();  
batch.set(docRef, task.toJson());  
}

await batch.commit();  
}

**5. Error Handling with AsyncValue**

final tasksAsync = ref.watch(userTasksProvider);

tasksAsync.when(  
data: (tasks) => YourWidget(tasks),  
loading: () => LoadingWidget(),  
error: (error, stack) => ErrorWidget(error),  
);

## Common Mistakes to Avoid

**❌ Don’t do this:**

// Reading providers in build without watching  
final user = ref.read(currentUserProvider); // Won't rebuild!

**✅ Do this:**

// Watch providers to rebuild on changes  
final user = ref.watch(currentUserProvider);

**❌ Don’t do this:**

// Forgetting to handle null users  
final tasks = firestore.collection('tasks')  
.where('userId', isEqualTo: user.uid) // Might be null!

**✅ Do this:**

// Always check for null  
if (user == null) return Stream.value([]);  
final tasks = firestore.collection('tasks')  
.where('userId', isEqualTo: user.uid)

## Performance Optimization Tips

**Use select() for specific fields:**

// Only rebuild when email changes  
final email = ref.watch(currentUserProvider.select((user) => user.value?.email));

**Limit Firestore queries:**

// Add .limit() to prevent loading too much data  
.collection('tasks')  
.where('userId', isEqualTo: userId)  
.orderBy('createdAt', descending: true)  
.limit(50)

**Pagination with Firestore:**

@riverpod  
Stream<List<Task>> paginatedTasks( PaginatedTasksRef ref,  
DocumentSnapshot? lastDoc,) {  
var query = firestore  
.collection('tasks')  
.orderBy('createdAt', descending: true)  
.limit(20);

if (lastDoc != null) {  
query = query.startAfterDocument(lastDoc);  
}

return query.snapshots().map((snapshot) => ...);  
}

## Testing Your Firebase + Riverpod App

Testing is super easy with Riverpod:

void main() {  
test('User tasks stream emits correctly', () async {  
final container = ProviderContainer(  
overrides: [  
firestoreProvider.overrideWithValue(mockFirestore),  
currentUserProvider.overrideWith((_) => Stream.value(testUser)),  
],  
);

    final tasks = await container.read(userTasksProvider.future);  
    expect(tasks, isNotEmpty);  
});  
}

## What’s Next?

You now have a solid Firebase + Riverpod foundation! Here are some features you can add:

-   Cloud Storage for file uploads
-   Firebase Cloud Messaging for push notifications
-   Cloud Functions for backend logic
-   Firebase Analytics for tracking
-   Remote Config for feature flags
-   Firebase Performance Monitoring

## Wrapping Up

Look, Firebase + Riverpod 3.0 is the dream team for Flutter development. You get a powerful backend without managing servers, and clean state management that makes your code a joy to work with.

The setup I showed you today is production-ready. I’ve used this exact pattern in apps with thousands of users, and it scales beautifully.

No more wrestling with state management. No more complicated backend setup. Just clean, maintainable code that lets you focus on building features your users will love.

Now go build something amazing! 🔥