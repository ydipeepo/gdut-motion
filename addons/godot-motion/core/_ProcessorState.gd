extends MotionState

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_value_type() -> int:
	return _target_value_type

func get_value_size() -> int:
	return _target_value_size

func get_array_size() -> int:
	return _target_array_size

func set_initial_position(value: Variant) -> void:
	_initial_position.set_external_value(value)

func get_initial_position() -> Variant:
	return _initial_position.get_external_value()

func get_initial_position_at(index: int) -> float:
	return _initial_position.get_at(index)

func set_final_position(value: Variant) -> void:
	_final_position.set_external_value(value)

func get_final_position() -> Variant:
	return _final_position.get_external_value()

func get_final_position_at(index: int) -> float:
	return _final_position.get_at(index)

func set_initial_velocity(value: Variant) -> void:
	_initial_velocity.set_external_value(value)

func get_initial_velocity() -> Variant:
	return _initial_velocity.get_external_value()

func get_initial_velocity_at(index: int) -> float:
	return _initial_velocity.get_at(index)

func set_position(value: Variant) -> void:
	_position.set_external_value(value)

func get_position() -> Variant:
	return _position.get_external_value()

func set_position_at(index: int, value: float) -> void:
	_position.set_at(index, value)

func get_position_at(index: int) -> float:
	return _position.get_at(index)

func set_velocity(value: Variant) -> void:
	_velocity.set_external_value(value)

func get_velocity() -> Variant:
	return _velocity.get_external_value()

func set_velocity_at(index: int, value: float) -> void:
	_velocity.set_at(index, value)

func get_velocity_at(index: int) -> float:
	return _velocity.get_at(index)

func set_rest_at(index: int) -> void:
	_rest.set_at(index)

func get_rest_at(index: int) -> bool:
	return _rest.get_at(index)

func clear_rest_at(index: int) -> void:
	_rest.clear_at(index)

func reset_initial_position(value: Variant) -> void:
	_initial_position.set_external_value(_position.get_external_value() if value == null else value)

func reset_final_position(value: Variant) -> void:
	_final_position.set_external_value(_position.get_external_value() if value == null else value)

func reset_initial_velocity(value: Variant) -> void:
	_initial_velocity.set_external_value(_velocity.get_external_value() if value == null else value)

func reset_rest() -> void:
	_rest.clear()

#-------------------------------------------------------------------------------

const _POSITION_CLASS := preload("uid://csy3050p11dl")
const _VELOCITY_CLASS := preload("uid://nlp5vq6rwq0k")
const _BITSET_CLASS := preload("uid://bivipc50d8ktf")

var _target_value_type: int
var _target_value_size: int
var _target_array_size: int

var _initial_position: _POSITION_CLASS
var _final_position: _POSITION_CLASS
var _initial_velocity: _VELOCITY_CLASS
var _position: _POSITION_CLASS
var _velocity: _VELOCITY_CLASS
var _rest: _BITSET_CLASS

func _init(
	target_value_type: int,
	target_value_size: int,
	target_array_size: int) -> void:

	var initial_position := _POSITION_CLASS.create(target_value_type, target_array_size)
	var final_position := _POSITION_CLASS.create(target_value_type, target_array_size)
	var initial_velocity := _VELOCITY_CLASS.create(target_value_type, target_array_size)
	var position := _POSITION_CLASS.create(target_value_type, target_array_size)
	var velocity := _VELOCITY_CLASS.create(target_value_type, target_array_size)
	var rest := _BITSET_CLASS.create(target_value_size * target_array_size)

	_target_value_type = target_value_type
	_target_value_size = target_value_size
	_target_array_size = target_array_size

	_initial_position = initial_position
	_final_position = final_position
	_initial_velocity = initial_velocity
	_position = position
	_velocity = velocity
	_rest = rest
