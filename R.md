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
#### create genomic bins
```
s=50 # stride
genome_bins <- unlist(GRangesList(lapply(names(seqlengths(Dmelanogaster)), function(chr){
  GRanges(chr, IRanges(seq(1, seqlengths(Dmelanogaster)[chr], s),
                       width = 601),
          seqinfo = Dmelanogaster@seqinfo)
})))

idx <- GenomicRanges:::get_out_of_bound_index(genome_bins)
if (length(idx) != 0L)
  genome_bins <- genome_bins[-idx]

# add names
names(genome_bins) <- paste0("bin", 1:length(genome_bins))

genome_bins <- genome_bins[genome_bins@seqnames %in% c("chr2L", "chr2LHet", "chr2R", "chr2RHet", "chr3L", "chr3LHet", "chr3R", "chr3RHet", "chr4", "chrX", "chrXHet", "chrYHet")]
```

### motif enrichment
```
motifmatchr::matchMotifs(TFBSTools::PWMatrix, gr, genome=BSgenome.*.UCSC.*, p.cutoff=1e-3, bg="genome", out="scores")
```
