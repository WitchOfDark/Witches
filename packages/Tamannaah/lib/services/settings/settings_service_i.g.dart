// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'settings_service_i.dart';

// // **************************************************************************
// // IsarCollectionGenerator
// // **************************************************************************

// // coverage:ignore-file
// // ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

// extension GetIsarSettingsCollection on Isar {
//   IsarCollection<IsarSettings> get isarSettings => this.collection();
// }

// const IsarSettingsSchema = CollectionSchema(
//   name: r'IsarSettings',
//   id: -2003972169886166418,
//   properties: {
//     r'lastAppOpen': PropertySchema(
//       id: 0,
//       name: r'lastAppOpen',
//       type: IsarType.long,
//     ),
//     r'theme': PropertySchema(
//       id: 1,
//       name: r'theme',
//       type: IsarType.long,
//     )
//   },
//   estimateSize: _isarSettingsEstimateSize,
//   serialize: _isarSettingsSerialize,
//   deserialize: _isarSettingsDeserialize,
//   deserializeProp: _isarSettingsDeserializeProp,
//   idName: r'id',
//   indexes: {},
//   links: {},
//   embeddedSchemas: {},
//   getId: _isarSettingsGetId,
//   getLinks: _isarSettingsGetLinks,
//   attach: _isarSettingsAttach,
//   version: '3.0.2',
// );

// int _isarSettingsEstimateSize(
//   IsarSettings object,
//   List<int> offsets,
//   Map<Type, List<int>> allOffsets,
// ) {
//   var bytesCount = offsets.last;
//   return bytesCount;
// }

// void _isarSettingsSerialize(
//   IsarSettings object,
//   IsarWriter writer,
//   List<int> offsets,
//   Map<Type, List<int>> allOffsets,
// ) {
//   writer.writeLong(offsets[0], object.lastAppOpen);
//   writer.writeLong(offsets[1], object.theme);
// }

// IsarSettings _isarSettingsDeserialize(
//   Id id,
//   IsarReader reader,
//   List<int> offsets,
//   Map<Type, List<int>> allOffsets,
// ) {
//   final object = IsarSettings(
//     lastAppOpen: reader.readLong(offsets[0]),
//     theme: reader.readLong(offsets[1]),
//   );
//   object.id = id;
//   return object;
// }

// P _isarSettingsDeserializeProp<P>(
//   IsarReader reader,
//   int propertyId,
//   int offset,
//   Map<Type, List<int>> allOffsets,
// ) {
//   switch (propertyId) {
//     case 0:
//       return (reader.readLong(offset)) as P;
//     case 1:
//       return (reader.readLong(offset)) as P;
//     default:
//       throw IsarError('Unknown property with id $propertyId');
//   }
// }

// Id _isarSettingsGetId(IsarSettings object) {
//   return object.id;
// }

// List<IsarLinkBase<dynamic>> _isarSettingsGetLinks(IsarSettings object) {
//   return [];
// }

// void _isarSettingsAttach(
//     IsarCollection<dynamic> col, Id id, IsarSettings object) {
//   object.id = id;
// }

// extension IsarSettingsQueryWhereSort
//     on QueryBuilder<IsarSettings, IsarSettings, QWhere> {
//   QueryBuilder<IsarSettings, IsarSettings, QAfterWhere> anyId() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(const IdWhereClause.any());
//     });
//   }
// }

