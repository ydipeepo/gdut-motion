@abstract
extends RefCounted

#-------------------------------------------------------------------------------
#	METHODS
#-------------------------------------------------------------------------------

static func create(size: int) -> RefCounted:
	return \
		_SMALL_CLASS.new() \
		if size <= 32 else \
		_LARGE_CLASS.new(size)

@abstract
func count() -> int

@abstract
func get_at(index: int) -> bool

@abstract
func set_at(index: int) -> void

@abstract
func clear_at(index: int) -> void

@abstract
func clear() -> void

#-------------------------------------------------------------------------------

const _SMALL_CLASS := preload("uid://c7yn32h3numqc")
const _LARGE_CLASS := preload("uid://c2xnliqnhq3ba")
