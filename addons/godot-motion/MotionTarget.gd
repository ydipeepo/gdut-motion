## Abstract base class representing a [MotionTarget].
##
## [MotionTarget] encapsulates a property or method that can be
## read from and written to by [MotionTransition]s.[br]
## It provides a unified interface for accessing and modifying
## values regardless of whether the underlying target is:[br]
##
## - A property path on an [Object]
## - A method ([Callable])
## - A named method on an [Object]
@abstract
class_name MotionTarget

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

## Creates a [MotionTarget] that wraps an [Object] property.
static func create_property(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint: int = TYPE_NIL) -> MotionTarget:

	return preload("core/target/_Property.gd").create(
		target_object,
		target_property_path,
		target_value_type_hint)

## Creates a [MotionTarget] that wraps a [Callable] method.
static func create_method(
	target_method: Callable,
	target_value_type_hint: int = TYPE_NIL) -> MotionTarget:

	return preload("core/target/_Method.gd").create(
		target_method,
		target_value_type_hint)

## Creates a [MotionTarget] that wraps a named method on an [Object].
static func create_method_name(
	target_object: Object,
	target_method_name: StringName,
	target_value_type_hint: int = TYPE_NIL) -> MotionTarget:

	return preload("core/target/_MethodName.gd").create(
		target_object,
		target_method_name,
		target_value_type_hint)

@abstract
func is_valid() -> bool

@abstract
func get_name() -> String

@abstract
func get_value_type() -> int

@abstract
func get_value_size() -> int

@abstract
func get_array_size() -> int

@abstract
func set_value(value: Variant) -> void

@abstract
func get_value() -> Variant

@abstract
func equals(target: MotionTarget) -> bool
