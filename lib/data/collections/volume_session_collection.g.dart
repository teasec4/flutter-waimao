// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_session_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVolumeSessionCollectionCollection on Isar {
  IsarCollection<VolumeSessionCollection> get volumeSessionCollections =>
      this.collection();
}

const VolumeSessionCollectionSchema = CollectionSchema(
  name: r'VolumeSessionCollection',
  id: -6805947485274475412,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.string,
    ),
    r'itemsJson': PropertySchema(
      id: 1,
      name: r'itemsJson',
      type: IsarType.string,
    ),
    r'name': PropertySchema(id: 2, name: r'name', type: IsarType.string),
    r'truckHeight': PropertySchema(
      id: 3,
      name: r'truckHeight',
      type: IsarType.double,
    ),
    r'truckId': PropertySchema(id: 4, name: r'truckId', type: IsarType.string),
    r'truckLength': PropertySchema(
      id: 5,
      name: r'truckLength',
      type: IsarType.double,
    ),
    r'truckMaxLoad': PropertySchema(
      id: 6,
      name: r'truckMaxLoad',
      type: IsarType.double,
    ),
    r'truckName': PropertySchema(
      id: 7,
      name: r'truckName',
      type: IsarType.string,
    ),
    r'truckWidth': PropertySchema(
      id: 8,
      name: r'truckWidth',
      type: IsarType.double,
    ),
    r'updatedAt': PropertySchema(
      id: 9,
      name: r'updatedAt',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(id: 10, name: r'uuid', type: IsarType.string),
  },

  estimateSize: _volumeSessionCollectionEstimateSize,
  serialize: _volumeSessionCollectionSerialize,
  deserialize: _volumeSessionCollectionDeserialize,
  deserializeProp: _volumeSessionCollectionDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: 2134397340427724972,
      name: r'uuid',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'uuid',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _volumeSessionCollectionGetId,
  getLinks: _volumeSessionCollectionGetLinks,
  attach: _volumeSessionCollectionAttach,
  version: '3.3.2',
);

int _volumeSessionCollectionEstimateSize(
  VolumeSessionCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.createdAt.length * 3;
  bytesCount += 3 + object.itemsJson.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.truckId.length * 3;
  bytesCount += 3 + object.truckName.length * 3;
  bytesCount += 3 + object.updatedAt.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _volumeSessionCollectionSerialize(
  VolumeSessionCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.itemsJson);
  writer.writeString(offsets[2], object.name);
  writer.writeDouble(offsets[3], object.truckHeight);
  writer.writeString(offsets[4], object.truckId);
  writer.writeDouble(offsets[5], object.truckLength);
  writer.writeDouble(offsets[6], object.truckMaxLoad);
  writer.writeString(offsets[7], object.truckName);
  writer.writeDouble(offsets[8], object.truckWidth);
  writer.writeString(offsets[9], object.updatedAt);
  writer.writeString(offsets[10], object.uuid);
}

VolumeSessionCollection _volumeSessionCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VolumeSessionCollection();
  object.createdAt = reader.readString(offsets[0]);
  object.id = id;
  object.itemsJson = reader.readString(offsets[1]);
  object.name = reader.readString(offsets[2]);
  object.truckHeight = reader.readDouble(offsets[3]);
  object.truckId = reader.readString(offsets[4]);
  object.truckLength = reader.readDouble(offsets[5]);
  object.truckMaxLoad = reader.readDouble(offsets[6]);
  object.truckName = reader.readString(offsets[7]);
  object.truckWidth = reader.readDouble(offsets[8]);
  object.updatedAt = reader.readString(offsets[9]);
  object.uuid = reader.readString(offsets[10]);
  return object;
}

P _volumeSessionCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readDouble(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _volumeSessionCollectionGetId(VolumeSessionCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _volumeSessionCollectionGetLinks(
  VolumeSessionCollection object,
) {
  return [];
}

void _volumeSessionCollectionAttach(
  IsarCollection<dynamic> col,
  Id id,
  VolumeSessionCollection object,
) {
  object.id = id;
}

extension VolumeSessionCollectionQueryWhereSort
    on QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QWhere> {
  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VolumeSessionCollectionQueryWhere
    on
        QueryBuilder<
          VolumeSessionCollection,
          VolumeSessionCollection,
          QWhereClause
        > {
  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterWhereClause
  >
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterWhereClause
  >
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

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterWhereClause
  >
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterWhereClause
  >
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterWhereClause
  >
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

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterWhereClause
  >
  uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'uuid', value: [uuid]),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterWhereClause
  >
  uuidNotEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uuid',
                lower: [],
                upper: [uuid],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uuid',
                lower: [uuid],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uuid',
                lower: [uuid],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uuid',
                lower: [],
                upper: [uuid],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension VolumeSessionCollectionQueryFilter
    on
        QueryBuilder<
          VolumeSessionCollection,
          VolumeSessionCollection,
          QFilterCondition
        > {
  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  createdAtEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'createdAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  createdAtGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  createdAtLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  createdAtBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  createdAtStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'createdAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  createdAtEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'createdAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  createdAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'createdAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  createdAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'createdAt',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  createdAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: ''),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  createdAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'createdAt', value: ''),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  itemsJsonEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'itemsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  itemsJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'itemsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  itemsJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'itemsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  itemsJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'itemsJson',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  itemsJsonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'itemsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  itemsJsonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'itemsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  itemsJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'itemsJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  itemsJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'itemsJson',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  itemsJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'itemsJson', value: ''),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  itemsJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'itemsJson', value: ''),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  nameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  nameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  nameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckHeightEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'truckHeight',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckHeightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'truckHeight',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckHeightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'truckHeight',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckHeightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'truckHeight',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'truckId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'truckId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'truckId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'truckId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'truckId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'truckId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'truckId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'truckId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'truckId', value: ''),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'truckId', value: ''),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckLengthEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'truckLength',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckLengthGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'truckLength',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckLengthLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'truckLength',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckLengthBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'truckLength',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckMaxLoadEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'truckMaxLoad',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckMaxLoadGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'truckMaxLoad',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckMaxLoadLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'truckMaxLoad',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckMaxLoadBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'truckMaxLoad',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'truckName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'truckName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'truckName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'truckName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'truckName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'truckName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'truckName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'truckName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'truckName', value: ''),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'truckName', value: ''),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckWidthEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'truckWidth',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckWidthGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'truckWidth',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckWidthLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'truckWidth',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  truckWidthBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'truckWidth',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  updatedAtEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'updatedAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  updatedAtGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'updatedAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  updatedAtLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'updatedAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  updatedAtBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'updatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  updatedAtStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'updatedAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  updatedAtEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'updatedAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  updatedAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'updatedAt',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  updatedAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'updatedAt',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  updatedAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: ''),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  updatedAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'updatedAt', value: ''),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
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

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'uuid', value: ''),
      );
    });
  }

  QueryBuilder<
    VolumeSessionCollection,
    VolumeSessionCollection,
    QAfterFilterCondition
  >
  uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'uuid', value: ''),
      );
    });
  }
}

