@tool
extends Control
class_name  WireFrameRect

# 背景颜色
@export var bk_color:Color = Color.WHITE:
	set(val):
		bk_color = val
		queue_redraw()

# 线条颜色
@export var line_color:Color = Color.BLACK:
	set(val):
		line_color = val
		queue_redraw()

# 线条宽度
@export var line_width:int = 1:
	set(val):
		line_width = val
		queue_redraw()


func _draw():
	var rect = get_draw_safety_rect()
	# 绘制矩形填充
	draw_rect(rect,bk_color)
	# 绘制矩形外框
	draw_rect(rect,line_color,false,line_width)

# 获取绘制函数能正确使用的控件Rect2
func get_draw_safety_rect() -> Rect2:
	var rect = get_rect()
	return Rect2(rect.position - position,rect.size/scale)
