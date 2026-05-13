@abstract
extends RefCounted

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func is_value_valid(value: Variant, value_type: int, array_size: int) -> bool:
	match value_type:
		TYPE_INT, \
		TYPE_FLOAT when _FLOAT_CLASS.can_convert(value, array_size):
			return true
		TYPE_VECTOR2, \
		TYPE_VECTOR2I when _VECTOR2_CLASS.can_convert(value, array_size):
			return true
		TYPE_VECTOR3, \
		TYPE_VECTOR3I when _VECTOR3_CLASS.can_convert(value, array_size):
			return true
		TYPE_TRANSFORM2D when _TRANSFORM2D_CLASS.can_convert(value, array_size):
			return true
		TYPE_VECTOR4, \
		TYPE_VECTOR4I when _VECTOR4_CLASS.can_convert(value, array_size):
			return true
		TYPE_BASIS when _BASIS_CLASS.can_convert(value, array_size):
			return true
		TYPE_TRANSFORM3D when _TRANSFORM3D_CLASS.can_convert(value, array_size):
			return true
		TYPE_COLOR when _VECTOR4_CLASS.can_convert(value, array_size):
			return true
		TYPE_PACKED_INT32_ARRAY when _PACKED_FLOAT32_ARRAY_CLASS.can_convert(value, array_size):
			return true
		TYPE_PACKED_INT64_ARRAY when _PACKED_FLOAT64_ARRAY_CLASS.can_convert(value, array_size):
			return true
		TYPE_PACKED_FLOAT32_ARRAY when _PACKED_FLOAT32_ARRAY_CLASS.can_convert(value, array_size):
			return true
		TYPE_PACKED_FLOAT64_ARRAY when _PACKED_FLOAT64_ARRAY_CLASS.can_convert(value, array_size):
			return true
		TYPE_PACKED_VECTOR2_ARRAY when _PACKED_VECTOR2_ARRAY_CLASS.can_convert(value, array_size):
			return true
		TYPE_PACKED_VECTOR3_ARRAY when _PACKED_VECTOR3_ARRAY_CLASS.can_convert(value, array_size):
			return true
		TYPE_PACKED_COLOR_ARRAY, \
		TYPE_PACKED_VECTOR4_ARRAY when _PACKED_VECTOR4_ARRAY_CLASS.can_convert(value, array_size):
			return true
	return false

static func create(value_type: int, array_size: int) -> RefCounted:
	var velocity: RefCounted
	var create := _NEW_MAP[value_type]
	if create.is_valid():
		velocity = create.call(array_size)
	return velocity

@abstract
func set_external_value(value: Variant) -> void

@abstract
func get_external_value() -> Variant

@abstract
func set_at(index: int, value: float) -> void

@abstract
func get_at(index: int) -> float

#-------------------------------------------------------------------------------

const _BASIS_CLASS := preload("uid://x3whfwvkbomd")
const _FLOAT_CLASS := preload("uid://37edkw0dlsiw")
const _PACKED_FLOAT32_ARRAY_CLASS := preload("uid://cc2eqir1pcw36")
const _PACKED_FLOAT64_ARRAY_CLASS := preload("uid://b2jpm06noie3i")
const _PACKED_VECTOR2_ARRAY_CLASS := preload("uid://dr511ifl213k5")
const _PACKED_VECTOR3_ARRAY_CLASS := preload("uid://bkmq4a7hml1ro")
const _PACKED_VECTOR4_ARRAY_CLASS := preload("uid://cfs5w6ysdv0nc")
const _TRANSFORM2D_CLASS := preload("uid://cli1g84ntddm5")
const _TRANSFORM3D_CLASS := preload("uid://dfo70y7ey0l8")
const _VECTOR2_CLASS := preload("uid://cavnl1o62iyja")
const _VECTOR3_CLASS := preload("uid://bj0f7hwfj7vsq")
const _VECTOR4_CLASS := preload("uid://cgb4rod5h1wyv")

const _NEW_MAP: Dictionary[int, Callable] = {
	TYPE_INT: _FLOAT_CLASS.new,
	TYPE_FLOAT: _FLOAT_CLASS.new,
	TYPE_VECTOR2: _VECTOR2_CLASS.new,
	TYPE_VECTOR2I: _VECTOR2_CLASS.new,
	TYPE_VECTOR3: _VECTOR3_CLASS.new,
	TYPE_VECTOR3I: _VECTOR3_CLASS.new,
	TYPE_TRANSFORM2D: _TRANSFORM2D_CLASS.new,
	TYPE_VECTOR4: _VECTOR4_CLASS.new,
	TYPE_VECTOR4I: _VECTOR4_CLASS.new,
	TYPE_BASIS: _BASIS_CLASS.new,
	TYPE_TRANSFORM3D: _TRANSFORM3D_CLASS.new,
	TYPE_COLOR: _VECTOR4_CLASS.new,
	TYPE_PACKED_INT32_ARRAY: _PACKED_FLOAT32_ARRAY_CLASS.new,
	TYPE_PACKED_INT64_ARRAY: _PACKED_FLOAT64_ARRAY_CLASS.new,
	TYPE_PACKED_FLOAT32_ARRAY: _PACKED_FLOAT32_ARRAY_CLASS.new,
	TYPE_PACKED_FLOAT64_ARRAY: _PACKED_FLOAT64_ARRAY_CLASS.new,
	TYPE_PACKED_VECTOR2_ARRAY: _PACKED_VECTOR2_ARRAY_CLASS.new,
	TYPE_PACKED_VECTOR3_ARRAY: _PACKED_VECTOR3_ARRAY_CLASS.new,
	TYPE_PACKED_COLOR_ARRAY: _PACKED_VECTOR4_ARRAY_CLASS.new,
	TYPE_PACKED_VECTOR4_ARRAY: _PACKED_VECTOR4_ARRAY_CLASS.new,
}
