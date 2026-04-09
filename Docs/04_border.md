# Dokumentace: Hranice mapy (Border)

Hranice mapy tvoří kruhovou herní arénu, která omezuje pohyb hráče. Skládá se z dlaždicového podkladu, fyzické kolizní vrstvy a vizuální obrysové čáry. Náraz do této hranice je pro hráče smrtelný.

## 1. Generování herní plochy a podkladu

Velikost herního světa je definována globální proměnnou `Global.world_size` (výchozí 4000x4000). Herní plocha má tvar kruhu. Skript při startu vypočítá poloměr a dynamicky vyplní odpovídající kruhovou oblast dlaždicemi v uzlu `TileMapLayer`.

**Kód pro generování podkladu (Hlavní scéna):**
```gdscript
func fill_tilemap_circular():
	var tile_size = 256
	var cols = int(Global.world_size.x / tile_size)+15
	var rows = int(Global.world_size.y / tile_size)+15
	var center = Vector2(cols / 2.0, rows / 2.0)
	var radius = min(cols, rows) / 2.0

	for x in range(cols):
		for y in range(rows):
			var dist = Vector2(x, y).distance_to(center)
			if dist < radius:
				# Offset tiles so (0,0) world = center of circle
				$TileMapLayer.set_cell(Vector2i(x - int(center.x), y - int(center.y)), 0, Vector2i(0, 0))
```

## 2. Fyzická kolize a vizuální hranice

Aby hráč nemohl opustit herní plochu, generuje se na okrajích kruhu `StaticBody2D`. Kruh je aproximován pomocí 64 kratších rovných úseků (`SegmentShape2D`), čímž vznikne plynulá bariéra. Tato bariéra je přiřazena do skupiny `"border"`. 

Vizuálně je tato hranice vykreslena pomocí uzlu `Line2D`, který tvoří červenou čáru o tloušťce 5 pixelů přesně v místech kolize.

**Kód tvorby zdi a vykreslení čáry (Hlavní scéna):**
```gdscript
func create_border_wall():
	var tile_size = 256
	var cols = int(Global.world_size.x / tile_size)
	var rows = int(Global.world_size.y / tile_size)
	var radius_px = (min(cols, rows) / 2.0) * tile_size

	var static_body = StaticBody2D.new()
	static_body.position = Vector2.ZERO
	add_child(static_body)
	
	# Build a ring of small collision segments around the circle edge
	var segments = 64  # More = smoother border
	for i in range(segments):
		# ... (výpočet úhlů)
		var collision = CollisionShape2D.new()
		var segment = SegmentShape2D.new()
		segment.a = Vector2(cos(angle_a), sin(angle_a)) * radius_px
		segment.b = Vector2(cos(angle_b), sin(angle_b)) * radius_px
		collision.shape = segment
		static_body.add_child(collision)
		static_body.add_to_group("border")

	# Visual (colored border)
	var line = Line2D.new()
	line.width = 5
	line.default_color = Color.RED
    # ... (přidání bodů do line.points a připojení ke static_body)
```

## 3. Vliv na hráče (Smrt)

Hráč (hlava hada) během svého pohybu funkcí `move_and_slide()` neustále kontroluje kolize. Pokud detekuje náraz do jakéhokoliv objektu ze skupiny `"border"`, okamžitě se zavolá funkce `die()`.

Funkce `die()` přehraje zvukový efekt, zastaví další pohyb (nastavením `velocity` na nulu a vypnutím funkce `_process`), označí hráče za mrtvého a zobrazí závěrečnou obrazovku (`DeathScreen`) s konečným skóre.

**Kód detekce kolize a smrti (head.gd - CharacterBody2D):**
```gdscript
func _process(delta):
	# ... (kód pohybu a rotace)
	move_and_slide()
	# Check collisions
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)  # KinematicCollision2D
		var collider_obj = collision.get_collider()  # actual object
		if collider_obj.is_in_group("border"):
			die()

func die():
	$AudioStreamPlayer2D.play()
	
	if is_dead:
		return
	is_dead = true

	# Show death screen
	var death_screen = get_tree().get_current_scene().get_node("DeathScreen")
	if death_screen:
		death_screen.show_death()
	
	# Stop player movement
	velocity = Vector2.ZERO
	set_process(false)
```