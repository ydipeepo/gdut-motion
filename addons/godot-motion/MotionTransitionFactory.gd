@abstract
class_name MotionTransitionFactory

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const PROCESS_IDLE := MotionTransition.PROCESS_IDLE
const PROCESS_PHYSICS := MotionTransition.PROCESS_PHYSICS
const VALID_PROCESS := MotionTransition.VALID_PROCESS
const DEFAULT_PROCESS := PROCESS_IDLE

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func is_valid_position(value: Variant) -> bool:
	return _POSITION_CLASS.is_value_valid(
		value,
		_target.get_value_type(),
		_target.get_array_size())

func is_valid_velocity(value: Variant) -> bool:
	return _VELOCITY_CLASS.is_value_valid(
		value,
		_target.get_value_type(),
		_target.get_array_size())

func load_preset(preset_name: StringName) -> void:
	MotionPresetBank.apply(
		preset_name,
		self,
		get_expression_name())

@abstract
func get_expression_name() -> StringName

func get_target() -> MotionTarget:
	return _target

@abstract
func set_process(value: int) -> void

@abstract
func get_process() -> int

@abstract
func create_transition(completion: Array) -> MotionTransition

#-------------------------------------------------------------------------------

const _POSITION_CLASS := preload("uid://csy3050p11dl")
const _VELOCITY_CLASS := preload("uid://nlp5vq6rwq0k")

var _target: MotionTarget

func _init(target: MotionTarget) -> void:
	assert(is_instance_valid(target))

	_target = target
