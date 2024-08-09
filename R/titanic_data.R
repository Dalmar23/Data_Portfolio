# Installing and Loading Necessary Packages
install.packages("dplyr")
library(dplyr)
# Reading CSV into a dataframe 
titanic_data <- read.csv("Titanic-Dataset.csv")
# Looking at dataframe in spreadsheet view
View(titanic_data)
# run summary stats on dataframe
summary(titanic_data)
# look at structure of dataframe
str(titanic_data)

# Fill missings values for Age with the median
titanic_data <- titanic_data %>% mutate(Age = ifelse(is.na(Age), median(Age, na.rm = TRUE), Age)) 

# Remove rows with missing Embarked Values
titanic_data <- titanic_data %>% filter(!is.na(Embarked))
num_blank_embarked <- sum(titanic_data$Embarked == "")
num_blank_embarked
titanic_data <- titanic_data %>%  filter(Embarked != "")
num_blank_embarked
# Drop the Cabin Column
titanic_data <- titanic_data %>% select(-Cabin)

# Convert relevant columns to appropriate data types
titanic_data <- titanic_data %>% mutate(Survived = as.factor(Survived), Pclass = as.factor(Pclass), Sex = as.factor(Sex), Embarked = as.factor(Embarked)) 

# Save my cleaned data to a new file
write.csv(titanic_data, "cleaned_titanic_data.csv", row.names = FALSE)

install.packages("ggplot2")
library(ggplot2)
ggplot(titanic_data, aes(x = as.factor(Survived), y = Age)) +
  geom_boxplot() +
  xlab("Survived") +
  ylab("fare") +
  ggtitle("Age Distribution by Survival Status")

ggplot(titanic_data, aes(x = as.factor(Survived))) +
  geom_bar() +
  xlab("Survived") +
  ylab("Count") +
  ggtitle("Count of Survived Passengers")

ggplot(titanic_data, aes(x = Age, y = Fare)) +
  geom_point(color = "blue") +
  xlab("Age") +
  ylab("Fare") +
  ggtitle("Scatter Plot of Age vs. Fare")
