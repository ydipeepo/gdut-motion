#
# Within the Engine class, there exists a user time scale separate from
# the game time scale (this is set by the SceneDebugger).
# As of version 4.6.2, there is no way to retrieve this value.
#
# Here, we attempt to estimate and adjust the user time scale so that
# behavior is somewhat consistent during debugging.
# This implementation has accuracy issues, and once it becomes possible to
# retrieve the user time scale in the future, the following code will be removed.
#

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

func estimate(delta: float) -> float:
	if _detection_enabled:
		if 0 < _detection_initial_skip_count:
			_detection_initial_skip_count -= 1
		else:
			_user_time_scale_accumulated_delta += delta
			_user_time_scale_counter += 1
			if _user_time_scale_counter == _detection_sample_count:
				var ticks := Time.get_ticks_msec()
				var sample_delta := (ticks - _user_time_scale_start_ticks) / 1000.0
				var game_time_scale := Engine.time_scale
				var user_time_scale := _user_time_scale_accumulated_delta / (sample_delta * game_time_scale)
				_user_time_scale = _adjust_user_time_scale(user_time_scale)
				_user_time_scale_accumulated_delta = 0.0
				_user_time_scale_start_ticks = ticks
				_user_time_scale_counter = 0
	return _user_time_scale

#-------------------------------------------------------------------------------

const _VALID_USER_TIME_SCALE_ARRAY: Array[float] = [
	0.0625,
	0.125,
	0.25,
	0.5,
	0.75,
	1.0,
	1.25,
	1.5,
	1.75,
	2.0,
	4.0,
	8.0,
	16.0,
]

var _detection_enabled: bool = ProjectSettings.get_setting("godot_motion/debug/user_time_scale_detection_enabled", true)
var _detection_sample_count: int = ProjectSettings.get_setting("godot_motion/debug/user_time_scale_detection_sample_count", 15)
var _detection_initial_skip_count: int = ProjectSettings.get_setting("godot_motion/debug/user_time_scale_detection_initial_skip_count", 30)

var _user_time_scale := 1.0
var _user_time_scale_start_ticks := Time.get_ticks_msec()
var _user_time_scale_accumulated_delta := 0.0
var _user_time_scale_counter := 0

static func _adjust_user_time_scale(user_time_scale: float) -> float:
	var n := _VALID_USER_TIME_SCALE_ARRAY.size() - 1
	var s := 0
	var e := n
	while s <= e:
		var m := s + (e - s) / 2
		if _VALID_USER_TIME_SCALE_ARRAY[m] == user_time_scale:
			return _VALID_USER_TIME_SCALE_ARRAY[m]
		if _VALID_USER_TIME_SCALE_ARRAY[m] < user_time_scale:
			s = m + 1
		else:
			e = m - 1
	if s >= n:
		return _VALID_USER_TIME_SCALE_ARRAY.back()
	if e < 0:
		return _VALID_USER_TIME_SCALE_ARRAY.front()
	return \
		_VALID_USER_TIME_SCALE_ARRAY[s] \
		if \
			absf(_VALID_USER_TIME_SCALE_ARRAY[s] - user_time_scale) < \
			absf(_VALID_USER_TIME_SCALE_ARRAY[e] - user_time_scale) else \
		_VALID_USER_TIME_SCALE_ARRAY[e]
