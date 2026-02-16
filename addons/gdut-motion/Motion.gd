<<<<<<< Updated upstream
=======
## This class that defines methods for starting motions.
##
## All motions are started through this class.
## You can animate properties and method calls.
## [codeblock]
## Motion \
##     .tween(self, "position:x") \
##     .ease_in() \
##     .tween_quad() \
##     .to(512.0)
## [/codeblock]
>>>>>>> Stashed changes
class_name Motion

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

<<<<<<< Updated upstream
static func create_method_name_proxy(
	target: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL) -> MotionProxy:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var proxy := GDUT_MethodNameMotionProxy.create(
		target,
		target_method_name,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_METHOD_NAME_TARGET",
			target_method_name,
			target)
		return null

	return canonical.merge_proxy(proxy)

static func create_method_proxy(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL) -> MotionProxy:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var proxy := GDUT_MethodMotionProxy.create(
		target_method,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_METHOD_TARGET",
			target_method)
		return null

	return canonical.merge_proxy(proxy)

static func create_property_proxy(
	target: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL) -> MotionProxy:
=======
## Starts a Tween motion for a property.
static func tween_property(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL) -> TweenMotionExpression:
>>>>>>> Stashed changes

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var proxy := GDUT_PropertyMotionProxy.create(
		target,
		target_property_path,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_PROPERTY_TARGET",
			target_property_path,
			target)
		return null

	return canonical.merge_proxy(proxy)

#region tween

