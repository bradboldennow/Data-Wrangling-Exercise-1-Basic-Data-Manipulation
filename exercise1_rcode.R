library(dplyr)
library(tidyr)

# Clean up brand names
refine_orignial$company[1:6] = 'philips'
refine_orignial$company[7:13] = 'akzo'
refine_orignial$company[14:16] = 'philips'
refine_orignial$company[17:21] = 'van houten'
refine_orignial$company[22:25] = 'unilever'

# Separate product code and number
refine_orignal =  separate(refine_orignial, `Product code / number `, c("product_code", "product_number"))

# Add product categories
products = c(p = "Smartphone", v = "TV", x = "Laptop", q = "Tablet")
refine_original = mutate(refine_orignial, product_category = products[product_code])

# Add full address for geocoding
refine_original = unite(refine_original, "full_address", address, city, country, sep = ", ")

# Create dummy variables for company and product category
refine_original = refine_original %>% mutate(company_phillips = ifelse(refine_original$company=="philips", 1, 0))
refine_original = refine_original %>% mutate(company_akzo = ifelse(refine_original$company=="akzo", 1, 0))
refine_original = refine_original %>% mutate(company_unilever = ifelse(refine_original$company=="unilever", 1, 0))
refine_original = refine_original %>% mutate(company_vanhouten = ifelse(refine_original$company=="van houten", 1, 0))
refine_original = refine_original %>% mutate(product_smartphone = ifelse(refine_original$product_category=="Smartphone", 1, 0))
refine_original = refine_original %>% mutate(product_tv = ifelse(refine_original$product_category=="TV", 1, 0))
refine_original = refine_original %>% mutate(product_laptop = ifelse(refine_original$product_category=="Laptop", 1, 0))
refine_original = refine_original %>% mutate(product_tablet = ifelse(refine_original$product_category=="Tablet", 1, 0))

refine_clean = refine_original
head(refine_clean)

write.csv(refine_clean, file = "refine_clean.csv")
