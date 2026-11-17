# Optional R reproduction of the results in Salomi (2025), SSHO 12, 102136.
# The analyses reported in the paper were run in SPSS 28.0.1.1 (see analysis/spss/).
# This script is provided for readers without SPSS. Data are not included (available on request).
# Requires: haven.  Place the analysis file at data/ssho_analysis_file.sav

library(haven)
d <- read_sav("data/ssho_analysis_file.sav")
d$Condition <- as.numeric(d$Condition)

alpha <- function(x) {                       # Cronbach's alpha, listwise
  x <- na.omit(as.data.frame(x)); k <- ncol(x)
  k / (k - 1) * (1 - sum(apply(x, 2, var)) / var(rowSums(x)))
}
rmean <- function(x) { m <- rowMeans(x, na.rm = TRUE); m[is.nan(m)] <- NA; m }

# ---- Composites ----
sec  <- c("EP1_1","EP1_2","EP1_3","EP1_5","EP1_9")
mal  <- c("REP1_4","REP1_6","REP1_7","REP1_8","REP1_10","REP1_11")  # reverse-coded 4,6,7,8,10,11
tru  <- c("Q2_1","Q2_1.0","Q2_1.1","Q2_1.2","Q2_1.3")   # "This information is true"
shr  <- c("Q2_3","Q2_3.0","Q2_3.1","Q2_3.2","Q2_3.3")   # "I would share this information..."
d$Truthfulness     <- rmean(d[, tru])   # reported in the paper as "identification ability"; higher = rated more true
d$ShareWillingness <- rmean(d[, shr])

cat("Alpha, 11 election items:", round(alpha(d[, c(sec, mal)]), 3), "(SPSS: .844)\n")
cat("Alpha, truthfulness:", round(alpha(d[d$Condition < 3, tru]), 3), "(.75)\n")
cat("Alpha, sharing:", round(alpha(d[d$Condition < 3, shr]), 3), "(.873)\n")

# ---- H1-H3: one-way ANOVAs (expected F: .199, .165, .029, 2.239) ----
for (v in c("ElectionSecurityBelief","ElectionMalpracticeBelief","VB2","VI1_2")) {
  f <- summary(aov(d[[v]] ~ factor(d$Condition)))[[1]]
  cat(sprintf("ANOVA %-26s F(%d,%d) = %.3f, p = %.3f\n", v, f$Df[1], f$Df[2], f$`F value`[1], f$`Pr(>F)`[1]))
}

# ---- H4-H5: t-tests, Conditions 1 vs 2 ----
g <- subset(d, Condition < 3)
# paper: Welch t(206.44) = -1.84, p = .067 for truthfulness; t(225) = -1.07, p = .287 for sharing
print(t.test(Truthfulness     ~ Condition, data = g, var.equal = FALSE))
print(t.test(ShareWillingness ~ Condition, data = g, var.equal = TRUE))

# ---- H6-H8: correlations, pairwise deletion ----
ct <- function(a, b) { r <- cor.test(a, b, use = "pairwise.complete.obs")
  cat(sprintf("r = %.3f, N = %d, p = %.3f\n", r$estimate, r$parameter + 2, r$p.value)) }
ct(g$Truthfulness, g$ShareWillingness)                      # .596, N = 229 in paper
ct(d$ElectionSecurityBelief, d$VI1_2)                       # .195
ct(d$ElectionSecurityBelief, d$VB2)                         # -.021
ct(d$ElectionMalpracticeBelief, d$VI1_2)                    # -.067
ct(d$ElectionMalpracticeBelief, d$VB2)                      # -.040
ct(d$ElectionSecurityBelief, d$ElectionMalpracticeBelief)   # -.493
ct(d$ElectionMalpracticeBelief, d$A6)                       # .165 (ideology)
