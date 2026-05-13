<br />

# Godot Motion

[![Release](https://badgen.net/github/release/ydipeepo/godot-motion)](https://github.com/ydipeepo/godot-motion/releases) [![MIT](https://badgen.net/github/license/ydipeepo/godot-motion)](https://github.com/ydipeepo/godot-motion/LICENSE)

This add-on animates any property or method using easing and continuous physics-based transition.

```gdscript
Motion \
	.tween(self, "position") \
	.trans_elastic() \
	.to(Vector2(500.0, 500.0))
```

> [!IMPORTANT]
> [Godot Task](https://github.com/ydipeepo/godot-task) and [Godot Easing](https://github.com/ydipeepo/godot-easing) must be installed before using this add-on.

<br />

## Objective

It was created for the following purposes:

* Easy to use as `Tween`.
* When rescheduling, velocity is preserved and curves are smoothly connected (limited to physics-based animations: tween and exponential decay).
* Animation curves can be configured from preset resources, making them easy for designers to maintain.

<br />

## Usage

When the addon is enabled, the `Motion` class and `MotionPresetBank` node become available.

#### Using `Motion`

This section explains how to use `Motion` from scripts.

There are two types of motion:

- **Physics-based Animation**: An animation where the duration are determined from the initial velocity at the start
- **Easing**: An animation that interpolates from the start position (or current position) to the end position over a fixed duration

These motions can be started using the `Motion` class.

##### Physics Motion

Type | Method name
---|---
Spring | `Motion.spring()`
Exp. Decay | `Motion.decay()`

##### Easing

Type | Method name
---|---
Back | `Motion.back()`
Bezier | `Motion.bezier()`
Elastic | `Motion.elastic()`
Linear | `Motion.linear()`
Power | `Motion.power()`
Random | `Motion.random()`
Steps | `Motion.steps()`

Each method returns an expression (`MotionExpression`). The expression has multiple self-returning methods, and calling these methods to configure the motion:

```gdscript
Motion \
	.tween(self, "position:x") \
	.duration(5.0) \
	.trans_cubic() \
	.ease_in() \
	.to(150.0)
```

As an exception, the `wait()` method is used to pause until the motion completes.

#### Using `MotionPresetBank`

This section explains how to use shared motion configurations via `MotionPresetBank`.

Place a `MotionPresetBank` node in the scene tree as shown below:

![Place a `MotionPresetBank`](./assets/texture/01.png)

Open the Inspector, add a `MotionPreset`, and configure it. (The `name` property is required!)
You can have multiple presets with the same `name` for each preset type.
In that case, you can adjust the selection probability using `probability`.

![Add and configure `MotionPreset`](./assets/texture/02.png)

At the appropriate timing, call the corresponding `Motion` method to start the animation.

```gdscript
func _on_button_pressed() -> void:
	Motion \
		.tween($Button, "scale") \
		.preset("QUINT_IN") \
		.to(Vector2.ONE * 2.0)
```

<br />

## License

All contents of this project are licensed under the attached 🔗 [MIT](https://github.com/ydipeepo/godot-motion/blob/main/LICENSE) license.

#### Attribution

Attribution is not required, but appreciated. If you would like to credit, please attribute to "Ydi".

<br />
