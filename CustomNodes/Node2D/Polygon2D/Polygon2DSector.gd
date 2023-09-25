@tool
extends Polygon2D
class_name Polygon2DSector
## 起始角度
@export var start_angle:int = -90:
	set(val):
		start_angle = val
		update_polygon()

## 结束角度
@export var end_angle:int = 90:
	set(val):
		end_angle = val
		update_polygon()

## 半径
@export var r:float = 50:
	set(val):
		r = val
		update_polygon()

# 更新形状
func update_polygon():
	polygon = ShapePoints.sector(start_angle,end_angle,r)

func _init():
	update_polygon()
