library("RSQLite")

drv <- dbDriver("SQLite")
con <- dbConnect(drv, "/Users/mich/Calibre Library/metadata.db")

calibreGetFilenames <- function (connection = con) {
  data = dbGetQuery(connection, 
                    "SELECT 
                    books.id,
                    books.title, 
                    books.author_sort AS authors, 
                    '/Users/mich/Calibre Library/' || books.path || '/' ||data.name || '.' || data.format AS filename, 
                    identifiers.val
                    FROM books INNER JOIN data ON books.id = data.book
                    INNER JOIN identifiers ON books.id = identifiers.book
                    WHERE data.format = 'TXT' and identifiers.type = 'isbn' ")
  return(data)
}

