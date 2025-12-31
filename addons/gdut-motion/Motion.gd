class_name Motion

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

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

	return canonical.merge_proxy(proxy)

#region tween

static func tween_method_name(
	target: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL) -> TweenMotionExpression:

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

	var transition_factory := GDUT_TweenMotionTransitionFactory.new(proxy)
	return TweenMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func tween_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL) -> TweenMotionExpression:

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

	var transition_factory := GDUT_TweenMotionTransitionFactory.new(proxy)
	return TweenMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

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

	GDUT_Motion.print_error(&"BAD_INIT", init)
	return null

#endregion

#region bezier

static func bezier_method_name(
	target: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL) -> BezierMotionExpression:

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

	var transition_factory := GDUT_BezierMotionTransitionFactory.new(proxy)
	return BezierMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func bezier_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL) -> BezierMotionExpression:

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

	var transition_factory := GDUT_BezierMotionTransitionFactory.new(proxy)
	return BezierMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

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

	GDUT_Motion.print_error(&"BAD_INIT", init)
	return null

#endregion

#region linear

static func linear_method_name(
	target: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL) -> LinearMotionExpression:

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

	var transition_factory := GDUT_LinearMotionTransitionFactory.new(proxy)
	return LinearMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func linear_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL) -> LinearMotionExpression:

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

	var transition_factory := GDUT_LinearMotionTransitionFactory.new(proxy)
	return LinearMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

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

	GDUT_Motion.print_error(&"BAD_INIT", init)
	return null

#endregion

#region steps

static func steps_method_name(
	target: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL) -> StepsMotionExpression:

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

	var transition_factory := GDUT_StepsMotionTransitionFactory.new(proxy)
	return StepsMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func steps_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL) -> StepsMotionExpression:

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

	var transition_factory := GDUT_StepsMotionTransitionFactory.new(proxy)
	return StepsMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

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

	GDUT_Motion.print_error(&"BAD_INIT", init)
	return null

#endregion

#region irregular

static func irregular_method_name(
	target: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL) -> IrregularMotionExpression:

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

	var transition_factory := GDUT_IrregularMotionTransitionFactory.new(proxy)
	return IrregularMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func irregular_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL) -> IrregularMotionExpression:

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

	var transition_factory := GDUT_IrregularMotionTransitionFactory.new(proxy)
	return IrregularMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

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

	GDUT_Motion.print_error(&"BAD_INIT", init)
	return null

#endregion

#region spring

static func spring_method_name(
	target: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL) -> SpringMotionExpression:

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

	var transition_factory := GDUT_SpringMotionTransitionFactory.new(proxy)
	return SpringMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func spring_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL) -> SpringMotionExpression:

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

	var transition_factory := GDUT_SpringMotionTransitionFactory.new(proxy)
	return SpringMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

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

	GDUT_Motion.print_error(&"BAD_INIT", init)
	return null

#endregion

#region glide

static func glide_method_name(
	target: Object,
	target_method_name: StringName,
	target_value_type_hint := TYPE_NIL) -> GlideMotionExpression:

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

	var transition_factory := GDUT_GlideMotionTransitionFactory.new(proxy)
	return GlideMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

static func glide_method(
	target_method: Callable,
	target_value_type_hint := TYPE_NIL) -> GlideMotionExpression:

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

	var transition_factory := GDUT_GlideMotionTransitionFactory.new(proxy)
	return GlideMotionExpression.new(
		canonical.schedule_transition(transition_factory, false),
		transition_factory)

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

	GDUT_Motion.print_error(&"BAD_INIT", init)
	return null

#endregion
