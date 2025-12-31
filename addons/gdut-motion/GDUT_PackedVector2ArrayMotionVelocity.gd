class_name GDUT_PackedVector2ArrayMotionVelocity extends GDUT_MotionVelocity

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@warning_ignore("unused_parameter")
static func create(array_size: int) -> GDUT_MotionVelocity:
	return new(array_size)

static func validate_incoming_value(value: Variant, array_size: int) -> bool:
	match typeof(value):
		TYPE_ARRAY:
			if not _can_convert_from_array(value, array_size):
				return false
		TYPE_PACKED_INT32_ARRAY:
			if not _can_convert_from_packed_int32_array(value, array_size):
				return false
		TYPE_PACKED_INT64_ARRAY:
			if not _can_convert_from_packed_int64_array(value, array_size):
				return false
		TYPE_PACKED_FLOAT32_ARRAY:
			if not _can_convert_from_packed_float32_array(value, array_size):
				return false
		TYPE_PACKED_FLOAT64_ARRAY:
			if not _can_convert_from_packed_float64_array(value, array_size):
				return false
		TYPE_PACKED_VECTOR2_ARRAY:
			if not _can_convert_from_packed_vector2_array(value, array_size):
				return false
		_:
			return false
	return true

func set_incoming_value(value: Variant) -> void:
	match typeof(value):
		TYPE_ARRAY:
			_convert_from_array(value)
		TYPE_PACKED_INT32_ARRAY:
			_convert_from_packed_int32_array(value)
		TYPE_PACKED_INT64_ARRAY:
			_convert_from_packed_int64_array(value)
		TYPE_PACKED_FLOAT32_ARRAY:
			_convert_from_packed_float32_array(value)
		TYPE_PACKED_FLOAT64_ARRAY:
			_convert_from_packed_float64_array(value)
		TYPE_PACKED_VECTOR2_ARRAY:
			_convert_from_packed_vector2_array(value)

func get_outgoing_value() -> Variant:
	return _array

func set_value_at(index: int, value: float) -> void:
	_array[index] = value

func get_value_at(index: int) -> float:
	return _array[index]

#-------------------------------------------------------------------------------

var _array: Array[float]

#region converters

static func _can_convert_from_array(array: Array, array_size: int) -> bool:
	match array.get_typed_builtin():
		TYPE_NIL:
			if array_size * 2 < array.size():
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
			if not valid or write != array_size * 2:
				return false
		TYPE_INT, \
		TYPE_FLOAT:
			if array.size() != array_size * 2:
				return false
		TYPE_VECTOR2, \
		TYPE_VECTOR2I:
			if array.size() != array_size:
				return false
		_:
			return false
	return true

static func _can_convert_from_packed_int32_array(array: PackedInt32Array, array_size: int) -> bool:
	return array.size() == array_size * 2

static func _can_convert_from_packed_int64_array(array: PackedInt64Array, array_size: int) -> bool:
	return array.size() == array_size * 2

static func _can_convert_from_packed_float32_array(array: PackedFloat32Array, array_size: int) -> bool:
	return array.size() == array_size * 2

static func _can_convert_from_packed_float64_array(array: PackedFloat64Array, array_size: int) -> bool:
	return array.size() == array_size * 2

static func _can_convert_from_packed_vector2_array(array: PackedVector2Array, array_size: int) -> bool:
	return array.size() == array_size

func _convert_from_array(array: Array) -> void:
	match array.get_typed_builtin():
		TYPE_NIL:
			var write := 0
			for value: Variant in array:
				match typeof(value):
					TYPE_INT, \
					TYPE_FLOAT:
						_array[write] = value
						write += 1
					TYPE_VECTOR2, \
					TYPE_VECTOR2I:
						_array[write + 0] = value.x
						_array[write + 1] = value.y
						write += 2
					TYPE_ARRAY:
						match value.size():
							1:
								_array[write + 0] = value[0]
								_array[write + 1] = value[0]
								write += 2
							2:
								_array[write + 0] = value[0]
								_array[write + 1] = value[1]
								write += 2
		TYPE_INT:
			var write := 0
			for value: int in array:
				_array[write] = value
				write += 1
		TYPE_FLOAT:
			var write := 0
			for value: float in array:
				_array[write] = value
				write += 1
		TYPE_VECTOR2:
			var write := 0
			for value: Vector2 in array:
				_array[write + 0] = value.x
				_array[write + 1] = value.y
				write += 2
		TYPE_VECTOR2I:
			var write := 0
			for value: Vector2i in array:
				_array[write + 0] = value.x
				_array[write + 1] = value.y
				write += 2

func _convert_from_packed_int32_array(array: PackedInt32Array) -> void:
	var write := 0
	for value: int in array:
		_array[write] = value
		write += 1

func _convert_from_packed_int64_array(array: PackedInt64Array) -> void:
	var write := 0
	for value: int in array:
		_array[write] = value
		write += 1

func _convert_from_packed_float32_array(array: PackedFloat32Array) -> void:
	var write := 0
	for value: float in array:
		_array[write] = value
		write += 1

func _convert_from_packed_float64_array(array: PackedFloat64Array) -> void:
	var write := 0
	for value: float in array:
		_array[write] = value
		write += 1

func _convert_from_packed_vector2_array(array: PackedVector2Array) -> void:
	var write := 0
	for value: Vector2 in array:
		_array[write + 0] = value.x
		_array[write + 1] = value.y
		write += 2

#endregion

func _init(array_size: int) -> void:
	_array.resize(array_size * 2)
