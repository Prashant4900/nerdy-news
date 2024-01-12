// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFavoriteEntityCollection on Isar {
  IsarCollection<FavoriteEntity> get favoriteEntitys => this.collection();
}

const FavoriteEntitySchema = CollectionSchema(
  name: r'FavoriteEntity',
  id: -2424802716597037588,
  properties: {
    r'news': PropertySchema(
      id: 0,
      name: r'news',
      type: IsarType.object,
      target: r'NewsModel',
    ),
    r'newsId': PropertySchema(
      id: 1,
      name: r'newsId',
      type: IsarType.long,
    )
  },
  estimateSize: _favoriteEntityEstimateSize,
  serialize: _favoriteEntitySerialize,
  deserialize: _favoriteEntityDeserialize,
  deserializeProp: _favoriteEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'newsId': IndexSchema(
      id: -452689727933443013,
      name: r'newsId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'newsId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'NewsModel': NewsModelSchema,
    r'PublisherModel': PublisherModelSchema
  },
  getId: _favoriteEntityGetId,
  getLinks: _favoriteEntityGetLinks,
  attach: _favoriteEntityAttach,
  version: '3.1.0+1',
);

int _favoriteEntityEstimateSize(
  FavoriteEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.news;
    if (value != null) {
      bytesCount += 3 +
          NewsModelSchema.estimateSize(
              value, allOffsets[NewsModel]!, allOffsets);
    }
  }
  return bytesCount;
}

void _favoriteEntitySerialize(
  FavoriteEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer
    ..writeObject<NewsModel>(
      offsets[0],
      allOffsets,
      NewsModelSchema.serialize,
      object.news,
    )
    ..writeLong(offsets[1], object.newsId);
}

FavoriteEntity _favoriteEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FavoriteEntity(
    id: id,
    news: reader.readObjectOrNull<NewsModel>(
      offsets[0],
      NewsModelSchema.deserialize,
      allOffsets,
    ),
    newsId: reader.readLongOrNull(offsets[1]),
  );
  return object;
}

P _favoriteEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<NewsModel>(
        offset,
        NewsModelSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _favoriteEntityGetId(FavoriteEntity object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _favoriteEntityGetLinks(FavoriteEntity object) {
  return [];
}

void _favoriteEntityAttach(
    IsarCollection<dynamic> col, Id id, FavoriteEntity object) {}

extension FavoriteEntityByIndex on IsarCollection<FavoriteEntity> {
  Future<FavoriteEntity?> getByNewsId(int? newsId) {
    return getByIndex(r'newsId', [newsId]);
  }

  FavoriteEntity? getByNewsIdSync(int? newsId) {
    return getByIndexSync(r'newsId', [newsId]);
  }

  Future<bool> deleteByNewsId(int? newsId) {
    return deleteByIndex(r'newsId', [newsId]);
  }

  bool deleteByNewsIdSync(int? newsId) {
    return deleteByIndexSync(r'newsId', [newsId]);
  }

  Future<List<FavoriteEntity?>> getAllByNewsId(List<int?> newsIdValues) {
    final values = newsIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'newsId', values);
  }

  List<FavoriteEntity?> getAllByNewsIdSync(List<int?> newsIdValues) {
    final values = newsIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'newsId', values);
  }

  Future<int> deleteAllByNewsId(List<int?> newsIdValues) {
    final values = newsIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'newsId', values);
  }

  int deleteAllByNewsIdSync(List<int?> newsIdValues) {
    final values = newsIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'newsId', values);
  }

  Future<Id> putByNewsId(FavoriteEntity object) {
    return putByIndex(r'newsId', object);
  }

  Id putByNewsIdSync(FavoriteEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'newsId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByNewsId(List<FavoriteEntity> objects) {
    return putAllByIndex(r'newsId', objects);
  }

  List<Id> putAllByNewsIdSync(List<FavoriteEntity> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'newsId', objects, saveLinks: saveLinks);
  }
}

extension FavoriteEntityQueryWhereSort
    on QueryBuilder<FavoriteEntity, FavoriteEntity, QWhere> {
  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterWhere> anyNewsId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'newsId'),
      );
    });
  }
}

extension FavoriteEntityQueryWhere
    on QueryBuilder<FavoriteEntity, FavoriteEntity, QWhereClause> {
  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterWhereClause>
      newsIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'newsId',
        value: [null],
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterWhereClause>
      newsIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'newsId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterWhereClause> newsIdEqualTo(
      int? newsId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'newsId',
        value: [newsId],
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterWhereClause>
      newsIdNotEqualTo(int? newsId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'newsId',
              lower: [],
              upper: [newsId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'newsId',
              lower: [newsId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'newsId',
              lower: [newsId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'newsId',
              lower: [],
              upper: [newsId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterWhereClause>
      newsIdGreaterThan(
    int? newsId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'newsId',
        lower: [newsId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterWhereClause>
      newsIdLessThan(
    int? newsId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'newsId',
        lower: [],
        upper: [newsId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterWhereClause> newsIdBetween(
    int? lowerNewsId,
    int? upperNewsId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'newsId',
        lower: [lowerNewsId],
        includeLower: includeLower,
        upper: [upperNewsId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FavoriteEntityQueryFilter
    on QueryBuilder<FavoriteEntity, FavoriteEntity, QFilterCondition> {
  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterFilterCondition>
      idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterFilterCondition>
      idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterFilterCondition>
      newsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'news',
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterFilterCondition>
      newsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'news',
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterFilterCondition>
      newsIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'newsId',
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterFilterCondition>
      newsIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'newsId',
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterFilterCondition>
      newsIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newsId',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterFilterCondition>
      newsIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'newsId',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterFilterCondition>
      newsIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'newsId',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterFilterCondition>
      newsIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'newsId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FavoriteEntityQueryObject
    on QueryBuilder<FavoriteEntity, FavoriteEntity, QFilterCondition> {
  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterFilterCondition> news(
      FilterQuery<NewsModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'news');
    });
  }
}

extension FavoriteEntityQueryLinks
    on QueryBuilder<FavoriteEntity, FavoriteEntity, QFilterCondition> {}

extension FavoriteEntityQuerySortBy
    on QueryBuilder<FavoriteEntity, FavoriteEntity, QSortBy> {
  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterSortBy> sortByNewsId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newsId', Sort.asc);
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterSortBy>
      sortByNewsIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newsId', Sort.desc);
    });
  }
}

extension FavoriteEntityQuerySortThenBy
    on QueryBuilder<FavoriteEntity, FavoriteEntity, QSortThenBy> {
  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterSortBy> thenByNewsId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newsId', Sort.asc);
    });
  }

  QueryBuilder<FavoriteEntity, FavoriteEntity, QAfterSortBy>
      thenByNewsIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newsId', Sort.desc);
    });
  }
}

extension FavoriteEntityQueryWhereDistinct
    on QueryBuilder<FavoriteEntity, FavoriteEntity, QDistinct> {
  QueryBuilder<FavoriteEntity, FavoriteEntity, QDistinct> distinctByNewsId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'newsId');
    });
  }
}

extension FavoriteEntityQueryProperty
    on QueryBuilder<FavoriteEntity, FavoriteEntity, QQueryProperty> {
  QueryBuilder<FavoriteEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FavoriteEntity, NewsModel?, QQueryOperations> newsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'news');
    });
  }

  QueryBuilder<FavoriteEntity, int?, QQueryOperations> newsIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'newsId');
    });
  }
}
