// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'truck_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTruckCollectionCollection on Isar {
  IsarCollection<TruckCollection> get truckCollections => this.collection();
}

const TruckCollectionSchema = CollectionSchema(
  name: r'TruckCollection',
  id: -6633922593753956480,
  properties: {
    r'bodyHeight': PropertySchema(
      id: 0,
      name: r'bodyHeight',
      type: IsarType.double,
    ),
    r'bodyLength': PropertySchema(
      id: 1,
      name: r'bodyLength',
      type: IsarType.double,
    ),
    r'bodyWidth': PropertySchema(
      id: 2,
      name: r'bodyWidth',
      type: IsarType.double,
    ),
    r'maxLoad': PropertySchema(id: 3, name: r'maxLoad', type: IsarType.double),
    r'name': PropertySchema(id: 4, name: r'name', type: IsarType.string),
    r'uuid': PropertySchema(id: 5, name: r'uuid', type: IsarType.string),
  },

  estimateSize: _truckCollectionEstimateSize,
  serialize: _truckCollectionSerialize,
  deserialize: _truckCollectionDeserialize,
  deserializeProp: _truckCollectionDeserializeProp,
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

  getId: _truckCollectionGetId,
  getLinks: _truckCollectionGetLinks,
  attach: _truckCollectionAttach,
  version: '3.3.2',
);

int _truckCollectionEstimateSize(
  TruckCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _truckCollectionSerialize(
  TruckCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.bodyHeight);
  writer.writeDouble(offsets[1], object.bodyLength);
  writer.writeDouble(offsets[2], object.bodyWidth);
  writer.writeDouble(offsets[3], object.maxLoad);
  writer.writeString(offsets[4], object.name);
  writer.writeString(offsets[5], object.uuid);
}

TruckCollection _truckCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TruckCollection();
  object.bodyHeight = reader.readDouble(offsets[0]);
  object.bodyLength = reader.readDouble(offsets[1]);
  object.bodyWidth = reader.readDouble(offsets[2]);
  object.id = id;
  object.maxLoad = reader.readDouble(offsets[3]);
  object.name = reader.readString(offsets[4]);
  object.uuid = reader.readString(offsets[5]);
  return object;
}

P _truckCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _truckCollectionGetId(TruckCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _truckCollectionGetLinks(TruckCollection object) {
  return [];
}

void _truckCollectionAttach(
  IsarCollection<dynamic> col,
  Id id,
  TruckCollection object,
) {
  object.id = id;
}

extension TruckCollectionQueryWhereSort
    on QueryBuilder<TruckCollection, TruckCollection, QWhere> {
  QueryBuilder<TruckCollection, TruckCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TruckCollectionQueryWhere
    on QueryBuilder<TruckCollection, TruckCollection, QWhereClause> {
  QueryBuilder<TruckCollection, TruckCollection, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterWhereClause>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterWhereClause> idBetween(
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterWhereClause> uuidEqualTo(
    String uuid,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'uuid', value: [uuid]),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterWhereClause>
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

extension TruckCollectionQueryFilter
    on QueryBuilder<TruckCollection, TruckCollection, QFilterCondition> {
  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  bodyHeightEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'bodyHeight',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  bodyHeightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bodyHeight',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  bodyHeightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bodyHeight',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  bodyHeightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bodyHeight',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  bodyLengthEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'bodyLength',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  bodyLengthGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bodyLength',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  bodyLengthLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bodyLength',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  bodyLengthBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bodyLength',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  bodyWidthEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'bodyWidth',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  bodyWidthGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'bodyWidth',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  bodyWidthLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'bodyWidth',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  bodyWidthBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'bodyWidth',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  maxLoadEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'maxLoad',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  maxLoadGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'maxLoad',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  maxLoadLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'maxLoad',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  maxLoadBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'maxLoad',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
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

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'uuid', value: ''),
      );
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterFilterCondition>
  uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'uuid', value: ''),
      );
    });
  }
}

extension TruckCollectionQueryObject
    on QueryBuilder<TruckCollection, TruckCollection, QFilterCondition> {}

extension TruckCollectionQueryLinks
    on QueryBuilder<TruckCollection, TruckCollection, QFilterCondition> {}

extension TruckCollectionQuerySortBy
    on QueryBuilder<TruckCollection, TruckCollection, QSortBy> {
  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy>
  sortByBodyHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyHeight', Sort.asc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy>
  sortByBodyHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyHeight', Sort.desc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy>
  sortByBodyLength() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyLength', Sort.asc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy>
  sortByBodyLengthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyLength', Sort.desc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy>
  sortByBodyWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyWidth', Sort.asc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy>
  sortByBodyWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyWidth', Sort.desc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy> sortByMaxLoad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxLoad', Sort.asc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy>
  sortByMaxLoadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxLoad', Sort.desc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy>
  sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy>
  sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension TruckCollectionQuerySortThenBy
    on QueryBuilder<TruckCollection, TruckCollection, QSortThenBy> {
  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy>
  thenByBodyHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyHeight', Sort.asc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy>
  thenByBodyHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyHeight', Sort.desc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy>
  thenByBodyLength() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyLength', Sort.asc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy>
  thenByBodyLengthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyLength', Sort.desc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy>
  thenByBodyWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyWidth', Sort.asc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy>
  thenByBodyWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bodyWidth', Sort.desc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy> thenByMaxLoad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxLoad', Sort.asc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy>
  thenByMaxLoadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxLoad', Sort.desc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy>
  thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QAfterSortBy>
  thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension TruckCollectionQueryWhereDistinct
    on QueryBuilder<TruckCollection, TruckCollection, QDistinct> {
  QueryBuilder<TruckCollection, TruckCollection, QDistinct>
  distinctByBodyHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bodyHeight');
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QDistinct>
  distinctByBodyLength() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bodyLength');
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QDistinct>
  distinctByBodyWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bodyWidth');
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QDistinct>
  distinctByMaxLoad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxLoad');
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TruckCollection, TruckCollection, QDistinct> distinctByUuid({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension TruckCollectionQueryProperty
    on QueryBuilder<TruckCollection, TruckCollection, QQueryProperty> {
  QueryBuilder<TruckCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TruckCollection, double, QQueryOperations> bodyHeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bodyHeight');
    });
  }

  QueryBuilder<TruckCollection, double, QQueryOperations> bodyLengthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bodyLength');
    });
  }

  QueryBuilder<TruckCollection, double, QQueryOperations> bodyWidthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bodyWidth');
    });
  }

  QueryBuilder<TruckCollection, double, QQueryOperations> maxLoadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxLoad');
    });
  }

  QueryBuilder<TruckCollection, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<TruckCollection, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
