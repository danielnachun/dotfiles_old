options(repos=structure(c(CRAN="http://cran.stat.ucla.edu/")))
# Lines added by the Vim-R-plugin command :RpluginConfig (2014-Oct-14 16:27):
if(interactive()){
    options(setwidth.verbose = 1,
               colorout.verbose = 1,
               nvimcom.verbose = 1,
               help_type = "text")
                

    options(editor='nvim')
    options(menu.graphics = FALSE)
    options(save.defaults = list(compress = FALSE))

    library(nvimcom)
    library(setwidth)
    library(pacman)

    # syntax highlighting
    library(colorout)
    #if (!Sys.getenv('TERM') %in% c('', 'linux'))
        #setOutputColors256(
        #normal = 15,
        #number = 12,
        #negnum = 9,
        #string = 10,
        #const = 13,
        #stderror = 120,
        #error = c(1, 0, 1),
        #warn = 5,
        #verbose=FALSE
    #)
}

.bc = function() {
    print('Sourcing http://bioconductor.org/biocLite.R')
    source("http://bioconductor.org/biocLite.R")
}
