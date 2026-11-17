# Prebunking, election security perceptions, and voting intentions

Analysis materials for:

Salomi, V. (2025). Prebunking misinformation, perceptions about electoral security, and voting intentions: A quantitative study. *Social Sciences & Humanities Open, 12*, 102136. https://doi.org/10.1016/j.ssaho.2025.102136

Sole-authored study: survey experiment (N = 340 undergraduates; Inoculation, Misinformation and Control conditions), fielded on Qualtrics Nov 8 to Dec 5, 2022.

## Data availability
Data are not included in this repository. In line with the paper's data availability statement, partial data (with identifiable information removed) are available from the author upon request.

## Contents
| Path | What it is |
|---|---|
| `analysis/spss/ssho_analysis.sps` | SPSS syntax for the reported analyses (the paper's analyses were run in SPSS 28.0.1.1) |
| `analysis/r/reproduce_results.R` | Optional R version for readers without SPSS; expected values are in the comments |
| `output/` | Final SPSS output (March 2023): `1_scales_reliability_anova.pdf`, `2_correlations_ttests.pdf`, `3_ttests_n229.pdf`. Tables were extracted from the original `.spv` files; values are unchanged, layout is reformatted |
| `codebook/variables.csv` | Variable names and survey wording |
| `materials/qualtrics_survey_instrument.pdf` | The survey instrument |

## Variable note
The composite described in the paper as "misinformation identification ability" is the mean of the item "This information is true" across the five misinformation messages (higher = rated as more true). The syntax calls it `Truthfulness`.

## Contact
Vithika Salomi, Georgia State University. Data requests: see the contact details on the paper.
