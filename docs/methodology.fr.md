# Méthodologie

## Choix : cycle en V avec missions incrémentales et portes

Branche gauche (définition) : exigences F/N, architecture (banc A, banc B, passerelle),
conception détaillée (cinématique, trajectoires, lois de commande).
Branche droite (vérification) : tests unitaires, tests d'intégration, tests de recette
T01-T46. Chaque exigence F a exactement un test de recette (voir requirements.csv).

Pourquoi pas la cascade pure : les risques techniques (disponibilité des toolboxes,
pas-à-pas ZeroMQ, intégration de la dynamique Simulink) doivent être traités en
premier. La porte G0 s'en charge.
Pourquoi pas un Agile pur : les exigences sont figées et définies par un test dans le
cahier des charges.

## Portes
| Porte | Signification | Preuve |
|---|---|---|
| G0 | Faisabilité | Licences, lien, dynamique simple, conventions |
| G1 | Modèle | Géométrie cohérente, IK, poses comparées |
| G2 | Trajectoires | Références valides pour toutes les cibles de palette |
| G3 | Commande | Deux lois, campagne dynamique reproductible |
| G4 | Cellule | Lot complet, incidents, journaux |
| G5 | Recette | T01-T34, résultats, vidéo, guide |
| G6 | Connecté | T35-T46, preuves de communication et de reprise |

## Definition of Done (par étape)
1. Résultat reproductible depuis le dépôt.
2. Preuve sauvegardée (figure, journal ou capture).
3. Statut de l'exigence mis à jour dans requirements.csv.
4. Documentation mise à jour.
5. Commit avec un message clair.

## Journal des risques (initial)
| Risque | Impact | Mitigation |
|---|---|---|
| Intégration Simulink / Robotics Toolbox échoue | Élevé | Prouver à G0, repli sur 2 axes |
| Pas-à-pas ZeroMQ instable | Élevé | Prouver à G0, versions figées |
| Effort sous-estimé | Moyen | Réserve de 14-18 h, revue hebdomadaire |
| Dérive des versions d'outils | Moyen | Figer les versions dans un manifeste |