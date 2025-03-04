install.packages("metan")
library(metan)
install.packages("ggplot2")
library(ggplot2)
options(max.print = 10000)
############################### set wd ######################################
getwd()
############################## importing data ###############################
alpha <- read.csv("data_ALD.csv", header = T)
rbd <- read.csv("data_RBD.csv", header = T)
############################# factors with unique levels ####################
rbd$ENV <- factor(rbd$ENV, levels=unique(rbd$ENV))
rbd$GEN <- factor(rbd$GEN, levels=unique(rbd$GEN))
rbd$REP <- factor(rbd$REP, levels=unique(rbd$REP))
str(rbd)
###################### data inspection and manipulation #####################
inspect(rbd, plot=TRUE, threshold = 10000)
##################### check for outliers ###################################
find_outliers(rbd, var=YLD, plots=TRUE)
find_outliers(rbd, var=TGW, plots=TRUE)
inspect(data_ge, plot = TRUE)
desc_stat(rbd)
model <- performs_ammi(rbd,
                       env = ENV,
                       gen = GEN,
                       rep = REP,
                       resp = everything(),
                       verbose = FALSE)

get_model_data(model, "ipca_pval")
a <- plot_scores(model)
b <- plot_scores(model,
                 type = 2, # AMMI 2 biplot
                 polygon = TRUE, # show a polygon
                 highlight = c("G4", "G5", "G6"), #highlight genotypes
                 col.alpha.env = 0.5, # alpha for environments
                 col.alpha.gen = 0, # remove the other genotypes
                 col.env = "gray", # color for environment point
                 col.segm.env = "gray", # color for environment segment
                 plot_theme = theme_metan_minimal()) # theme
arrange_ggplot(a, b, tag_levels = "a")
