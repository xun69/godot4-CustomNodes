@tool
extends Polygon2D
class_name Polygon2DChamferRect

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

## 左上角圆角半径
@export_range(0.0,10000.0,1.0) var a:float = 5:
	set(val):
		a = val
		update_polygon()
## 左上角圆角半径
@export_range(0.0,10000.0,1.0) var b:float = 5:
	set(val):
		b = val
		update_polygon()
## 左上角圆角半径
@export_range(0.0,10000.0,1.0) var c:float = 5:
	set(val):
		c = val
		update_polygon()
## 左上角圆角半径
@export_range(0.0,10000.0,1.0) var d:float = 5:
	set(val):
		d = val
		update_polygon()

# 更新形状
func update_polygon():
	polygon = ShapePoints.chamfer_rect(Vector2(width,height),a,b,c,d)

func _init():
	update_polygon()

