// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WordPack _$WordPackFromJson(Map<String, dynamic> json) {
  return _WordPack.fromJson(json);
}

/// @nodoc
mixin _$WordPack {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_premium')
  bool get isPremium => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'icon_name')
  String? get iconName => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_seasonal')
  bool get isSeasonal => throw _privateConstructorUsedError;
  @JsonKey(name: 'available_from')
  DateTime? get availableFrom => throw _privateConstructorUsedError;
  @JsonKey(name: 'available_until')
  DateTime? get availableUntil => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this WordPack to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WordPack
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WordPackCopyWith<WordPack> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordPackCopyWith<$Res> {
  factory $WordPackCopyWith(WordPack value, $Res Function(WordPack) then) =
      _$WordPackCopyWithImpl<$Res, WordPack>;
  @useResult
  $Res call({
    String id,
    String name,
    String language,
    @JsonKey(name: 'is_premium') bool isPremium,
    String? category,
    @JsonKey(name: 'icon_name') String? iconName,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_seasonal') bool isSeasonal,
    @JsonKey(name: 'available_from') DateTime? availableFrom,
    @JsonKey(name: 'available_until') DateTime? availableUntil,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$WordPackCopyWithImpl<$Res, $Val extends WordPack>
    implements $WordPackCopyWith<$Res> {
  _$WordPackCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WordPack
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? language = null,
    Object? isPremium = null,
    Object? category = freezed,
    Object? iconName = freezed,
    Object? sortOrder = null,
    Object? isSeasonal = null,
    Object? availableFrom = freezed,
    Object? availableUntil = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            language: null == language
                ? _value.language
                : language // ignore: cast_nullable_to_non_nullable
                      as String,
            isPremium: null == isPremium
                ? _value.isPremium
                : isPremium // ignore: cast_nullable_to_non_nullable
                      as bool,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
            iconName: freezed == iconName
                ? _value.iconName
                : iconName // ignore: cast_nullable_to_non_nullable
                      as String?,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            isSeasonal: null == isSeasonal
                ? _value.isSeasonal
                : isSeasonal // ignore: cast_nullable_to_non_nullable
                      as bool,
            availableFrom: freezed == availableFrom
                ? _value.availableFrom
                : availableFrom // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            availableUntil: freezed == availableUntil
                ? _value.availableUntil
                : availableUntil // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WordPackImplCopyWith<$Res>
    implements $WordPackCopyWith<$Res> {
  factory _$$WordPackImplCopyWith(
    _$WordPackImpl value,
    $Res Function(_$WordPackImpl) then,
  ) = __$$WordPackImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String language,
    @JsonKey(name: 'is_premium') bool isPremium,
    String? category,
    @JsonKey(name: 'icon_name') String? iconName,
    @JsonKey(name: 'sort_order') int sortOrder,
    @JsonKey(name: 'is_seasonal') bool isSeasonal,
    @JsonKey(name: 'available_from') DateTime? availableFrom,
    @JsonKey(name: 'available_until') DateTime? availableUntil,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$WordPackImplCopyWithImpl<$Res>
    extends _$WordPackCopyWithImpl<$Res, _$WordPackImpl>
    implements _$$WordPackImplCopyWith<$Res> {
  __$$WordPackImplCopyWithImpl(
    _$WordPackImpl _value,
    $Res Function(_$WordPackImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WordPack
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? language = null,
    Object? isPremium = null,
    Object? category = freezed,
    Object? iconName = freezed,
    Object? sortOrder = null,
    Object? isSeasonal = null,
    Object? availableFrom = freezed,
    Object? availableUntil = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$WordPackImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        language: null == language
            ? _value.language
            : language // ignore: cast_nullable_to_non_nullable
                  as String,
        isPremium: null == isPremium
            ? _value.isPremium
            : isPremium // ignore: cast_nullable_to_non_nullable
                  as bool,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
        iconName: freezed == iconName
            ? _value.iconName
            : iconName // ignore: cast_nullable_to_non_nullable
                  as String?,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        isSeasonal: null == isSeasonal
            ? _value.isSeasonal
            : isSeasonal // ignore: cast_nullable_to_non_nullable
                  as bool,
        availableFrom: freezed == availableFrom
            ? _value.availableFrom
            : availableFrom // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        availableUntil: freezed == availableUntil
            ? _value.availableUntil
            : availableUntil // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WordPackImpl implements _WordPack {
  const _$WordPackImpl({
    required this.id,
    required this.name,
    this.language = 'en',
    @JsonKey(name: 'is_premium') this.isPremium = false,
    this.category,
    @JsonKey(name: 'icon_name') this.iconName,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
    @JsonKey(name: 'is_seasonal') this.isSeasonal = false,
    @JsonKey(name: 'available_from') this.availableFrom,
    @JsonKey(name: 'available_until') this.availableUntil,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$WordPackImpl.fromJson(Map<String, dynamic> json) =>
      _$$WordPackImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey(name: 'is_premium')
  final bool isPremium;
  @override
  final String? category;
  @override
  @JsonKey(name: 'icon_name')
  final String? iconName;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;
  @override
  @JsonKey(name: 'is_seasonal')
  final bool isSeasonal;
  @override
  @JsonKey(name: 'available_from')
  final DateTime? availableFrom;
  @override
  @JsonKey(name: 'available_until')
  final DateTime? availableUntil;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'WordPack(id: $id, name: $name, language: $language, isPremium: $isPremium, category: $category, iconName: $iconName, sortOrder: $sortOrder, isSeasonal: $isSeasonal, availableFrom: $availableFrom, availableUntil: $availableUntil, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordPackImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.iconName, iconName) ||
                other.iconName == iconName) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isSeasonal, isSeasonal) ||
                other.isSeasonal == isSeasonal) &&
            (identical(other.availableFrom, availableFrom) ||
                other.availableFrom == availableFrom) &&
            (identical(other.availableUntil, availableUntil) ||
                other.availableUntil == availableUntil) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    language,
    isPremium,
    category,
    iconName,
    sortOrder,
    isSeasonal,
    availableFrom,
    availableUntil,
    createdAt,
  );

  /// Create a copy of WordPack
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WordPackImplCopyWith<_$WordPackImpl> get copyWith =>
      __$$WordPackImplCopyWithImpl<_$WordPackImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WordPackImplToJson(this);
  }
}

abstract class _WordPack implements WordPack {
  const factory _WordPack({
    required final String id,
    required final String name,
    final String language,
    @JsonKey(name: 'is_premium') final bool isPremium,
    final String? category,
    @JsonKey(name: 'icon_name') final String? iconName,
    @JsonKey(name: 'sort_order') final int sortOrder,
    @JsonKey(name: 'is_seasonal') final bool isSeasonal,
    @JsonKey(name: 'available_from') final DateTime? availableFrom,
    @JsonKey(name: 'available_until') final DateTime? availableUntil,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$WordPackImpl;

  factory _WordPack.fromJson(Map<String, dynamic> json) =
      _$WordPackImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get language;
  @override
  @JsonKey(name: 'is_premium')
  bool get isPremium;
  @override
  String? get category;
  @override
  @JsonKey(name: 'icon_name')
  String? get iconName;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;
  @override
  @JsonKey(name: 'is_seasonal')
  bool get isSeasonal;
  @override
  @JsonKey(name: 'available_from')
  DateTime? get availableFrom;
  @override
  @JsonKey(name: 'available_until')
  DateTime? get availableUntil;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of WordPack
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WordPackImplCopyWith<_$WordPackImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Word _$WordFromJson(Map<String, dynamic> json) {
  return _Word.fromJson(json);
}

/// @nodoc
mixin _$Word {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'pack_id')
  String get packId => throw _privateConstructorUsedError;
  String get word => throw _privateConstructorUsedError;
  String? get hint => throw _privateConstructorUsedError;
  int get difficulty => throw _privateConstructorUsedError;

  /// Serializes this Word to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WordCopyWith<Word> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordCopyWith<$Res> {
  factory $WordCopyWith(Word value, $Res Function(Word) then) =
      _$WordCopyWithImpl<$Res, Word>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'pack_id') String packId,
    String word,
    String? hint,
    int difficulty,
  });
}

/// @nodoc
class _$WordCopyWithImpl<$Res, $Val extends Word>
    implements $WordCopyWith<$Res> {
  _$WordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? packId = null,
    Object? word = null,
    Object? hint = freezed,
    Object? difficulty = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            packId: null == packId
                ? _value.packId
                : packId // ignore: cast_nullable_to_non_nullable
                      as String,
            word: null == word
                ? _value.word
                : word // ignore: cast_nullable_to_non_nullable
                      as String,
            hint: freezed == hint
                ? _value.hint
                : hint // ignore: cast_nullable_to_non_nullable
                      as String?,
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WordImplCopyWith<$Res> implements $WordCopyWith<$Res> {
  factory _$$WordImplCopyWith(
    _$WordImpl value,
    $Res Function(_$WordImpl) then,
  ) = __$$WordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'pack_id') String packId,
    String word,
    String? hint,
    int difficulty,
  });
}

/// @nodoc
class __$$WordImplCopyWithImpl<$Res>
    extends _$WordCopyWithImpl<$Res, _$WordImpl>
    implements _$$WordImplCopyWith<$Res> {
  __$$WordImplCopyWithImpl(_$WordImpl _value, $Res Function(_$WordImpl) _then)
    : super(_value, _then);

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? packId = null,
    Object? word = null,
    Object? hint = freezed,
    Object? difficulty = null,
  }) {
    return _then(
      _$WordImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        packId: null == packId
            ? _value.packId
            : packId // ignore: cast_nullable_to_non_nullable
                  as String,
        word: null == word
            ? _value.word
            : word // ignore: cast_nullable_to_non_nullable
                  as String,
        hint: freezed == hint
            ? _value.hint
            : hint // ignore: cast_nullable_to_non_nullable
                  as String?,
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WordImpl implements _Word {
  const _$WordImpl({
    required this.id,
    @JsonKey(name: 'pack_id') required this.packId,
    required this.word,
    this.hint,
    this.difficulty = 1,
  });

  factory _$WordImpl.fromJson(Map<String, dynamic> json) =>
      _$$WordImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'pack_id')
  final String packId;
  @override
  final String word;
  @override
  final String? hint;
  @override
  @JsonKey()
  final int difficulty;

  @override
  String toString() {
    return 'Word(id: $id, packId: $packId, word: $word, hint: $hint, difficulty: $difficulty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.packId, packId) || other.packId == packId) &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.hint, hint) || other.hint == hint) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, packId, word, hint, difficulty);

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WordImplCopyWith<_$WordImpl> get copyWith =>
      __$$WordImplCopyWithImpl<_$WordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WordImplToJson(this);
  }
}

abstract class _Word implements Word {
  const factory _Word({
    required final String id,
    @JsonKey(name: 'pack_id') required final String packId,
    required final String word,
    final String? hint,
    final int difficulty,
  }) = _$WordImpl;

  factory _Word.fromJson(Map<String, dynamic> json) = _$WordImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'pack_id')
  String get packId;
  @override
  String get word;
  @override
  String? get hint;
  @override
  int get difficulty;

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WordImplCopyWith<_$WordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
