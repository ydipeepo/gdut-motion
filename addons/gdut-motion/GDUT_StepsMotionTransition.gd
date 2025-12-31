class_name GDUT_StepsMotionTransition extends GDUT_PerceivedMotionTransition

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const ROUND_CEIL := 0
const ROUND_FLOOR := 1

const VALID_ROUND: Array[int] = [
	ROUND_CEIL,
	ROUND_FLOOR,
]

const MIN_SEGMENTS := 1
const DEFAULT_SEGMENTS := 5

const DEFAULT_ROUND := ROUND_CEIL

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_value(x: float) -> float:
	return _round.call(x * _segments) * _inv_segments

@warning_ignore("unused_parameter")
func get_prime(x: float) -> float:
	return 0.0

#-------------------------------------------------------------------------------

var _segments: float
var _inv_segments: float
var _round: Callable

@warning_ignore("shadowed_global_identifier")
func _init(
	segments: int,
	round: int,
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

	assert(MIN_SEGMENTS <= segments)
	assert(round in VALID_ROUND)

	_segments = segments
	_inv_segments = 1.0 / segments
	_round = ceilf if round == ROUND_CEIL else floorf
