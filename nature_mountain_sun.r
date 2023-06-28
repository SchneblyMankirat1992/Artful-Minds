# Load required libraries
library(dplyr)
library(ggplot2)
library(reshape2)

# Read in data
artful_minds <- read.csv("artful_minds_data.csv", header = T,
                         stringsAsFactors = F)

# Create a summary table
artful_minds_summary <- artful_minds %>%
  summarise(n_pre = n(),
            n_post = sum(post_code),
            n_ed = sum(ed_code),
            n_cert = sum(certificate_code))

# Visualize summary table
ggplot(data = artful_minds_summary) +
  geom_bar(aes(x = "", y = n_pre), stat = "identity") +
  geom_bar(aes(x = "", y = n_post, fill = "Post-Code"), 
           stat = "identity") +
  geom_bar(aes(x = "", y = n_ed, fill = "ED-Code"), 
           stat = "identity") +
  geom_bar(aes(x = "", y = n_cert, fill = "Certificate-Code"), 
           stat = "identity") +
  scale_fill_manual("", values = c("green", "red", "blue")) +
  ggtitle("Summary of Artful Minds Data") +
  labs(x = "", y = "Number of Responses")

# Create a table of pre and post-code responses
artful_minds_post_pre <- artful_minds %>%
  select(respondent_id, pre_code, post_code) %>%
  rename(pre = pre_code,
         post = post_code) %>%
  melt(id.vars = c("respondent_id"),
       value.name = "code")

# Visualize pre and post-code responses
ggplot(data = artful_minds_post_pre, 
       aes(x = respondent_id, y = code, fill = variable)) +
  geom_bar(stat="identity") +
  scale_fill_manual("Code Type", values = c("green", "red")) +
  ggtitle("Artful Minds Code Responses by Respondent") +
  labs(x = "Respondent ID", y = "Code Response")

# Create a table of ED-Code responses
artful_minds_ed <- artful_minds %>%
  select(respondent_id, ed_code) %>%
  rename(ed = ed_code) %>%
  melt(
    id.vars = c("respondent_id"),
    value.name = "code"
  )

# Visualize ED-Code responses
ggplot(data = artful_minds_ed, 
       aes(x = respondent_id, y = code, fill = variable)) +
  geom_bar(stat="identity") +
  scale_fill_manual("Code Type", values = c("blue")) +
  ggtitle("Artful Minds ED-Code Responses by Respondent") +
  labs(x = "Respondent ID", y = "Code Response")

# Create a table of certificate-Code responses
artful_minds_cert <- artful_minds %>%
  select(respondent_id, certificate_code) %>%
  rename(certificate = certificate_code) %>%
  melt(
    id.vars = c("respondent_id"),
    value.name = "code"
  )

# Visualize certificate-Code responses
ggplot(data = artful_minds_cert, 
       aes(x = respondent_id, y = code, fill = variable)) +
  geom_bar(stat="identity") +
  scale_fill_manual("Code Type", values = c("red")) +
  ggtitle("Artful Minds Certificate-Code Responses by Respondent") +
  labs(x = "Respondent ID", y = "Code Response")


# Create a table of overall code responses
artful_minds_all <- artful_minds %>%
  select(respondent_id, pre_code, post_code, ed_code, certificate_code) %>%
  gather(Key, Code, 
         pre_code:certificate_code,
         na.rm = T)

# Visualize overall code responses
ggplot(data = artful_minds_all, 
       aes(x = respondent_id, y = Code, fill = Key)) +
  geom_bar(stat="identity") +
  scale_fill_manual("Code Type", values = c("green", "blue", "red")) +
  ggtitle("Artful Minds Responses by Respondent") +
  labs(x = "Respondent ID", y = "Code Response")