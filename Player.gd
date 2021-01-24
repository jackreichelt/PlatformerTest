extends Area2D

var currentV = Vector2()
var maxSpeed = 10
var accel = 50
var decel = 50
var screen_size
var state = 'ground'

func _ready():
  screen_size = get_viewport_rect()
  
func _process(delta):
  match state:
    'jumping':
      pass
    'falling':
      pass
    'ground':
      continue
    _: #default to ground
      run(delta)
  $DebugSpeedLabel.text = str(currentV.length())
      
func run(delta):
  var targetV = Vector2()
  
  if Input.is_action_pressed("ui_right"):
    targetV.x += 1
  if Input.is_action_pressed("ui_left"):
    targetV.x -= 1
  if Input.is_action_pressed("ui_up"):
    targetV.y -= 1
  if Input.is_action_pressed("ui_down"):
    targetV.y += 1
  if targetV.length() > 0:
    targetV = targetV.normalized() * maxSpeed
    
  var deltaV = currentV.direction_to(targetV)
  
  if deltaV.length() > 0:
    var newV = currentV + deltaV * accel * delta
    # if overshot, just get to target
    if currentV.distance_to(newV) > currentV.distance_to(targetV):
      currentV = targetV
    else:
      currentV = newV
    
  currentV = currentV.clamped(maxSpeed)
  
  if currentV.length() > 0:
    $AnimatedSprite.animation = 'run'
    if currentV.x < 0:
      $AnimatedSprite.flip_h = true
    else:
      $AnimatedSprite.flip_h = false
  else:
    $AnimatedSprite.animation = 'idle'
  position += currentV
    
    
