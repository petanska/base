# R

### GRanges
#### inspect
```
View(data.frame(gr))
```
#### access the metadata using $
```
gr$meta
```
#### access the metadata using []
```
mcols(gr)[1]
```
#### find overlapping peaks
```
findOverlaps(query, subject, minoverlap = 100)
```
##### list indices for query / subject hits
```
queryHits(findOverlaps())
subjectHits(findOverlaps())
```
#### resize peaks
```
resize(gr, 1001, "center")
```

### motif enrichment
```
motifmatchr::matchMotifs(TFBSTools::PWMatrix, gr, genome=BSgenome.*.UCSC.*, p.cutoff=1e-3, bg="genome", out="scores")
```
