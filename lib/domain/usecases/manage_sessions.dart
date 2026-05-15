import 'package:paste_tool/domain/entities/volume_session.dart';
import 'package:paste_tool/domain/repositories/volume_session_repository.dart';

/// Usecase для управления сохранёнными сессиями расчёта загрузки.
class ManageSessions {
  final VolumeSessionRepository _repository;

  ManageSessions({required VolumeSessionRepository repository})
    : _repository = repository;

  /// Все сессии.
  Future<List<VolumeSession>> getAll() => _repository.getAll();

  /// Сохранить новую сессию.
  Future<void> save(VolumeSession session) => _repository.save(session);

  /// Удалить сессию.
  Future<void> delete(String id) => _repository.delete(id);

  /// Обновить существующую сессию.
  Future<void> update(VolumeSession session) => _repository.update(session);
}
