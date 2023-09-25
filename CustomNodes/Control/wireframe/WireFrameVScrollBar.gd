@tool
extends Control
class_name  WireFrameVScrollBar

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



# 按钮 - 背景颜色
@export var btn_bk_color:Color = Color.DARK_GRAY:
	set(val):
		btn_bk_color = val
		queue_redraw()

func _draw():
	var rect = get_draw_safety_rect()
	# 绘制矩形填充
	draw_rect(rect,bk_color)
	# 绘制矩形外框
	draw_rect(rect,line_color,false,line_width)
	var btn_size = Vector2.ONE * rect.size.x
	
	var top_rect = Rect2(rect.position,btn_size)
	# 绘制顶部填充矩形
	draw_rect(top_rect,btn_bk_color)
	# 绘制顶部外框
	draw_rect(top_rect,line_color,false,line_width)
	var bottom_rect = Rect2(rect.end - btn_size,btn_size)
	# 绘制顶部填充矩形
	draw_rect(bottom_rect,btn_bk_color)
	# 绘制顶部外框
	draw_rect(bottom_rect,line_color,false,line_width)

# 获取绘制函数能正确使用的控件Rect2
func get_draw_safety_rect() -> Rect2:
	var rect = get_rect()
	return Rect2(rect.position - position,rect.size/scale)
