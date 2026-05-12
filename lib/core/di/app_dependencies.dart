import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:paste_tool/data/collections/phrase_collection.dart';
import 'package:paste_tool/data/collections/volume_item_collection.dart';
import 'package:paste_tool/data/collections/volume_session_collection.dart';
import 'package:paste_tool/data/collections/phrase_category_collection.dart';
import 'package:paste_tool/data/collections/truck_collection.dart';
import 'package:paste_tool/data/collections/todo_list_collection.dart';
import 'package:paste_tool/data/collections/todo_item_collection.dart';
import 'package:paste_tool/data/repositories/phrase_repository_impl.dart';
import 'package:paste_tool/data/repositories/volume_repository_impl.dart';
import 'package:paste_tool/data/repositories/volume_session_repository_impl.dart';
import 'package:paste_tool/data/repositories/phrase_category_repository_impl.dart';
import 'package:paste_tool/data/repositories/truck_repository_impl.dart';
import 'package:paste_tool/data/repositories/dictionary_repository_impl.dart';
import 'package:paste_tool/data/repositories/todo_list_repository_impl.dart';
import 'package:paste_tool/data/repositories/todo_item_repository_impl.dart';
import 'package:paste_tool/domain/usecases/manage_phrases.dart';
import 'package:paste_tool/domain/usecases/manage_volume.dart';
import 'package:paste_tool/domain/usecases/manage_sessions.dart';
import 'package:paste_tool/domain/usecases/manage_trucks.dart';
import 'package:paste_tool/domain/usecases/manage_categories.dart';
import 'package:paste_tool/domain/usecases/search_dictionary.dart';
import 'package:paste_tool/domain/usecases/manage_todo_lists.dart';
import 'package:paste_tool/domain/usecases/manage_todo_items.dart';
import 'package:paste_tool/presentation/providers/phrase_provider.dart';
import 'package:paste_tool/presentation/providers/volume_provider.dart';
import 'package:paste_tool/presentation/providers/dictionary_provider.dart';
import 'package:paste_tool/presentation/providers/todo_provider.dart';

final class AppDependencies {
  AppDependencies._();

  late final Isar isar;

  late final PhraseRepositoryImpl phraseRepository;
  late final VolumeRepositoryImpl volumeRepository;
  late final PhraseCategoryRepositoryImpl phraseCategoryRepository;
  late final TruckRepositoryImpl truckRepository;
  late final VolumeSessionRepositoryImpl volumeSessionRepository;
  late final ApiDictionaryRepository dictionaryRepository;
  late final TodoListRepositoryImpl todoListRepository;
  late final TodoItemRepositoryImpl todoItemRepository;

  late final ManagePhrases managePhrases;
  late final ManageVolume manageVolume;
  late final ManageCategories manageCategories;
  late final ManageTrucks manageTrucks;
  late final ManageSessions manageSessions;
  late final SearchDictionary searchDictionary;
  late final ManageTodoLists manageTodoLists;
  late final ManageTodoItems manageTodoItems;

  late final PhraseProvider phraseProvider;
  late final VolumeProvider volumeProvider;
  late final DictionaryProvider dictionaryProvider;
  late final TodoProvider todoProvider;

  static final AppDependencies _instance = AppDependencies._();

  static AppDependencies get instance => _instance;

  static Future<void> init() async {
    final i = _instance;

    final dir = await getApplicationDocumentsDirectory();
    i.isar = await Isar.open([
      PhraseCollectionSchema,
      VolumeItemCollectionSchema,
      VolumeSessionCollectionSchema,
      PhraseCategoryCollectionSchema,
      TruckCollectionSchema,
      TodoListCollectionSchema,
      TodoItemCollectionSchema,
    ], directory: dir.path);

    i.phraseRepository = PhraseRepositoryImpl(isar: i.isar);
    i.volumeRepository = VolumeRepositoryImpl(isar: i.isar);
    i.phraseCategoryRepository = PhraseCategoryRepositoryImpl(isar: i.isar);
    i.truckRepository = TruckRepositoryImpl(isar: i.isar);
    i.volumeSessionRepository = VolumeSessionRepositoryImpl(isar: i.isar);
    i.dictionaryRepository = ApiDictionaryRepository();
    i.todoListRepository = TodoListRepositoryImpl(isar: i.isar);
    i.todoItemRepository = TodoItemRepositoryImpl(isar: i.isar);

    i.managePhrases = ManagePhrases(i.phraseRepository);
    i.manageVolume = ManageVolume(i.volumeRepository);
    i.manageCategories = ManageCategories(i.phraseCategoryRepository, i.phraseRepository);
    i.manageTrucks = ManageTrucks(i.truckRepository);
    i.manageSessions = ManageSessions(repository: i.volumeSessionRepository);
    i.searchDictionary = SearchDictionary(repository: i.dictionaryRepository);
    i.manageTodoLists = ManageTodoLists(i.todoListRepository);
    i.manageTodoItems = ManageTodoItems(i.todoItemRepository);

    i.phraseProvider = PhraseProvider(i.managePhrases, i.manageCategories);
    i.volumeProvider = VolumeProvider(i.manageVolume, i.manageTrucks, i.manageSessions);
    i.dictionaryProvider = DictionaryProvider(i.searchDictionary);
    i.todoProvider = TodoProvider(i.manageTodoLists, i.manageTodoItems);
  }
}
