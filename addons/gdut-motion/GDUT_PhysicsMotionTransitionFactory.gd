@abstract
class_name GDUT_PhysicsMotionTransitionFactory extends GDUT_MotionTransitionFactory

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func set_initial_position(value: Variant) -> void:
<<<<<<< Updated upstream
	if not GDUT_Motion.validate_incoming_position(get_proxy(), value):
		GDUT_Motion.print_warning(
			&"BAD_INITIAL_POSITION",
			get_name(),
			value)
=======
	var target := get_target()
	if not GDUT_MotionPosition.is_valid_value(
		value,
		target.get_value_type(),
		target.get_array_size()):

		GDUT_Motion.print_warning(&"BAD_INITIAL_POSITION", get_name(), value)
>>>>>>> Stashed changes
		value = null
	_initial_position = value

func get_initial_position() -> Variant:
	return _initial_position

func set_final_position(value: Variant) -> void:
<<<<<<< Updated upstream
	if not GDUT_Motion.validate_incoming_position(get_proxy(), value):
		GDUT_Motion.print_warning(
			&"BAD_FINAL_POSITION",
			get_name(),
			value)
=======
	var target := get_target()
	if not GDUT_MotionPosition.is_valid_value(
		value,
		target.get_value_type(),
		target.get_array_size()):

		GDUT_Motion.print_warning(&"BAD_FINAL_POSITION", get_name(), value)
>>>>>>> Stashed changes
		value = null
	_final_position = value

func get_final_position() -> Variant:
	return _final_position

func set_initial_velocity(value: Variant) -> void:
<<<<<<< Updated upstream
	if not GDUT_Motion.validate_incoming_velocity(get_proxy(), value):
		GDUT_Motion.print_warning(
			&"BAD_INITIAL_VELOCITY",
			 get_name(),
			value)
=======
	var target := get_target()
	if not GDUT_MotionVelocity.is_valid_value(
		value,
		target.get_value_type(),
		target.get_array_size()):

		GDUT_Motion.print_warning(&"BAD_INITIAL_VELOCITY", get_name(), value)
>>>>>>> Stashed changes
		value = null
	_initial_velocity = value

func get_initial_velocity() -> Variant:
	return _initial_velocity

#-------------------------------------------------------------------------------

var _initial_position: Variant
var _final_position: Variant
var _initial_velocity: Variant
