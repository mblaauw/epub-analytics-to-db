library(tm)
library(reshape2)
getSentiment <- function (input_text, book_title) {
  
  
  sentiment.file <- "../dutch-text-analytics/data/NL_AFINN-111.txt"
  book.label <- book_title
  
  # LOAD Sentiment words to matrix
  df.sentiments <- read.table(sentiment.file,header=F,sep="\t",quote="",col.names=c("term","score"))
  df.sentiments$term <- gsub("[^[:alnum:]]", " ",df.sentiments$term)
  
  # Build Scoring functions
  ScoreTerm <- function(term){
    df.sentiments[match(term,df.sentiments[,"term"]),"score"]
  }
  ScoreText <- function(text){
    text <- tolower(gsub("[^[:alnum:]]", " ",text))
    text <- do.call(c,strsplit(text," "))
    text <- text[text!=""]
    scores <- ScoreTerm(text)
    scores[is.na(scores)] <- 0
    scores
  }
  RollUpScores <-function(scores, parts=100){
    batch.size <- length(scores)/parts
    
    s <- sapply(seq(batch.size/2, length(scores) - batch.size/2, batch.size), function(x){
      low  <- x - (batch.size/2)
      high <- x + (batch.size/2)
      mean(scores[low:high])
    })
    s
  }
  
  # reshape scores 
  scores <- ScoreText(input_text)
  percent.scores <- as.data.frame(RollUpScores(scores))
  colnames(percent.scores)<-book.label
  percent.scores$percent <- 1:nrow(percent.scores)
  escores <- melt(percent.scores,"percent",book.label,variable.name="book",value.name="sentiment")

  return(escores)
  
  
}



