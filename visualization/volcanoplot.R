require(ggplot2)
theme_set(theme_light() + theme(axis.text = element_text(colour = "black")))
require(ggpointdensity)
require(ggrepel)

volcano <- ggplot(df[order(df$Significant),], aes(log2_OR, min_log10_pvalue, col=Significant)) +
      geom_point(size=2) +
      ggtitle(paste0(c, " over ", d)) +
      scale_x_continuous("log2 odds ratio", breaks = seq(-10,10,1)) +
      scale_y_continuous("-log10 p-value") +
      theme_bw() +
      theme(panel.background = element_rect(fill="white",colour="white"), panel.grid=element_blank(), axis.text=element_text(size=13, colour="black"), axis.title=element_text(size=18, colour="black"), plot.title = element_text(size=18, hjust = 0.5, colour="black"), legend.key=element_rect(fill=NA, colour=NA), legend.text = element_text(size=13, colour="black"), legend.title = element_text(size=16, colour="black"), legend.position = "bottom", axis.title.x=element_text(margin=margin(5,0,0,0)), axis.title.y=element_text(margin=margin(0,5,0,0))) +
      scale_color_manual("", values = c(color_d,"grey60", color_c)) +
      geom_text_repel(
      data = subset(df, text %in% "yes"),
      aes(label = name),
      size=2,
      box.padding = unit(0.35, "lines"),
      point.padding = unit(0.3, "lines"))
