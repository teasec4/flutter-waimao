import 'package:paste_tool/domain/entities/volume_session.dart';
import 'package:paste_tool/domain/repositories/volume_session_repository.dart';

/// Usecase для управления сохранёнными сессиями расчёта загрузки.
class ManageSessions {
  final VolumeSessionRepository _repository;

  ManageSessions({required VolumeSessionRepository repository})
      : _repository = repository;

  /// Все сессии.
  List<VolumeSession> getAll() => _repository.getAll();

  /// Сохранить новую сессию.
  void save(VolumeSession session) => _repository.save(session);

  /// Удалить сессию.
  void delete(String id) => _repository.delete(id);

  /// Обновить существующую сессию.
  void update(VolumeSession session) => _repository.update(session);
}
