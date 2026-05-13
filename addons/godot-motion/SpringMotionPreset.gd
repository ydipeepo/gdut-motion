@tool
class_name SpringMotionPreset extends MotionPreset

#-------------------------------------------------------------------------------
#	CONSTANTS
#-------------------------------------------------------------------------------

const MIN_STIFFNESS := _SPRING_CLASS.MIN_STIFFNESS
const MAX_STIFFNESS := 1000.0
const STIFFNESS_STEP := 1e-1
const DEFAULT_STIFFNESS := _SPRING_CLASS.DEFAULT_STIFFNESS

const MIN_DAMPING := _SPRING_CLASS.MIN_DAMPING
const MAX_DAMPING := 100.0
const DAMPING_STEP := 1e-2
const DEFAULT_DAMPING := _SPRING_CLASS.DEFAULT_DAMPING

const MIN_MASS := _SPRING_CLASS.MIN_MASS
const MAX_MASS := 10.0
const MASS_STEP := 1e-3
const DEFAULT_MASS := _SPRING_CLASS.DEFAULT_MASS

const MIN_REST_ENERGY := _SPRING_CLASS.MIN_REST_ENERGY
const MAX_REST_ENERGY := 1.0
const REST_ENERGY_STEP := 1e-4
const DEFAULT_REST_ENERGY := _SPRING_CLASS.DEFAULT_REST_ENERGY

const DEFAULT_LIMIT_OVERDAMPING := _SPRING_CLASS.DEFAULT_LIMIT_OVERDAMPING

const DEFAULT_LIMIT_OVERSHOOTING := _SPRING_CLASS.DEFAULT_LIMIT_OVERSHOOTING

#-------------------------------------------------------------------------------
#	PROPERTIES
#-------------------------------------------------------------------------------

@export_range(
	MIN_STIFFNESS,
	MAX_STIFFNESS,
	STIFFNESS_STEP,
	"or_greater",
	"suffix:N/m")
var stiffness := DEFAULT_STIFFNESS:
	set = set_stiffness,
	get = get_stiffness

@export_range(
	MIN_DAMPING,
	MAX_DAMPING,
	DAMPING_STEP,
	"or_greater",
	"suffix:N·s/m")
var damping := DEFAULT_DAMPING:
	set = set_damping,
	get = get_damping

@export_range(
	MIN_MASS,
	MAX_MASS,
	MASS_STEP,
	"or_greater",
	"suffix:kg")
var mass := DEFAULT_MASS:
	set = set_mass,
	get = get_mass

@export_range(
	MIN_REST_ENERGY,
	MAX_REST_ENERGY,
	REST_ENERGY_STEP,
	"or_greater",
	"suffix:J")
var rest_energy := DEFAULT_REST_ENERGY:
	set = set_rest_energy,
	get = get_rest_energy

@export
var limit_overdamping := DEFAULT_LIMIT_OVERDAMPING:
	set = set_limit_overdamping,
	get = get_limit_overdamping

@export
var limit_overshooting := DEFAULT_LIMIT_OVERSHOOTING:
	set = set_limit_overshooting,
	get = get_limit_overshooting

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func get_target_class_ids() -> Array[int]:
	var target_class: Script = _SPRING_CLASS
	return [target_class.get_instance_id()]

func set_stiffness(value: float) -> void:
	if _stiffness != value:
		_stiffness = value
		emit_changed()

func get_stiffness() -> float:
	return _stiffness

func set_damping(value: float) -> void:
	if _damping != value:
		_damping = value
		emit_changed()

func get_damping() -> float:
	return _damping

func set_mass(value: float) -> void:
	if _mass != value:
		_mass = value
		emit_changed()

func get_mass() -> float:
	return _mass

func set_rest_energy(value: float) -> void:
	if _rest_energy != value:
		_rest_energy = value
		emit_changed()

func get_rest_energy() -> float:
	return _rest_energy

func set_limit_overdamping(value: bool) -> void:
	if _limit_overdamping != value:
		_limit_overdamping = value
		emit_changed()

func get_limit_overdamping() -> bool:
	return _limit_overdamping

func set_limit_overshooting(value: bool) -> void:
	if _limit_overshooting != value:
		_limit_overshooting = value
		emit_changed()

func get_limit_overshooting() -> bool:
	return _limit_overshooting

func apply(transition_factory: MotionTransitionFactory) -> bool:
	var target := transition_factory as _SPRING_CLASS
	if target != null:
		target.set_process(get_process())
		target.set_stiffness(_stiffness)
		target.set_damping(_damping)
		target.set_mass(_mass)
		target.set_rest_energy(_rest_energy)
		target.set_limit_overdamping(_limit_overdamping)
		target.set_limit_overshooting(_limit_overshooting)
		return true
	return false

#-------------------------------------------------------------------------------

const _SPRING_CLASS := preload("uid://cu530wnsnvp3d")

var _stiffness := DEFAULT_STIFFNESS
var _damping := DEFAULT_DAMPING
var _mass := DEFAULT_MASS
var _rest_energy := DEFAULT_REST_ENERGY
var _limit_overdamping := DEFAULT_LIMIT_OVERDAMPING
var _limit_overshooting := DEFAULT_LIMIT_OVERSHOOTING
