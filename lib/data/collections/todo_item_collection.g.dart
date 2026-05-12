// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_item_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTodoItemCollectionCollection on Isar {
  IsarCollection<TodoItemCollection> get todoItemCollections =>
      this.collection();
}

const TodoItemCollectionSchema = CollectionSchema(
  name: r'TodoItemCollection',
  id: -4732571965888487775,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'isDone': PropertySchema(id: 1, name: r'isDone', type: IsarType.bool),
    r'listId': PropertySchema(id: 2, name: r'listId', type: IsarType.string),
    r'listIndex': PropertySchema(
      id: 3,
      name: r'listIndex',
      type: IsarType.string,
    ),
    r'sortOrder': PropertySchema(
      id: 4,
      name: r'sortOrder',
      type: IsarType.long,
    ),
    r'text': PropertySchema(id: 5, name: r'text', type: IsarType.string),
    r'uuid': PropertySchema(id: 6, name: r'uuid', type: IsarType.string),
    r'uuidIndex': PropertySchema(
      id: 7,
      name: r'uuidIndex',
      type: IsarType.string,
    ),
  },

  estimateSize: _todoItemCollectionEstimateSize,
  serialize: _todoItemCollectionSerialize,
  deserialize: _todoItemCollectionDeserialize,
  deserializeProp: _todoItemCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuidIndex': IndexSchema(
      id: -7968580825086528144,
      name: r'uuidIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'uuidIndex',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'listIndex': IndexSchema(
      id: -5764065629612488335,
      name: r'listIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'listIndex',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _todoItemCollectionGetId,
  getLinks: _todoItemCollectionGetLinks,
  attach: _todoItemCollectionAttach,
  version: '3.3.2',
);

int _todoItemCollectionEstimateSize(
  TodoItemCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.listId.length * 3;
  {
    final value = object.listIndex;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.text.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  {
    final value = object.uuidIndex;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _todoItemCollectionSerialize(
  TodoItemCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeBool(offsets[1], object.isDone);
  writer.writeString(offsets[2], object.listId);
  writer.writeString(offsets[3], object.listIndex);
  writer.writeLong(offsets[4], object.sortOrder);
  writer.writeString(offsets[5], object.text);
  writer.writeString(offsets[6], object.uuid);
  writer.writeString(offsets[7], object.uuidIndex);
}

TodoItemCollection _todoItemCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TodoItemCollection();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.id = id;
  object.isDone = reader.readBool(offsets[1]);
  object.listId = reader.readString(offsets[2]);
  object.sortOrder = reader.readLong(offsets[4]);
  object.text = reader.readString(offsets[5]);
  object.uuid = reader.readString(offsets[6]);
  return object;
}

P _todoItemCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _todoItemCollectionGetId(TodoItemCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _todoItemCollectionGetLinks(
  TodoItemCollection object,
) {
  return [];
}

void _todoItemCollectionAttach(
  IsarCollection<dynamic> col,
  Id id,
  TodoItemCollection object,
) {
  object.id = id;
}

extension TodoItemCollectionQueryWhereSort
    on QueryBuilder<TodoItemCollection, TodoItemCollection, QWhere> {
  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TodoItemCollectionQueryWhere
    on QueryBuilder<TodoItemCollection, TodoItemCollection, QWhereClause> {
  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterWhereClause>
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterWhereClause>
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterWhereClause>
  uuidIndexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'uuidIndex', value: [null]),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterWhereClause>
  uuidIndexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'uuidIndex',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterWhereClause>
  uuidIndexEqualTo(String? uuidIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'uuidIndex', value: [uuidIndex]),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterWhereClause>
  uuidIndexNotEqualTo(String? uuidIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uuidIndex',
                lower: [],
                upper: [uuidIndex],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uuidIndex',
                lower: [uuidIndex],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uuidIndex',
                lower: [uuidIndex],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uuidIndex',
                lower: [],
                upper: [uuidIndex],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterWhereClause>
  listIndexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'listIndex', value: [null]),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterWhereClause>
  listIndexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'listIndex',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterWhereClause>
  listIndexEqualTo(String? listIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'listIndex', value: [listIndex]),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterWhereClause>
  listIndexNotEqualTo(String? listIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'listIndex',
                lower: [],
                upper: [listIndex],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'listIndex',
                lower: [listIndex],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'listIndex',
                lower: [listIndex],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'listIndex',
                lower: [],
                upper: [listIndex],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension TodoItemCollectionQueryFilter
    on QueryBuilder<TodoItemCollection, TodoItemCollection, QFilterCondition> {
  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  isDoneEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isDone', value: value),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'listId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'listId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'listId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'listId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'listId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'listId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'listId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'listId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'listId', value: ''),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'listId', value: ''),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIndexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'listIndex'),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIndexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'listIndex'),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIndexEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'listIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIndexGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'listIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIndexLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'listIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIndexBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'listIndex',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIndexStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'listIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIndexEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'listIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIndexContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'listIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIndexMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'listIndex',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIndexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'listIndex', value: ''),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  listIndexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'listIndex', value: ''),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  sortOrderEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sortOrder', value: value),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  sortOrderGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sortOrder',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  sortOrderLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sortOrder',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  sortOrderBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sortOrder',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  textEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'text',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  textStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  textEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  textContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'text',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  textMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'text',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'text', value: ''),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'text', value: ''),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'uuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'uuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'uuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'uuid',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'uuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'uuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'uuid',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'uuid',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'uuid', value: ''),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'uuid', value: ''),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidIndexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'uuidIndex'),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidIndexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'uuidIndex'),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidIndexEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'uuidIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidIndexGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'uuidIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidIndexLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'uuidIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidIndexBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'uuidIndex',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidIndexStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'uuidIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidIndexEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'uuidIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidIndexContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'uuidIndex',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidIndexMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'uuidIndex',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidIndexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'uuidIndex', value: ''),
      );
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterFilterCondition>
  uuidIndexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'uuidIndex', value: ''),
      );
    });
  }
}