static func tween_method_name(
	target: Object,
=======
	var target := GDUT_MotionTarget.from_property(
		target_object,
		target_property_path,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_PROPERTY_TARGET", target_property_path, target_object)
		return null

	var transition_factory := GDUT_TweenMotionTransitionFactory.new(target)
	return TweenMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

## Starts a Tween motion for a method call.
static func tween_method_name(
	target_object: Object,
>>>>>>> Stashed changes
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL) -> TweenMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var proxy := GDUT_MethodNameMotionProxy.create(
		target,
		target_method_name,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_METHOD_NAME_TARGET",
			target_method_name,
			target)
		return null

	var transition_factory := GDUT_TweenMotionTransitionFactory.new(proxy)
=======
	var target := GDUT_MotionTarget.from_method_name(
		target_object,
		target_method_name,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_METHOD_NAME_TARGET", target_method_name, target_object)
		return null

	var transition_factory := GDUT_TweenMotionTransitionFactory.new(target)
>>>>>>> Stashed changes
	return TweenMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

<<<<<<< Updated upstream
=======
## Starts a Tween motion for a [Callable] call.
>>>>>>> Stashed changes
static func tween_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL) -> TweenMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var proxy := GDUT_MethodMotionProxy.create(
		target_method,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_METHOD_TARGET",
			target_method)
		return null

	var transition_factory := GDUT_TweenMotionTransitionFactory.new(proxy)
=======
	var target := GDUT_MotionTarget.from_method(
		target_method,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_METHOD_TARGET", target_method)
		return null

	var transition_factory := GDUT_TweenMotionTransitionFactory.new(target)
>>>>>>> Stashed changes
	return TweenMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

<<<<<<< Updated upstream
static func tween_property(
	target: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL) -> TweenMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var proxy := GDUT_PropertyMotionProxy.create(
		target,
		target_property_path,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_PROPERTY_TARGET",
			target_property_path,
			target)
		return null

	var transition_factory := GDUT_TweenMotionTransitionFactory.new(proxy)
	return TweenMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func tween_proxy(proxy: MotionProxy) -> TweenMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	if proxy == null or not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_PROXY_TARGET",
			proxy.get_name())
		return null

	var transition_factory := GDUT_TweenMotionTransitionFactory.new(proxy)
	return TweenMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func tween(...init: Array) -> TweenMotionExpression:
	match init.size():
		2, 3 when GDUT_Motion.validate_method_name_init(init):
			return tween_method_name(
				GDUT_Motion.get_method_name_init_target(init),
				GDUT_Motion.get_method_name_init_target_method_name(init),
				GDUT_Motion.get_method_name_init_target_value_type_hint(init))
		1, 2 when GDUT_Motion.validate_method_init(init):
			return tween_method(
				GDUT_Motion.get_method_init_target_method(init),
				GDUT_Motion.get_method_init_target_value_type_hint(init))
		2, 3 when GDUT_Motion.validate_property_init(init):
			return tween_property(
				GDUT_Motion.get_property_init_target(init),
				GDUT_Motion.get_property_init_target_property_path(init),
				GDUT_Motion.get_property_init_target_value_type_hint(init))
		1 when GDUT_Motion.validate_proxy_init(init):
			return tween_proxy(
				GDUT_Motion.get_proxy_init_proxy(init))
=======
## Starts a Tween motion.[br]
## [br]
## It is another interface of [method tween], not a vararg [param init].
static func tween_v(init: Array) -> TweenMotionExpression:
	match init.size():
		2, \
		3 when _can_parse_method_name_init(init):
			return tween_method_name(
				_parse_method_name_init_target(init),
				_parse_method_name_init_target_method_name(init),
				_parse_method_name_init_target_value_type_hint(init))
		2, \
		3 when _can_parse_property_init(init):
			return tween_property(
				_parse_property_init_target(init),
				_parse_property_init_target_property_path(init),
				_parse_property_init_target_value_type_hint(init))
		1, \
		2 when _can_parse_method_init(init):
			return tween_method(
				_parse_method_init_target_method(init),
				_parse_method_init_target_value_type_hint(init))
>>>>>>> Stashed changes

	GDUT_Motion.print_error(&"BAD_INIT", init)
	return null

<<<<<<< Updated upstream
#endregion

#region bezier

static func bezier_method_name(
	target: Object,
=======
## Starts a Tween motion.[br]
## [br]
## Starts an animation for the target defined in [param init].
## The following inputs are supported:
## [codeblock]
## # Method name + Type hint
## Motion.tween(self, "set_position", TYPE_VECTOR2)
## # Method name
## Motion.tween(self, "set_position")
## # Callable + Type hint
## Motion.tween(self.set_position, TYPE_VECTOR2)
## # Callable
## Motion.tween(self.set_position)
## # Property name + Type hint
## Motion.tween(self, "position", TYPE_VECTOR2)
## # Property name
## Motion.tween(self, "position")
## [/codeblock]
## [b]Note:[/b] If there is no type annotation,
## or if it has a [Variant] annotation, you must specify a type hint.
## Type annotations take precedence, but the type hint will be used
## if the target type cannot be determined.
static func tween(...init: Array) -> TweenMotionExpression:
	return tween_v(init)

## Starts a Bezier motion for a property.
static func bezier_property(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL) -> BezierMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var target := GDUT_MotionTarget.from_property(
		target_object,
		target_property_path,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_PROPERTY_TARGET", target_property_path, target_object)
		return null

	var transition_factory := GDUT_BezierMotionTransitionFactory.new(target)
	return BezierMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

## Starts a Bezier motion for a method call.
static func bezier_method_name(
	target_object: Object,
>>>>>>> Stashed changes
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL) -> BezierMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var proxy := GDUT_MethodNameMotionProxy.create(
		target,
		target_method_name,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_METHOD_NAME_TARGET",
			target_method_name,
			target)
		return null

	var transition_factory := GDUT_BezierMotionTransitionFactory.new(proxy)
=======
	var target := GDUT_MotionTarget.from_method_name(
		target_object,
		target_method_name,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_METHOD_NAME_TARGET", target_method_name, target_object)
		return null

	var transition_factory := GDUT_BezierMotionTransitionFactory.new(target)
>>>>>>> Stashed changes
	return BezierMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

<<<<<<< Updated upstream
=======
## Starts a Bezier motion for a [Callable] invocation.
>>>>>>> Stashed changes
static func bezier_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL) -> BezierMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var proxy := GDUT_MethodMotionProxy.create(
		target_method,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_METHOD_TARGET",
			target_method)
		return null

	var transition_factory := GDUT_BezierMotionTransitionFactory.new(proxy)
=======
	var target := GDUT_MotionTarget.from_method(
		target_method,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_METHOD_TARGET", target_method)
		return null

	var transition_factory := GDUT_BezierMotionTransitionFactory.new(target)
>>>>>>> Stashed changes
	return BezierMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

<<<<<<< Updated upstream
static func bezier_property(
	target: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL) -> BezierMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var proxy := GDUT_PropertyMotionProxy.create(
		target,
		target_property_path,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_PROPERTY_TARGET",
			target_property_path,
			target)
		return null

	var transition_factory := GDUT_BezierMotionTransitionFactory.new(proxy)
	return BezierMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func bezier_proxy(proxy: MotionProxy) -> BezierMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	if proxy == null or not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_PROXY_TARGET",
			proxy.get_name())
		return null

	var transition_factory := GDUT_BezierMotionTransitionFactory.new(proxy)
	return BezierMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func bezier(...init: Array) -> BezierMotionExpression:
	match init.size():
		2, 3 when GDUT_Motion.validate_method_name_init(init):
			return bezier_method_name(
				GDUT_Motion.get_method_name_init_target(init),
				GDUT_Motion.get_method_name_init_target_method_name(init),
				GDUT_Motion.get_method_name_init_target_value_type_hint(init))
		1, 2 when GDUT_Motion.validate_method_init(init):
			return bezier_method(
				GDUT_Motion.get_method_init_target_method(init),
				GDUT_Motion.get_method_init_target_value_type_hint(init))
		2, 3 when GDUT_Motion.validate_property_init(init):
			return bezier_property(
				GDUT_Motion.get_property_init_target(init),
				GDUT_Motion.get_property_init_target_property_path(init),
				GDUT_Motion.get_property_init_target_value_type_hint(init))
		1 when GDUT_Motion.validate_proxy_init(init):
			return bezier_proxy(
				GDUT_Motion.get_proxy_init_proxy(init))
=======
## Starts a Bezier motion.[br]
## [br]
## It is another interface of [method bezier], not a vararg [param init].
static func bezier_v(init: Array) -> BezierMotionExpression:
	match init.size():
		2, \
		3 when _can_parse_method_name_init(init):
			return bezier_method_name(
				_parse_method_name_init_target(init),
				_parse_method_name_init_target_method_name(init),
				_parse_method_name_init_target_value_type_hint(init))
		2, \
		3 when _can_parse_property_init(init):
			return bezier_property(
				_parse_property_init_target(init),
				_parse_property_init_target_property_path(init),
				_parse_property_init_target_value_type_hint(init))
		1, \
		2 when _can_parse_method_init(init):
			return bezier_method(
				_parse_method_init_target_method(init),
				_parse_method_init_target_value_type_hint(init))
>>>>>>> Stashed changes

	GDUT_Motion.print_error(&"BAD_INIT", init)
	return null

<<<<<<< Updated upstream
#endregion

#region linear

static func linear_method_name(
	target: Object,
=======
## Starts a Bezier motion.[br]
## [br]
## Starts an animation for the target defined in [param init].
## The following inputs are supported:
## [codeblock]
## # Method name + Type hint
## Motion.bezier(self, "set_position", TYPE_VECTOR2)
## # Method name
## Motion.bezier(self, "set_position")
## # Callable + Type hint
## Motion.bezier(self.set_position, TYPE_VECTOR2)
## # Callable
## Motion.bezier(self.set_position)
## # Property name + Type hint
## Motion.bezier(self, "position", TYPE_VECTOR2)
## # Property name
## Motion.bezier(self, "position")
## [/codeblock]
## [b]Note:[/b] If there is no type annotation,
## or if it has a [Variant] annotation, you must specify a type hint.
## Type annotations take precedence, but the type hint will be used
## if the target type cannot be determined.
static func bezier(...init: Array) -> BezierMotionExpression:
	return bezier_v(init)

## Starts a Linear motion for a property.
static func linear_property(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL) -> LinearMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var target := GDUT_MotionTarget.from_property(
		target_object,
		target_property_path,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_PROPERTY_TARGET", target_property_path, target_object)
		return null

	var transition_factory := GDUT_LinearMotionTransitionFactory.new(target)
	return LinearMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

## Starts a Linear motion for a method call.
static func linear_method_name(
	target_object: Object,
>>>>>>> Stashed changes
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL) -> LinearMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var proxy := GDUT_MethodNameMotionProxy.create(
		target,
		target_method_name,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_METHOD_NAME_TARGET",
			target_method_name,
			target)
		return null

	var transition_factory := GDUT_LinearMotionTransitionFactory.new(proxy)
=======
	var target := GDUT_MotionTarget.from_method_name(
		target_object,
		target_method_name,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_METHOD_NAME_TARGET", target_method_name, target_object)
		return null

	var transition_factory := GDUT_LinearMotionTransitionFactory.new(target)
>>>>>>> Stashed changes
	return LinearMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

<<<<<<< Updated upstream
=======
## Starts a Linear motion for a [Callable] call.
>>>>>>> Stashed changes
static func linear_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL) -> LinearMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var proxy := GDUT_MethodMotionProxy.create(
		target_method,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_METHOD_TARGET",
			target_method)
		return null

	var transition_factory := GDUT_LinearMotionTransitionFactory.new(proxy)
=======
	var target := GDUT_MotionTarget.from_method(
		target_method,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_METHOD_TARGET", target_method)
		return null

	var transition_factory := GDUT_LinearMotionTransitionFactory.new(target)
>>>>>>> Stashed changes
	return LinearMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

<<<<<<< Updated upstream
static func linear_property(
	target: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL) -> LinearMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var proxy := GDUT_PropertyMotionProxy.create(
		target,
		target_property_path,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_PROPERTY_TARGET",
			target_property_path,
			target)
		return null

	var transition_factory := GDUT_LinearMotionTransitionFactory.new(proxy)
	return LinearMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func linear_proxy(proxy: MotionProxy) -> LinearMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	if proxy == null or not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_PROXY_TARGET",
			proxy.get_name())
		return null

	var transition_factory := GDUT_LinearMotionTransitionFactory.new(proxy)
	return LinearMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func linear(...init: Array) -> LinearMotionExpression:
	match init.size():
		2, 3 when GDUT_Motion.validate_method_name_init(init):
			return linear_method_name(
				GDUT_Motion.get_method_name_init_target(init),
				GDUT_Motion.get_method_name_init_target_method_name(init),
				GDUT_Motion.get_method_name_init_target_value_type_hint(init))
		1, 2 when GDUT_Motion.validate_method_init(init):
			return linear_method(
				GDUT_Motion.get_method_init_target_method(init),
				GDUT_Motion.get_method_init_target_value_type_hint(init))
		2, 3 when GDUT_Motion.validate_property_init(init):
			return linear_property(
				GDUT_Motion.get_property_init_target(init),
				GDUT_Motion.get_property_init_target_property_path(init),
				GDUT_Motion.get_property_init_target_value_type_hint(init))
		1 when GDUT_Motion.validate_proxy_init(init):
			return linear_proxy(
				GDUT_Motion.get_proxy_init_proxy(init))
=======
## Starts a Linear motion.
static func linear_v(init: Array) -> LinearMotionExpression:
	match init.size():
		2, \
		3 when _can_parse_method_name_init(init):
			return linear_method_name(
				_parse_method_name_init_target(init),
				_parse_method_name_init_target_method_name(init),
				_parse_method_name_init_target_value_type_hint(init))
		2, \
		3 when _can_parse_property_init(init):
			return linear_property(
				_parse_property_init_target(init),
				_parse_property_init_target_property_path(init),
				_parse_property_init_target_value_type_hint(init))
		1, \
		2 when _can_parse_method_init(init):
			return linear_method(
				_parse_method_init_target_method(init),
				_parse_method_init_target_value_type_hint(init))
>>>>>>> Stashed changes

	GDUT_Motion.print_error(&"BAD_INIT", init)
	return null

<<<<<<< Updated upstream
#endregion

#region steps

static func steps_method_name(
	target: Object,
=======
## Starts a Linear motion.[br]
## [br]
## Starts an animation for the target defined in [param init].
## The following inputs are supported:
## [codeblock]
## # Method name + type hint
## Motion.linear(self, "set_position", TYPE_VECTOR2)
## # Method name
## Motion.linear(self, "set_position")
## # Callable + type hint
## Motion.linear(self.set_position, TYPE_VECTOR2)
## # Callable
## Motion.linear(self.set_position)
## # Property name + type hint
## Motion.linear(self, "position", TYPE_VECTOR2)
## # Property name
## Motion.linear(self, "position")
## [/codeblock]
## [b]Note:[/b] If there is no type annotation,
## or if it has a [Variant] annotation, you must specify a type hint.
## Type annotations take precedence, but the type hint will be used
## if the target type cannot be determined.
static func linear(...init: Array) -> LinearMotionExpression:
	return linear_v(init)

## Starts a Steps motion for a property.
static func steps_property(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL) -> StepsMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var target := GDUT_MotionTarget.from_property(
		target_object,
		target_property_path,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_PROPERTY_TARGET", target_property_path, target_object)
		return null

	var transition_factory := GDUT_StepsMotionTransitionFactory.new(target)
	return StepsMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

## Starts a Steps motion for a method call.
static func steps_method_name(
	target_object: Object,
>>>>>>> Stashed changes
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL) -> StepsMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var proxy := GDUT_MethodNameMotionProxy.create(
		target,
		target_method_name,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_METHOD_NAME_TARGET",
			target_method_name,
			target)
		return null

	var transition_factory := GDUT_StepsMotionTransitionFactory.new(proxy)
=======
	var target := GDUT_MotionTarget.from_method_name(
		target_object,
		target_method_name,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_METHOD_NAME_TARGET", target_method_name, target_object)
		return null

	var transition_factory := GDUT_StepsMotionTransitionFactory.new(target)
>>>>>>> Stashed changes
	return StepsMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

<<<<<<< Updated upstream
=======
## Starts a Steps motion for a [Callable] call.
>>>>>>> Stashed changes
static func steps_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL) -> StepsMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var proxy := GDUT_MethodMotionProxy.create(
		target_method,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_METHOD_TARGET",
			target_method)
		return null

	var transition_factory := GDUT_StepsMotionTransitionFactory.new(proxy)
=======
	var target := GDUT_MotionTarget.from_method(
		target_method,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_METHOD_TARGET", target_method)
		return null

	var transition_factory := GDUT_StepsMotionTransitionFactory.new(target)
>>>>>>> Stashed changes
	return StepsMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

<<<<<<< Updated upstream
static func steps_property(
	target: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL) -> StepsMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var proxy := GDUT_PropertyMotionProxy.create(
		target,
		target_property_path,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_PROPERTY_TARGET",
			target_property_path,
			target)
		return null

	var transition_factory := GDUT_StepsMotionTransitionFactory.new(proxy)
	return StepsMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func steps_proxy(proxy: MotionProxy) -> StepsMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	if proxy == null or not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_PROXY_TARGET",
			proxy.get_name())
		return null

	var transition_factory := GDUT_StepsMotionTransitionFactory.new(proxy)
	return StepsMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func steps(...init: Array) -> StepsMotionExpression:
	match init.size():
		2, 3 when GDUT_Motion.validate_method_name_init(init):
			return steps_method_name(
				GDUT_Motion.get_method_name_init_target(init),
				GDUT_Motion.get_method_name_init_target_method_name(init),
				GDUT_Motion.get_method_name_init_target_value_type_hint(init))
		1, 2 when GDUT_Motion.validate_method_init(init):
			return steps_method(
				GDUT_Motion.get_method_init_target_method(init),
				GDUT_Motion.get_method_init_target_value_type_hint(init))
		2, 3 when GDUT_Motion.validate_property_init(init):
			return steps_property(
				GDUT_Motion.get_property_init_target(init),
				GDUT_Motion.get_property_init_target_property_path(init),
				GDUT_Motion.get_property_init_target_value_type_hint(init))
		1 when GDUT_Motion.validate_proxy_init(init):
			return steps_proxy(
				GDUT_Motion.get_proxy_init_proxy(init))
=======
## Starts a Steps motion.
static func steps_v(init: Array) -> StepsMotionExpression:
	match init.size():
		2, \
		3 when _can_parse_method_name_init(init):
			return steps_method_name(
				_parse_method_name_init_target(init),
				_parse_method_name_init_target_method_name(init),
				_parse_method_name_init_target_value_type_hint(init))
		2, \
		3 when _can_parse_property_init(init):
			return steps_property(
				_parse_property_init_target(init),
				_parse_property_init_target_property_path(init),
				_parse_property_init_target_value_type_hint(init))
		1, \
		2 when _can_parse_method_init(init):
			return steps_method(
				_parse_method_init_target_method(init),
				_parse_method_init_target_value_type_hint(init))
>>>>>>> Stashed changes

	GDUT_Motion.print_error(&"BAD_INIT", init)
	return null

<<<<<<< Updated upstream
#endregion

#region irregular

static func irregular_method_name(
	target: Object,
=======
## Starts a Steps motion.[br]
## [br]
## Starts an animation for the target defined in [param init].
## The following inputs are supported:
## [codeblock]
## # Method name + type hint
## Motion.steps(self, "set_position", TYPE_VECTOR2)
## # Method name
## Motion.steps(self, "set_position")
## # Callable + type hint
## Motion.steps(self.set_position, TYPE_VECTOR2)
## # Callable
## Motion.steps(self.set_position)
## # Property name + type hint
## Motion.steps(self, "position", TYPE_VECTOR2)
## # Property name
## Motion.steps(self, "position")
## [/codeblock]
## [b]Note:[/b] If there is no type annotation,
## or if it has a [Variant] annotation, you must specify a type hint.
## Type annotations take precedence, but the type hint will be used
## if the target type cannot be determined.
static func steps(...init: Array) -> StepsMotionExpression:
	return steps_v(init)

## Starts an Irregular motion for a property.
static func irregular_property(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL) -> IrregularMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var target := GDUT_MotionTarget.from_property(
		target_object,
		target_property_path,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_PROPERTY_TARGET", target_property_path, target_object)
		return null

	var transition_factory := GDUT_IrregularMotionTransitionFactory.new(target)
	return IrregularMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

## Starts an Irregular motion for a method call.
static func irregular_method_name(
	target_object: Object,
>>>>>>> Stashed changes
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL) -> IrregularMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var proxy := GDUT_MethodNameMotionProxy.create(
		target,
		target_method_name,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_METHOD_NAME_TARGET",
			target_method_name,
			target)
		return null

	var transition_factory := GDUT_IrregularMotionTransitionFactory.new(proxy)
=======
	var target := GDUT_MotionTarget.from_method_name(
		target_object,
		target_method_name,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_METHOD_NAME_TARGET", target_method_name, target_object)
		return null

	var transition_factory := GDUT_IrregularMotionTransitionFactory.new(target)
>>>>>>> Stashed changes
	return IrregularMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

<<<<<<< Updated upstream
=======
## Starts an Irregular motion for a [Callable] call.
>>>>>>> Stashed changes
static func irregular_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL) -> IrregularMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var proxy := GDUT_MethodMotionProxy.create(
		target_method,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_METHOD_TARGET",
			target_method)
		return null

	var transition_factory := GDUT_IrregularMotionTransitionFactory.new(proxy)
=======
	var target := GDUT_MotionTarget.from_method(
		target_method,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_METHOD_TARGET", target_method)
		return null

	var transition_factory := GDUT_IrregularMotionTransitionFactory.new(target)
>>>>>>> Stashed changes
	return IrregularMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

<<<<<<< Updated upstream
static func irregular_property(
	target: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL) -> IrregularMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var proxy := GDUT_PropertyMotionProxy.create(
		target,
		target_property_path,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_PROPERTY_TARGET",
			target_property_path,
			target)
		return null

	var transition_factory := GDUT_IrregularMotionTransitionFactory.new(proxy)
	return IrregularMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func irregular_proxy(proxy: MotionProxy) -> IrregularMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	if proxy == null or not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_PROXY_TARGET",
			proxy.get_name())
		return null

	var transition_factory := GDUT_IrregularMotionTransitionFactory.new(proxy)
	return IrregularMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func irregular(...init: Array) -> IrregularMotionExpression:
	match init.size():
		2, 3 when GDUT_Motion.validate_method_name_init(init):
			return irregular_method_name(
				GDUT_Motion.get_method_name_init_target(init),
				GDUT_Motion.get_method_name_init_target_method_name(init),
				GDUT_Motion.get_method_name_init_target_value_type_hint(init))
		1, 2 when GDUT_Motion.validate_method_init(init):
			return irregular_method(
				GDUT_Motion.get_method_init_target_method(init),
				GDUT_Motion.get_method_init_target_value_type_hint(init))
		2, 3 when GDUT_Motion.validate_property_init(init):
			return irregular_property(
				GDUT_Motion.get_property_init_target(init),
				GDUT_Motion.get_property_init_target_property_path(init),
				GDUT_Motion.get_property_init_target_value_type_hint(init))
		1 when GDUT_Motion.validate_proxy_init(init):
			return irregular_proxy(
				GDUT_Motion.get_proxy_init_proxy(init))
=======
## Starts an Irregular motion.
static func irregular_v(init: Array) -> IrregularMotionExpression:
	match init.size():
		2, \
		3 when _can_parse_method_name_init(init):
			return irregular_method_name(
				_parse_method_name_init_target(init),
				_parse_method_name_init_target_method_name(init),
				_parse_method_name_init_target_value_type_hint(init))
		2, \
		3 when _can_parse_property_init(init):
			return irregular_property(
				_parse_property_init_target(init),
				_parse_property_init_target_property_path(init),
				_parse_property_init_target_value_type_hint(init))
		1, \
		2 when _can_parse_method_init(init):
			return irregular_method(
				_parse_method_init_target_method(init),
				_parse_method_init_target_value_type_hint(init))
>>>>>>> Stashed changes

	GDUT_Motion.print_error(&"BAD_INIT", init)
	return null

<<<<<<< Updated upstream
#endregion

#region spring

static func spring_method_name(
	target: Object,
=======
## Starts an Irregular motion.[br]
## [br]
## Starts an animation for the target defined in [param init].
## The following inputs are supported:
## [codeblock]
## # Method name + Type hint
## Motion.irregular(self, "set_position", TYPE_VECTOR2)
## # Method name
## Motion.irregular(self, "set_position")
## # Callable + Type hint
## Motion.irregular(self.set_position, TYPE_VECTOR2)
## # Callable
## Motion.irregular(self.set_position)
## # Property name + Type hint
## Motion.irregular(self, "position", TYPE_VECTOR2)
## # Property name
## Motion.irregular(self, "position")
## [/codeblock]
## [b]Note:[/b] If there is no type hint,
## or if a [Variant] annotation is present, you must specify a type hint.
## Type annotations take precedence, but the type hint will be used
## if the target type cannot be determined.
static func irregular(...init: Array) -> IrregularMotionExpression:
	return irregular_v(init)

## Starts a Spring motion for a property.
static func spring_property(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL) -> SpringMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var target := GDUT_MotionTarget.from_property(
		target_object,
		target_property_path,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_PROPERTY_TARGET", target_property_path, target_object)
		return null

	var transition_factory := GDUT_SpringMotionTransitionFactory.new(target)
	return SpringMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

## Starts a Spring motion for a method call.
static func spring_method_name(
	target_object: Object,
>>>>>>> Stashed changes
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL) -> SpringMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var proxy := GDUT_MethodNameMotionProxy.create(
		target,
		target_method_name,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_METHOD_NAME_TARGET",
			target_method_name,
			target)
		return null

	var transition_factory := GDUT_SpringMotionTransitionFactory.new(proxy)
=======
	var target := GDUT_MotionTarget.from_method_name(
		target_object,
		target_method_name,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_METHOD_NAME_TARGET", target_method_name, target_object)
		return null

	var transition_factory := GDUT_SpringMotionTransitionFactory.new(target)
>>>>>>> Stashed changes
	return SpringMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

<<<<<<< Updated upstream
=======
## Starts a Spring motion for a [Callable] call.
>>>>>>> Stashed changes
static func spring_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL) -> SpringMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var proxy := GDUT_MethodMotionProxy.create(
		target_method,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_METHOD_TARGET",
			target_method)
		return null

	var transition_factory := GDUT_SpringMotionTransitionFactory.new(proxy)
=======
	var target := GDUT_MotionTarget.from_method(
		target_method,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_METHOD_TARGET", target_method)
		return null

	var transition_factory := GDUT_SpringMotionTransitionFactory.new(target)
>>>>>>> Stashed changes
	return SpringMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

<<<<<<< Updated upstream
static func spring_property(
	target: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL) -> SpringMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var proxy := GDUT_PropertyMotionProxy.create(
		target,
		target_property_path,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_PROPERTY_TARGET",
			target_property_path,
			target)
		return null

	var transition_factory := GDUT_SpringMotionTransitionFactory.new(proxy)
	return SpringMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func spring_proxy(proxy: MotionProxy) -> SpringMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	if proxy == null or not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_PROXY_TARGET",
			proxy.get_name())
		return null

	var transition_factory := GDUT_SpringMotionTransitionFactory.new(proxy)
	return SpringMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func spring(...init: Array) -> SpringMotionExpression:
	match init.size():
		2, 3 when GDUT_Motion.validate_method_name_init(init):
			return spring_method_name(
				GDUT_Motion.get_method_name_init_target(init),
				GDUT_Motion.get_method_name_init_target_method_name(init),
				GDUT_Motion.get_method_name_init_target_value_type_hint(init))
		1, 2 when GDUT_Motion.validate_method_init(init):
			return spring_method(
				GDUT_Motion.get_method_init_target_method(init),
				GDUT_Motion.get_method_init_target_value_type_hint(init))
		2, 3 when GDUT_Motion.validate_property_init(init):
			return spring_property(
				GDUT_Motion.get_property_init_target(init),
				GDUT_Motion.get_property_init_target_property_path(init),
				GDUT_Motion.get_property_init_target_value_type_hint(init))
		1 when GDUT_Motion.validate_proxy_init(init):
			return spring_proxy(
				GDUT_Motion.get_proxy_init_proxy(init))
=======
## Starts a Spring motion.
static func spring_v(init: Array) -> SpringMotionExpression:
	match init.size():
		2, \
		3 when _can_parse_method_name_init(init):
			return spring_method_name(
				_parse_method_name_init_target(init),
				_parse_method_name_init_target_method_name(init),
				_parse_method_name_init_target_value_type_hint(init))
		2, \
		3 when _can_parse_property_init(init):
			return spring_property(
				_parse_property_init_target(init),
				_parse_property_init_target_property_path(init),
				_parse_property_init_target_value_type_hint(init))
		1, \
		2 when _can_parse_method_init(init):
			return spring_method(
				_parse_method_init_target_method(init),
				_parse_method_init_target_value_type_hint(init))
>>>>>>> Stashed changes

	GDUT_Motion.print_error(&"BAD_INIT", init)
	return null

<<<<<<< Updated upstream
#endregion

#region glide

static func glide_method_name(
	target: Object,
=======
## Starts a Spring motion.[br]
## [br]
## Starts an animation for the target defined in [param init].
## The following inputs are supported:
## [codeblock]
## # Method name + type hint
## Motion.spring(self, "set_position", TYPE_VECTOR2)
## # Method name
## Motion.spring(self, "set_position")
## # Callable + type hint
## Motion.spring(self.set_position, TYPE_VECTOR2)
## # Callable
## Motion.spring(self.set_position)
## # Property name + type hint
## Motion.spring(self, "position", TYPE_VECTOR2)
## # Property name
## Motion.spring(self, "position")
## [/codeblock]
## [b]Note:[/b] If there is no type annotation,
## or if it has a [Variant] annotation, you must specify a type hint.
## Type annotations take precedence, but the type hint will be used
## if the target type cannot be determined.
static func spring(...init: Array) -> SpringMotionExpression:
	return spring_v(init)

## Starts a Glide motion for a property.
static func glide_property(
	target_object: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL) -> GlideMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var target := GDUT_MotionTarget.from_property(
		target_object,
		target_property_path,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_PROPERTY_TARGET", target_property_path, target_object)
		return null

	var transition_factory := GDUT_GlideMotionTransitionFactory.new(target)
	return GlideMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

## Starts a Glide motion for a method call.
static func glide_method_name(
	target_object: Object,
>>>>>>> Stashed changes
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL) -> GlideMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var proxy := GDUT_MethodNameMotionProxy.create(
		target,
		target_method_name,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_METHOD_NAME_TARGET",
			target_method_name,
			target)
		return null

	var transition_factory := GDUT_GlideMotionTransitionFactory.new(proxy)
=======
	var target := GDUT_MotionTarget.from_method_name(
		target_object,
		target_method_name,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_METHOD_NAME_TARGET", target_method_name, target_object)
		return null

	var transition_factory := GDUT_GlideMotionTransitionFactory.new(target)
>>>>>>> Stashed changes
	return GlideMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

<<<<<<< Updated upstream
=======
## Starts a Glide motion for a [Callable] call.
>>>>>>> Stashed changes
static func glide_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL) -> GlideMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

<<<<<<< Updated upstream
	var proxy := GDUT_MethodMotionProxy.create(
		target_method,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_METHOD_TARGET",
			target_method)
		return null

	var transition_factory := GDUT_GlideMotionTransitionFactory.new(proxy)
=======
	var target := GDUT_MotionTarget.from_method(
		target_method,
		target_value_type_hint)
	if target == null or not target.is_valid():
		GDUT_Motion.print_error(&"INVALID_METHOD_TARGET", target_method)
		return null

	var transition_factory := GDUT_GlideMotionTransitionFactory.new(target)
>>>>>>> Stashed changes
	return GlideMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

<<<<<<< Updated upstream
static func glide_property(
	target: Object,
	target_property_path: NodePath,
	target_value_type_hint := TYPE_NIL) -> GlideMotionExpression:

	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	var proxy := GDUT_PropertyMotionProxy.create(
		target,
		target_property_path,
		target_value_type_hint)
	if not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_PROPERTY_TARGET",
			target_property_path,
			target)
		return null

	var transition_factory := GDUT_GlideMotionTransitionFactory.new(proxy)
	return GlideMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func glide_proxy(proxy: MotionProxy) -> GlideMotionExpression:
	var canonical := GDUT_Motion.canonical
	if canonical == null:
		GDUT_Motion.print_error(&"ADDON_NOT_READY")
		return null

	if proxy == null or not proxy.is_valid():
		GDUT_Motion.print_error(
			&"INVALID_PROXY_TARGET",
			proxy.get_name())
		return null

	var transition_factory := GDUT_GlideMotionTransitionFactory.new(proxy)
	return GlideMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func glide(...init: Array) -> GlideMotionExpression:
	match init.size():
		2, 3 when GDUT_Motion.validate_method_name_init(init):
			return glide_method_name(
				GDUT_Motion.get_method_name_init_target(init),
				GDUT_Motion.get_method_name_init_target_method_name(init),
				GDUT_Motion.get_method_name_init_target_value_type_hint(init))
		1, 2 when GDUT_Motion.validate_method_init(init):
			return glide_method(
				GDUT_Motion.get_method_init_target_method(init),
				GDUT_Motion.get_method_init_target_value_type_hint(init))
		2, 3 when GDUT_Motion.validate_property_init(init):
			return glide_property(
				GDUT_Motion.get_property_init_target(init),
				GDUT_Motion.get_property_init_target_property_path(init),
				GDUT_Motion.get_property_init_target_value_type_hint(init))
		1 when GDUT_Motion.validate_proxy_init(init):
			return glide_proxy(
				GDUT_Motion.get_proxy_init_proxy(init))
=======
## Starts a Glide motion.
static func glide_v(init: Array) -> GlideMotionExpression:
	match init.size():
		2, \
		3 when _can_parse_method_name_init(init):
			return glide_method_name(
				_parse_method_name_init_target(init),
				_parse_method_name_init_target_method_name(init),
				_parse_method_name_init_target_value_type_hint(init))
		2, \
		3 when _can_parse_property_init(init):
			return glide_property(
				_parse_property_init_target(init),
				_parse_property_init_target_property_path(init),
				_parse_property_init_target_value_type_hint(init))
		1, \
		2 when _can_parse_method_init(init):
			return glide_method(
				_parse_method_init_target_method(init),
				_parse_method_init_target_value_type_hint(init))
>>>>>>> Stashed changes

	GDUT_Motion.print_error(&"BAD_INIT", init)
	return null

<<<<<<< Updated upstream
#endregion
=======
## Starts a Glide motion.[br]
## [br]
## Starts an animation for the target defined in [param init].
## The following inputs are supported:
## [codeblock]
## # Method name + Type hint
## Motion.glide(self, "set_position", TYPE_VECTOR2)
## # Method name
## Motion.glide(self, "set_position")
## # Callable + Type hint
## Motion.glide(self.set_position, TYPE_VECTOR2)
## # Callable
## Motion.glide(self.set_position)
## # Property name + Type hint
## Motion.glide(self, "position", TYPE_VECTOR2)
## # Property name
## Motion.glide(self, "position")
## [/codeblock]
## [b]Note:[/b] If there is no type annotation,
## or if it has a [Variant] annotation, be sure to specify a type hint.
## Type annotations take precedence, but the type hint will be used
## if the target type cannot be determined.
static func glide(...init: Array) -> GlideMotionExpression:
	return glide_v(init)

#-------------------------------------------------------------------------------

static func _can_parse_method_name_init(init: Array) -> bool:
	match init.size():
		3 when init[0] is Object and (init[1] is StringName or init[1] is String) and init[2] is int:
			if init[0].has_method(init[1]):
				return true
		2 when init[0] is Object and (init[1] is StringName or init[1] is String):
			if init[0].has_method(init[1]):
				return true
	return false

static func _can_parse_method_init(init: Array) -> bool:
	match init.size():
		2 when init[0] is Callable and init[1] is int:
			return true
		1 when init[0] is Callable:
			return true
	return false

static func _can_parse_property_init(init: Array) -> bool:
	match init.size():
		3 when init[0] is Object and (init[1] is StringName or init[1] is String or init[1] is NodePath) and init[2] is int:
			return true
		2 when init[0] is Object and (init[1] is StringName or init[1] is String or init[1] is NodePath):
			return true
	return false

static func _parse_method_name_init_target(init: Array) -> Object:
	return init[0]

static func _parse_method_name_init_target_method_name(init: Array) -> StringName:
	return init[1]

static func _parse_method_name_init_target_value_type_hint(init: Array) -> int:
	return \
		init[2] \
		if init.size() == 3 and init[2] is int else \
		TYPE_NIL

static func _parse_method_init_target_method(init: Array) -> Callable:
	return init[0]

static func _parse_method_init_target_value_type_hint(init: Array) -> int:
	return \
		init[1] \
		if init.size() == 2 and init[1] is int else \
		TYPE_NIL

static func _parse_property_init_target(init: Array) -> Object:
	return init[0]

static func _parse_property_init_target_property_path(init: Array) -> NodePath:
	return str(init[1]) if init[1] is StringName else init[1]

static func _parse_property_init_target_value_type_hint(init: Array) -> int:
	return \
		init[2] \
		if init.size() == 3 and init[2] is int else \
		TYPE_NIL
>>>>>>> Stashed changes
