// lib/data/index.dart

// Import all lesson files here
import 'lesson1.dart';
import 'lesson20.dart';
import 'lesson0.dart';
import '../models/lesson.dart';

// Export them if you also want direct access
export 'lesson1.dart';
export 'lesson20.dart';
export 'lesson0.dart';

// Now provide a single list that contains all lessons
List<Lesson> lessons = [lesson1, lesson20, lesson0];
