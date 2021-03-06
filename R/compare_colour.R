#' Calculate the distance between colours
#' 
#' There are many ways to measure the distance between colours. `farver` 
#' provides 5 different algorithms, ranging from simple euclidean distance in 
#' RGB space, to different perceptual measures such as CIE2000.
#' 
#' @param from,to Numeric matrices with colours to compare - the format is the 
#' same as that for [convert_colour()]. If `to` is not set `from` will be 
#' compared with itself and only the upper triangle will get calculated
#' 
#' @param from_space,to_space The colour space of `from` and `to` respectively. 
#' `to_space` defaults to be the same as `from_space`.
#' 
#' @param method The method to use for comparison. Either `'euclidean'`, 
#' `'cie1976'`, `'cie94'`, `'cie2000'`, or `'cmc'`
#' 
#' @return A numeric matrix with the same number of rows as colours in `from`
#' and the same number of columns as colours in `to`. If `to` is not given, only
#' the upper triangle will be returned.
#' 
#' @export
#' 
#' @examples 
#' r <- t(col2rgb(rainbow(10)))
#' h <- t(col2rgb(heat.colors(15)))
#' 
#' # Compare two sets of colours
#' compare_colour(r, h, 'rgb', method = 'cie2000')
#' 
#' # Compare a set of colours with itself
#' compare_colour(r, from_space = 'rgb', method = 'cmc')
compare_colour <- function(from, to = NULL, from_space, to_space = from_space, method = 'euclidean') {
  sym <- FALSE
  if (is.null(to)) {
    to <- from;
    sym <- TRUE
  }
  from_space <- match.arg(from_space, colourspaces)
  to_space <- match.arg(to_space, colourspaces)
  method <- match.arg(tolower(method), c('euclidean', 'cie1976', 'cie94', 'cie2000', 'cmc'))
  compare_c(from, to, from_space, to_space, method, sym)
}