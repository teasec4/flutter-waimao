// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_item_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVolumeItemCollectionCollection on Isar {
  IsarCollection<VolumeItemCollection> get volumeItemCollections =>
      this.collection();
}

const VolumeItemCollectionSchema = CollectionSchema(
  name: r'VolumeItemCollection',
  id: -7806075054518044338,
  properties: {
    r'height': PropertySchema(id: 0, name: r'height', type: IsarType.double),
    r'length': PropertySchema(id: 1, name: r'length', type: IsarType.double),
    r'quantity': PropertySchema(id: 2, name: r'quantity', type: IsarType.long),
    r'uuid': PropertySchema(id: 3, name: r'uuid', type: IsarType.string),
    r'weight': PropertySchema(id: 4, name: r'weight', type: IsarType.double),
    r'width': PropertySchema(id: 5, name: r'width', type: IsarType.double),
  },

  estimateSize: _volumeItemCollectionEstimateSize,
  serialize: _volumeItemCollectionSerialize,
  deserialize: _volumeItemCollectionDeserialize,
  deserializeProp: _volumeItemCollectionDeserializeProp,
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

  getId: _volumeItemCollectionGetId,
  getLinks: _volumeItemCollectionGetLinks,
  attach: _volumeItemCollectionAttach,
  version: '3.3.2',
);

int _volumeItemCollectionEstimateSize(
  VolumeItemCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _volumeItemCollectionSerialize(
  VolumeItemCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.height);
  writer.writeDouble(offsets[1], object.length);
  writer.writeLong(offsets[2], object.quantity);
  writer.writeString(offsets[3], object.uuid);
  writer.writeDouble(offsets[4], object.weight);
  writer.writeDouble(offsets[5], object.width);
}

VolumeItemCollection _volumeItemCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VolumeItemCollection();
  object.height = reader.readDouble(offsets[0]);
  object.id = id;
  object.length = reader.readDouble(offsets[1]);
  object.quantity = reader.readLong(offsets[2]);
  object.uuid = reader.readString(offsets[3]);
  object.weight = reader.readDouble(offsets[4]);
  object.width = reader.readDouble(offsets[5]);
  return object;
}

P _volumeItemCollectionDeserializeProp<P>(
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
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _volumeItemCollectionGetId(VolumeItemCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _volumeItemCollectionGetLinks(
  VolumeItemCollection object,
) {
  return [];
}

void _volumeItemCollectionAttach(
  IsarCollection<dynamic> col,
  Id id,
  VolumeItemCollection object,
) {
  object.id = id;
}

extension VolumeItemCollectionQueryWhereSort
    on QueryBuilder<VolumeItemCollection, VolumeItemCollection, QWhere> {
  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VolumeItemCollectionQueryWhere
    on QueryBuilder<VolumeItemCollection, VolumeItemCollection, QWhereClause> {
  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterWhereClause>
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

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterWhereClause>
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

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterWhereClause>
  uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'uuid', value: [uuid]),
      );
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterWhereClause>
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

extension VolumeItemCollectionQueryFilter
    on
        QueryBuilder<
          VolumeItemCollection,
          VolumeItemCollection,
          QFilterCondition
        > {
  QueryBuilder<
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  heightEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'height',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  heightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'height',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  heightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'height',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  heightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'height',
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
    VolumeItemCollection,
    VolumeItemCollection,
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
    VolumeItemCollection,
    VolumeItemCollection,
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
    VolumeItemCollection,
    VolumeItemCollection,
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
    VolumeItemCollection,
    VolumeItemCollection,
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
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  lengthEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'length',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  lengthGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'length',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  lengthLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'length',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  lengthBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'length',
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
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  quantityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'quantity', value: value),
      );
    });
  }

  QueryBuilder<
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  quantityGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'quantity',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  quantityLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'quantity',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  quantityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'quantity',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeItemCollection,
    VolumeItemCollection,
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
    VolumeItemCollection,
    VolumeItemCollection,
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
    VolumeItemCollection,
    VolumeItemCollection,
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
    VolumeItemCollection,
    VolumeItemCollection,
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
    VolumeItemCollection,
    VolumeItemCollection,
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
    VolumeItemCollection,
    VolumeItemCollection,
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
    VolumeItemCollection,
    VolumeItemCollection,
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
    VolumeItemCollection,
    VolumeItemCollection,
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
    VolumeItemCollection,
    VolumeItemCollection,
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
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'uuid', value: ''),
      );
    });
  }

  QueryBuilder<
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  weightEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'weight',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  weightGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'weight',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  weightLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'weight',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  weightBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'weight',
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
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  widthEqualTo(double value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'width',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  widthGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'width',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  widthLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'width',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<
    VolumeItemCollection,
    VolumeItemCollection,
    QAfterFilterCondition
  >
  widthBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'width',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }
}

extension VolumeItemCollectionQueryObject
    on
        QueryBuilder<
          VolumeItemCollection,
          VolumeItemCollection,
          QFilterCondition
        > {}

extension VolumeItemCollectionQueryLinks
    on
        QueryBuilder<
          VolumeItemCollection,
          VolumeItemCollection,
          QFilterCondition
        > {}

extension VolumeItemCollectionQuerySortBy
    on QueryBuilder<VolumeItemCollection, VolumeItemCollection, QSortBy> {
  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  sortByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  sortByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  sortByLength() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'length', Sort.asc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  sortByLengthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'length', Sort.desc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  sortByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  sortByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  sortByWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.asc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  sortByWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.desc);
    });
  }
}

extension VolumeItemCollectionQuerySortThenBy
    on QueryBuilder<VolumeItemCollection, VolumeItemCollection, QSortThenBy> {
  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  thenByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.asc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  thenByHeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'height', Sort.desc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  thenByLength() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'length', Sort.asc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  thenByLengthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'length', Sort.desc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  thenByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.asc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  thenByWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weight', Sort.desc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  thenByWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.asc);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QAfterSortBy>
  thenByWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'width', Sort.desc);
    });
  }
}

extension VolumeItemCollectionQueryWhereDistinct
    on QueryBuilder<VolumeItemCollection, VolumeItemCollection, QDistinct> {
  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QDistinct>
  distinctByHeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'height');
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QDistinct>
  distinctByLength() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'length');
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QDistinct>
  distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QDistinct>
  distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QDistinct>
  distinctByWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weight');
    });
  }

  QueryBuilder<VolumeItemCollection, VolumeItemCollection, QDistinct>
  distinctByWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'width');
    });
  }
}

extension VolumeItemCollectionQueryProperty
    on
        QueryBuilder<
          VolumeItemCollection,
          VolumeItemCollection,
          QQueryProperty
        > {
  QueryBuilder<VolumeItemCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<VolumeItemCollection, double, QQueryOperations>
  heightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'height');
    });
  }

  QueryBuilder<VolumeItemCollection, double, QQueryOperations>
  lengthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'length');
    });
  }

  QueryBuilder<VolumeItemCollection, int, QQueryOperations> quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }

  QueryBuilder<VolumeItemCollection, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }

  QueryBuilder<VolumeItemCollection, double, QQueryOperations>
  weightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weight');
    });
  }

  QueryBuilder<VolumeItemCollection, double, QQueryOperations> widthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'width');
    });
  }
}
