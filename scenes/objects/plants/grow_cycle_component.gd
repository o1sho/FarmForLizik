class_name GrowCycleComponent
extends Node

@export var current_grow_state: DataTypes.GrowStates = DataTypes.GrowStates.Germination
@export_range(5, 365) var days_until_harvest: int = 7

signal crop_maturity
signal crop_harvesting

var is_watered: bool
var starting_day: int
var current_day: int

func _ready() -> void:
	DayAndNightCycleManager.time_tick_day.connect(on_time_tick_day)
	
func on_time_tick_day(day:int) -> void:
	if is_watered:
		if starting_day == 0:
			starting_day = day
			
		grow_states(starting_day, day)
		harvest_state(starting_day, day)
		
func grow_states(starting_day: int, current_day: int) -> void:
	if current_grow_state == DataTypes.GrowStates.Maturity:
		return
	
	var num_states = 5
	
	var grow_days_passed = (current_day - starting_day) % num_states
	var state_index = grow_days_passed % num_states + 1
	
	current_grow_state = state_index
	
	var name = DataTypes.GrowStates.keys()[current_grow_state]
	print("Current grow state: ", name, " State index: ", state_index)
	
	if current_grow_state == DataTypes.GrowStates.Maturity:
		crop_maturity.emit()
		
func harvest_state(starting_day: int, current_day: int) -> void:
	if current_grow_state == DataTypes.GrowStates.Harvesting:
		return
		
	var days_passed = (current_day - starting_day) % days_until_harvest
	
	if days_passed == days_until_harvest - 1:
		current_grow_state = DataTypes.GrowStates.Harvesting
		crop_harvesting.emit()
		
func get_current_grow_state() -> DataTypes.GrowStates:
	return current_grow_state
