extends PanelContainer

@onready var tool_axe: Button = $MarginContainer/BoxContainer/ToolAxe
@onready var tool_telling: Button = $MarginContainer/BoxContainer/ToolTelling
@onready var tool_watering_can: Button = $MarginContainer/BoxContainer/ToolWateringCan
@onready var tool_corn: Button = $MarginContainer/BoxContainer/ToolCorn
@onready var tool_tomato: Button = $MarginContainer/BoxContainer/ToolTomato


func _on_tool_axe_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.AxeWood)
	
func _on_tool_telling_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.TillGround)

func _on_tool_watering_can_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.WaterCrops)

func _on_tool_corn_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.PlantCorn)

func _on_tool_tomato_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.PlantTomato)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			ToolManager.select_tool(DataTypes.Tools.None)
			tool_axe.release_focus()
			tool_telling.release_focus()
			tool_watering_can.release_focus()
			tool_corn.release_focus()
			tool_tomato.release_focus()
