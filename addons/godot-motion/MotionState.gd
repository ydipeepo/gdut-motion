@abstract
class_name MotionState

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

var value_type: int:
	get = get_value_type

var value_size: int:
	get = get_value_size

var array_size: int:
	get = get_array_size

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@abstract
func get_value_type() -> int

@abstract
func get_value_size() -> int

@abstract
func get_array_size() -> int

@abstract
func set_initial_position(value: Variant) -> void

@abstract
func get_initial_position() -> Variant

@abstract
func get_initial_position_at(index: int) -> float

@abstract
func set_final_position(value: Variant) -> void

@abstract
func get_final_position() -> Variant

@abstract
func get_final_position_at(index: int) -> float

@abstract
func set_initial_velocity(value: Variant) -> void

@abstract
func get_initial_velocity() -> Variant

@abstract
func get_initial_velocity_at(index: int) -> float

@abstract
func set_position(value: Variant) -> void

@abstract
func get_position() -> Variant

@abstract
func set_position_at(index: int, value: float) -> void

@abstract
func get_position_at(index: int) -> float

@abstract
func set_velocity(value: Variant) -> void

@abstract
func get_velocity() -> Variant

@abstract
func set_velocity_at(index: int, value: float) -> void

@abstract
func get_velocity_at(index: int) -> float

@abstract
func set_rest_at(index: int) -> void

@abstract
func get_rest_at(index: int) -> bool

@abstract
func clear_rest_at(index: int) -> void

@abstract
func reset_initial_position(value: Variant) -> void

@abstract
func reset_final_position(value: Variant) -> void

@abstract
func reset_initial_velocity(value: Variant) -> void

@abstract
func reset_rest() -> void
