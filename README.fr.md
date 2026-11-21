# RoboCell

[English](README.md) | Français

Cellule robotisée simulée de tri et de palettisation : un bras 6 axes (classe UR5)
modélisé dans MATLAB, commandé dans Simulink, intégré dans CoppeliaSim, puis supervisé
par une couche IIoT (OPC UA, MQTT, Modbus TCP, SCADA).

![statut](https://img.shields.io/badge/statut-en%20cours-orange)
![matlab](https://img.shields.io/badge/MATLAB-R2024b-blue)
![coppeliasim](https://img.shields.io/badge/CoppeliaSim-4.10%20Edu-green)
![licence](https://img.shields.io/badge/licence-MIT-lightgrey)

## Problème

Les lignes de conditionnement cosmétique en petite série traitent de nombreuses
références et de nombreux motifs d'empilage. La programmation en positions fixes est
lente à reconfigurer. RoboCell étudie trois difficultés dans un périmètre réduit et
vérifiable : la reconfiguration, la précision sous variation de charge, et la reprise
après interruption.

## Architecture

- **Banc A (Simulink) :** dynamique corps rigide, PD + gravité vs couple calculé, saturation.
- **Banc B (CoppeliaSim) :** convoyeur, palettes, collisions, logique de cellule, MATLAB via ZeroMQ.
- **Phase IIoT :** passerelle Python, OPC UA, MQTT (Mosquitto), Modbus TCP, SCADA Ignition,
  Node-RED, PostgreSQL. MATLAB reste le seul maître du mouvement.

## Méthode

Cycle en V avec missions incrémentales et portes G0 à G5. 54 exigences, 46 tests de
recette. Voir [docs/methodology.md](docs/methodology.md) et [docs/planning.md](docs/planning.md).

## Avancement

| Mission | Périmètre | Statut |
|---|---|---|
| M0 | Cadrage, méthode, planning | Terminé |
| M1 | Faisabilité (G0) | Terminé |
| M2 à M8 | Cœur robotique, tests T02-T34 | Planifié |
| M9 à M10 | Phase IIoT, tests T35-T46 | Planifié |

## Déclaration d'honnêteté

Tous les chiffres du cahier des charges sont des cibles d'acceptation, pas des
résultats. Les résultats ne sont publiés qu'après mesure. Ceci est une étude en
simulation, pas un jumeau numérique validé, pas une commande temps réel, pas une
sécurité certifiée.

## Organisation du dépôt

`matlab/` `simulink/` `coppeliasim/` `config/` `tests/` `results/` `docs/` `evidence/` `captures/`

## Autrice

Horacia Azonhoumon. Projet d'apprentissage personnel, élève ingénieur.
Les outils tiers gardent leurs propres licences (MATLAB, CoppeliaSim Edu : non commercial).