import 'package:japanese_assistant/models/Paragraph/paragraph_lesson.dart';
import 'package:japanese_assistant/models/Paragraph/paragraph_unit.dart';
import 'package:japanese_assistant/models/Paragraph/paragraph.dart';
import 'package:japanese_assistant/models/Paragraph/question_answer.dart';

final paragraph1 = ParagraphLesson(
  lessonNumber: 1,
  lessonTitle: 'Self Introduction',
  lessonPages: '1-3',
  slug: 'self-introduction',
  units: [
    ParagraphUnit(
      title: 'Basic Introduction',
      slug: 'basic-introduction',
      items: [
        Paragraph(
          title: 'Nice to meet you',
          content: 'はじめまして。わたしはウジワルです。',
          meaning: 'Nice to meet you. I am Ujwal.',
          questions: [
            QuestionAnswer(
              question: 'What does はじめまして mean?',
              answer: 'It means "Nice to meet you."',
            ),
            QuestionAnswer(
              question: 'What is the speaker’s name?',
              answer: 'The speaker’s name is Ujwal.',
            ),
          ],
        ),
        Paragraph(
          title: 'From India',
          content: 'インドから来ました。',
          meaning: 'I came from India.',
          questions: [
            QuestionAnswer(
              question: 'Which country is mentioned?',
              answer: 'India is mentioned.',
            ),
          ],
        ),
      ],
    ),
    ParagraphUnit(
      title: 'Polite Ending',
      slug: 'polite-ending',
      items: [
        Paragraph(
          title: 'Please take care of me',
          content: 'どうぞよろしくお願いします。',
          meaning: 'Please be kind to me / I look forward to working with you.',
          questions: [
            QuestionAnswer(
              question: 'Is this phrase polite?',
              answer: 'Yes, it is a polite closing phrase.',
            ),
          ],
        ),
      ],
    ),
  ],
);
