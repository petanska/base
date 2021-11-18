library(ggplot2)

hm <- ggplot(precision, aes(variable, ID)) + 
	geom_tile(aes(fill = value), colour = "white") + 
	scale_fill_gradient(low = "#a52a2a", high = "#a6cee3") + 
	geom_text(label = precision$value, size = 2.5) + 
	ggtitle("Title") + 
	theme(plot.title = element_text(size = 10, face = "bold", hjust = 0.5), 
					axis.text = element_text(size = 8),
					axis.text.x = element_text(angle = 45, hjust = 1),
					axis.title = element_blank()) + 
	scale_y_discrete(labels=c("A", "B", "C", "D", "E", "F", "G")) + 
	theme(legend.title = element_blank())
