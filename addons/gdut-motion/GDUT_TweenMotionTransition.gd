class_name GDUT_TweenMotionTransition extends GDUT_PerceivedMotionTransition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const EASE_IN: int = Tween.EASE_IN
const EASE_OUT: int = Tween.EASE_OUT
const EASE_IN_OUT: int = Tween.EASE_IN_OUT
const EASE_OUT_IN: int = Tween.EASE_OUT_IN

const VALID_EASE: Array[int] = [
	EASE_IN,
	EASE_OUT,
	EASE_IN_OUT,
	EASE_OUT_IN,
]

const TRANS_LINEAR: int = Tween.TRANS_LINEAR
const TRANS_SINE: int = Tween.TRANS_SINE
const TRANS_QUINT: int = Tween.TRANS_QUINT
const TRANS_QUART: int = Tween.TRANS_QUART
const TRANS_QUAD: int = Tween.TRANS_QUAD
const TRANS_EXPO: int = Tween.TRANS_EXPO
const TRANS_ELASTIC: int = Tween.TRANS_ELASTIC
const TRANS_CUBIC: int = Tween.TRANS_CUBIC
const TRANS_CIRC: int = Tween.TRANS_CIRC
const TRANS_BOUNCE: int = Tween.TRANS_BOUNCE
const TRANS_BACK: int = Tween.TRANS_BACK
const TRANS_SPRING: int = Tween.TRANS_SPRING

const VALID_TRANS := [
	TRANS_LINEAR,
	TRANS_SINE,
	TRANS_QUINT,
	TRANS_QUART,
	TRANS_QUAD,
	TRANS_EXPO,
	TRANS_ELASTIC,
	TRANS_CUBIC,
	TRANS_CIRC,
	TRANS_BOUNCE,
	TRANS_BACK,
	TRANS_SPRING,
]

const DEFAULT_EASE := EASE_IN_OUT
const DEFAULT_TRANS := TRANS_LINEAR

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_value(x: float) -> float:
	return _ease_f.call(x)

func get_prime(x: float) -> float:
	return _ease_df.call(x)

#-------------------------------------------------------------------------------

var _ease_f: Callable
var _ease_df: Callable

@warning_ignore("shadowed_global_identifier")
func _init(
	ease: int,
	trans: int,
	duration: float,
	initial_position: Variant,
	final_position: Variant,
	process: int,
	completion: Array) -> void:

	super(
		duration,
		initial_position,
		final_position,
		process,
		completion)

	assert(ease in VALID_EASE)
	assert(trans in VALID_TRANS)

	_ease_f = _ease_f_map[trans][ease]
	_ease_df = _ease_df_map[trans][ease]

#region easing functions

const _HALF_PI := 0.5 * PI
const _LN2 := log(2.0)

