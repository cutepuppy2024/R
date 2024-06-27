library(stringr)

string1 <- c("Data12","daft","YouTube is fun","channel", "Wow are you a student")

str_length(string1)

str_length("abcde")

str_to_upper(string1)
str_to_lower(string1)
str_to_title(string1)
str_to_sentence(string1)

str_trim(" d! ")
str_pad("pad this", width=15,side="both")
str_trunc("hi how are you i am fine thank you and you?", width=30)

str_split("split this", pattern = " ")
str_c(c("join","this"), c("club","book"),sep=".")
str_c(c("turn","me"),collapse=" ")
str_replace_na(c("make",NA, "string"))

string2 <- c("sort","this","now")
str_order(string2)
str_sort(string2)

first <- c("joohyun","inna","sujin")
last <- c("jeon","ryu","kim")

str_glue("My name is {first}. {first} {last}")

data1 <- data.frame(author = c("kim", "banana","cereal"),
           message = c("apple was good but i like banana more, can i buy banana milk?", "the apple and the banana is great", "the cereal makes us healthy"))
data1

str_detect(data1$message, pattern = "banana")
idx <- str_which(data1$message, pattern = "banana")
data1$message[idx]

str_count(data1$message, "banana")
str_locate(data1$message, "banana")
str_locate_all(data1$message, "banana")
str_extract(data1$message, "banana|apple|the")

str_subset(data1$message, pattern = "banana")
str_sub(data1$message[1], start = 1, end = 5)<-str_to_upper(str_sub(data1$message[1], start = 1, end = 5))

str_replace(data1$message, pattern = "banana", replacement="kiwi")
str_replace_all(data1$message, pattern = "banana",replacement="kiwi")
