library(ggplot2)
library(dplyr)
library(gridExtra)
library(reshape2)
library(RColorBrewer)

MAJ_INT <- c("WC","WSC","OWG","TDS")

wjc_plot <- function(nations){
  create_plot <- function(x){
    dat <- filter(DATA,cat1 == 'WJC' & nation == x)
    sprCutoff <- data.frame(type = c('Sprint','Sprint'),
                            gender = c('Men','Women'),
                            yint = c(30,30))
    b <- sort(unique(dat$season))
    p <- ggplot(dat,aes(x = season, y = rank)) + 
      facet_grid(gender ~ type) + 
      geom_hline(data = sprCutoff,aes(yintercept = yint),color = "black") + 
      geom_point() + 
      stat_summary(fun.y = median,
                   aes(group = 1),
                   geom = "line",
                   color = "blue") + 
      scale_x_discrete(breaks = b[seq(1,length(b),by = 2)]) +
      labs(x = NULL,y = "Finishing Place") + 
      ggtitle(x) +
      theme(axis.text.x = element_text(hjust=0,vjust=1,angle=310,
                                       size=8,color = "black"))
    p
  }
  
  plots <- lapply(nations,create_plot)
  if (length(nations) == 1){
    plots[[1]]
  }else{
    plots$nrow <- 2
    plots$newpage <- FALSE
    invisible(do.call(grid.arrange,plots))
  }
}

u23_plot <- function(nations){
  create_plot <- function(x){
    dat <- filter(DATA,cat1 == 'U23' & nation == x)
    sprCutoff <- data.frame(type = c('Sprint','Sprint'),
                            gender = c('Men','Women'),
                            yint = c(30,30))
    b <- sort(unique(dat$season))
    p <- ggplot(dat,aes(x = season, y = rank)) + 
      facet_grid(gender ~ type) + 
      geom_hline(data = sprCutoff,aes(yintercept = yint),color = "black") + 
      geom_point() + 
      stat_summary(fun.y = median,
                   aes(group = 1),
                   geom = "line",
                   color = "blue") + 
      scale_x_discrete(breaks = b[seq(1,length(b),by = 2)]) +
      labs(x = NULL,y = "Finishing Place") + 
      ggtitle(x) +
      theme(axis.text.x = element_text(hjust=0,vjust=1,angle=310,
                                       size=8,color = "black"))
    p
  }
  
  plots <- lapply(nations,create_plot)
  if (length(nations) == 1){
    plots[[1]]
  }else{
    plots$nrow <- 2
    plots$newpage <- FALSE
    invisible(do.call(grid.arrange,plots))
  }
}

nation_perf <- function(nations,sex = NULL,race_type = NULL){
  dat <- filter(DATA,
                nation %in% nations & 
                  cat1 %in% MAJ_INT & 
                  gender == sex & 
                  type == race_type)
  
  dat_sum <- dat %>%
    group_by(season,nation) %>%
    summarise(Wins = sum(rank == 1,na.rm = TRUE) / n_distinct(raceid),
              Podiums = sum(rank <= 3,na.rm = TRUE) / n_distinct(raceid),
              Top5 = sum(rank <= 5,na.rm = TRUE) / n_distinct(raceid),
              Top15 = sum(rank <= 15,na.rm = TRUE) / n_distinct(raceid),
              Top30 = sum(rank <= 30,na.rm = TRUE) / n_distinct(raceid))
  dat_sum <- melt(dat_sum,
                  id.vars = c("season","nation"),
                  value.name = "Proportion",
                  variable.name = "Level")
  
  b <- sort(unique(dat_sum$season))
  p <- ggplot(dat_sum,aes(x = season,y = Proportion,fill = Level,group = Level)) + 
    facet_wrap(~nation,ncol = 1) +
    geom_area(position = "stack") +
    scale_x_discrete(breaks = b[seq(1,length(b),by = 2)]) +
    scale_fill_manual(values = rev(tail(brewer.pal(9,"Blues"),5))) +
    labs(x=NULL,y="Results Per Race",colour="") + 
    theme(axis.text.x = element_text(angle=310,hjust=0,vjust=1,colour="black",size=9),
          legend.direction = "horizontal",
          legend.position = "bottom")
  p
}

nation_depth <- function(nations,sex = NULL,race_type = NULL){
  dat <- filter(DATA,
                nation %in% nations &
                  cat1 %in% MAJ_INT &
                  gender == sex &
                  type == race_type)
  
  dat_sum <- dat %>%
    group_by(season,nation) %>%
    summarise(Wins = length(unique((fisid[rank == 1]))),
              Podiums = length(unique((fisid[rank <= 3]))),
              Top5 = length(unique((fisid[rank <= 5]))),
              Top15 = length(unique((fisid[rank <= 15]))),
              Top30 = length(unique((fisid[rank <= 30]))),
              Total = length(unique((fisid))))
  dat_sum <- melt(dat_sum,
                  id.vars = c("season","nation"),
                  value.name = "DistinctRacers",
                  variable.name = "Level")
  
  b <- sort(unique(dat_sum$season))
  p <- ggplot(dat_sum,aes(x = season,y = DistinctRacers,fill = Level,group = Level)) + 
    facet_wrap(~nation,ncol = 1) +
    geom_area(position = "stack") +
    scale_x_discrete(breaks = b[seq(1,length(b),by = 2)]) +
    scale_fill_manual(values = c(rev(tail(brewer.pal(7,"Blues"),6)))) +
    labs(x=NULL,y="Unique Skiers",colour="") + 
    theme(axis.text.x = element_text(angle=310,hjust=0,vjust=1,colour="black",size=9),
          legend.direction = "horizontal",
          legend.position = "bottom")
  p 
}