// extension IsarSettingsQueryWhere
//     on QueryBuilder<IsarSettings, IsarSettings, QWhereClause> {
//   QueryBuilder<IsarSettings, IsarSettings, QAfterWhereClause> idEqualTo(Id id) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(IdWhereClause.between(
//         lower: id,
//         upper: id,
//       ));
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QAfterWhereClause> idNotEqualTo(
//       Id id) {
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

//   QueryBuilder<IsarSettings, IsarSettings, QAfterWhereClause> idGreaterThan(
//       Id id,
//       {bool include = false}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(
//         IdWhereClause.greaterThan(lower: id, includeLower: include),
//       );
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QAfterWhereClause> idLessThan(Id id,
//       {bool include = false}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addWhereClause(
//         IdWhereClause.lessThan(upper: id, includeUpper: include),
//       );
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QAfterWhereClause> idBetween(
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

// extension IsarSettingsQueryFilter
//     on QueryBuilder<IsarSettings, IsarSettings, QFilterCondition> {
//   QueryBuilder<IsarSettings, IsarSettings, QAfterFilterCondition> idEqualTo(
//       Id value) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'id',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QAfterFilterCondition> idGreaterThan(
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

//   QueryBuilder<IsarSettings, IsarSettings, QAfterFilterCondition> idLessThan(
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

//   QueryBuilder<IsarSettings, IsarSettings, QAfterFilterCondition> idBetween(
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

//   QueryBuilder<IsarSettings, IsarSettings, QAfterFilterCondition>
//       lastAppOpenEqualTo(int value) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'lastAppOpen',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QAfterFilterCondition>
//       lastAppOpenGreaterThan(
//     int value, {
//     bool include = false,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'lastAppOpen',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QAfterFilterCondition>
//       lastAppOpenLessThan(
//     int value, {
//     bool include = false,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'lastAppOpen',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QAfterFilterCondition>
//       lastAppOpenBetween(
//     int lower,
//     int upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'lastAppOpen',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//       ));
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QAfterFilterCondition> themeEqualTo(
//       int value) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.equalTo(
//         property: r'theme',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QAfterFilterCondition>
//       themeGreaterThan(
//     int value, {
//     bool include = false,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.greaterThan(
//         include: include,
//         property: r'theme',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QAfterFilterCondition> themeLessThan(
//     int value, {
//     bool include = false,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.lessThan(
//         include: include,
//         property: r'theme',
//         value: value,
//       ));
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QAfterFilterCondition> themeBetween(
//     int lower,
//     int upper, {
//     bool includeLower = true,
//     bool includeUpper = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(FilterCondition.between(
//         property: r'theme',
//         lower: lower,
//         includeLower: includeLower,
//         upper: upper,
//         includeUpper: includeUpper,
//       ));
//     });
//   }
// }

// extension IsarSettingsQueryObject
//     on QueryBuilder<IsarSettings, IsarSettings, QFilterCondition> {}

// extension IsarSettingsQueryLinks
//     on QueryBuilder<IsarSettings, IsarSettings, QFilterCondition> {}

// extension IsarSettingsQuerySortBy
//     on QueryBuilder<IsarSettings, IsarSettings, QSortBy> {
//   QueryBuilder<IsarSettings, IsarSettings, QAfterSortBy> sortByLastAppOpen() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'lastAppOpen', Sort.asc);
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QAfterSortBy>
//       sortByLastAppOpenDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'lastAppOpen', Sort.desc);
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QAfterSortBy> sortByTheme() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'theme', Sort.asc);
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QAfterSortBy> sortByThemeDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'theme', Sort.desc);
//     });
//   }
// }

// extension IsarSettingsQuerySortThenBy
//     on QueryBuilder<IsarSettings, IsarSettings, QSortThenBy> {
//   QueryBuilder<IsarSettings, IsarSettings, QAfterSortBy> thenById() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'id', Sort.asc);
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QAfterSortBy> thenByIdDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'id', Sort.desc);
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QAfterSortBy> thenByLastAppOpen() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'lastAppOpen', Sort.asc);
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QAfterSortBy>
//       thenByLastAppOpenDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'lastAppOpen', Sort.desc);
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QAfterSortBy> thenByTheme() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'theme', Sort.asc);
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QAfterSortBy> thenByThemeDesc() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(r'theme', Sort.desc);
//     });
//   }
// }

// extension IsarSettingsQueryWhereDistinct
//     on QueryBuilder<IsarSettings, IsarSettings, QDistinct> {
//   QueryBuilder<IsarSettings, IsarSettings, QDistinct> distinctByLastAppOpen() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addDistinctBy(r'lastAppOpen');
//     });
//   }

//   QueryBuilder<IsarSettings, IsarSettings, QDistinct> distinctByTheme() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addDistinctBy(r'theme');
//     });
//   }
// }

// extension IsarSettingsQueryProperty
//     on QueryBuilder<IsarSettings, IsarSettings, QQueryProperty> {
//   QueryBuilder<IsarSettings, int, QQueryOperations> idProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'id');
//     });
//   }

//   QueryBuilder<IsarSettings, int, QQueryOperations> lastAppOpenProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'lastAppOpen');
//     });
//   }

//   QueryBuilder<IsarSettings, int, QQueryOperations> themeProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addPropertyName(r'theme');
//     });
//   }
// }
