# ========================================================
# 名称：Grid2D
# 类型：Node2D扩展
# 简介：扩展自Node2D的网格节点，提供基本的网格绘制和坐标转换。
#      可以在不用TileMap的情况下实现一些网格的效果。
# 作者：巽星石
# Godot版本：4.0.3-stable (official)
# 创建时间：2023-07-02 00:32:48
# 最后修改时间：2023-07-02 00:32:48
# ========================================================
@tool
extends Node2D
class_name Grid2D

# =================================== 参数 ===================================
## 网格尺寸 - 有多少行、多少列
@export var grid_size = Vector2i(32,32):
	set(val):
		grid_size = val
		queue_redraw()

## 单元格大小
@export var cell_size = Vector2i(32,32):
	set(val):
		cell_size = val
		queue_redraw()

## 网格颜色
@export var grid_color:Color = Color("#a49b7858"):
	set(val):
		grid_color = val
		queue_redraw()

## 网格边框宽度
@export var grid_border_width:int = 1:
	set(val):
		grid_border_width = val
		queue_redraw()

# =================================== 虚函数 ===================================
func _draw():
	# 绘制网格
	for x in grid_size.x:
		for y in grid_size.y:
#			draw_rect(get_cell_rect(Vector2(x,y)),grid_color,false,grid_border_width)
			draw_circle(Vector2i(x,y) * grid_size,2,grid_color)

# =================================== 方法 ===================================
# 网格坐标 -> 单元格的矩形
func get_cell_rect(cell_pos:Vector2i):
	return Rect2(cell_pos * cell_size,cell_size)

# 网格坐标 -> 单元格中心点
func get_cell_center(cell_pos:Vector2):
	return cell_pos * Vector2(cell_size) + Vector2(cell_size/2)
	
# 屏幕坐标 -> 网格坐标
func get_grid_pos(screen_pos:Vector2):
	return floor(screen_pos / Vector2(cell_size))
