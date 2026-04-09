# Dokumentace: XP Orb (ColoredSprite)

XP orby (`ColoredSprite`) představují hlavní zdroj zkušeností (XP) a bodů pro hráče. Hráč je sbírá k dosažení vyššího skóre a prodloužení těla hada.

## 1. Generování a Respawn

Při startu hry se vygeneruje stanovený počet orbů (`Global.max_orbs`, výchozí hodnota je 200). Orby se objevují v náhodných bodech uvnitř herní mapy (kruhu). Pokud hráč orb sebere, orb není smazán, ale okamžitě se "respawnuje" na nové náhodné pozici.

**Kód generování (Hlavní scéna):**
```gdscript
func spawn_orb(pos: Vector2, color: Color, size: float) -> void:
	var s : ColoredSprite = ColoredSprite.instantiate()
	add_child(s)
	s.position = pos
	s.set_color(color)
	s.scale = Vector2(size, size)

# Část funkce _ready()
for i in range(Global.max_orbs):
	spawn_orb(
		get_random_point_in_circle(Global.world_size.x/2-100),
		Global.orb_colors[randi_range(0,15)],
		randf_range(0.5,3)
	)		
```

## 2. Barvy

Barvy orbů jsou náhodně vybírány ze seznamu 16 neonových barev definovaných v `Global.orb_colors`. Každý orb získá unikátní instanci materiálu (aby barvy nepřetékaly na ostatní) a barva je aplikována na shader jako parametr `tint`. Novou barvu orb získá vždy, když je vytvořen nebo sebrán.

**Kód definice barev (Global) a nastavení (ColoredSprite):**
```gdscript
# globad.gd (zkráceno)
var orb_colors = [
	Color(1.0, 0.0, 0.6),   # neon pink
	Color(1.0, 0.2, 0.0),   # neon orange-red
	# ... celkem 16 barev
]

# ColoredSprite.gd
func set_color(color: Color) -> void:
	_sprite.material.set_shader_parameter("tint", color)
```

## 3. Velikost

Velikost každého orbu je určena náhodně při jeho vygenerování. Pohybuje se v rozmezí od `0.5` do `3.0` a nastavuje se přímo pomocí vlastnosti `scale`. 

Velikost není jen vizuální; **přímo určuje, kolik zkušeností (XP) orb obsahuje** (viz další bod).

## 4. Vliv na růst a skóre hráče

Když hlava hada (`body` ze skupiny "player") vstoupí do oblasti orbu, aktivuje se kolize. Hráč získá počet XP, který přesně odpovídá velikosti orbu (vypočítáno ze `scale[0]`). Následně se orb přemístí.

Na straně hráče se hodnota přičte k celkovému `Global.score` a aktuálním XP. Jakmile nasbírané XP překročí hranici `Global.max_orbs_xp` (výchozí 30), dojde k přidání nové části těla hada a odpočtu limitu pro získání další úrovně.

**Kód detekce kolize (ColoredSprite):**
```gdscript
func _on_body_entered(body):
	if body.is_in_group("player"):
		body.add_xp(self.scale[0])
		self.position = get_random_point_in_circle(Global.world_size.x/2-100)
		self.set_color(Global.orb_colors[randi_range(0,15)])
```

**Kód přičtení XP a růstu (CharacterBody2D hráče):**
```gdscript
func add_xp(amount):
	xp += amount
	Global.score += amount
	
	if (xp >= Global.max_orbs_xp):
		snake_head.add_body_part()
		xp -= Global.max_orbs_xp
	
	xp_bar.value = xp
	score_label.text = "Score: %.2f" % Global.score
```