// lib/data/index.dart

// Import all lesson files here
import 'lesson1.dart';
import 'lesson20.dart';

// Export them if you also want direct access
export 'lesson1.dart';
export 'lesson20.dart';

// Now provide a single list that contains all lessons
final lessons = [
  lesson1,
  lesson20,
];
