
tot_divergence <- 0
for (i in 1:length(divergence_t_0)) {
  tot_divergence <- tot_divergence + (sum(colSums(as.array(divergence_t_0[[i]][[2]])))/2)
}
tot_divergence


