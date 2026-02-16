class_name GDUT_MotionState

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
static func create(proxy: MotionProxy) -> GDUT_MotionState:
	return new(proxy)

func get_value_type() -> int:
	return _value_type

func get_value_size() -> int:
	return _value_size

func get_array_size() -> int:
	return _array_size

func create_initial_position(value: Variant) -> void:
	_initial_position.set_incoming_value(_position.get_outgoing_value() if value == null else value)

func create_final_position(value: Variant) -> void:
	_final_position.set_incoming_value(_position.get_outgoing_value() if value == null else value)

func create_initial_velocity(value: Variant) -> void:
	_initial_velocity.set_incoming_value(_velocity.get_outgoing_value() if value == null else value)
=======
func get_value_type() -> int:
	return _target_value_type

func get_value_size() -> int:
	return _target_value_size

func get_array_size() -> int:
	return _target_array_size

func reset_initial_position(value: Variant) -> void:
	_initial_position.set_value(_position.get_value() if value == null else value)

func reset_final_position(value: Variant) -> void:
	_final_position.set_value(_position.get_value() if value == null else value)

func reset_initial_velocity(value: Variant) -> void:
	_initial_velocity.set_value(_velocity.get_value() if value == null else value)
>>>>>>> Stashed changes

func set_initial_position_at(index: int, value: float) -> void:
	_initial_position.set_value_at(index, value)

func get_initial_position_at(index: int) -> float:
	return _initial_position.get_value_at(index)

func set_final_position_at(index: int, value: float) -> void:
	_final_position.set_value_at(index, value)

func get_final_position_at(index: int) -> float:
	return _final_position.get_value_at(index)

func set_position(value: Variant) -> void:
<<<<<<< Updated upstream
	_position.set_incoming_value(value)

func get_position() -> Variant:
	return _position.get_outgoing_value()
=======
	_position.set_value(value)

func get_position() -> Variant:
	return _position.get_value()
>>>>>>> Stashed changes

func set_position_at(index: int, value: float) -> void:
	_position.set_value_at(index, value)

func get_position_at(index: int) -> float:
	return _position.get_value_at(index)

func set_initial_velocity_at(index: int, value: float) -> void:
	_initial_velocity.set_value_at(index, value)

func get_initial_velocity_at(index: int) -> float:
	return _initial_velocity.get_value_at(index)

func set_velocity(value: Variant) -> void:
<<<<<<< Updated upstream
	_velocity.set_incoming_value(value)

func get_velocity() -> Variant:
	return _velocity.get_outgoing_value()
=======
	_velocity.set_value(value)

func get_velocity() -> Variant:
	return _velocity.get_value()
>>>>>>> Stashed changes

func set_velocity_at(index: int, value: float) -> void:
	_velocity.set_value_at(index, value)

func get_velocity_at(index: int) -> float:
	return _velocity.get_value_at(index)

<<<<<<< Updated upstream
func set_rest_at(index: int, value: bool) -> void:
	_rest_bits.set_value_at(index, value)

func get_rest_at(index: int) -> bool:
	return _rest_bits.get_value_at(index)

#-------------------------------------------------------------------------------

=======
func get_rest_at(index: int) -> bool:
	return _rest.get_at(index)

func set_rest_at(index: int) -> void:
	_rest.set_at(index)

func clear_rest_at(index: int) -> void:
	_rest.clear_at(index)

#-------------------------------------------------------------------------------

var _target_value_type: int
var _target_value_size: int
var _target_array_size: int

>>>>>>> Stashed changes
var _initial_position: GDUT_MotionPosition
var _final_position: GDUT_MotionPosition
var _initial_velocity: GDUT_MotionVelocity
var _position: GDUT_MotionPosition
var _velocity: GDUT_MotionVelocity
<<<<<<< Updated upstream
var _rest_bits: GDUT_MotionBitSet
var _value_type: int
var _value_size: int
var _array_size: int

func _init(proxy: MotionProxy) -> void:
	_initial_position = GDUT_Motion.create_position(proxy)
	_final_position = GDUT_Motion.create_position(proxy)
	_initial_velocity = GDUT_Motion.create_velocity(proxy)
	_position = GDUT_Motion.create_position(proxy)
	_velocity = GDUT_Motion.create_velocity(proxy)
	_rest_bits = GDUT_Motion.create_bitset(proxy)

	_value_type = proxy.get_value_type()
	_value_size = proxy.get_value_size()
	_array_size = proxy.get_array_size()
=======
var _rest: GDUT_MotionBitSet

func _init(target: GDUT_MotionTarget) -> void:
	_target_value_type = target.get_value_type()
	_target_value_size = target.get_value_size()
	_target_array_size = target.get_array_size()

	var target_value := target.get_value()

	_initial_position = GDUT_MotionPosition.create(target_value, _target_value_type, _target_array_size)
	_final_position = GDUT_MotionPosition.create(target_value, _target_value_type, _target_array_size)
	_initial_velocity = GDUT_MotionVelocity.create(_target_value_type, _target_array_size)
	_position = GDUT_MotionPosition.create(target_value, _target_value_type, _target_array_size)
	_velocity = GDUT_MotionVelocity.create(_target_value_type, _target_array_size)
	_rest = GDUT_MotionBitSet.create(_target_value_size, _target_array_size)
>>>>>>> Stashed changes
