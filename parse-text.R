library(qdap)
library(koRpus)
library(textcat)

source('sentiment-functions.R')
source('db-functions.R')
filenames = calibreGetFilenames()

for (i in 1:1) {
  file = print(filenames$filename[i])
  
  # collect raw text
  #raw_text = substr(readChar(file, file.info(file)$size),1,10000)
  raw_text = substr(readChar(file, file.info(file)$size),1,30000)
  
  
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
  #lex.div(tagged.text, segment=input$LD.segment, factor.size=input$LD.factor, min.tokens=input$LD.minTokens,
  #       rand.sample=input$LD.random, window=input$LD.window, case.sens=input$LD.caseSens, detailed=FALSE, char=c(), quiet=TRUE))

  r_measures = c("TTR", "MSTTR", "MATTR", "C", "R", "CTTR","U", "S", "K", "Maas", "HD-D", "MTLD")
  lexdiv.scores = lex.div(tagged.text, keep.tokens = T,  measure = r_measures, char = r_measures)
  summary(lexdiv.scores)
  
  # readability
  readability.scores = readability(tagged.text, hyphen=hyphenated.text,  quiet=TRUE, factor.size = 0.5)
  summary(readability.scores)

  # sentiment
  sentiment.scores = getSentiment(input_text = raw_text,book_title = filenames$title[i])
  
  # Create base plot
  plot.sentiment<- ggplot(sentiment.scores, aes(x = percent, y = sentiment, color='#DB0049')  )
  
  # detail plot
  print(plot.sentiment + geom_point() + 
          stat_smooth(method="loess",span=0.1) + 
          geom_hline() + theme_bw() + 
          theme(legend.position="none") + 
          opts(panel.background = theme_rect(fill='#F5F5F5'),
               plot.background = element_rect(fill='#F5F5F5')))
  
  
}
