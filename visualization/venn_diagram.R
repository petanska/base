library(VennCiagram)

f <- read.csv("")
grid.newpage()
draw.quad.venn(area1 = nrow(subset(f, A == 1)), 
               area2 = nrow(subset(f, B == 1)), 
               area3 = nrow(subset(f, C == 1)), 
               area4 = nrow(subset(f, D == 1)),
               n12 = nrow(subset(f, A == 1 & B == 1)), 
               n13 = nrow(subset(f, A == 1 & C == 1)), 
               n14 = nrow(subset(f, A == 1 & D == 1)), 
               n23 = nrow(subset(f, B == 1 & C == 1)), 
               n24 = nrow(subset(f, B == 1 & D == 1)), 
               n34 = nrow(subset(f, C == 1 & D == 1)), 
               n123 = nrow(subset(f, A == 1 & B == 1 & C == 1)), 
               n124 = nrow(subset(f, A == 1 & B == 1 & D == 1)), 
               n134 = nrow(subset(f, A == 1 & C == 1 & D == 1)), 
               n234 = nrow(subset(f, B == 1 & C == 1 & D == 1)), 
               n1234 = nrow(subset(f, A == 1 & B == 1 & C == 1 & D == 1)), 
               category = c("A", "B", "C", "D"), lty = "blank", 
               fill = c("springgreen3", "lightskyblue", "orangered", "gold"))

grid.newpage()
draw.pairwise.venn(area1 = nrow(subset(f, A == 1)),
                   area2 = nrow(subset(f, C == 1)),
                   cross.area = nrow(subset(f, A == 1 & C == 1)),
                   category = c("A", "C"), lty = "blank", 
                   fill = c("springgreen3", "orangered"))
