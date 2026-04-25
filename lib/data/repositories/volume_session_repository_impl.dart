import 'package:isar_community/isar.dart';
import 'package:paste_tool/data/collections/volume_session_collection.dart';
import 'package:paste_tool/domain/entities/volume_session.dart';
import 'package:paste_tool/domain/repositories/volume_session_repository.dart';

class VolumeSessionRepositoryImpl implements VolumeSessionRepository {
  final Isar isar;

  VolumeSessionRepositoryImpl({required this.isar});

  @override
  List<VolumeSession> getAll() {
    return isar.volumeSessionCollections
        .where()
        .sortByCreatedAtDesc()
        .findAllSync()
        .map((c) => c.toEntity())
        .toList();
  }

  @override
  void save(VolumeSession session) {
    final collection = VolumeSessionCollection.fromEntity(session);
    isar.writeTxnSync(() => isar.volumeSessionCollections.putSync(collection));
  }

  @override
  void delete(String id) {
    final existing = isar.volumeSessionCollections
        .filter()
        .uuidEqualTo(id)
        .findAllSync();
    if (existing.isNotEmpty) {
      isar.writeTxnSync(
        () => isar.volumeSessionCollections.deleteAllSync(
          existing.map((e) => e.id).toList(),
        ),
      );
    }
  }

  @override
  void update(VolumeSession session) {
    final collection = VolumeSessionCollection.fromEntity(session);
    // Ищем существующую запись по uuid и обновляем
    final existing = isar.volumeSessionCollections
        .filter()
        .uuidEqualTo(session.id)
        .findFirstSync();
    if (existing != null) {
      collection.id = existing.id;
      isar.writeTxnSync(() => isar.volumeSessionCollections.putSync(collection));
    }
  }
}
