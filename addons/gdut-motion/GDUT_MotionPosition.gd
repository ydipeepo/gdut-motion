@abstract
class_name GDUT_MotionPosition

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@abstract
func set_incoming_value(value: Variant) -> void

@abstract
func get_outgoing_value() -> Variant

@abstract
func set_value_at(index: int, value: float) -> void

@abstract
func get_value_at(index: int) -> float
