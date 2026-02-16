@abstract
class_name GDUT_PhysicsMotionPresetPreview extends GDUT_MotionPresetPreview

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_initial_velocity() -> float:
	return _initial_velocity

func set_initial_velocity(value: float) -> void:
	_initial_velocity = value
	reset()
	queue_redraw()

@abstract
func get_minimum_initial_velocity() -> float

@abstract
func get_maximum_initial_velocity() -> float

func draw(transform: Transform2D) -> void:
	super(transform)
	draw_dashed_line(
		transform * Vector2.ZERO,
		transform * Vector2(1.0, get_initial_velocity() * get_duration()),
		_V0_COLOR,
		0.5,
		3.0,
		true,
		true)

#-------------------------------------------------------------------------------

const _V0_COLOR := Color.BLUE

var _initial_velocity := 0.0
