# === Targets: workshops --------------------------------------------------
# Alec L. Robitaille

library(targets)


find_rmds <- function(dirs) {
	basename_dirs <- lapply(dirs, basename)
	slides_dirs <- dirs[grep('slides$', basename_dirs)]
	drop_rprojuser <- grep('.Rproj.user', slides_dirs, invert = TRUE, value = TRUE)
	vapply(drop_rprojuser, dir, pattern = '.Rmd$', full.names = TRUE, 'potato')
}

find_extras <- function(dirs) {
	basename_dirs <- lapply(dirs, basename)
	slides_dirs <- dirs[grep('slides$', basename_dirs)]
	drop_rprojuser <- grep('.Rproj.user', slides_dirs, invert = TRUE, value = TRUE)
	unlist(lapply(drop_rprojuser, dir, pattern = 'css$|js$', full.names = TRUE))
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
		extras,
		find_extras(dirs)
	),
	tar_target(
		extra,
		extras,
		pattern = map(extras),
		format = 'file'
	),
	tar_target(
		rmd,
		rmds,
		pattern = map(rmds),
		format = 'file'
	),
	tar_target(
		render,
		rmarkdown::render(
			rmd,
			output_dir = 'docs'
		),
		pattern = map(rmd)
	),
	tar_target(
		copy_extras,
		file.copy(extra, 'docs', overwrite = TRUE),
		pattern = map(extra)
	)
)
