@abstract
class_name GDUT_MotionBitSet

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
@abstract
func set_value_at(index: int, value: bool) -> void

@abstract
func get_value_at(index: int) -> bool
=======
static func create(
	value_size: int,
	array_size: int) -> GDUT_MotionBitSet:

	var size := value_size * array_size
	return \
		GDUT_SmallMotionBitSet.new() \
		if size <= 32 else \
		GDUT_LargeMotionBitSet.new(size)

#@abstract
#func count() -> int

@abstract
func get_at(index: int) -> bool

@abstract
func set_at(index: int) -> void

@abstract
func clear_at(index: int) -> void

#@abstract
#func clear() -> void
>>>>>>> Stashed changes
