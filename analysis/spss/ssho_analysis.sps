* Encoding: UTF-8.
* Salomi (2025), Social Sciences & Humanities Open, 12, 102136.
* Consolidated SPSS syntax (SPSS 28.0.1.1) for the analyses reported in the paper.
* Assembled from working syntax files used Dec 2022 - Mar 2023; the T-TEST and composite
* COMPUTE commands below were written out here for completeness.
* Analysis file: cleaned data, N = 340 (not included; available on request).
* Condition: 1 = Inoculation (I), 2 = Misinformation (M), 3 = Control (C).

* ---- Reverse-code malpractice items (EP1_4, 6, 7, 8, 10, 11) ----.
RECODE EP1_4 EP1_6 EP1_7 EP1_8 EP1_10 EP1_11 (1=5) (2=4) (3=3) (4=2) (5=1)
  INTO REP1_4 REP1_6 REP1_7 REP1_8 REP1_10 REP1_11.
EXECUTE.

* ---- Scale composites (stored in the file as ElectionSecurityBelief / ElectionMalpracticeBelief) ----.
COMPUTE ElectionSecurityBelief=MEAN(EP1_1,EP1_2,EP1_3,EP1_5,EP1_9).
COMPUTE ElectionMalpracticeBelief=MEAN(REP1_4,REP1_6,REP1_7,REP1_8,REP1_10,REP1_11).
* Perceived truthfulness of the five misinformation messages ("This information is true");
* reported in the paper as misinformation identification ability. Higher = rated as more true.
COMPUTE Truthfulness=MEAN(Q2_1,Q2_1.0,Q2_1.1,Q2_1.2,Q2_1.3).
COMPUTE ShareWillingness=MEAN(Q2_3,Q2_3.0,Q2_3.1,Q2_3.2,Q2_3.3).
EXECUTE.

* ---- Reliability ----.
RELIABILITY /VARIABLES=EP1_1 EP1_2 EP1_3 EP1_5 EP1_9 REP1_4 REP1_6 REP1_7 REP1_8 REP1_10 REP1_11
  /SCALE('ALL VARIABLES') ALL /MODEL=ALPHA.
RELIABILITY /VARIABLES=Q2_1 Q2_1.0 Q2_1.1 Q2_1.2 Q2_1.3 /SCALE('Truthfulness') ALL /MODEL=ALPHA.
RELIABILITY /VARIABLES=Q2_3 Q2_3.0 Q2_3.1 Q2_3.2 Q2_3.3 /SCALE('Sharing') ALL /MODEL=ALPHA.

* ---- H1-H3: one-way ANOVAs across the three conditions ----.
ONEWAY ElectionSecurityBelief ElectionMalpracticeBelief VB2 VI1_2 VI1_1 BY Condition
  /STATISTICS DESCRIPTIVES
  /MISSING ANALYSIS
  /POSTHOC=TUKEY ALPHA(0.05).

* ---- H4-H6: Conditions 1 and 2 only (N = 229) ----.
USE ALL.
COMPUTE filter_$=(Condition < 3).
FILTER BY filter_$.
T-TEST GROUPS=Condition(1 2)
  /VARIABLES=Truthfulness ShareWillingness
  /CRITERIA=CI(.95).
CORRELATIONS /VARIABLES=Truthfulness ShareWillingness
  /PRINT=TWOTAIL NOSIG /MISSING=PAIRWISE.
FILTER OFF.
USE ALL.

* ---- H7-H8 and ideology: correlations (full sample) ----.
CORRELATIONS /VARIABLES=ElectionSecurityBelief ElectionMalpracticeBelief VB2 VI1_2 A6
  /PRINT=TWOTAIL NOSIG /STATISTICS DESCRIPTIVES /MISSING=PAIRWISE.
