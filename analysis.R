require(plyr)
require(ggplot2)
require(sqldf)

data <- read.csv("data.csv", header=TRUE)

schools <- na.omit(sqldf("SELECT school, count(school) FROM data GROUP BY school ORDER BY count(school) desc"))
genders <- na.omit(sqldf("SELECT gender, count(gender) FROM data GROUP BY gender ORDER BY count(gender) desc"))
ages <- na.omit(sqldf("SELECT age, count(age) FROM data GROUP BY age ORDER BY count(age) desc"))
majors <- na.omit(sqldf("SELECT major, count(major) FROM data GROUP BY major ORDER BY count(major) desc"))
minors <- na.omit(sqldf("SELECT minor, count(minor) FROM data GROUP BY minor ORDER BY count(minor) desc"))
credits <- na.omit(sqldf("SELECT credits_registered_for, count(credits_registered_for) FROM data GROUP BY credits_registered_for ORDER BY count(credits_registered_for) desc"))

stressed <- na.omit(sqldf("SELECT more_stressed, count(more_stressed) FROM data GROUP BY more_stressed ORDER BY count(more_stressed) desc"))
work_harder <- na.omit(sqldf("SELECT work_harder, count(work_harder) FROM data GROUP BY work_harder ORDER BY count(work_harder) desc"))
major_harder <- na.omit(sqldf("SELECT major_harder, count(major_harder) FROM data GROUP BY major_harder ORDER BY count(major_harder) desc")) 

hours_slept <- na.omit(sqldf("SELECT hours_slept_recently, count(hours_slept_recently) FROM data GROUP BY hours_slept_recently ORDER BY count(hours_slept_recently) desc")) 
skipped_class <- na.omit(sqldf("SELECT skipped_class, count(skipped_class) FROM data GROUP BY skipped_class ORDER BY count(skipped_class) desc")) 

df_data <- data.frame(data)

# histogram of ages in participants
# ggplot(data = df_data) + geom_histogram(aes(x = data$age))
# # histogram of credits in participants
# ggplot(data = df_data) + geom_histogram(aes(x = data$credits_registered_for))
# # histogram of majors of participants
# ggplot(data = df_data) + geom_histogram(aes(x = data$major)) + coord_flip() + theme(axis.text.y = element_text(hjust=0.5, size=6, colour="black"))
# # minors
# ggplot(data = df_data) + geom_histogram(aes(x = data$minor)) + coord_flip() + theme(axis.text.y = element_text(hjust=0.5, size=6, colour="black"))	

