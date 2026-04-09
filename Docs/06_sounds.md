# Dokumentace: Zvukové efekty hráče (Audio)

Skript hlavy hada (`head.gd`) obsahuje integrované zvukové uzly (`AudioStreamPlayer2D` / `AudioStreamPlayer`), které reagují na klíčové herní události. Všechny použité zvukové efekty jsou **přirozeně dabované**. Využití originálních, hlasem tvořených zvuků dodává hře unikátní identitu a organický charakter, což je silný a snadno zapamatovatelný prvek pro budoucí prezentaci a komerční potenciál projektu.

## 1. Zvukové události

Ve hře jsou aktuálně definovány tři hlavní zvukové spouštěče:

* **Konzumace orbu (`$ConsumePlayer`):** Zvuk se přehraje okamžitě při každém sebrání XP orbu (při zavolání funkce `add_xp`). Poskytuje hráči okamžitou zpětnou vazbu o úspěšném sběru.
* **Růst hada (`$BodyExpansionPlayer`):** Tento zvukový efekt se aktivuje pouze tehdy, když nasbírané XP dosáhnou požadovaného limitu (`Global.max_orbs_xp`) a dojde k přidání nového článku těla. Odděluje tak běžný sběr od důležitého "level-up" momentu.
* **Smrt hráče (`$DeathPlayer`):** Přehraje se při fatálním nárazu do hranice mapy (`border`), těsně před tím, než se zastaví pohyb a zobrazí se závěrečná obrazovka.

**Kód implementace zvuků (ve skriptu `head.gd`):**

```gdscript
func die():
    $DeathPlayer.play()  # Přehraje zvuk smrti při nárazu
    
    if is_dead:
        return
    is_dead = true
    # ... (zbytek logiky smrti)

func add_xp(amount):
    $ConsumePlayer.play()  # Přehraje zvuk při každém zisku XP
    xp += amount
    Global.score += amount
    
    if (xp >= Global.max_orbs_xp):
        $BodyExpansionPlayer.play()  # Přehraje zvuk při přidání části těla
        snake_head.add_body_part()
        xp -= Global.max_orbs_xp
    
    # ... (zbytek logiky aktualizace UI)
```