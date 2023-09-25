# ========================================================
# 名称：LinkPolyLine
# 类型：Line2D扩展节点
# 简介：专用于绘制两点之间的折线连接，并可以自由选择两端的箭头样式
# 作者：巽星石
# Godot版本：4.0.3-stable (official)
# 创建时间：2023-07-02 01:22:02
# 最后修改时间：2023年7月2日02:32:29
# ========================================================
@tool
extends Line2D
class_name LinkPolyLine

# 端点样式
enum{
	NULL = 0, # 没有
	ARROW = 1, # 箭头
	EMPTY_RECT = 2, # 空心矩形
	FILL_RECT = 3, # 填充矩形
}

# =================================== 参数 ===================================
## 起点
@export var start_point = Vector2(100,100):
	set(val):
		start_point = val
		refresh_linkline()
		
## 终点
@export var end_point = Vector2(200,100):
	set(val):
		end_point = val
		refresh_linkline()
## 左侧箭头样式
@export_enum("无","箭头","空心矩形","实心矩形") var left_arrow:int = 0:
	set(val):
		left_arrow = val
		refresh_linkline()

## 右侧箭头样式
@export_enum("无","箭头","空心矩形","实心矩形") var right_arrow:int = 0:
	set(val):
		right_arrow = val
		refresh_linkline()

# =================================== 虚函数 ===================================

func _init():
	default_color = Color("yellow")
	width = 1
	
# 测试 -- 根据鼠标位置动态绘制连线
func _input(event):
	if event is InputEventMouseMotion:
		start_point = get_global_mouse_position()

# 绘制端点样式
func _draw():
	# 左箭头
	match left_arrow:
		ARROW:
			draw_arrow(START_POINT)
		EMPTY_RECT:
			draw_empty_rect(START_POINT)
		FILL_RECT:
			draw_fill_rect(START_POINT)
	# 右箭头
	match right_arrow:
		ARROW:
			draw_arrow(END_POINT)
		EMPTY_RECT:
			draw_empty_rect(END_POINT)
		FILL_RECT:
			draw_fill_rect(END_POINT)

# =================================== 方法 ===================================
# 刷新连线
func refresh_linkline():
	var m_points:PackedVector2Array = []
	var dx = end_point.x - start_point.x
	m_points.append(start_point)
	m_points.append(start_point + Vector2(dx/2,0))
	m_points.append(end_point - Vector2(dx/2,0))
	m_points.append(end_point)
	points = m_points
	queue_redraw()

# 要绘制箭头或矩形的端点
enum {
	START_POINT = 0, # 起始点
	END_POINT = 1,   # 终点
}

## 绘制箭头
func draw_arrow(point:int):
	# 根据给定的点计算绘制所需的起始点
	var start_pos:Vector2
	var end_pos:Vector2
	if point == START_POINT: # 起始端点
		start_pos = points[1]
		end_pos = points[0]
	else:
		start_pos = points[2]
		end_pos = points[3]
	
	var line_angle:float = (end_pos-start_pos).angle() # 直线与X轴夹角
	var length:float = 20.0 # 箭头的边线长度
	var angle:float = 25 # 箭头线的偏转角度
	
	var arrow_end_pos1 = end_pos + Vector2.UP.rotated(line_angle + deg_to_rad(-(90-angle))) * length
	var arrow_end_pos2 = end_pos + Vector2.DOWN.rotated(line_angle + deg_to_rad(90-angle)) * length
	draw_line(end_pos,arrow_end_pos1,default_color,width)
	draw_line(end_pos,arrow_end_pos2,default_color,width)

# 绘制指定两点的线段的头尾端的空矩形
func draw_empty_rect(point:int,size:Vector2 = Vector2(20,20)) -> void:
	# 根据给定的点计算绘制所需的起始点
	var start_pos:Vector2
	var end_pos:Vector2
	var pos:Vector2
	if point == START_POINT: # 起始端点
		start_pos = points[1]
		end_pos = points[0]
	else:
		start_pos = points[2]
		end_pos = points[3]
	pos = end_pos
	
	var line_angle:float = (end_pos - start_pos).angle() # 直线与X轴夹角
	
	# 计算各个点
	var point0 = pos + Vector2.UP.rotated(line_angle) * (size.y/2)
	var point1 = point0 + Vector2.RIGHT.rotated(line_angle) * size.x
	var point2 = point1 + Vector2.DOWN.rotated(line_angle) * size.y
	var point3 = point2 + Vector2.LEFT.rotated(line_angle) * size.x
	var point4 = point0
	
	# 绘制
	draw_line(end_pos,point0,default_color,width)
	draw_line(point0,point1,default_color,width)
	draw_line(point1,point2,default_color,width)
	draw_line(point2,point3,default_color,width)
	draw_line(point3,point4,default_color,width)

# 绘制指定两点的线段的头尾端的实心矩形
func draw_fill_rect(point:int,size:Vector2 = Vector2(20,20)) -> void:
	# 根据给定的点计算绘制所需的起始点
	var start_pos:Vector2
	var end_pos:Vector2
	var pos:Vector2
	if point == START_POINT: # 起始端点
		start_pos = points[1]
		end_pos = points[0]
	else:
		start_pos = points[2]
		end_pos = points[3]
	pos = end_pos
	
	
	var line_angle:float = (end_pos - start_pos).angle() # 直线与X轴夹角
	# 计算各个点
	var point0 = pos + Vector2.UP.rotated(line_angle) * (size.y/2)
	var point1 = point0 + Vector2.RIGHT.rotated(line_angle) * size.x
	var point2 = point1 + Vector2.DOWN.rotated(line_angle) * size.y
	var point3 = point2 + Vector2.LEFT.rotated(line_angle) * size.x
	var point4 = point0
	# 创建绘制函数所需的数据形式
	var d_points:PackedVector2Array = [
		point0,point1,point2,point3,point4
	]

	draw_colored_polygon(d_points,default_color)



