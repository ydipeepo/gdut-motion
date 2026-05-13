@abstract
extends RefCounted

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func is_value_valid(value: Variant, value_type: int, array_size: int) -> bool:
	match value_type:
		TYPE_INT when _INT_CLASS.can_convert(value, array_size):
			return true
		TYPE_FLOAT when _FLOAT_CLASS.can_convert(value, array_size):
			return true
		TYPE_VECTOR2 when _VECTOR2_CLASS.can_convert(value, array_size):
			return true
		TYPE_VECTOR2I when _VECTOR2I_CLASS.can_convert(value, array_size):
			return true
		TYPE_VECTOR3 when _VECTOR3_CLASS.can_convert(value, array_size):
			return true
		TYPE_VECTOR3I when _VECTOR3I_CLASS.can_convert(value, array_size):
			return true
		TYPE_TRANSFORM2D when _TRANSFORM2D_CLASS.can_convert(value, array_size):
			return true
		TYPE_VECTOR4 when _VECTOR4_CLASS.can_convert(value, array_size):
			return true
		TYPE_VECTOR4I when _VECTOR4I_CLASS.can_convert(value, array_size):
			return true
		TYPE_BASIS when _BASIS_CLASS.can_convert(value, array_size):
			return true
		TYPE_TRANSFORM3D when _TRANSFORM3D_CLASS.can_convert(value, array_size):
			return true
		TYPE_COLOR when _COLOR_CLASS.can_convert(value, array_size):
			return true
		TYPE_PACKED_INT32_ARRAY when _PACKED_INT32_ARRAY_CLASS.can_convert(value, array_size):
			return true
		TYPE_PACKED_INT64_ARRAY when _PACKED_INT64_ARRAY_CLASS.can_convert(value, array_size):
			return true
		TYPE_PACKED_FLOAT32_ARRAY when _PACKED_FLOAT32_ARRAY_CLASS.can_convert(value, array_size):
			return true
		TYPE_PACKED_FLOAT64_ARRAY when _PACKED_FLOAT64_ARRAY_CLASS.can_convert(value, array_size):
			return true
		TYPE_PACKED_VECTOR2_ARRAY when _PACKED_VECTOR2_ARRAY_CLASS.can_convert(value, array_size):
			return true
		TYPE_PACKED_VECTOR3_ARRAY when _PACKED_VECTOR3_ARRAY_CLASS.can_convert(value, array_size):
			return true
		TYPE_PACKED_COLOR_ARRAY when _PACKED_COLOR_ARRAY_CLASS.can_convert(value, array_size):
			return true
		TYPE_PACKED_VECTOR4_ARRAY when _PACKED_VECTOR4_ARRAY_CLASS.can_convert(value, array_size):
			return true
	return false

static func create(value_type: int, array_size: int) -> RefCounted:
	var position: RefCounted
	var create := _NEW_MAP.get(value_type)
	if create.is_valid():
		position = create.call(array_size)
	return position

@abstract
func set_external_value(value: Variant) -> void

@abstract
func get_external_value() -> Variant

@abstract
func set_at(index: int, value: float) -> void

@abstract
func get_at(index: int) -> float

#-------------------------------------------------------------------------------

const _BASIS_CLASS := preload("uid://dl1lvb5fe6s7d")
const _COLOR_CLASS := preload("uid://ben6uhdj1vy8w")
const _FLOAT_CLASS := preload("uid://2lyk4bnfeam5")
const _INT_CLASS := preload("uid://7070374cadwv")
const _PACKED_COLOR_ARRAY_CLASS := preload("uid://mdq6ktmaya5n")
const _PACKED_FLOAT32_ARRAY_CLASS := preload("uid://b4akoc6nb1862")
const _PACKED_FLOAT64_ARRAY_CLASS := preload("uid://7qb567mglj3l")
const _PACKED_INT32_ARRAY_CLASS := preload("uid://bsvbnxv6ghap5")
const _PACKED_INT64_ARRAY_CLASS := preload("uid://chbx35oeq1kj7")
const _PACKED_VECTOR2_ARRAY_CLASS := preload("uid://ba755ee8ivsjw")
const _PACKED_VECTOR3_ARRAY_CLASS := preload("uid://7jbk8ktg2g40")
const _PACKED_VECTOR4_ARRAY_CLASS := preload("uid://dqkwnlywe1hll")
const _TRANSFORM2D_CLASS := preload("uid://chg6shoql4072")
const _TRANSFORM3D_CLASS := preload("uid://37w0q28h4el3")
const _VECTOR2I_CLASS := preload("uid://celaimru2q8lt")
const _VECTOR2_CLASS := preload("uid://bf4cmwwcwmmlj")
const _VECTOR3I_CLASS := preload("uid://b61ppu48i8p4s")
const _VECTOR3_CLASS := preload("uid://i630yraymydv")
const _VECTOR4I_CLASS := preload("uid://bshv3y1s1mw77")
const _VECTOR4_CLASS := preload("uid://b5f8m7mb5j5qd")

const _NEW_MAP: Dictionary[int, Callable] = {
	TYPE_INT: _INT_CLASS.new,
	TYPE_FLOAT: _FLOAT_CLASS.new,
	TYPE_VECTOR2: _VECTOR2_CLASS.new,
	TYPE_VECTOR2I: _VECTOR2I_CLASS.new,
	TYPE_VECTOR3: _VECTOR3_CLASS.new,
	TYPE_VECTOR3I: _VECTOR3I_CLASS.new,
	TYPE_TRANSFORM2D: _TRANSFORM2D_CLASS.new,
	TYPE_VECTOR4: _VECTOR4_CLASS.new,
	TYPE_VECTOR4I: _VECTOR4I_CLASS.new,
	TYPE_BASIS: _BASIS_CLASS.new,
	TYPE_TRANSFORM3D: _TRANSFORM3D_CLASS.new,
	TYPE_COLOR: _COLOR_CLASS.new,
	TYPE_PACKED_INT32_ARRAY: _PACKED_INT32_ARRAY_CLASS.new,
	TYPE_PACKED_INT64_ARRAY: _PACKED_INT64_ARRAY_CLASS.new,
	TYPE_PACKED_FLOAT32_ARRAY: _PACKED_FLOAT32_ARRAY_CLASS.new,
	TYPE_PACKED_FLOAT64_ARRAY: _PACKED_FLOAT64_ARRAY_CLASS.new,
	TYPE_PACKED_VECTOR2_ARRAY: _PACKED_VECTOR2_ARRAY_CLASS.new,
	TYPE_PACKED_VECTOR3_ARRAY: _PACKED_VECTOR3_ARRAY_CLASS.new,
	TYPE_PACKED_COLOR_ARRAY: _PACKED_COLOR_ARRAY_CLASS.new,
	TYPE_PACKED_VECTOR4_ARRAY: _PACKED_VECTOR4_ARRAY_CLASS.new,
}
