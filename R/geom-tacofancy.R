directory.names <- c('base_layers', 'mixins', 'condiments', 'seasonings', 'shells')

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
      c("label", directory.names), name = "geom_tacofancy")
    if (empty(data)) return(zeroGrob())
    directories <- cached.directories()
    for (col in names(directories)) {
      data[,col] <- convert.vec(data[,col], directories[[col]], col)
    }

    # Replace this with do.call eventually.
    recipes <- data.frame(
      url = paste('http://www.randomtaco.me', data$base_layers, data$mixins, data$condiments, data$seasonings, data$shells, '', sep = '/')
    )
    rownames(recipes) <- data$label
    print(recipes)
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


convert.vec(vec, slugs, name) {
  new.vec <- factor(vec)
  if (length(levels(new.vec)) > length(slugs)) {
    stop('Too many different values for ', name)
  }
  levels(new.vec) <- slugs
  new.vec
}

directory <- function(directory.name) {
  fn <- '.tmp.json'
  url <- paste0('http://www.randomtaco.me/', directory.name, '/')
  download.file(url, fn)
  xs <- fromJSON(fn)
  file.remove(fn)
  unname(sapply(xs, function(x) { x['slug'] }))
}

cached.directories <- function() {
  fn <- '.geom_tacofancy.rda' 
  if (file.exists(fn)) {
    load(fn)
  } else {
    directories <- lapply(directory.names, directory)
    names(directories) <- directory.names
    save(directories, file = '.geom_tacofancy.rda')
  }
  directories
}
