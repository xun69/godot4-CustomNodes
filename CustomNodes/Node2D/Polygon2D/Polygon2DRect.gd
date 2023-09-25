@tool
extends Polygon2D
class_name Polygon2DRect

## 宽度
@export_range(0.0,10000.0,1.0) var width:float = 50.0:
	set(val):
		width = val
		update_polygon()
## 高度
@export_range(0.0,10000.0,1.0) var height:float = 50.0:
	set(val):
		height = val
		update_polygon()

# 更新形状
func update_polygon():
	polygon = ShapePoints.rect(Vector2(width,height))

func _init():
	update_polygon()
