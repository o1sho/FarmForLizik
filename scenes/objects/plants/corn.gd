extends Node2D

var corn_harvest_scene = preload("res://scenes/objects/plants/corn_harvest.tscn")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var watering_particles: GPUParticles2D = $WateringParticles
@onready var flowering_particles: GPUParticles2D = $FloweringParticles
@onready var grow_cycle_component: GrowCycleComponent = $GrowCycleComponent
@onready var hurt_component: HurtComponent = $HurtComponent

var grow_state: DataTypes.GrowStates = DataTypes.GrowStates.Seed

func _ready() -> void:
	watering_particles.emitting = false
	flowering_particles.emitting = false
	
	hurt_component.hurt.connect(on_hurt)
	grow_cycle_component.crop_maturity.connect(on_crop_maturuty)
	grow_cycle_component.crop_harvesting.connect(on_crop_hasrvesting)
	
func _process(delta: float) -> void:
	grow_state = grow_cycle_component.get_current_grow_state()
	sprite_2d.frame = grow_state
	
	if grow_state == DataTypes.GrowStates.Maturity:
		flowering_particles.emitting = true

func on_hurt(hit_damage: int) -> void:
	if !grow_cycle_component.is_watered:
		watering_particles.emitting = true
		await get_tree().create_timer(5.0).timeout
		watering_particles.emitting = false
		grow_cycle_component.is_watered = true
		
func on_crop_maturuty() -> void:
	flowering_particles.emitting = true
	
func on_crop_hasrvesting() -> void:
	var corn_harvest_instance = corn_harvest_scene.instantiate() as Node2D
	corn_harvest_instance.global_position = global_position
	get_parent().add_child(corn_harvest_instance)
	queue_free()
