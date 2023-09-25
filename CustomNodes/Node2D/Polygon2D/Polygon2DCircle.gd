@tool
extends Polygon2D
class_name Polygon2DCircle
## 圆半径
@export var r:float = 50:
	set(val):
		r = val
		update_polygon()
# 更新形状
func update_polygon():
	polygon = ShapePoints.circle(r)

func _init():
	update_polygon()
