
options(repos=structure(c(CRAN="http://cran.stat.ucla.edu/")))
# Lines added by the Vim-R-plugin command :RpluginConfig (2014-Oct-14 16:27):
if(interactive()){
    options(setwidth.verbose = 1,
               colorout.verbose = 1,
               vimcom.verbose = 1,
               pager = file.path(Sys.getenv("HOME"), "bin/vimrpager"), 
               help_type = "text")
                

    options(editor='vim')
    #.libPaths(c("/home/daniel/R/x86_64-unknown-linux-gnu-library/3.2", "/usr/lib/R/library"))
    options(menu.graphics = FALSE)
    options(save.defaults = list(compress = FALSE))

    if(Sys.getenv("TMUX") != "" && Sys.getenv("DISPLAY") == "")
        options(browser = function (u) system(paste0("tmux new-window 'vimrpager ", u, "'"))
            ,help_type = "text")
    library(setwidth)

    if(Sys.getenv("VIMRPLUGIN_TMPDIR") != "") {
       library(vimcom)
    }
    # syntax highlighting
    library(colorout)
    if (!Sys.getenv('TERM') %in% c('', 'linux'))
        setOutputColors256(
        normal = 15,
        number = 12,
        negnum = 9,
        string = 10,
        const = 13,
        stderror = 120,
        error = c(1, 0, 1),
        warn = 5,
        verbose=FALSE
    )
}

.bc = function() {
    print('Sourcing http://bioconductor.org/biocLite.R')
    source("http://bioconductor.org/biocLite.R")
}
