@tool
extends Polygon2D
class_name Polygon2DRoundRect

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
@export_range(0.0,10000.0,1.0) var r1:float = 5:
	set(val):
		r1 = val
		update_polygon()
## 左上角圆角半径
@export_range(0.0,10000.0,1.0) var r2:float = 5:
	set(val):
		r2 = val
		update_polygon()
## 左上角圆角半径
@export_range(0.0,10000.0,1.0) var r3:float = 5:
	set(val):
		r3 = val
		update_polygon()
## 左上角圆角半径
@export_range(0.0,10000.0,1.0) var r4:float = 5:
	set(val):
		r4 = val
		update_polygon()

# 更新形状
func update_polygon():
	polygon = ShapePoints.round_rect(Vector2(width,height),r1,r2,r3,r4)

func _init():
	update_polygon()

