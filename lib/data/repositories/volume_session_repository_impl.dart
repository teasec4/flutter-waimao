import 'package:isar_community/isar.dart';
import 'package:paste_tool/data/collections/volume_session_collection.dart';
import 'package:paste_tool/domain/entities/volume_session.dart';
import 'package:paste_tool/domain/repositories/volume_session_repository.dart';

class VolumeSessionRepositoryImpl implements VolumeSessionRepository {
  final Isar isar;

  VolumeSessionRepositoryImpl({required this.isar});

  @override
  Future<List<VolumeSession>> getAll() async {
    return isar.volumeSessionCollections
        .where()
        .sortByCreatedAtDesc()
        .findAll()
        .then((list) => list.map((c) => c.toEntity()).toList());
  }

  @override
  Future<void> save(VolumeSession session) async {
    final collection = VolumeSessionCollection.fromEntity(session);
    await isar.writeTxn(() => isar.volumeSessionCollections.put(collection));
  }

  @override
  Future<void> delete(String id) async {
    final existing = await isar.volumeSessionCollections
        .filter()
        .uuidEqualTo(id)
        .findAll();
    if (existing.isNotEmpty) {
      await isar.writeTxn(
        () => isar.volumeSessionCollections.deleteAll(
          existing.map((e) => e.id).toList(),
        ),
      );
    }
  }

  @override
  Future<void> update(VolumeSession session) async {
    final collection = VolumeSessionCollection.fromEntity(session);
    final existing = await isar.volumeSessionCollections
        .filter()
        .uuidEqualTo(session.id)
        .findFirst();
    if (existing != null) {
      collection.id = existing.id;
      await isar.writeTxn(() => isar.volumeSessionCollections.put(collection));
    }
  }
}