static var _ease_f_map: Array[Array] = [
	# TRANS_LINEAR
	[
		_ease_f_linear,
		_ease_f_linear,
		_ease_f_linear,
		_ease_f_linear,
	],

	# TRANS_SINE
	[
		_ease_f_sinusoidal_in,
		_ease_f_sinusoidal_out,
		_ease_f_sinusoidal_inout,
		_ease_f_sinusoidal_outin,
	],

	# TRANS_QUINT
	[
		_ease_f_quintic_in,
		_ease_f_quintic_out,
		_ease_f_quintic_inout,
		_ease_f_quintic_outin,
	],

	# TRANS_QUART
	[
		_ease_f_quartic_in,
		_ease_f_quartic_out,
		_ease_f_quartic_inout,
		_ease_f_quartic_outin,
	],

	# TRANS_QUAD
	[
		_ease_f_quadratic_in,
		_ease_f_quadratic_out,
		_ease_f_quadratic_inout,
		_ease_f_quadratic_outin,
	],

	# TRANS_EXPO
	[
		_ease_f_exponential_in,
		_ease_f_exponential_out,
		_ease_f_exponential_inout,
		_ease_f_exponential_outin,
	],

	# TRANS_ELASTIC
	[
		_ease_f_elastic_in,
		_ease_f_elastic_out,
		_ease_f_elastic_inout,
		_ease_f_elastic_outin,
	],

	# TRANS_CUBIC
	[
		_ease_f_cubic_in,
		_ease_f_cubic_out,
		_ease_f_cubic_inout,
		_ease_f_cubic_outin,
	],

	# TRANS_CIRC
	[
		_ease_f_circular_in,
		_ease_f_circular_out,
		_ease_f_circular_inout,
		_ease_f_circular_outin,
	],

	# TRANS_BOUNCE
	[
		_ease_f_bounce_in,
		_ease_f_bounce_out,
		_ease_f_bounce_inout,
		_ease_f_bounce_outin,
	],

	# TRANS_BACK
	[
		_ease_f_back_in,
		_ease_f_back_out,
		_ease_f_back_inout,
		_ease_f_back_outin,
	],

	# TRANS_SPRING
	[
		_ease_f_spring_in,
		_ease_f_spring_out,
		_ease_f_spring_inout,
		_ease_f_spring_outin,
	],
]
static var _ease_df_map: Array[Array] = [
	# TRANS_LINEAR
	[
		_ease_df_linear,
		_ease_df_linear,
		_ease_df_linear,
		_ease_df_linear,
	],

	# TRANS_SINE
	[
		_ease_df_sinusoidal_in,
		_ease_df_sinusoidal_out,
		_ease_df_sinusoidal_inout,
		_ease_df_sinusoidal_outin,
	],

	# TRANS_QUINT
	[
		_ease_df_quintic_in,
		_ease_df_quintic_out,
		_ease_df_quintic_inout,
		_ease_df_quintic_outin,
	],

	# TRANS_QUART
	[
		_ease_df_quartic_in,
		_ease_df_quartic_out,
		_ease_df_quartic_inout,
		_ease_df_quartic_outin,
	],

	# TRANS_QUAD
	[
		_ease_df_quadratic_in,
		_ease_df_quadratic_out,
		_ease_df_quadratic_inout,
		_ease_df_quadratic_outin,
	],

	# TRANS_EXPO
	[
		_ease_df_exponential_in,
		_ease_df_exponential_out,
		_ease_df_exponential_inout,
		_ease_df_exponential_outin,
	],

	# TRANS_ELASTIC
	[
		_ease_df_elastic_in,
		_ease_df_elastic_out,
		_ease_df_elastic_inout,
		_ease_df_elastic_outin,
	],

	# TRANS_CUBIC
	[
		_ease_df_cubic_in,
		_ease_df_cubic_out,
		_ease_df_cubic_inout,
		_ease_df_cubic_outin,
	],

	# TRANS_CIRC
	[
		_ease_df_circular_in,
		_ease_df_circular_out,
		_ease_df_circular_inout,
		_ease_df_circular_outin,
	],

	# TRANS_BOUNCE
	[
		_ease_df_bounce_in,
		_ease_df_bounce_out,
		_ease_df_bounce_inout,
		_ease_df_bounce_outin,
	],

	# TRANS_BACK
	[
		_ease_df_back_in,
		_ease_df_back_out,
		_ease_df_back_inout,
		_ease_df_back_outin,
	],

	# TRANS_SPRING
	[
		_ease_df_spring_in,
		_ease_df_spring_out,
		_ease_df_spring_inout,
		_ease_df_spring_outin,
	],
]

static func _ease_f_linear(x: float) -> float:
	return x

@warning_ignore("unused_parameter")
static func _ease_df_linear(x: float) -> float:
	return 1.0

static func _ease_f_sinusoidal_in(x: float) -> float:
	return 1.0 - cos(_HALF_PI * x)

static func _ease_df_sinusoidal_in(x: float) -> float:
	return _HALF_PI * sin(_HALF_PI * x)

