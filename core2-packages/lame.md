# LAME LIBMP3LAME
| debian pkg | flags |
| :--- | :--- |
| **lame** debian pkg | ```generic``` |
| **lame** build 2: debian pkg | ``` -O2 -march=core2 -mtune=core2 ``` |
| **lame** last build debian | ```O3 -march=core2 -mtune=core2 -ffast-math -funroll-loops``` |


Performance increases relative to baseline (4x):
- [ ] **lame** debian pkg  (4)
- [ ] **Build 2:** +27.5% speed increase (5.1 / 4 = 1.275)
- [x] **Last Build:** +50.0% speed increase (6.0 / 4 = 1.50)

_Gained 50% speed - that is insane!_
