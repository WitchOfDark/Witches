// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'api_service_i.dart';

// // **************************************************************************
// // IsarCollectionGenerator
// // **************************************************************************

// // coverage:ignore-file
// // ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

// extension GetIsarApiCollection on Isar {
//   IsarCollection<IsarApi> get isarApis => this.collection();
// }

// const IsarApiSchema = CollectionSchema(
//   name: r'IsarApi',
//   id: 5742610174867096207,
//   properties: {
//     r'data': PropertySchema(
//       id: 0,
//       name: r'data',
//       type: IsarType.string,
//     ),
//     r'expire': PropertySchema(
//       id: 1,
//       name: r'expire',
//       type: IsarType.long,
//     ),
//     r'isExpired': PropertySchema(
//       id: 2,
//       name: r'isExpired',
//       type: IsarType.bool,
//     ),
//     r'url': PropertySchema(
//       id: 3,
//       name: r'url',
//       type: IsarType.string,
//     )
//   },
//   estimateSize: _isarApiEstimateSize,
//   serialize: _isarApiSerialize,
//   deserialize: _isarApiDeserialize,
//   deserializeProp: _isarApiDeserializeProp,
//   idName: r'id',
//   indexes: {},
//   links: {},
//   embeddedSchemas: {},
//   getId: _isarApiGetId,
//   getLinks: _isarApiGetLinks,
//   attach: _isarApiAttach,
//   version: '3.0.2',
// );

// int _isarApiEstimateSize(
//   IsarApi object,
//   List<int> offsets,
//   Map<Type, List<int>> allOffsets,
// ) {
//   var bytesCount = offsets.last;
//   bytesCount += 3 + object.data.length * 3;
//   bytesCount += 3 + object.url.length * 3;
//   return bytesCount;
// }

// void _isarApiSerialize(
//   IsarApi object,
//   IsarWriter writer,
//   List<int> offsets,
//   Map<Type, List<int>> allOffsets,
// ) {
//   writer.writeString(offsets[0], object.data);
//   writer.writeLong(offsets[1], object.expire);
//   writer.writeBool(offsets[2], object.isExpired);
//   writer.writeString(offsets[3], object.url);
// }

// IsarApi _isarApiDeserialize(
//   Id id,
//   IsarReader reader,
//   List<int> offsets,
//   Map<Type, List<int>> allOffsets,
// ) {
//   final object = IsarApi(
//     data: reader.readString(offsets[0]),
//     expire: reader.readLongOrNull(offsets[1]) ?? -1,
//     url: reader.readString(offsets[3]),
//   );
//   object.id = id;
//   return object;
// }

// P _isarApiDeserializeProp<P>(
//   IsarReader reader,
//   int propertyId,
//   int offset,
//   Map<Type, List<int>> allOffsets,
// ) {
//   switch (propertyId) {
//     case 0:
//       return (reader.readString(offset)) as P;
//     case 1:
//       return (reader.readLongOrNull(offset) ?? -1) as P;
//     case 2:
//       return (reader.readBool(offset)) as P;
//     case 3:
//       return (reader.readString(offset)) as P;
//     default:
//       throw IsarError('Unknown property with id $propertyId');
//   }
// }

// Id _isarApiGetId(IsarApi object) {
//   return object.id;
// }

// List<IsarLinkBase<dynamic>> _isarApiGetLinks(IsarApi object) {
//   return [];
// }

// void _isarApiAttach(IsarCollection<dynamic> col, Id id, IsarApi object) {
//   object.id = id;
// }

// extension IsarApiQueryWhereSort on QueryBuilder<IsarApi, IsarApi, QWhere> {
//   QueryBuilder<IsarApi, IsarApi, QAfterWhere> anyId() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(const IdWhereClause.any());
//     });
//   }
// }

