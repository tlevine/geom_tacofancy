geom_tacofancy <- function (mapping = NULL, data = NULL, stat = "identity", position = "identity",
na.rm = FALSE, ...) {
  GeomTacoFancy$new(mapping = mapping, data = data, stat = stat, position = position, 
  na.rm = na.rm, ...)
}
      
GeomTacoFancy <- proto(ggplot2:::Geom, {
  objname <- "tacofancy"

  draw_groups <- function(., ...) .$draw(...)
  draw <- function(., data, scales, coordinates, na.rm = FALSE, ...) {    
    data <- remove_missing(data, na.rm, 
      c("label","fill","salsa","lime","radish","guacamole","cilantro"), name = "geom_tacofancy")
    if (empty(data)) return(zeroGrob())
    cat(url)
  }

  draw_legend <- function(., data, ...) {
    data <- aesdefaults(data, .$default_aes(), list(...))
  }

  default_stat <- function(.) StatIdentity
  required_aes <- c()
  default_aes <- function(.) aes(
    fill = 'carne asada', label = Sys.info()[["user"]],
    salsa = 1, lime = FALSE, radish = FALSE,
    guacamole = FALSE, cilantro = FALSE)
})

directory <- function(directory.name) {
  fn <- '.tmp.json'
  url <- paste0('http://www.randomtaco.me/', directory.name, '/')
# download.file(url, fn)
  xs <- fromJSON(fn)
# file.remove(fn)
  unname(sapply(xs, function(x) { x['slug'] }))
}

cached.directories <- function() {
  fn <- '.geom_tacofancy.rda' 
  if (file.exists(fn)) {
    load(fn)
  } else {
    directory.names <- c('base_layer', 'mixin', 'condiment', 'seasoning', 'shell')
    options <- lapply(directory.names, directory)
    names(options) <- directory.names
    save(options, file = '.geom_tacofancy.rda')
  }
  directories
}
