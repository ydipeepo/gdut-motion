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

* Simpler to use than Tween.
* When rescheduling, velocity is preserved and curves are smoothly connected (limited to physics-based animations).
* Animation curves can be configured from node (and resources), making them easy for designers to manage.

<br />

## Usage

Here, we will explain only how to configure curves using `MotionPresetBank` node.

Place a `MotionPresetBank` node in the scene tree as shown below:

![Place a `MotionPresetBank`](./assets/texture/01.png)

Open the Inspector, add a `MotionPreset`, and configure it. (The `name` property is required!)
You can have multiple presets with the same `name` for each preset type.

![Add and configure `MotionPreset`](./assets/texture/02.png)

At the appropriate timing, call the corresponding `Motion` method to start the animation.

```gdscript
func _on_button_pressed() -> void:
	Motion.tween($Button, "scale").preset("QUINT_IN").to(Vector2.ONE * 2.0)
```

<br />

## Quick start

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
