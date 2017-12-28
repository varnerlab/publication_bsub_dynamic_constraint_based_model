function Bounds(DF)

  FB = DF["default_flux_bounds_array"]
  #PTS Uptake
  FB[1,1] = DF["r1"]
  FB[2,2] = DF["r2"]
  FB[3,1] = DF["r3"]
  FB[4,1] = DF["r4"]
  FB[5,1] = DF["r5"]
  FB[6,1] = DF["r6"]
  FB[7,1] = DF["r7"]
  FB[8,1] = DF["r8"]
  FB[9,1] = DF["r9"]

  #Catabolite repression


  DF["default_flux_bounds_array"] = FB
  return DF
end
