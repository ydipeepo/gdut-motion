class_name GDUT_PackedVector4ArrayMotionVelocity extends GDUT_MotionVelocity

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
		TYPE_PACKED_VECTOR4_ARRAY:
			if not _can_convert_from_packed_vector4_array(value, array_size):
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
		TYPE_PACKED_VECTOR4_ARRAY:
			_convert_from_packed_vector4_array(value)

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
			if array_size * 4 < array.size():
				return false
			var valid := true
			var write := 0
			for value: Variant in array:
				match typeof(value):
					TYPE_INT, \
					TYPE_FLOAT:
						write += 1
					TYPE_VECTOR4, \
					TYPE_VECTOR4I:
						if write % 4 != 0:
							valid = false
							break
						write += 4
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
								write += 4
							4:
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
								match typeof(value[2]):
									TYPE_INT, \
									TYPE_FLOAT:
										pass
									_:
										valid = false
										break
								match typeof(value[3]):
									TYPE_INT, \
									TYPE_FLOAT:
										pass
									_:
										valid = false
										break
								write += 4
							_:
								valid = false
								break
					_:
						valid = false
						break
			if not valid or write != array_size * 4:
				return false
		TYPE_INT, \
		TYPE_FLOAT:
			if array.size() != array_size * 4:
				return false
		TYPE_VECTOR4, \
		TYPE_VECTOR4I:
			if array.size() != array_size:
				return false
		_:
			return false
	return true

static func _can_convert_from_packed_int32_array(array: PackedInt32Array, array_size: int) -> bool:
	return array.size() == array_size * 4

static func _can_convert_from_packed_int64_array(array: PackedInt64Array, array_size: int) -> bool:
	return array.size() == array_size * 4

static func _can_convert_from_packed_float32_array(array: PackedFloat32Array, array_size: int) -> bool:
	return array.size() == array_size * 4

static func _can_convert_from_packed_float64_array(array: PackedFloat64Array, array_size: int) -> bool:
	return array.size() == array_size * 4

static func _can_convert_from_packed_vector4_array(array: PackedVector4Array, array_size: int) -> bool:
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
					TYPE_VECTOR4, \
					TYPE_VECTOR4I:
						_array[write + 0] = value.x
						_array[write + 1] = value.y
						_array[write + 2] = value.z
						_array[write + 3] = value.w
						write += 4
					TYPE_ARRAY:
						match value.size():
							1:
								_array[write + 0] = value[0]
								_array[write + 1] = value[0]
								_array[write + 2] = value[0]
								_array[write + 3] = value[0]
								write += 4
							4:
								_array[write + 0] = value[0]
								_array[write + 1] = value[1]
								_array[write + 2] = value[2]
								_array[write + 3] = value[3]
								write += 4
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
		TYPE_VECTOR4:
			var write := 0
			for value: Vector4 in array:
				_array[write + 0] = value.x
				_array[write + 1] = value.y
				_array[write + 2] = value.z
				_array[write + 3] = value.w
				write += 4
		TYPE_VECTOR4I:
			var write := 0
			for value: Vector4i in array:
				_array[write + 0] = value.x
				_array[write + 1] = value.y
				_array[write + 2] = value.z
				_array[write + 3] = value.w
				write += 4

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

func _convert_from_packed_vector4_array(array: PackedVector4Array) -> void:
	var write := 0
	for value: Vector4 in array:
		_array[write + 0] = value.x
		_array[write + 1] = value.y
		_array[write + 2] = value.z
		_array[write + 3] = value.w
		write += 4

#endregion

func _init(array_size: int) -> void:
	_array.resize(array_size * 4)
