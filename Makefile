sass:
	sass .\www\styles.scss www/styles.css
	
style:
	R -e "styler::style_file('start.r')"
	R -e "styler::style_dir('box')"