// extension IsarApiQueryWhere on QueryBuilder<IsarApi, IsarApi, QWhereClause> {
//   QueryBuilder<IsarApi, IsarApi, QAfterWhereClause> idEqualTo(Id id) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(IdWhereClause.between(
//         lower: id,
//         upper: id,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterWhereClause> idNotEqualTo(Id id) {
//     return QueryBuilder.apply(this, (query) {
//       if (query.whereSort == Sort.asc) {
//         return query
//             .addWhereClause(
//               IdWhereClause.lessThan(upper: id, includeUpper: false),
//             )
//             .addWhereClause(
//               IdWhereClause.greaterThan(lower: id, includeLower: false),
//             );
//       } else {
//         return query
//             .addWhereClause(
//               IdWhereClause.greaterThan(lower: id, includeLower: false),
//             )
//             .addWhereClause(
//               IdWhereClause.lessThan(upper: id, includeUpper: false),
//             );
//       }
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterWhereClause> idGreaterThan(Id id,
//       {bool include = false}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(
//         IdWhereClause.greaterThan(lower: id, includeLower: include),
//       );
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterWhereClause> idLessThan(Id id,
//       {bool include = false}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(
//         IdWhereClause.lessThan(upper: id, includeUpper: include),
//       );
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterWhereClause> idBetween(
//     Id lowerId,
//     Id upperId, {
//     bool includeLower = true,
//     bool includeUpper = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(IdWhereClause.between(
//         lower: lowerId,
//         includeLower: includeLower,
//         upper: upperId,
//         includeUpper: includeUpper,
//       ));
//     });
//   }
// }

// extension IsarApiQueryFilter
//     on QueryBuilder<IsarApi, IsarApi, QFilterCondition> {
//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> dataEqualTo(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'data',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> dataGreaterThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'data',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> dataLessThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'data',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> dataBetween(
//     String lower,
//     String upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'data',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> dataStartsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.startsWith(
//         property: r'data',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> dataEndsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.endsWith(
//         property: r'data',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> dataContains(
//       String value,
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.contains(
//         property: r'data',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> dataMatches(
//       String pattern,
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.matches(
//         property: r'data',
//         wildcard: pattern,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> dataIsEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'data',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> dataIsNotEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         property: r'data',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> expireEqualTo(
//       int value) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'expire',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> expireGreaterThan(
//     int value, {
//     bool include = false,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'expire',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> expireLessThan(
//     int value, {
//     bool include = false,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'expire',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> expireBetween(
//     int lower,
//     int upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'expire',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> idEqualTo(Id value) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'id',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> idGreaterThan(
//     Id value, {
//     bool include = false,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'id',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> idLessThan(
//     Id value, {
//     bool include = false,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'id',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> idBetween(
//     Id lower,
//     Id upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'id',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> isExpiredEqualTo(
//       bool value) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'isExpired',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> urlEqualTo(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'url',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> urlGreaterThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'url',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> urlLessThan(
//     String value, {
//     bool include = false,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'url',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> urlBetween(
//     String lower,
//     String upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'url',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> urlStartsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.startsWith(
//         property: r'url',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> urlEndsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.endsWith(
//         property: r'url',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> urlContains(
//       String value,
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.contains(
//         property: r'url',
//         value: value,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> urlMatches(
//       String pattern,
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.matches(
//         property: r'url',
//         wildcard: pattern,
//         caseSensitive: caseSensitive,
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> urlIsEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'url',
//         value: '',
//       ));
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterFilterCondition> urlIsNotEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         property: r'url',
//         value: '',
//       ));
//     });
//   }
// }

// extension IsarApiQueryObject
//     on QueryBuilder<IsarApi, IsarApi, QFilterCondition> {}

// extension IsarApiQueryLinks
//     on QueryBuilder<IsarApi, IsarApi, QFilterCondition> {}

// extension IsarApiQuerySortBy on QueryBuilder<IsarApi, IsarApi, QSortBy> {
//   QueryBuilder<IsarApi, IsarApi, QAfterSortBy> sortByData() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'data', Sort.asc);
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterSortBy> sortByDataDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'data', Sort.desc);
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterSortBy> sortByExpire() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'expire', Sort.asc);
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterSortBy> sortByExpireDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'expire', Sort.desc);
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterSortBy> sortByIsExpired() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'isExpired', Sort.asc);
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterSortBy> sortByIsExpiredDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'isExpired', Sort.desc);
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterSortBy> sortByUrl() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'url', Sort.asc);
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterSortBy> sortByUrlDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'url', Sort.desc);
//     });
//   }
// }

// extension IsarApiQuerySortThenBy
//     on QueryBuilder<IsarApi, IsarApi, QSortThenBy> {
//   QueryBuilder<IsarApi, IsarApi, QAfterSortBy> thenByData() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'data', Sort.asc);
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterSortBy> thenByDataDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'data', Sort.desc);
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterSortBy> thenByExpire() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'expire', Sort.asc);
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterSortBy> thenByExpireDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'expire', Sort.desc);
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterSortBy> thenById() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'id', Sort.asc);
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterSortBy> thenByIdDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'id', Sort.desc);
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterSortBy> thenByIsExpired() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'isExpired', Sort.asc);
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterSortBy> thenByIsExpiredDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'isExpired', Sort.desc);
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterSortBy> thenByUrl() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'url', Sort.asc);
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QAfterSortBy> thenByUrlDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'url', Sort.desc);
//     });
//   }
// }

// extension IsarApiQueryWhereDistinct
//     on QueryBuilder<IsarApi, IsarApi, QDistinct> {
//   QueryBuilder<IsarApi, IsarApi, QDistinct> distinctByData(
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addDistinctBy(r'data', caseSensitive: caseSensitive);
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QDistinct> distinctByExpire() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addDistinctBy(r'expire');
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QDistinct> distinctByIsExpired() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addDistinctBy(r'isExpired');
//     });
//   }

//   QueryBuilder<IsarApi, IsarApi, QDistinct> distinctByUrl(
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addDistinctBy(r'url', caseSensitive: caseSensitive);
//     });
//   }
// }

// extension IsarApiQueryProperty
//     on QueryBuilder<IsarApi, IsarApi, QQueryProperty> {
//   QueryBuilder<IsarApi, int, QQueryOperations> idProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'id');
//     });
//   }

//   QueryBuilder<IsarApi, String, QQueryOperations> dataProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'data');
//     });
//   }

//   QueryBuilder<IsarApi, int, QQueryOperations> expireProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'expire');
//     });
//   }

//   QueryBuilder<IsarApi, bool, QQueryOperations> isExpiredProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'isExpired');
//     });
//   }

//   QueryBuilder<IsarApi, String, QQueryOperations> urlProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'url');
//     });
//   }
// }
