libs<-c("data.table",'stargazer', 'AICcmodavg', 'ggplot2','RColorBrewer','lme4','pwr','MuMIn','nlme')
lapply(libs, require, character.only = TRUE)

      ###Statistical Analyses
DTpiles<-readRDS("Input/pile_format.rds")
DTtrials<-readRDS("Input/trial_format.rds")
DTtraps<-readRDS("Input/all_trap_locs.rds")

#clean DTtraps for summary stats

DTtraps<-DTtraps[!Sampling=="Interpolated"]

#summary stats from nutrient sampling
#for nitrogen
DTtraps[,mean(N)]
DTtraps[,max(N)]
DTtraps[,min(N)]
DTtraps[,sd(N)]
#for phosphorus
DTtraps[,mean(P)]
DTtraps[,max(P)]
DTtraps[,min(P)]
DTtraps[,sd(P)]

#correlation between DTtraps nitrogen and DTtraps phosphorus
cor(DTtraps$N, DTtraps$P)
summary(lm(DTtraps$P ~ DTtraps$N))

#Summary info for cafeteria experiments
unique(DTpiles$Date) #summary of experiment dates
unique(DTpiles$Eartag) #summary of individuals
max(DTpiles$Low_temp) #max lowest temp
min(DTpiles$Low_temp) #min lowest temp
summary(lme(Eaten~Side,random=~1|sampleID, data=DTpiles)) #test that side doesn't matter

DTtrials[, mean(TotalEaten)]
DTtrials[, sd(TotalEaten)]

DTpiles[, mean(Total), by=Treatment]
DTpiles[, sd(Total), by=Treatment]


#First, run the basic model, just DTtraps nutrient treatment
ModelBasic<-lmer(Eaten ~ Treatment + (1|sampleID), REML=F, data=DTpiles)
summary(ModelBasic)
r.squaredGLMM(ModelBasic)

#correlations to check for overlap between hypothesis testing
cor(DTtrials$White, DTtrials$N)
cor(DTtrials$Low_temp, DTtrials$N)
cor(DTtrials$White, DTtrials$P)
cor(DTtrials$Low_temp, DTtrials$P)


                      #### Feeding AIC ####

Choice.Mod<-list()

#1 = Null model
Choice.Mod[[1]]<-lmer(Total ~ 1 + (1|sampleID), REML=F, data=DTpiles)
#2 = Base model
Choice.Mod[[2]]<-lmer(Total ~ Treatment + (1|sampleID), REML=F, data=DTpiles)
#3 = Temperature model
Choice.Mod[[3]]<-lmer(Total ~ Low_temp*Treatment + (1|sampleID), REML=F, data=DTpiles)
#4 = Coat Color model
Choice.Mod[[4]]<-lmer(Total ~ White*Treatment + (1|sampleID), REML=F, data=DTpiles)
#5 = Energetic model 
Choice.Mod[[5]]<-lmer(Total ~ White*Treatment + Low_temp*Treatment + (1|sampleID), REML=F, data=DTpiles)
#6 = Nitrogen model
Choice.Mod[[6]]<-lmer(Total ~ N*Treatment + (1|sampleID), REML=F, data=DTpiles)
#7 = Phosphorus model
Choice.Mod[[7]]<-lmer(Total ~ P*Treatment + (1|sampleID), REML=F, data=DTpiles)
#8 = Nutrient model
Choice.Mod[[8]]<-lmer(Total ~ N*Treatment + P*Treatment + (1|sampleID), REML=F, data=DTpiles)
#9 = Full model
Choice.Mod[[9]]<-lmer(Total ~ White*Treatment + Low_temp*Treatment + N*Treatment + P*Treatment + (1|sampleID), REML=F, data=DTpiles)

#create a vector of names to trace back models in set 
Modnames <- paste("mod", 1:length(Choice.Mod), sep = " ")
AIC<-aictab(REML=F, cand.set = Choice.Mod, modnames = Modnames, sort = TRUE)
AIC #this will be table 1 in the paper

#same models but not in list form
#1 = Null model
mod1<-lmer(Total ~ 1 + (1|sampleID), REML=F, data=DTpiles)
r.squaredGLMM(mod1)

#2 = Base model
mod2<-lmer(Total ~ Treatment + (1|sampleID), REML=F, data=DTpiles)
r.squaredGLMM(mod2)

#3 = Temperature model
mod3<-lmer(Total ~ Low_temp*Treatment + (1|sampleID), REML=F, data=DTpiles)
mod3<-lme(Total ~ Low_temp*Treatment, random =~1|sampleID, data=DTpiles)

r.squaredGLMM(mod3)

#4 = Coat Color model
mod4<-lmer(Total ~ White*Treatment + (1|sampleID), REML=T, data=DTpiles)
mod4<-lme(Total ~ White*Treatment, random =~1|sampleID, data=DTpiles)

r.squaredGLMM(mod4)

#5 = Energetic mode 
mod5<-lmer(Total ~ White*Treatment + Low_temp*Treatment + (1|sampleID), REML=F, data=DTpiles)
r.squaredGLMM(mod5)

#6 = Nitrogen model
mod6<-lmer(Total ~ N*Treatment + (1|sampleID), REML=F, data=DTpiles)
r.squaredGLMM(mod6)

#7 = Phosphorus model
mod7<-lmer(Total ~ P*Treatment + (1|sampleID), REML=F, data=DTpiles)
r.squaredGLMM(mod7)

#8 = Nutrient model
mod8<-lmer(Total ~ N*Treatment + P*Treatment + (1|sampleID), REML=F, data=DTpiles)
r.squaredGLMM(mod8)

#9 = Full model
mod9<-lmer(Total ~ White*Treatment + Low_temp*Treatment + N*Treatment + P*Treatment + (1|sampleID), REML=F, data=DTpiles)
r.squaredGLMM(mod9)

#create a table for top models
stargazer(mod6, mod4, mod5, mod3, mod2,
          type="html",
          out="Findings/table3.html",
          digits = 2,
         # covariate.labels = c("Nutrient Rank", "Temp", "Coat*Temp", "Coat", "N", "P"),
          column.labels = c("Nitrogen", "Coat Colour", "Energetic", "Temperature", "Base"),
          dep.var.labels = "Grams of Spruce Pile Consumed"
)

#create a table for extra
stargazer(mod1, mod7, mod8, mod9,
          type="html",
          out="Findings/appendix 1.html",
          digits = 2,
          # covariate.labels = c("Nutrient Rank", "Temp", "Coat*Temp", "Coat", "N", "P"),
          #column.labels = c("Null", "Phosphorus", "Nutrient", "Full"),
          dep.var.labels = "Grams of Spruce Pile Consumed"
)



###Extra stats stuff
summary(mod1)
r.squaredGLMM(mod1)
anova(mod1)
res1<-residuals(mod1)
hist(res1)
fitmod1<-fitted(mod1)
plot(res1~fitmod1, xlab="Fitted Values", ylab="Residuals")
lag.plot(res1,diag = FALSE, do.lines = FALSE)
