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

#turn data into df to make histograms
df_data <- data.frame(data)
# histogram of ages in participants
# ggplot(data = df_data) + geom_histogram(aes(x = data$age))
# # histogram of credits in participants
# ggplot(data = df_data) + geom_histogram(aes(x = data$credits_registered_for))
# # histogram of majors of participants
# ggplot(data = df_data) + geom_histogram(aes(x = data$major)) + coord_flip() + theme(axis.text.y = element_text(hjust=0.5, size=6, colour="black"))
# # minors
# ggplot(data = df_data) + geom_histogram(aes(x = data$minor)) + coord_flip() + theme(axis.text.y = element_text(hjust=0.5, size=6, colour="black"))	

######################## REPLACEMENTS IN DATA ########################
#     "Agree" = 1
#     "Disagree" = -1
#     "Unsure" = 0

# "40 or more" in extracurricular hours/week is turned into just 40
#######################################################################

data$extra_hours <- as.numeric(gsub("40 or more", 40, data$extra_hours))
data$hours_slept_recently <- as.numeric(data$hours_slept_recently)
data$credits_registered_for <- as.numeric(data$credits_registered_for)
cor(data$extra_hours, data$credits_registered_for)
# -0.06354762
cor(data$credits_registered_for, data$hours_slept_recently)
# -0.04722214

# "My major is harder than the average major."
data$major_harder <- gsub("Agree", 1, data$major_harder)
data$major_harder <- gsub("Disagree", -1, data$major_harder)
data$major_harder <- as.numeric(gsub("Unsure", 0, data$major_harder))
cor(data$extra_hours, data$major_harder)
# -0.06803745 NEGATIVELY correlated??
cor(data$hours_slept_recently, data$major_harder)
# -0.04646655
cor(data$credits_registered_for, data$major_harder)
# 0.1661509 POSITIVELY CORRELATED

#######################################################################

# "I work harder than the average Columbia student."
data$work_harder <- gsub("Agree", 1, data$work_harder)
data$work_harder <- gsub("Disagree", -1, data$work_harder)
data$work_harder <- as.numeric(gsub("Unsure", 0, data$work_harder))
cor(data$extra_hours, data$work_harder) # with extracurriculars
# 0.01824176 POSITIVELY CORRELATED
cor(data$hours_slept_recently, data$work_harder) # with hours slept
# -0.06615118
cor(data$credits_registered_for, data$work_harder) # with registering for credits
# 0.128383 (SIGNIFICANTLY more POSITIVELY correlated than before!)
cor(data$major_harder, data$work_harder) # with thinking they have a harder major
# 0.2941092 (EVEN MORE CORRELATED)

#######################################################################

# "Columbia undergraduate students have more work than undergraduates at other Ivy League Schools." 
data$more_stressed <- gsub("Agree", 1, data$more_stressed)
data$more_stressed <- gsub("Disagree", -1, data$more_stressed)
data$more_stressed <- as.numeric(gsub("Unsure", 0, data$more_stressed))
cor(data$extra_hours, data$more_stressed) # with extracurriculars
# -0.01487181 NEGATIVELY CORRELATED
cor(data$hours_slept_recently, data$more_stressed) # with hours slept
# -0.01238693
cor(data$credits_registered_for, data$more_stressed) # with registering for credits
# 0.07858558 (WHOA! FIRST MAYBE-SIGNIFICANT/CLOSELY LINEAR CORRELATION)
plot(data$credits_registered_for,data$more_stressed, pch=".")
lines(abline(lm(data$more_stressed~data$credits_registered_for)))

cor(data$major_harder, data$more_stressed) # with thinking they have a harder major
# 0.1481981
cor(data$work_harder, data$more_stressed) # with thinking they have a harder major
# 0.2099383

#######################################################################

# "I need more sleep than the average Columbia student does"
data$need_more_sleep <- gsub("Agree", 1, data$need_more_sleep)
data$need_more_sleep <- gsub("Disagree", -1, data$need_more_sleep)
data$need_more_sleep <- as.numeric(gsub("Unsure", 0, data$need_more_sleep))
cor(data$extra_hours, data$need_more_sleep) # with extracurriculars
# 0.02399717
cor(data$hours_slept_recently, data$need_more_sleep) # with hours slept
# 0.02810527
cor(data$credits_registered_for, data$need_more_sleep) # with registering for credits
# -0.1063192
cor(data$major_harder, data$need_more_sleep) # with thinking they have a harder major
# 0.02211552
cor(data$work_harder, data$need_more_sleep) # with thinking they have a harder major
# -0.05736443
cor(data$more_stressed, data$need_more_sleep)
# 0.02085614

