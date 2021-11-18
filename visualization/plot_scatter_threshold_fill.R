library(ggplot2)

var <- ggplot(df, aes(x = lvlA, y = lvlB, fill = cut(covB, breaks=c(-1,0,379,760,Inf)))) + 
	geom_point(shape = 21, size = 2) + 
	scale_fill_manual(values=c("#a6cee3", "#a57c86", "#a52a2a", "white"),
					limits=c("(760,Inf]","(379,760]","(0,379]","(-1,0]"),
					name = "Coverage", labels = c("> 760", "380-760", "< 380", "not called")) + 
	geom_abline() +
	ggtitle("Title") +
	labs(x = "Levels A", y = "Levels B") +
	theme(plot.title = element_text(face = "bold", hjust = 0.5),
		axis.text = element_text(size = 8),
		axis.title = element_text(size = 10))
