@abstract
class_name GDUT_MotionVelocity

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
	value_type: int,
	array_size: int) -> GDUT_MotionVelocity:

	var create: Callable = _create_map[value_type]
	return create.call(array_size)

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
	TYPE_INT: GDUT_FloatMotionVelocity.can_convert,
	TYPE_FLOAT: GDUT_FloatMotionVelocity.can_convert,
	TYPE_VECTOR2: GDUT_Vector2MotionVelocity.can_convert,
	TYPE_VECTOR2I: GDUT_Vector2MotionVelocity.can_convert,
	TYPE_VECTOR3: GDUT_Vector3MotionVelocity.can_convert,
	TYPE_VECTOR3I: GDUT_Vector3MotionVelocity.can_convert,
	TYPE_TRANSFORM2D: GDUT_Transform2DMotionVelocity.can_convert,
	TYPE_VECTOR4: GDUT_Vector4MotionVelocity.can_convert,
	TYPE_VECTOR4I: GDUT_Vector4MotionVelocity.can_convert,
	TYPE_BASIS: GDUT_BasisMotionVelocity.can_convert,
	TYPE_TRANSFORM3D: GDUT_Transform3DMotionVelocity.can_convert,
	TYPE_COLOR: GDUT_Vector4MotionVelocity.can_convert,
	TYPE_PACKED_INT32_ARRAY: GDUT_PackedFloat32ArrayMotionVelocity.can_convert,
	TYPE_PACKED_INT64_ARRAY: GDUT_PackedFloat64ArrayMotionVelocity.can_convert,
	TYPE_PACKED_FLOAT32_ARRAY: GDUT_PackedFloat32ArrayMotionVelocity.can_convert,
	TYPE_PACKED_FLOAT64_ARRAY: GDUT_PackedFloat64ArrayMotionVelocity.can_convert,
	TYPE_PACKED_VECTOR2_ARRAY: GDUT_PackedVector2ArrayMotionVelocity.can_convert,
	TYPE_PACKED_VECTOR3_ARRAY: GDUT_PackedVector3ArrayMotionVelocity.can_convert,
	TYPE_PACKED_COLOR_ARRAY: GDUT_PackedVector4ArrayMotionVelocity.can_convert,
	TYPE_PACKED_VECTOR4_ARRAY: GDUT_PackedVector4ArrayMotionVelocity.can_convert,
}
static var _create_map: Dictionary[int, Callable] = {
	TYPE_INT: GDUT_FloatMotionVelocity.new,
	TYPE_FLOAT: GDUT_FloatMotionVelocity.new,
	TYPE_VECTOR2: GDUT_Vector2MotionVelocity.new,
	TYPE_VECTOR2I: GDUT_Vector2MotionVelocity.new,
	TYPE_VECTOR3: GDUT_Vector3MotionVelocity.new,
	TYPE_VECTOR3I: GDUT_Vector3MotionVelocity.new,
	TYPE_TRANSFORM2D: GDUT_Transform2DMotionVelocity.new,
	TYPE_VECTOR4: GDUT_Vector4MotionVelocity.new,
	TYPE_VECTOR4I: GDUT_Vector4MotionVelocity.new,
	TYPE_BASIS: GDUT_BasisMotionVelocity.new,
	TYPE_TRANSFORM3D: GDUT_Transform3DMotionVelocity.new,
	TYPE_COLOR: GDUT_Vector4MotionVelocity.new,
	TYPE_PACKED_INT32_ARRAY: GDUT_PackedFloat32ArrayMotionVelocity.new,
	TYPE_PACKED_INT64_ARRAY: GDUT_PackedFloat64ArrayMotionVelocity.new,
	TYPE_PACKED_FLOAT32_ARRAY: GDUT_PackedFloat32ArrayMotionVelocity.new,
	TYPE_PACKED_FLOAT64_ARRAY: GDUT_PackedFloat64ArrayMotionVelocity.new,
	TYPE_PACKED_VECTOR2_ARRAY: GDUT_PackedVector2ArrayMotionVelocity.new,
	TYPE_PACKED_VECTOR3_ARRAY: GDUT_PackedVector3ArrayMotionVelocity.new,
	TYPE_PACKED_COLOR_ARRAY: GDUT_PackedVector4ArrayMotionVelocity.new,
	TYPE_PACKED_VECTOR4_ARRAY: GDUT_PackedVector4ArrayMotionVelocity.new,
}
>>>>>>> Stashed changes
