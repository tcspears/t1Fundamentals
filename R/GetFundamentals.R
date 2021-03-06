#' GetFundamentals
#' 
#' Extracts a set of fundamentals for a given firm across a number of reporting periods.
#' 
#' @param firm.name Name of firm
#' @param fundamentals.names A character vector of fundamentals
#' @param sheets A list of T1 sheets
#' @param dates (optional) A character vector of reporting dates. These can either be years (e.g. '2014') or specific dates (e.g. '2014-05-12).
#' @return A matrix of fundamentals (one per column)

GetFundamentals <- function(firm.name,fundamentals.codes,sheets,dates=NULL){
  # Run fundamentals.codes through FundCode to change full names into abbreviations
  fundamentals.codes <- FundCode(fundamentals.codes)
  
  # Extract name/location information on chosen fundamentals, as well as the corresponding sheets.
  info <- lapply(fundamentals.codes,FUN=function(x) FundamentalsInfo(firm.name,fundamental.code=x,sheets))
  sheet <- lapply(info,FUN=function(x) GetSheet(x,sheets))
  
  # Drop redundant date entries from sheets.
  sheet.nodups <- lapply(sheet,FUN=function(x) DropRedundantFilings(x))
  
  # Determine dates in common; reset dates to this value
  dates <- DatesInCommon(sheet.nodups,dates)
  
  # Determine the dates.location for chosen years
  dates.location <- lapply(sheet.nodups,function(x) attributes(x)$reporting.dates.columns[which(attributes(x)$reporting.dates %in% dates)])
  
  # Extract the specified fundamentals
  fundamentals <- mapply(sheet.nodups,info,dates.location,FUN=function(x,y,z) StripFormatting(x[as.numeric(y[2]),z]))
  
  # Set attributes for fundamentals. 
  rownames(fundamentals) <- as.character(dates)
  colnames(fundamentals) <- sapply(info,FUN=function(x) x[3])
  attributes(fundamentals)$firm <- firm.name
  
  # Return fundamentals
  return(fundamentals)
}