extension VolumeSessionCollectionQueryObject
    on
        QueryBuilder<
          VolumeSessionCollection,
          VolumeSessionCollection,
          QFilterCondition
        > {}

extension VolumeSessionCollectionQueryLinks
    on
        QueryBuilder<
          VolumeSessionCollection,
          VolumeSessionCollection,
          QFilterCondition
        > {}

extension VolumeSessionCollectionQuerySortBy
    on QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QSortBy> {
  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByItemsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemsJson', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByItemsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemsJson', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByTruckHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckHeight', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByTruckHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckHeight', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByTruckId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckId', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByTruckIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckId', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByTruckLength() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckLength', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByTruckLengthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckLength', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByTruckMaxLoad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckMaxLoad', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByTruckMaxLoadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckMaxLoad', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByTruckName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckName', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByTruckNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckName', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByTruckWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckWidth', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByTruckWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckWidth', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension VolumeSessionCollectionQuerySortThenBy
    on
        QueryBuilder<
          VolumeSessionCollection,
          VolumeSessionCollection,
          QSortThenBy
        > {
  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByItemsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemsJson', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByItemsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemsJson', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByTruckHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckHeight', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByTruckHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckHeight', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByTruckId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckId', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByTruckIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckId', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByTruckLength() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckLength', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByTruckLengthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckLength', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByTruckMaxLoad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckMaxLoad', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByTruckMaxLoadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckMaxLoad', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByTruckName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckName', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByTruckNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckName', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByTruckWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckWidth', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByTruckWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'truckWidth', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QAfterSortBy>
  thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension VolumeSessionCollectionQueryWhereDistinct
    on
        QueryBuilder<
          VolumeSessionCollection,
          VolumeSessionCollection,
          QDistinct
        > {
  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QDistinct>
  distinctByCreatedAt({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QDistinct>
  distinctByItemsJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itemsJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QDistinct>
  distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QDistinct>
  distinctByTruckHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'truckHeight');
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QDistinct>
  distinctByTruckId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'truckId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QDistinct>
  distinctByTruckLength() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'truckLength');
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QDistinct>
  distinctByTruckMaxLoad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'truckMaxLoad');
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QDistinct>
  distinctByTruckName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'truckName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QDistinct>
  distinctByTruckWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'truckWidth');
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QDistinct>
  distinctByUpdatedAt({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VolumeSessionCollection, VolumeSessionCollection, QDistinct>
  distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension VolumeSessionCollectionQueryProperty
    on
        QueryBuilder<
          VolumeSessionCollection,
          VolumeSessionCollection,
          QQueryProperty
        > {
  QueryBuilder<VolumeSessionCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<VolumeSessionCollection, String, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<VolumeSessionCollection, String, QQueryOperations>
  itemsJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itemsJson');
    });
  }

  QueryBuilder<VolumeSessionCollection, String, QQueryOperations>
  nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<VolumeSessionCollection, double, QQueryOperations>
  truckHeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'truckHeight');
    });
  }

  QueryBuilder<VolumeSessionCollection, String, QQueryOperations>
  truckIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'truckId');
    });
  }

  QueryBuilder<VolumeSessionCollection, double, QQueryOperations>
  truckLengthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'truckLength');
    });
  }

  QueryBuilder<VolumeSessionCollection, double, QQueryOperations>
  truckMaxLoadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'truckMaxLoad');
    });
  }

  QueryBuilder<VolumeSessionCollection, String, QQueryOperations>
  truckNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'truckName');
    });
  }

  QueryBuilder<VolumeSessionCollection, double, QQueryOperations>
  truckWidthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'truckWidth');
    });
  }

  QueryBuilder<VolumeSessionCollection, String, QQueryOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<VolumeSessionCollection, String, QQueryOperations>
  uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