static func _ease_f_sinusoidal_out(x: float) -> float:
	return sin(_HALF_PI * x)

static func _ease_df_sinusoidal_out(x: float) -> float:
	return _HALF_PI * cos(_HALF_PI * x)

static func _ease_f_sinusoidal_inout(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_sinusoidal_in(x) \
		if x < 1.0 else \
		0.5 * _ease_f_sinusoidal_out(x - 1.0) + 0.5

static func _ease_df_sinusoidal_inout(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_sinusoidal_in(x) \
		if x < 1.0 else \
		_ease_df_sinusoidal_out(x - 1.0)

static func _ease_f_sinusoidal_outin(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_sinusoidal_out(x) \
		if x < 1.0 else \
		0.5 * _ease_f_sinusoidal_in(x - 1.0) + 0.5

static func _ease_df_sinusoidal_outin(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_sinusoidal_out(x) \
		if x < 1.0 else \
		_ease_df_sinusoidal_in(x - 1.0)

static func _ease_f_quintic_in(x: float) -> float:
	return x * x * x * x * x

static func _ease_df_quintic_in(x: float) -> float:
	return 5.0 * x * x * x * x

static func _ease_f_quintic_out(x: float) -> float:
	x = 1.0 - x
	return 1.0 - x * x * x * x * x

static func _ease_df_quintic_out(x: float) -> float:
	x -= 1.0
	return 5.0 * x * x * x * x

static func _ease_f_quintic_inout(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_quintic_in(x) \
		if x < 1.0 else \
		0.5 * _ease_f_quintic_out(x - 1.0) + 0.5

static func _ease_df_quintic_inout(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_quintic_in(x) \
		if x < 1.0 else \
		_ease_df_quintic_out(x - 1.0)

static func _ease_f_quintic_outin(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_quintic_out(x) \
		if x < 1.0 else \
		0.5 * _ease_f_quintic_in(x - 1.0) + 0.5

static func _ease_df_quintic_outin(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_quintic_out(x) \
		if x < 1.0 else \
		_ease_df_quintic_in(x - 1.0)

static func _ease_f_quartic_in(x: float) -> float:
	return x * x * x * x

static func _ease_df_quartic_in(x: float) -> float:
	return 4.0 * x * x * x

static func _ease_f_quartic_out(x: float) -> float:
	x = 1.0 - x
	return 1.0 - x * x * x * x

static func _ease_df_quartic_out(x: float) -> float:
	x = 1.0 - x
	return 4.0 * x * x * x

static func _ease_f_quartic_inout(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_quartic_in(x) \
		if x < 1.0 else \
		0.5 * _ease_f_quartic_out(x - 1.0) + 0.5

static func _ease_df_quartic_inout(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_quartic_in(x) \
		if x < 1.0 else \
		_ease_df_quartic_out(x - 1.0)

static func _ease_f_quartic_outin(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_quartic_out(x) \
		if x < 1.0 else \
		0.5 * _ease_f_quartic_in(x - 1.0) + 0.5

static func _ease_df_quartic_outin(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_quartic_out(x) \
		if x < 1.0 else \
		_ease_df_quartic_in(x - 1.0)

static func _ease_f_quadratic_in(x: float) -> float:
	return x * x

static func _ease_df_quadratic_in(x: float) -> float:
	return 2.0 * x

static func _ease_f_quadratic_out(x: float) -> float:
	return (2.0 - x) * x

static func _ease_df_quadratic_out(x: float) -> float:
	return 2.0 - 2.0 * x

static func _ease_f_quadratic_inout(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_quadratic_in(x) \
		if x < 1.0 else \
		0.5 * _ease_f_quadratic_out(x - 1) + 0.5

static func _ease_df_quadratic_inout(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_quadratic_in(x) \
		if x < 1.0 else \
		_ease_df_quadratic_out(x - 1)

static func _ease_f_quadratic_outin(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_quadratic_out(x) \
		if x < 1.0 else \
		0.5 * _ease_f_quadratic_in(x - 1) + 0.5

static func _ease_df_quadratic_outin(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_quadratic_out(x) \
		if x < 1.0 else \
		_ease_df_quadratic_in(x - 1)

static func _ease_f_exponential_in(x: float) -> float:
	return 0.0 if x == 0.0 else 2.0 ** (10.0 * x - 10.0)

static func _ease_df_exponential_in(x: float) -> float:
	return 0.0 if x == 0.0 else 5.0 * _LN2 * 2.0 ** (10.0 * x - 9.0)

static func _ease_f_exponential_out(x: float) -> float:
	return 1.0 if x == 1.0 else 1.0 - 2.0 ** (-10.0 * x)

static func _ease_df_exponential_out(x: float) -> float:
	return 0.0 if x == 1.0 else 5.0 * _LN2 * 2.0 ** (1.0 - 10.0 * x)

static func _ease_f_exponential_inout(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_exponential_in(x) \
		if x < 1.0 else \
		0.5 * _ease_f_exponential_out(x - 1.0) + 0.5

static func _ease_df_exponential_inout(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_exponential_in(x) \
		if x < 1.0 else \
		_ease_df_exponential_out(x - 1.0)

static func _ease_f_exponential_outin(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_exponential_out(x) \
		if x < 1.0 else \
		0.5 * _ease_f_exponential_in(x - 1.0) + 0.5

static func _ease_df_exponential_outin(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_exponential_out(x) \
		if x < 1.0 else \
		_ease_df_exponential_in(x - 1.0)

static func _ease_f_elastic_in(x: float) -> float:
	if x == 0.0:
		return 0.0
	const C4 := TAU / 3.0
	return 2.0 ** (10.0 * x - 10.0) * sin((10.75 - 10.0 * x) * C4)

static func _ease_df_elastic_in(x: float) -> float:
	if x == 0.0:
		return 0.0
	if x == 1.0:
		return 10.0 * _LN2
	var t := TAU * (40.0 * x - 43.0) / 12.0
	return (5.0 * 2.0 ** (10.0 * x - 9.0) * (3.0 * _LN2 * sin(t) + TAU * cos(t))) / -3.0

static func _ease_f_elastic_out(x: float) -> float:
	if x == 0.0 or x == 1.0:
		return x
	const C4 := TAU / 3.0
	return 2.0 ** (-10.0 * x) * sin((10.0 * x - 0.75) * C4) + 1.0

static func _ease_df_elastic_out(x: float) -> float:
	if x == 0.0:
		return 10.0 * _LN2
	if x == 1.0:
		return 0.0
	var t := 10.0 * TAU * x / 3.0
	var s := 10.0 * TAU * sin(t)
	var c := 30.0 * _LN2 * cos(t)
	return (s + c) / (3.0 * 2.0 ** (10.0 * x))

static func _ease_f_elastic_inout(x: float) -> float:
	if x == 0.0 or x == 1.0:
		return x
	const C5 = TAU / 4.5
	x *= 2.0
	return \
		-0.5 * (2.0 ** (10.0 * x - 10.0) * sin((10.0 * x - 11.125) * C5)) \
		if x < 1.0 else \
		0.5 * (2.0 ** (-10.0 * x + 10.0) * sin((10.0 * x - 11.125) * C5)) + 1.0

static func _ease_df_elastic_inout(x: float) -> float:
	if x == 0.0 or x == 1.0:
		return 10.0 * _LN2
	x *= 2.0
	var t := TAU * (80.0 * x - 89.0) / 36.0
	var s := 45.0 * _LN2 * sin(t)
	var c := 10.0 * TAU * cos(t)
	return \
		(2.0 ** (10.0 * x - 9.0) * (s + c)) / -9.0 \
		if x < 1.0 else \
		2048.0 * (s - c) / -(9.0 * 2.0 ** (10.0 * x))

static func _ease_f_elastic_outin(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_elastic_out(x) \
		if x < 1.0 else \
		0.5 * _ease_f_elastic_in(x - 1.0) + 0.5

static func _ease_df_elastic_outin(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_elastic_out(x) \
		if x < 1.0 else \
		_ease_df_elastic_in(x - 1.0)

static func _ease_f_cubic_in(x: float) -> float:
	return x * x * x

static func _ease_df_cubic_in(x: float) -> float:
	return 3.0 * x * x

static func _ease_f_cubic_out(x: float) -> float:
	x = 1.0 - x
	return 1.0 - x * x * x

static func _ease_df_cubic_out(x: float) -> float:
	x -= 1.0
	return 3.0 * x * x

static func _ease_f_cubic_inout(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_cubic_in(x) \
		if x < 1.0 else \
		0.5 * _ease_f_cubic_out(x - 1.0) + 0.5

static func _ease_df_cubic_inout(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_cubic_in(x) \
		if x < 1.0 else \
		_ease_df_cubic_out(x - 1.0)

static func _ease_f_cubic_outin(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_cubic_out(x) \
		if x < 1.0 else \
		0.5 * _ease_f_cubic_in(x - 1.0) + 0.5

static func _ease_df_cubic_outin(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_cubic_out(x) \
		if x < 1.0 else \
		_ease_df_cubic_in(x - 1.0)

static func _ease_f_circular_in(x: float) -> float:
	return 1.0 - sqrt(1.0 - x * x)

static func _ease_df_circular_in(x: float) -> float:
	return x / sqrt(1.0 - x * x)

static func _ease_f_circular_out(x: float) -> float:
	return sqrt((2.0 - x) * x)

static func _ease_df_circular_out(x: float) -> float:
	x -= 1.0
	return -x / sqrt(1.0 - x * x)

static func _ease_f_circular_inout(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_circular_in(x) \
		if x < 1.0 else \
		0.5 * _ease_f_circular_out(x - 1.0) + 0.5

static func _ease_df_circular_inout(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_circular_in(x) \
		if x < 1.0 else \
		_ease_df_circular_out(x - 1.0)

static func _ease_f_circular_outin(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_circular_out(x) \
		if x < 1.0 else \
		0.5 * _ease_f_circular_in(x - 1.0) + 0.5

static func _ease_df_circular_outin(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_circular_out(x) \
		if x < 1.0 else \
		_ease_df_circular_in(x - 1.0)

static func _ease_f_bounce_in(x: float) -> float:
	return 1.0 - _ease_f_bounce_out(1.0 - x)

static func _ease_df_bounce_in(x: float) -> float:
	return _ease_df_bounce_out(1.0 - x)

static func _ease_f_bounce_out(x: float) -> float:
	if x < 1.0 / 2.75:
		return 7.5625 * x * x
	if x < 2.0 / 2.75:
		x -= 1.5 / 2.75
		return 7.5625 * x * x + 0.75
	if x < 2.5 / 2.75:
		x -= 2.25 / 2.75
		return 7.5625 * x * x + 0.9375
	x -= 2.625 / 2.75
	return 7.5625 * x * x + 0.984375

static func _ease_df_bounce_out(x: float) -> float:
	if x < 1.0 / 2.75:
		return 121.0 * x / 8.0
	if x < 2.0 / 2.75:
		return (121.0 * x - 66.0) / 8.0
	if x < 2.5 / 2.75:
		return (121.0 * x - 99.0) / 8.0
	return (242.0 * x - 231.0) / 16.0

static func _ease_f_bounce_inout(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_bounce_in(x) \
		if x < 1.0 else \
		0.5 * _ease_f_bounce_out(x - 1.0) + 0.5

static func _ease_df_bounce_inout(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_bounce_in(x) \
		if x < 1.0 else \
		_ease_df_bounce_out(x - 1.0)

static func _ease_f_bounce_outin(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_bounce_out(x) \
		if x < 1.0 else \
		0.5 * _ease_f_bounce_in(x - 1.0) + 0.5

static func _ease_df_bounce_outin(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_bounce_out(x) \
		if x < 1.0 else \
		_ease_df_bounce_in(x - 1.0)

static func _ease_f_back_in(x: float) -> float:
	const C1 := 1.70158
	const C3 := C1 + 1.0
	return C3 * x * x * x - C1 * x * x

static func _ease_df_back_in(x: float) -> float:
	const C1 := 1.70158
	const C3 := C1 + 1.0
	return x * (3.0 * C3 * x - 2.0 * C1)

static func _ease_f_back_out(x: float) -> float:
	const C1 := 1.70158
	const C3 := C1 + 1.0
	x -= 1.0
	return 1.0 + C3 * x * x * x + C1 * x * x

static func _ease_df_back_out(x: float) -> float:
	const C1 := 1.70158
	const C3 := C1 + 1.0
	x -= 1.0
	return x * (3.0 * C3 * x + 2.0 * C1)

static func _ease_f_back_inout(x: float) -> float:
	const C1 = 1.70158;
	const C2 = C1 * 1.525;
	x *= 2.0
	return \
		0.5 * x * x * (C2 * x - C2 + x) \
		if x < 1.0 else \
		0.5 * (x - 2.0) ** 2.0 * (C2 * (x - 1.0) + x - 2.0) + 1.0

static func _ease_df_back_inout(x: float) -> float:
	const C1 = 1.70158;
	const C2 = C1 * 1.525;
	return \
		4.0 * x * (3.0 * (C2 + 1.0) * x - C2) \
		if x < 0.5 else \
		4.0 * (x - 1.0) * (3.0 * (C2 + 1.0) * x - 2.0 * C2 - 3.0)

static func _ease_f_back_outin(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_back_out(x) \
		if x < 1.0 else \
		0.5 * _ease_f_back_in(x - 1.0) + 0.5

static func _ease_df_back_outin(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_back_out(x) \
		if x < 1.0 else \
		_ease_df_back_in(x - 1.0)

static func _ease_f_spring_in(x: float) -> float:
	return 1.0 - _ease_f_spring_out(1.0 - x)

static func _ease_df_spring_in(x: float) -> float:
	return _ease_df_spring_out(1.0 - x)

static func _ease_f_spring_out(x: float) -> float:
	# //github.com/godotengine/godot/blob/2cc031f3a3f5086e8cfedd4dc769e02714abe358/scene/animation/easing_equations.h#L418
	var s := 1.0 - x
	return (sin(PI * x * (0.2 + 2.5 * x * x * x)) * s ** 2.2 + x) * (s * 1.2 + 1.0)

static func _ease_df_spring_out(x: float) -> float:
	var a := 1.0 - x
	var b := a ** 1.2
	var c := a ** 2.2
	var d := 25.0 * x ** 3.0
	var e := 6.0 * x - 11.0
	var t := PI * x * (d + 2.0) / 10.0
	return (sin(t) * (11.0 * b * e - 30.0 * c) - cos(t) * PI * c * e * (2.0 * d + 1.0) - 60.0 * x + 55.0) / 25.0

static func _ease_f_spring_inout(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_spring_in(x) \
		if x < 1.0 else \
		0.5 * _ease_f_spring_out(x - 1.0) + 0.5

static func _ease_df_spring_inout(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_spring_in(x) \
		if x < 1.0 else \
		_ease_df_spring_out(x - 1.0)

static func _ease_f_spring_outin(x: float) -> float:
	x *= 2.0
	return \
		0.5 * _ease_f_spring_out(x) \
		if x < 1.0 else \
		0.5 * _ease_f_spring_in(x - 1.0) + 0.5

static func _ease_df_spring_outin(x: float) -> float:
	x *= 2.0
	return \
		_ease_df_spring_out(x) \
		if x < 1.0 else \
		_ease_df_spring_in(x - 1.0)

#endregion
