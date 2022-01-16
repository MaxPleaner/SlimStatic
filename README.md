# SLIM STATIC

A _really easy_ static site generator using Slim and Guard.

I made this because there wasn't a dead-simple way to make a static HTML site using partials (shared HTML snippets). HTML5 imports are unfortunately not gonna happen, the powers that be decided on ES modules. Which are okay, but I don't want to write a bunch of `createElement` or create HTML in Javascript by other means. Also, being able to use Slim would be a nice plus.  

## Usage

1. Install dependencies with `bundle`
2. Run Guard with `guard`. You can alternatively just run `ruby build.rb` manually.
3. Run a static HTTP server e.g. `python -m http.server -d dist` (then open `localhost:8000`). You can alternatively run `sh server.sh` which does the same thing.
2. Add Slim files in `src/pages/`. Files in `src/pages/` will be copied to the top level of `dist/`. This includes folder structure, e.g. `src/pages/subfolder/foo.slim` would get copied to `dist/subfolder/foo.html`. Slim files outside of `pages/` won't be copied to the output at all. However, they can still be used as build-time, e.g. you can put partials inside a `src/shared` folder as shown below.
4. Include partials using the `partial` helper (make sure to use the double equals `==` so nothing gets escaped). You can also pass custom data to the partial and then read it through `PartialData`.

	```ruby
	body
	  == partial("./src/shared/nav.slim")
	  == partial("./src/shared/other_partial.slim", { custom_arg: "foo" })
	
	```

	```ruby
	# in other_partial.slim
	= PartialData[:custom_arg]
	
	```

	_Note that you don't have to use the exact folder name `src/shared`, you can use any custom folder name inside `src` for this purpose._

5. Put static assets in `src/public`. These will be copied as-is, including folder structure.

... and that's about it. The Guard process will watch for all changes to the `src` directory, and rebuild `dist` each time. You _do_ have to press reload in your browser.

### Notes

- Slim supports writing **inline** CSS, Javascript, Sass, Coffeescript, and so on. That's why there's no support for these kinds of standalone files. See https://rdoc.info/gems/slim/frames#embedded-engines-markdown

- If you want to use the `markdown` preprocessor, you need to install `pandoc` to your system as well.


