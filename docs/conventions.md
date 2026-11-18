# Conventions

## Units (N01)
SI only: meters, radians, seconds, kg, N.m. Display in degrees or mm only in plots.

## Frames
W world, B base, F flange, T TCP, C pick, P_A and P_B pallets.
A_T_B maps coordinates expressed in B into A. Same suffix and direction everywhere.
Homogeneous transforms are 4x4. Joint vector q = [q1 ... q6] in rad.

## Git
- main is always in a working state.
- One branch per mission: mission/mXX-short-name.
- One commit per finished step. Conventional Commits in English.
- Merge by Pull Request (merge commit, to keep step history).
- Tag at each gate: g0-feasibility, g1-model, etc.

## Languages
Code, comments, commit messages, issues: English.
README and methodology: English plus French version (*.fr.md).

## Naming
MATLAB functions: lowerCamelCase. Files: snake_case.m for scripts.
Run identifiers: run_YYYYMMDD_HHMM. Results never overwrite: one folder per run_id.

## Evidence rules
No claim without a measured result (N08). Simulated results are labelled as such.
Secrets, certificates, licensed files are never committed (N07).

## Typography
No long dashes (em or en dash) in files or exchanges. Use hyphen, colon or comma.