extension TodoItemCollectionQueryObject
    on QueryBuilder<TodoItemCollection, TodoItemCollection, QFilterCondition> {}

extension TodoItemCollectionQueryLinks
    on QueryBuilder<TodoItemCollection, TodoItemCollection, QFilterCondition> {}

extension TodoItemCollectionQuerySortBy
    on QueryBuilder<TodoItemCollection, TodoItemCollection, QSortBy> {
  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  sortByIsDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDone', Sort.asc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  sortByIsDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDone', Sort.desc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  sortByListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listId', Sort.asc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  sortByListIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listId', Sort.desc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  sortByListIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listIndex', Sort.asc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  sortByListIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listIndex', Sort.desc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  sortBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.asc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  sortBySortOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.desc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  sortByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  sortByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  sortByUuidIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuidIndex', Sort.asc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  sortByUuidIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuidIndex', Sort.desc);
    });
  }
}

extension TodoItemCollectionQuerySortThenBy
    on QueryBuilder<TodoItemCollection, TodoItemCollection, QSortThenBy> {
  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  thenByIsDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDone', Sort.asc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  thenByIsDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDone', Sort.desc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  thenByListId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listId', Sort.asc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  thenByListIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listId', Sort.desc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  thenByListIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listIndex', Sort.asc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  thenByListIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listIndex', Sort.desc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  thenBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.asc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  thenBySortOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sortOrder', Sort.desc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  thenByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  thenByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  thenByUuidIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuidIndex', Sort.asc);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QAfterSortBy>
  thenByUuidIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuidIndex', Sort.desc);
    });
  }
}

extension TodoItemCollectionQueryWhereDistinct
    on QueryBuilder<TodoItemCollection, TodoItemCollection, QDistinct> {
  QueryBuilder<TodoItemCollection, TodoItemCollection, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QDistinct>
  distinctByIsDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDone');
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QDistinct>
  distinctByListId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'listId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QDistinct>
  distinctByListIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'listIndex', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QDistinct>
  distinctBySortOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sortOrder');
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QDistinct>
  distinctByText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'text', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QDistinct>
  distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TodoItemCollection, TodoItemCollection, QDistinct>
  distinctByUuidIndex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuidIndex', caseSensitive: caseSensitive);
    });
  }
}

extension TodoItemCollectionQueryProperty
    on QueryBuilder<TodoItemCollection, TodoItemCollection, QQueryProperty> {
  QueryBuilder<TodoItemCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TodoItemCollection, DateTime, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<TodoItemCollection, bool, QQueryOperations> isDoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDone');
    });
  }

  QueryBuilder<TodoItemCollection, String, QQueryOperations> listIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'listId');
    });
  }

  QueryBuilder<TodoItemCollection, String?, QQueryOperations>
  listIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'listIndex');
    });
  }

  QueryBuilder<TodoItemCollection, int, QQueryOperations> sortOrderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sortOrder');
    });
  }

  QueryBuilder<TodoItemCollection, String, QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }

  QueryBuilder<TodoItemCollection, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }

  QueryBuilder<TodoItemCollection, String?, QQueryOperations>
  uuidIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuidIndex');
    });
  }
}
