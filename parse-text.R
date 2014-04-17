library(qdap)
library(koRpus)
library(textcat)


source('db-functions.R')
filenames = calibreGetFilenames()

for (i in 1:1) {
  file = print(filenames$filename[i])
  
  # collect raw text
  raw_text = substr(readChar(file, file.info(file)$size),1,10000)
  
  # tag the text
  tagged.text = tokenize(raw_text, format="obj", lang='en')
  
  # Hypenate the text
  # set the next line to activate caching, if this application is run on a shiny server
  #set.kRp.env(hyph.cache.file=file.path("/var","shiny-server","cache","koRpus",paste("hyph.cache.",input$lang,".rdata", sep="")))
  hyphenated.text = hyphen(tagged.text, quiet=TRUE)
  
  # Language Detection
  textcat(raw_text)  
  
  tagged.text@desc$all.chars
  tagged.text@desc$normalized.space
  tagged.text@desc$chars.no.space 
  tagged.text@desc$letters.only
  tagged.text@desc$lines
  tagged.text@desc$punct
  tagged.text@desc$digits
  tagged.text@desc$words
  tagged.text@desc$sentences
  tagged.text@desc$avg.sentc.length
  tagged.text@desc$avg.word.length
  tagged.text@desc$words
  tagged.text@desc$sentences
  tagged.text@desc$avg.sentc.length
  tagged.text@desc$avg.word.length
  tagged.text@desc$letters
  tagged.text@desc$char.distrib
  tagged.text@desc$lttr.distrib
  
  hyphenated.text@desc$num.syll
  hyphenated.text@desc$avg.syll.word
  hyphenated.text@desc$syll.distrib
  hyphenated.text@desc$syll.unique.distrib
  hyphenated.text@desc$syll.per100
  
  # Lexical diversity
  ex.div(tagged.text(), segment=input$LD.segment, factor.size=input$LD.factor, min.tokens=input$LD.minTokens,
         rand.sample=input$LD.random, window=input$LD.window, case.sens=input$LD.caseSens, detailed=FALSE, char=c(), quiet=TRUE))
  
}




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