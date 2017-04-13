dollar_si<-function (number, rounding=F, digits=ifelse(rounding, NA, 4))
{
  sign <- ""
  if (number < 0) {
    sign <- "-"
    number <- -number
  }
  lut <- c(1, 1000, 1e+06, 1e+09, 1e+12)
  pre <- c("" ,"K",  "M", "B", "T")
  ix <- findInterval(number, lut)

  if (ix > 0 && ix <= length(lut) && lut[ix] != 1)
    if (rounding == T && !is.numeric(digits))
      sistring <- paste0("$ ", sign, round(number / lut[ix]), pre[ix])
  else if (rounding == T || is.numeric(digits))
    sistring <- paste0("$ ", sign, round(number / lut[ix], digits), pre[ix])
  else
    sistring <- paste0("$ ", sign, number / lut[ix], pre[ix])
  else
    if (rounding == T && !is.numeric(digits))
      sistring <- paste0("$ ", sign, as.character(round(number)))
  else if (rounding == T || is.numeric(digits))
    sistring <- paste0("$ ", sign, as.character(round(number, digits)))
  else
    sistring <- paste0("$ ", sign, as.character(number), pre[ix])

  return(sistring)
}

comma_si <- function (number, rounding = F, digits = ifelse(rounding, NA, 4))
{
  sign <- ""
  if (number < 0) {
    sign <- "-"
    number <- -number
  }
  lut <- c(1, 1000, 1e+06, 1e+09, 1e+12)
  pre <- c("" ,"K",  "M", "B", "T")
  ix <- findInterval(number, lut)

  if (ix > 0 && ix <= length(lut) && lut[ix] != 1)
    if (rounding == T && !is.numeric(digits))
      sistring <- paste0("$ ", sign , round(number / lut[ix]), pre[ix])
  else if (rounding == T || is.numeric(digits))
    sistring <- paste0(sign , round(number / lut[ix], digits), pre[ix])
  else
    sistring <- paste0(sign , number / lut[ix], pre[ix])
  else
    if (rounding == T && !is.numeric(digits))
      sistring <- paste0(sign , as.character(round(number)))
  else if (rounding == T || is.numeric(digits))
    sistring <- paste0(sign , as.character(round(number, digits)))
  else
    sistring <- paste0(sign , as.character(number), pre[ix])

  return(sistring)
}