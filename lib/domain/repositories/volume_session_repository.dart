import 'package:paste_tool/domain/entities/volume_session.dart';

/// Репозиторий сохранённых сессий расчёта загрузки.
abstract class VolumeSessionRepository {
  /// Все сохранённые сессии, от новых к старым.
  List<VolumeSession> getAll();

  /// Сохранить новую сессию.
  void save(VolumeSession session);

  /// Удалить сессию.
  void delete(String id);

  /// Обновить существующую сессию (товары, дату).
  void update(VolumeSession session);
}
