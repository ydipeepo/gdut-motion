@abstract
class_name MotionProxy

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

@abstract
func is_valid() -> bool

@abstract
func get_name() -> String

@abstract
func set_value(value: Variant) -> void

@abstract
func get_value() -> Variant

@abstract
func get_value_type() -> int

@abstract
func get_value_size() -> int

@abstract
func get_array_size() -> int

@abstract
func equals(proxy: MotionProxy) -> bool
