class_name GDUT_BezierMotionPresetPreview extends GDUT_PerceivedMotionPresetPreview

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func draw(transform: Transform2D) -> void:
	super(transform)
	draw_dashed_line(transform * Vector2.ZERO, transform * _cp1, _CP1_COLOR, 0.5, 3.0, true, true)
	draw_dashed_line(transform * Vector2.ONE, transform * _cp2, _CP2_COLOR, 0.5, 3.0, true, true)
	draw_rect(Rect2(transform * _cp1 - _TIP_SIZE * 0.5, _TIP_SIZE), _CP1_COLOR, false, 0.5, true)
	draw_rect(Rect2(transform * _cp2 - _TIP_SIZE * 0.5, _TIP_SIZE), _CP2_COLOR, false, 0.5, true)

func reset() -> void:
	var preset := get_preset() as BezierMotionPreset
	_cp1.x = preset.x1
	_cp1.y = preset.y1
	_cp2.x = preset.x2
	_cp2.y = preset.y2
	_x.x = 1.0 - 3.0 * _cp2.x + 3.0 * _cp1.x
	_x.y = 3.0 * _cp2.x - 6.0 * _cp1.x
	_x.z = 3.0 * _cp1.x
	_y.x = 1.0 - 3.0 * _cp2.y + 3.0 * _cp1.y
	_y.y = 3.0 * _cp2.y - 6.0 * _cp1.y
	_y.z = 3.0 * _cp1.y

func solve(t: float) -> float:
	t /= get_duration()
	var a := 0.0
	var b := 1.0
	var current_t: float
	var current_x: float
	for j: int in _SUBDIVISION_MAX_ITERS:
		current_t = 0.5 * (a + b)
		current_x = ((_x.x * current_t + _x.y) * current_t + _x.z) * current_t - t
		if 0.0 < current_x:
			b = current_t
		else:
			a = current_t
		if absf(current_x) <= _EPSILON:
			break
	return ((_y.x * current_t + _y.y) * current_t + _y.z) * current_t

#-------------------------------------------------------------------------------

const _EPSILON := 0.0001
const _SUBDIVISION_MAX_ITERS := 10
const _TIP_SIZE := Vector2(5.0, 5.0)
const _CP1_COLOR := Color.BLUE
const _CP2_COLOR := Color.RED

var _cp1: Vector2
var _cp2: Vector2
var _x: Vector3
var _y: Vector3
