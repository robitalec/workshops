# === Targets: workshops --------------------------------------------------
# Alec L. Robitaille

library(targets)


find_rmds <- function(dirs) {
	basename_dirs <- lapply(dirs, basename)
	slides_dirs <- dirs[grep('slides$', basename_dirs)]
	drop_rprojuser <- grep('.Rproj.user', slides_dirs, invert = TRUE, value = TRUE)
	vapply(drop_rprojuser, dir, pattern = '.Rmd$', full.names = TRUE, 'potato')
}

c(
	tar_target(
		dirs,
		list.dirs('.')
	),
	tar_target(
		rmds,
		find_rmds(dirs)
	),
	tar_target(
		render,
		rmarkdown::render(
			rmds,
			output_dir = 'docs'
		),
		pattern = map(rmds)
	)
)
