library(qdap)

AR1 <- with(rajSPLIT, automated_readability_index(dialogue, list(person, act)))
htruncdf(AR1,, 15)
AR2 <- with(rajSPLIT, automated_readability_index(dialogue, list(sex, fam.aff)))
htruncdf(AR2,, 15)

CL1 <- with(rajSPLIT, coleman_liau(dialogue, list(person, act)))
head(CL1)
CL2 <- with(rajSPLIT, coleman_liau(dialogue, list(sex, fam.aff)))
head(CL2)

SM1 <- with(rajSPLIT, SMOG(dialogue, list(person, act)))
head(SM1)
SM2 <- with(rajSPLIT, SMOG(dialogue, list(sex, fam.aff)))
head(SM2)

FL1 <- with(rajSPLIT, flesch_kincaid(dialogue, list(person, act)))
head(FL1)
FL2 <-  with(rajSPLIT, flesch_kincaid(dialogue, list(sex, fam.aff)))
head(FL2)

FR <- with(rajSPLIT, fry(dialogue, list(sex, fam.aff)))
htruncdf(FR$SENTENCES_USED)
head(FR$SENTENCE_AVERAGES)

LW1 <- with(rajSPLIT, linsear_write(dialogue, list(person, act)))
head(LW1)
LW2 <- with(rajSPLIT, linsear_write(dialogue, list(sex, fam.aff)))
head(LW2)