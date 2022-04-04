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

find_images <- function(dirs) {
	paths_slides <- dir(dirs, pattern = 'slides', include.dirs = TRUE, recursive = TRUE)
	paths_slides_images <- lapply(paths_slides, dir, 'images', full.names = TRUE)
	unlist(paths_slides_images)
}

c(
	tar_target(
		dirs,
		list.dirs('.'),
		format = 'file'
	),
	tar_target(
		rmds,
		find_rmds(dirs)
	),
	tar_target(
		extra,
		find_extras(dirs),
		format = 'file'
	),
	tar_target(
		imgs,
		find_images(dirs),
		format = 'file'
	),
	# tar_target(
	# 	extra,
	# 	extras,
	# 	pattern = map(extras),
	# 	format = 'file'
	# ),
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
		file.copy(extra, 'docs', overwrite = TRUE)
	),
	tar_target(
		copy_imgs,
		file.copy(dir(imgs, full.names = TRUE), file.path('docs', 'images'))
	),
	tar_target(
		workshops_csv,
		'workshops.csv',
		format = 'file'
	),
	tar_target(
		readme,
		'README.Rmd',
		format = 'file'
	),
	tar_target(
		render_index,
		{workshops_csv; rmarkdown::render(readme, output_format = 'html_document', output_file = 'docs/index.html')}
	)
)
