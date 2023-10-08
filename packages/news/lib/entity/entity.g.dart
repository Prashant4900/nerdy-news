// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNewsEntityCollection on Isar {
  IsarCollection<NewsEntity> get newsEntitys => this.collection();
}

const NewsEntitySchema = CollectionSchema(
  name: r'NewsEntity',
  id: 7885277117339750830,
  properties: {
    r'news': PropertySchema(
      id: 0,
      name: r'news',
      type: IsarType.object,
      target: r'NewsModel',
    )
  },
  estimateSize: _newsEntityEstimateSize,
  serialize: _newsEntitySerialize,
  deserialize: _newsEntityDeserialize,
  deserializeProp: _newsEntityDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'NewsModel': NewsModelSchema,
    r'PublisherModel': PublisherModelSchema
  },
  getId: _newsEntityGetId,
  getLinks: _newsEntityGetLinks,
  attach: _newsEntityAttach,
  version: '3.1.0+1',
);

int _newsEntityEstimateSize(
  NewsEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      NewsModelSchema.estimateSize(
          object.news, allOffsets[NewsModel]!, allOffsets);
  return bytesCount;
}

void _newsEntitySerialize(
  NewsEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<NewsModel>(
    offsets[0],
    allOffsets,
    NewsModelSchema.serialize,
    object.news,
  );
}

NewsEntity _newsEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NewsEntity(
    isarId: id,
    news: reader.readObjectOrNull<NewsModel>(
          offsets[0],
          NewsModelSchema.deserialize,
          allOffsets,
        ) ??
        NewsModel(),
  );
  return object;
}

P _newsEntityDeserializeProp<P>(
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
          ) ??
          NewsModel()) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _newsEntityGetId(NewsEntity object) {
  return object.isarId ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _newsEntityGetLinks(NewsEntity object) {
  return [];
}

void _newsEntityAttach(IsarCollection<dynamic> col, Id id, NewsEntity object) {}

extension NewsEntityQueryWhereSort
    on QueryBuilder<NewsEntity, NewsEntity, QWhere> {
  QueryBuilder<NewsEntity, NewsEntity, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NewsEntityQueryWhere
    on QueryBuilder<NewsEntity, NewsEntity, QWhereClause> {
  QueryBuilder<NewsEntity, NewsEntity, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<NewsEntity, NewsEntity, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<NewsEntity, NewsEntity, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<NewsEntity, NewsEntity, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<NewsEntity, NewsEntity, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension NewsEntityQueryFilter
    on QueryBuilder<NewsEntity, NewsEntity, QFilterCondition> {
  QueryBuilder<NewsEntity, NewsEntity, QAfterFilterCondition> isarIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<NewsEntity, NewsEntity, QAfterFilterCondition>
      isarIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isarId',
      ));
    });
  }

  QueryBuilder<NewsEntity, NewsEntity, QAfterFilterCondition> isarIdEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<NewsEntity, NewsEntity, QAfterFilterCondition> isarIdGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<NewsEntity, NewsEntity, QAfterFilterCondition> isarIdLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<NewsEntity, NewsEntity, QAfterFilterCondition> isarIdBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension NewsEntityQueryObject
    on QueryBuilder<NewsEntity, NewsEntity, QFilterCondition> {
  QueryBuilder<NewsEntity, NewsEntity, QAfterFilterCondition> news(
      FilterQuery<NewsModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'news');
    });
  }
}

extension NewsEntityQueryLinks
    on QueryBuilder<NewsEntity, NewsEntity, QFilterCondition> {}

extension NewsEntityQuerySortBy
    on QueryBuilder<NewsEntity, NewsEntity, QSortBy> {}

extension NewsEntityQuerySortThenBy
    on QueryBuilder<NewsEntity, NewsEntity, QSortThenBy> {
  QueryBuilder<NewsEntity, NewsEntity, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<NewsEntity, NewsEntity, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }
}

extension NewsEntityQueryWhereDistinct
    on QueryBuilder<NewsEntity, NewsEntity, QDistinct> {}

extension NewsEntityQueryProperty
    on QueryBuilder<NewsEntity, NewsEntity, QQueryProperty> {
  QueryBuilder<NewsEntity, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<NewsEntity, NewsModel, QQueryOperations> newsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'news');
    });
  }
}
