# RoboCell

[English](README.md) | Francais

Cellule robotisee simulee de tri et de palettisation : un bras 6 axes (classe UR5)
modelise dans MATLAB, commande dans Simulink, integre dans CoppeliaSim, puis supervise
par une couche IIoT (OPC UA, MQTT, Modbus TCP, SCADA).

![statut](https://img.shields.io/badge/statut-en%20cours-orange)
![matlab](https://img.shields.io/badge/MATLAB-R2024b-blue)
![coppeliasim](https://img.shields.io/badge/CoppeliaSim-4.10%20Edu-green)
![licence](https://img.shields.io/badge/licence-MIT-lightgrey)

## Probleme

Les lignes de conditionnement cosmetique en petite serie traitent de nombreuses
references et de nombreux motifs d'empilage. La programmation en positions fixes est
lente a reconfigurer. RoboCell etudie trois difficultes dans un perimetre reduit et
verifiable : la reconfiguration, la precision sous variation de charge, et la reprise
apres interruption.

## Architecture

- **Banc A (Simulink) :** dynamique corps rigide, PD + gravite vs couple calcule, saturation.
- **Banc B (CoppeliaSim) :** convoyeur, palettes, collisions, logique de cellule, MATLAB via ZeroMQ.
- **Phase IIoT :** passerelle Python, OPC UA, MQTT (Mosquitto), Modbus TCP, SCADA Ignition,
  Node-RED, PostgreSQL. MATLAB reste le seul maitre du mouvement.

## Methode

Cycle en V avec missions incrementales et portes G0 a G5. 54 exigences, 46 tests de
recette. Voir [docs/methodology.md](docs/methodology.md) et [docs/planning.md](docs/planning.md).

## Avancement

| Mission | Perimetre | Statut |
|---|---|---|
| M0 | Cadrage, methode, planning | En cours |
| M1 a M8 | Coeur robotique, tests T01-T34 | Planifie |
| M9 a M10 | Phase IIoT, tests T35-T46 | Planifie |

## Declaration d'honnetete

Tous les chiffres du cahier des charges sont des cibles d'acceptation, pas des
resultats. Les resultats ne sont publies qu'apres mesure. Ceci est une etude en
simulation, pas un jumeau numerique valide, pas une commande temps reel, pas une
sécurité certifiée.

## Organisation du depot

`matlab/` `simulink/` `coppeliasim/` `config/` `tests/` `results/` `docs/` `evidence/` `captures/`

## Autrice

Horacia Azonhoumon. Projet d'apprentissage personnel, eleve ingenieur.
Les outils tiers gardent leurs propres licences (MATLAB, CoppeliaSim Edu : non commercial).