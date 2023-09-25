# ========================================================
# 名称：RectProgress
# 类型：扩展控件
# 简介：基于_draw实现的更简单的进度条控件
# 作者：巽星石
# Godot版本：4.1-stable (official)
# 创建时间：2023-07-08 03:13:48
# 最后修改时间：2023年7月8日03:49:41
# ========================================================
@tool
extends Control
class_name RectProgress
# =================================== 信号 ===================================
signal value_changed(new_value) # value发生改变时触发


# =================================== 参数 ===================================
@export_group("Color")
## 边框颜色
@export var border_color:Color = Color("#56741b"):
	set(val):
		border_color = val
		queue_redraw()

## 进度矩形颜色
@export var progress_color:Color = Color.YELLOW_GREEN:
	set(val):
		progress_color = val
		queue_redraw()

## 背景矩形颜色
@export var background_color:Color = Color("#f0fddf"):
	set(val):
		background_color = val
		queue_redraw()
## 边框宽度
@export var border_width:int = 1:
	set(val):
		border_width = val
		queue_redraw()

@export_group("Range")
## 最大值
@export var max:int = 100:
	set(val):
		max = val
		queue_redraw()
## 最小值
@export var min:int = 0:
	set(val):
		min = val
		queue_redraw()
## 当前值
@export var value:int = 50:
	set(val):
		var new_value = clamp(val,min,max)
		value = new_value
		emit_signal("value_changed",new_value)
		queue_redraw()


func _draw():
	# 背景矩形
	draw_rect(get_rect(),background_color,true)
	# 进度矩形
	var r = float(value) / float(max)
	draw_rect(Rect2(Vector2(),Vector2(size.x * r,size.y)),progress_color,true)
	# 外边框
	draw_rect(get_rect(),border_color,false,border_width)
