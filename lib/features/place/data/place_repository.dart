import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myhighst_map_app/features/place/domain/place_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'place_repository.g.dart';

@riverpod
PlaceRepository placeRepository(PlaceRepositoryRef ref) =>
    PlaceRepository(fs: FirebaseFirestore.instance);

class PlaceRepository {
  final FirebaseFirestore fs;

  PlaceRepository({required this.fs});

  Future<List<Place>> getPlaces(int? count) async {
    final Query query = fs.collection('places');
    final snapshots = query.get();
    List<Place> results = [];

    await snapshots.then((snapshots) {
      for (final doc in snapshots.docs) {
        results.add(Place.fromFirestore(doc));
      }
    });

    if (count != null) {
      results = results.sublist(0, count);
    }

    return results;
  }
}
