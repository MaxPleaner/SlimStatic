# SLIM STATIC

A _really easy_ static site generator using Slim and Guard.

I made this because there wasn't a dead-simple way to make a static HTML site using partials (shared HTML snippets). HTML5 imports are unfortunately not gonna happen, the powers that be decided on ES modules. Which are okay, but I don't want to write a bunch of `createElement` or create HTML in Javascript by other means. Also, being able to use Slim would be a nice plus.  

## Usage

1. Install dependencies with `bundle`
2. Run Guard with `guard`. You can alternatively just run `ruby build.rb` manually.
3. Run a static HTTP server e.g. `python -m http.server -d dist` (then open `localhost:8000`)
2. Add Slim files in `src/`
3. Include partials using the `partial` helper (make sure to use the double equals `==` so nothing gets escaped). You can also pass custom data to the partial and then read it through `PartialData`.

	```ruby
	body
	  == partial("./src/shared/nav.slim")
	  == partial("./src/shared/other_partial.slim", { custom_arg: "foo" })
	
	```

	```ruby
	# in other_partial.slim
	= PartialData[:custom_arg]
	
	```

5. Put static assets in `src/public`

... and that's about it. The Guard process will watch for all changes to the `src` directory, and rebuild `dist` each time. You _do_ have to press reload in your browser.

### Notes

Files in `public/` will be copied as-is. 

Other than that, `.slim` files at the top level of `src` are the _only things_ supported.

_But what about my scripts and styles?_ Slim supports writing all this stuff inline. See https://rdoc.info/gems/slim/frames#embedded-engines-markdown


