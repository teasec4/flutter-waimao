import 'package:paste_tool/domain/entities/volume_session.dart';

/// Репозиторий сохранённых сессий расчёта загрузки.
abstract class VolumeSessionRepository {
  /// Все сохранённые сессии, от новых к старым.
  Future<List<VolumeSession>> getAll();

  /// Сохранить новую сессию.
  Future<void> save(VolumeSession session);

  /// Удалить сессию.
  Future<void> delete(String id);

  /// Обновить существующую сессию (товары, дату).
  Future<void> update(VolumeSession session);
}
