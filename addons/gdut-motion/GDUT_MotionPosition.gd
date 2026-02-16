@abstract
class_name GDUT_MotionPosition

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
@abstract
func set_incoming_value(value: Variant) -> void

@abstract
func get_outgoing_value() -> Variant
=======
static func is_valid_value(
	value: Variant,
	value_type: int,
	array_size: int) -> bool:

	var validate: Callable = _validate_map.get(value_type)
	return validate.is_valid() and validate.call(value, array_size)

static func create(
	value: Variant,
	value_type: int,
	array_size: int) -> GDUT_MotionPosition:

	var position: GDUT_MotionPosition
	var create: Callable = _create_map.get(value_type)
	if create.is_valid():
		position = create.call(array_size)
	return position

@abstract
func set_value(value: Variant) -> void

@abstract
func get_value() -> Variant
>>>>>>> Stashed changes

@abstract
func set_value_at(index: int, value: float) -> void

@abstract
func get_value_at(index: int) -> float
<<<<<<< Updated upstream
=======

#-------------------------------------------------------------------------------

static var _validate_map: Dictionary[int, Callable] = {
	TYPE_INT: GDUT_IntMotionPosition.can_convert,
	TYPE_FLOAT: GDUT_FloatMotionPosition.can_convert,
	TYPE_VECTOR2: GDUT_Vector2MotionPosition.can_convert,
	TYPE_VECTOR2I: GDUT_Vector2iMotionPosition.can_convert,
	TYPE_VECTOR3: GDUT_Vector3MotionPosition.can_convert,
	TYPE_VECTOR3I: GDUT_Vector3iMotionPosition.can_convert,
	TYPE_TRANSFORM2D: GDUT_Transform2DMotionPosition.can_convert,
	TYPE_VECTOR4: GDUT_Vector4MotionPosition.can_convert,
	TYPE_VECTOR4I: GDUT_Vector4iMotionPosition.can_convert,
	TYPE_BASIS: GDUT_BasisMotionPosition.can_convert,
	TYPE_TRANSFORM3D: GDUT_Transform3DMotionPosition.can_convert,
	TYPE_COLOR: GDUT_ColorMotionPosition.can_convert,
	TYPE_PACKED_INT32_ARRAY: GDUT_PackedInt32ArrayMotionPosition.can_convert,
	TYPE_PACKED_INT64_ARRAY: GDUT_PackedInt64ArrayMotionPosition.can_convert,
	TYPE_PACKED_FLOAT32_ARRAY: GDUT_PackedFloat32ArrayMotionPosition.can_convert,
	TYPE_PACKED_FLOAT64_ARRAY: GDUT_PackedFloat64ArrayMotionPosition.can_convert,
	TYPE_PACKED_VECTOR2_ARRAY: GDUT_PackedVector2ArrayMotionPosition.can_convert,
	TYPE_PACKED_VECTOR3_ARRAY: GDUT_PackedVector3ArrayMotionPosition.can_convert,
	TYPE_PACKED_COLOR_ARRAY: GDUT_PackedColorArrayMotionPosition.can_convert,
	TYPE_PACKED_VECTOR4_ARRAY: GDUT_PackedVector4ArrayMotionPosition.can_convert,
}
static var _create_map: Dictionary[int, Callable] = {
	TYPE_INT: GDUT_IntMotionPosition.new,
	TYPE_FLOAT: GDUT_FloatMotionPosition.new,
	TYPE_VECTOR2: GDUT_Vector2MotionPosition.new,
	TYPE_VECTOR2I: GDUT_Vector2iMotionPosition.new,
	TYPE_VECTOR3: GDUT_Vector3MotionPosition.new,
	TYPE_VECTOR3I: GDUT_Vector3iMotionPosition.new,
	TYPE_TRANSFORM2D: GDUT_Transform2DMotionPosition.new,
	TYPE_VECTOR4: GDUT_Vector4MotionPosition.new,
	TYPE_VECTOR4I: GDUT_Vector4iMotionPosition.new,
	TYPE_BASIS: GDUT_BasisMotionPosition.new,
	TYPE_TRANSFORM3D: GDUT_Transform3DMotionPosition.new,
	TYPE_COLOR: GDUT_ColorMotionPosition.new,
	TYPE_PACKED_INT32_ARRAY: GDUT_PackedInt32ArrayMotionPosition.new,
	TYPE_PACKED_INT64_ARRAY: GDUT_PackedInt64ArrayMotionPosition.new,
	TYPE_PACKED_FLOAT32_ARRAY: GDUT_PackedFloat32ArrayMotionPosition.new,
	TYPE_PACKED_FLOAT64_ARRAY: GDUT_PackedFloat64ArrayMotionPosition.new,
	TYPE_PACKED_VECTOR2_ARRAY: GDUT_PackedVector2ArrayMotionPosition.new,
	TYPE_PACKED_VECTOR3_ARRAY: GDUT_PackedVector3ArrayMotionPosition.new,
	TYPE_PACKED_COLOR_ARRAY: GDUT_PackedColorArrayMotionPosition.new,
	TYPE_PACKED_VECTOR4_ARRAY: GDUT_PackedVector4ArrayMotionPosition.new,
}
>>>>>>> Stashed changes
