import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_app_alpha/src/models/training_plan_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> createPaymentIntent({
    required String userId,
    required int amount,
  }) async {
    try {
      final docRef = _db
          .collection('stripe_customers')
          .doc(userId)
          .collection('payments')
          .doc();
      await docRef.set({'amount': amount, 'currency': 'usd'});
      return docRef.id;
    } catch (e) {
      // 🛡️ Sentinel: Catch generic exception to prevent internal db paths leakage
      throw Exception('Failed to create payment intent. Please try again.');
    }
  }

  Future<void> saveTrainingPlan(TrainingPlan trainingPlan) async {
    try {
      await _db.collection('training_plans').doc(trainingPlan.id).set({
        'name': trainingPlan.name,
        'trainerId': trainingPlan.trainerId,
        'athleteId': trainingPlan.athleteId,
        'exercises': trainingPlan.exercises
            .map(
              (e) => {
                'name': e.name,
                'sets': e.sets,
                'reps': e.reps,
                'notes': e.notes,
              },
            )
            .toList(),
      });
    } catch (e) {
      // 🛡️ Sentinel: Catch generic exception to prevent internal db paths leakage
      throw Exception('Failed to save training plan. Please try again.');
    }
  }

  Future<TrainingPlan?> getTrainingPlan(String id) async {
    try {
      final doc = await _db.collection('training_plans').doc(id).get();
      if (doc.exists) {
        final data = doc.data()!;
        return TrainingPlan(
          id: id,
          name: data['name'],
          trainerId: data['trainerId'],
          athleteId: data['athleteId'],
          exercises: (data['exercises'] as List)
              .map(
                (e) => Exercise(
                  name: e['name'],
                  sets: e['sets'],
                  reps: e['reps'],
                  notes: e['notes'],
                ),
              )
              .toList(),
        );
      }
      return null;
    } catch (e) {
      // 🛡️ Sentinel: Catch generic exception to prevent internal db paths leakage
      throw Exception('Failed to fetch training plan. Please try again.');
    }
  }
}
