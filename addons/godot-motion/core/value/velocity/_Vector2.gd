extends "../_Velocity.gd"

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func can_convert(value: Variant, array_size: int) -> bool:
	match typeof(value):
		TYPE_INT when _can_convert_from_int(value, array_size):
			return true
		TYPE_FLOAT when _can_convert_from_float(value, array_size):
			return true
		TYPE_VECTOR2 when _can_convert_from_vector2(value, array_size):
			return true
		TYPE_VECTOR2I when _can_convert_from_vector2i(value, array_size):
			return true
		TYPE_ARRAY when _can_convert_from_array(value, array_size):
			return true
		TYPE_PACKED_INT32_ARRAY when _can_convert_from_packed_int32_array(value, array_size):
			return true
		TYPE_PACKED_INT64_ARRAY when _can_convert_from_packed_int64_array(value, array_size):
			return true
		TYPE_PACKED_FLOAT32_ARRAY when _can_convert_from_packed_float32_array(value, array_size):
			return true
		TYPE_PACKED_FLOAT64_ARRAY when _can_convert_from_packed_float64_array(value, array_size):
			return true
		TYPE_PACKED_VECTOR2_ARRAY when _can_convert_from_packed_vector2_array(value, array_size):
			return true
	return false

func set_external_value(value: Variant) -> void:
	match typeof(value):
		TYPE_INT:
			_convert_from_int(value, _array)
		TYPE_FLOAT:
			_convert_from_float(value, _array)
		TYPE_VECTOR2:
			_convert_from_vector2(value, _array)
		TYPE_VECTOR2I:
			_convert_from_vector2i(value, _array)
		TYPE_ARRAY:
			_convert_from_array(value, _array)
		TYPE_PACKED_INT32_ARRAY:
			_convert_from_packed_int32_array(value, _array)
		TYPE_PACKED_INT64_ARRAY:
			_convert_from_packed_int64_array(value, _array)
		TYPE_PACKED_FLOAT32_ARRAY:
			_convert_from_packed_float32_array(value, _array)
		TYPE_PACKED_FLOAT64_ARRAY:
			_convert_from_packed_float64_array(value, _array)
		TYPE_PACKED_VECTOR2_ARRAY:
			_convert_from_packed_vector2_array(value, _array)

func get_external_value() -> Variant:
	return _array

func set_at(index: int, value: float) -> void:
	_array[index] = value

func get_at(index: int) -> float:
	return _array[index]

#-------------------------------------------------------------------------------

var _array: Array[float] = [0.0, 0.0]

#region converters

@warning_ignore("unused_parameter")
static func _can_convert_from_int(
	value: int,
	array_size: int) -> bool:

	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_float(
	value: float,
	array_size: int) -> bool:

	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_vector2(
	value: Vector2,
	array_size: int) -> bool:

	return array_size == 1

@warning_ignore("unused_parameter")
static func _can_convert_from_vector2i(
	value: Vector2i,
	array_size: int) -> bool:

	return array_size == 1

static func _can_convert_from_array(
	array: Array,
	array_size: int) -> bool:

	match array.get_typed_builtin():
		TYPE_NIL:
			if array_size != 1 or 2 < array.size():
				return false
			var valid := true
			var write := 0
			for value: Variant in array:
				match typeof(value):
					TYPE_INT, \
					TYPE_FLOAT:
						write += 1
					TYPE_VECTOR2, \
					TYPE_VECTOR2I:
						if write % 2 != 0:
							valid = false
							break
						write += 2
					TYPE_ARRAY:
						match value.size():
							1:
								match typeof(value[0]):
									TYPE_INT, \
									TYPE_FLOAT:
										pass
									_:
										valid = false
										break
								write += 2
							2:
								match typeof(value[0]):
									TYPE_INT, \
									TYPE_FLOAT:
										pass
									_:
										valid = false
										break
								match typeof(value[1]):
									TYPE_INT, \
									TYPE_FLOAT:
										pass
									_:
										valid = false
										break
								write += 2
							_:
								valid = false
								break
					_:
						valid = false
						break
			if not valid or write != 2:
				return false
		TYPE_INT, \
		TYPE_FLOAT:
			if array_size != 1 or array.size() != 2:
				return false
		TYPE_VECTOR2, \
		TYPE_VECTOR2I:
			if array_size != 1 or array.size() != 1:
				return false
		_:
			return false
	return true

