# Project plan (baseline v1)

Assumption: 10 h per week, start Monday 23 November 2026. Dates are targets and
are adjusted at each weekly review (baseline stays untouched, replans are v2, v3).

```mermaid
gantt
    title RoboCell baseline v1
    dateFormat YYYY-MM-DD
    axisFormat %d %b
    section Robotics core
    M0 Setup and method       :m0, 2026-11-23, 7d
    M1 Feasibility G0         :crit, m1, after m0, 14d
    G0                        :milestone, after m1, 0d
    M2 Model 6 axes G1        :m2, after m1, 21d
    G1                        :milestone, after m2, 0d
    M3 Trajectories G2        :m3, after m2, 21d
    G2                        :milestone, after m3, 0d
    M4 Simulink control G3    :crit, m4, after m3, 28d
    G3                        :milestone, after m4, 0d
    M5 Scene and interface    :m5, after m4, 14d
    M6 Cell and incidents G4  :crit, m6, after m5, 14d
    G4                        :milestone, after m6, 0d
    M7 Business utility       :m7, after m6, 14d
    M8 Acceptance G5          :m8, after m7, 35d
    G5                        :milestone, after m8, 0d
    section IIoT phase
    M9 IIoT build             :crit, m9, after m8, 49d
    M10 IIoT acceptance G6    :m10, after m9, 21d
    G6 and final report       :milestone, after m10, 0d
```

| Mission | Effort (h) | Target end |
|---|---|---|
| M0 | 6 | 29 Nov 2026 |
| M1 | 14 | 13 Dec 2026 |
| M2 | 25 | 3 Jan 2027 |
| M3 | 22 | 24 Jan 2027 |
| M4 | 34 | 21 Feb 2027 |
| M5 | 16 | 7 Mar 2027 |
| M6 | 16 | 21 Mar 2027 |
| M7 | 12 | 4 Apr 2027 |
| M8 | 27 + 16 reserve | 9 May 2027 |
| M9 | about 59 | 27 Jun 2027 |
| M10 | about 16 + report | 18 Jul 2027 |

## Weekly review routine (Sunday, 20 minutes)
1. Fill docs/time-log.csv (date, mission, hours, note).
2. Compute PV, EV, AC, SPI, CPI.
3. Update status in requirements.csv and README.
4. If SPI is below 0.85 two weeks in a row: use reserve or cut scope, write the decision here.