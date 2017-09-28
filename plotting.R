library(wordcloud2)
library(jsonlite)
library(htmlwidgets)
lyrics_raw = read_json('lyrics.json')
lyrics_vec = c()
for(i in 1:length(lyrics_raw)){

  curr_lyrics_vec = strsplit(lyrics_raw[[i]], ' ')[[1]]
  curr_lyrics_vec = gsub('[[:punct:]]', '', tolower(curr_lyrics_vec))

  lyrics_vec = append(lyrics_vec, curr_lyrics_vec)

}

sorted_lyrics = sort(table(lyrics_vec), decreasing = TRUE)

lyrics_df <- data.frame('word' = names(sorted_lyrics),
                        'freq' = as.integer(sorted_lyrics))

# The first twenty or so words are unimportant anyway
lyrics_df <- lyrics_df[-c(1:20),]
cloud = wordcloud2(lyrics_df, figPath = 'yrn-silhouette.jpg',
                   backgroundColor = 'black', shuffle = FALSE, color = 'gold',
                   size = 0.5)

saveWidget(cloud,"cloud.html",selfcontained = F)
