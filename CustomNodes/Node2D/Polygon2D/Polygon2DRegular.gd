@tool
extends Polygon2D
class_name Polygon2DRegular
## 起始角度
@export var start_angle:int = -90:
	set(val):
		start_angle = val
		update_polygon()

## 角数
@export var edges:int=5:
	set(val):
		edges = val
		update_polygon()

## 圆半径
@export var r:float = 50:
	set(val):
		r = val
		update_polygon()

# 更新形状
func update_polygon():
	polygon = ShapePoints.regular_polygon(start_angle,edges,r)

func _init():
	update_polygon()