static func _can_convert_from_packed_int32_array(
	array: PackedInt32Array,
	array_size: int) -> bool:

	return array_size == 1 and array.size() == 2

static func _can_convert_from_packed_int64_array(
	array: PackedInt64Array,
	array_size: int) -> bool:

	return array_size == 1 and array.size() == 2

static func _can_convert_from_packed_float32_array(
	array: PackedFloat32Array,
	array_size: int) -> bool:

	return array_size == 1 and array.size() == 2

static func _can_convert_from_packed_float64_array(
	array: PackedFloat64Array,
	array_size: int) -> bool:

	return array_size == 1 and array.size() == 2

static func _can_convert_from_packed_vector2_array(
	array: PackedVector2Array,
	array_size: int) -> bool:

	return array_size == 1 and array.size() == 1

static func _convert_from_int(
	value: int,
	converted_array: Array[float]) -> void:

	converted_array[0] = value
	converted_array[1] = value

static func _convert_from_float(
	value: float,
	converted_array: Array[float]) -> void:

	converted_array[0] = value
	converted_array[1] = value

static func _convert_from_vector2(
	value: Vector2,
	converted_array: Array[float]) -> void:

	converted_array[0] = value.x
	converted_array[1] = value.y

static func _convert_from_vector2i(
	value: Vector2i,
	converted_array: Array[float]) -> void:

	converted_array[0] = value.x
	converted_array[1] = value.y

static func _convert_from_array(
	array: Array,
	converted_array: Array[float]) -> void:

	match array.get_typed_builtin():
		TYPE_NIL:
			var write := 0
			for value: Variant in array:
				match typeof(value):
					TYPE_INT, \
					TYPE_FLOAT:
						converted_array[write] = value
						write += 1
					TYPE_VECTOR2, \
					TYPE_VECTOR2I:
						converted_array[write + 0] = value.x
						converted_array[write + 1] = value.y
						write += 2
					TYPE_ARRAY:
						match value.size():
							1:
								converted_array[write + 0] = value[0]
								converted_array[write + 1] = value[0]
								write += 2
							2:
								converted_array[write + 0] = value[0]
								converted_array[write + 1] = value[1]
								write += 2
		TYPE_INT:
			converted_array[0] = array[0]
			converted_array[1] = array[1]
		TYPE_FLOAT:
			converted_array[0] = array[0]
			converted_array[1] = array[1]
		TYPE_VECTOR2:
			var value: Vector2 = array[0]
			converted_array[0] = value.x
			converted_array[1] = value.y
		TYPE_VECTOR2I:
			var value: Vector2i = array[0]
			converted_array[0] = value.x
			converted_array[1] = value.y

static func _convert_from_packed_int32_array(
	array: PackedInt32Array,
	converted_array: Array[float]) -> void:

	converted_array[0] = array[0]
	converted_array[1] = array[1]

static func _convert_from_packed_int64_array(
	array: PackedInt64Array,
	converted_array: Array[float]) -> void:

	converted_array[0] = array[0]
	converted_array[1] = array[1]

static func _convert_from_packed_float32_array(
	array: PackedFloat32Array,
	converted_array: Array[float]) -> void:

	converted_array[0] = array[0]
	converted_array[1] = array[1]

static func _convert_from_packed_float64_array(
	array: PackedFloat64Array,
	converted_array: Array[float]) -> void:

	converted_array[0] = array[0]
	converted_array[1] = array[1]

static func _convert_from_packed_vector2_array(
	array: PackedVector2Array,
	converted_array: Array[float]) -> void:

	var value: Vector2 = array[0]
	converted_array[0] = value.x
	converted_array[1] = value.y

#endregion

@warning_ignore("unused_parameter")
func _init(array_size: int) -> void:
	pass
