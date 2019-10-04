libs<-c("data.table",'lme4','MuMIn')
lapply(libs, require, character.only = TRUE)

#Data:
DTpiles<-readRDS("jules/pile_format.rds")

#Models:

#The Nitrogen model
Nitrogen<-lmer(Total ~ N*Treatment + (1|sampleID), REML=F, data=DTpiles)

#The Coat Color model
Coat<-lmer(Total ~ Treatment + White + (1|sampleID), REML=T, data=DTpiles)

#The Energetic model, (combines temp and coat models)
Energetic<-lmer(Total ~ White*Treatment + Low_temp*Treatment + (1|sampleID), REML=F, data=DTpiles)

#The Temperature model
Temp<-lmer(Total ~ Low_temp*Treatment + (1|sampleID), REML=F, data=DTpiles)

#The base model that other models build off of
Base<-lmer(Total ~ Treatment + (1|sampleID), REML=F, data=DTpiles)


listModels <-
  list(
    'Nitrogen' = Nitrogen,
    'Coat' = Coat,
    'Energetic' = Energetic,
    'Temp' = Temp,
    'Base' = Base
  )


DT <- rbindlist(lapply(seq_along(listModels), function(m) {
  data.table(broom.mixed::tidy(listModels[[m]]))[, model := names(listModels[m])]
}))


##Looking for a table that takes all coefficients and standard errors, with p-values or indicators of significance
#if p-values makes things too complicated, leave them out, not that important. 
#For R2s extract only marginal R2:
r.squaredGLMM(Nitrogen)

