<br />

# ![GDUT Motion](assets/texture/icon.png) GDUT Motion

[![Release](https://badgen.net/github/release/ydipeepo/gdut-motion)](https://github.com/ydipeepo/gdut-motion/releases) [![MIT](https://badgen.net/github/license/ydipeepo/gdut-motion)](https://github.com/ydipeepo/gdut-motion/LICENSE)

This add-on animates any property or method using easing and continuous physics-based transition.

```gdscript
await Motion \
	.tween(self, "position") \
	.trans_elastic() \
	.to(Vector2(500.0, 500.0))
```

<br />

## Objective

It was created for the following purposes:

* Easy to use as `Tween`.
* When rescheduling, velocity is preserved and curves are smoothly connected (limited to physics-based animations).
* Animation curves can be configured from node (and resources), making them easy for designers to maintain.

<br />

## Quick start

When the add-on is enabled, the `Motion` class and the `MotionPresetBank` node become available.

#### Using `MotionPresetBank`

This section explains how to place `MotionPresetBank` and use them from code.

Place a `MotionPresetBank` node in the scene tree as shown below:

![Place a `MotionPresetBank`](./assets/texture/01.png)

Open the Inspector, add a `MotionPreset`, and configure it. (The `name` property is required!)
You can have multiple presets with the same `name` for each preset type.

![Add and configure `MotionPreset`](./assets/texture/02.png)

At the appropriate timing, call the corresponding `Motion` method to start the animation.

```gdscript
func _on_button_pressed() -> void:
	Motion \
		.tween($Button, "scale") \
		.preset("QUINT_IN") \
		.to(Vector2.ONE * 2.0)
```

#### Using `Motion`

This section explains how to start motions from code.

There are two categories of motions:

* **Perceived motions**: complete within a specified duration.
* **Physics motions**: vary in duration depending on the current velocity.

Each of the following motion types can be started using the methods defined in `Motion`.

##### Perceived motions

Type | Method name
---|---
Tween motion | `Motion.tween()`
Bezier motion | `Motion.bezier()`
Linear motion | `Motion.linear()`
Steps motion | `Motion.steps()`
Irregular motion | `Motion.irregular()`

##### Physics motions

Type | Method name
---|---
Spring motion | `Motion.spring()`
Glide motion | `Motion.glide()`

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
The `then_*` methods returns a new expression for chaining subsequent motions.

```gdscript
await Motion \
	.tween(self, "position:x") \
	# ...
	.then_bezier() \
	.to(100.0) \
	.wait()
```

The expressions differ for each motion type. For details, please refer to the in-editor help.

#### Installation

1. `git clone https://github.com/ydipeepo/gdut-motion.git` or [download release](https://github.com/ydipeepo/gdut-motion/releases).
2. Then copy `addons/gdut-motion` directory into your project.
3. And enable GDUT Motion from your project settings.

> [!IMPORTANT]
> [GDUT Task](https://github.com/ydipeepo/gdut-task) must be installed before using this add-on.

<br />

## License

All contents of this project are licensed under the attached 🔗 [MIT](https://github.com/ydipeepo/gdut-motion/blob/main/LICENSE) license.

#### Attribution

Attribution is not required, but appreciated. If you would like to credit, please attribute to "Ydi".

<br />
