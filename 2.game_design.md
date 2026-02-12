# 2. Game Design 

## 1. Žánr
- 2D arkádová kompetitivní multiplayer hra
- Real-time arena survival
- Inspirováno slither.io

---

## 3. Herní mechaniky

### Hráčův had
- Neustále se pohybuje vpřed
- Směr ovládán myší či jiným vstupem
- Podržení klávesy = **boost** (vyšší rychlost)
  - Boost či jiné akční mechaniky spotřebovávájí **XP**
- Růst nastává při sbírání XP kuliček

### XP kuličky (Orby)
- Objevují se náhodně po mapě
- Padají z mrtvých hráčů
- Mají různou hodnotu dle barvy (a váhu)

### Kolize a smrt
- Hráč **umírá**, pokud hlavou narazí do těla jiného hada nebo borderu
- Po smrti zanechá hromadu XP s velkou váhou
- Tělo mrtvého hada mizí (volitelný čas)

### Cíl hry
- Přežít co nejdéle
- Nasbírat co nejvíce XP
- Přelstít soupeře, obklíčit je

---

## 4. Herní systém

### Herní mapa
- Velká otevřená plocha (velikost upravitelná)
- Jednoduché hranice (naráží se do okrajů)
- Překážky 

### Multiplayer
- Lokální **LAN** multiplayer
- Real-time synchronizace hadů
- Později možnost i headless serveru

### Respawn
- Hráč se objeví jako malý had u náhodné pozice
- Začíná s minimální velikostí

### Tempo hry
- Krátké, dynamické zápasy
- Rychlý růst → rychlé konflikty
- Neustálé riziko při boji o XP

---

## 5. Atributy

### Had
- Rychlost
- Velikost
- Délka
- Barva
- XP zásoba
- Směr pohybu

### XP kuličky (Orby)
- Hodnota
- Barva
- Velikost
- Váha
---

## 6. Vizualita

### Grafický styl
- Minimalistické sci-fi 2D
- Jednoduché tvary a výrazné barvy
- Důraz na přehlednost při velkém chaosu hráčů
- Plynulé animace hadího pohybu

### UI prvky
- XP bar
- Ukazatel rychlosti (boost)
- Skóre hráče
- Žebříček největších hráčů

---

## 7. Ovládání

### PC
- **Myš** – určování směru
- **Shift / Space / levé tlačítko** – boost
- **Esc** – menu

---

## 8. Zvuk
- Jednoduché efekty:
  - Sebrání XP
  - Boost
  - Smrt hráče
- Lehké ambientní pozadí

---

## 9. Herní smyčka

1. Spawn hráče  
2. Sběr XP → růst  
3. Kontakt se soupeři → riziko  
4. Kolize → smrt jednoho hráče  
5. Ostatní sbírají jeho XP  
6. Neustálé zvětšování, taktizování a soupeření  
7. „Last big snake wins“

---

## 10. Finální vize
- Jednoduchá, rychlá, návyková multiplayerová hra
- Snadno pochopitelná, těžko dokonale ovladatelná
- Zábava na LAN párty, školní přestávky i rychlé online hraní

