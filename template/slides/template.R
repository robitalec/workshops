library(xaringanthemer)
library(ggplot2)
library(colorspace)

code_bg <- '#3F3F3F'
dark <- darken_color(code_bg, 0.2)
contrast <- '#76a5af'
header_color <- desaturate(contrast, 0.5)
text_color <- '#DCDCDC'
plot_light <- lighten_color(dark, 0.4)

style_mono_dark(
	base_color = contrast,
	white_color = text_color,
	black_color = dark,
	header_color = header_color,
	text_color = text_color,
	text_font_size = '2.25rem',
	header_h2_font_size = '1.5rem',
	header_font_google = google_font('Open Sans', '300'),
	text_font_google = google_font('Open Sans', '400'),
	header_font_weight = 100
)

theme_set(
	theme_dark(base_size = 24) +
		theme(plot.background = element_rect(fill = dark, color = dark),
					panel.background = element_rect(fill = dark, color = plot_light),
					panel.grid.major = element_line(color = plot_light),
					axis.text = element_text(color = text_color),
					axis.title = element_text(color = text_color))
)
