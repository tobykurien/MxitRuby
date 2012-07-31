MxitRuby
========

A skeleton Mxit app written in Ruby. A good starting point for your own Ruby app.

You will need to install the following gems:
- sinatra
- ruty

Usage
=====

To start your mxit app, simply fork this repository.

The app.rb file is that starting point for the app, with the lines beginning with "get" being the routes. Two sample routes are provided for the default page and a detail page. The sample app lists two items and allows a click-through to a detail page. The do_render method renders the view using the Ruty templating engine. The code looks as follows:

    get '/event_details/:e_uri' do |e_uri|
      do_render :coming_soon, :message => "coming soon for #{e_uri}"
    end

    get '' do
      data = {
        :mxit => @mxit,
        :events => [ 
            { :uri => 1, :name => "Test event 1" }, 
            { :uri => 2, :name => "Test event 2" } 
        ]
      }

      do_render :index, data
    end 

The HTML is all stored neatly in the views folder, with layout.html controlling the main template layout, and each view then extending it. The views have two global variables they can use: mxit (which gives access to mxit data via the mxit class, see modules/mxit/mxit.rb) and root which points to the app's root url directory. All your links in the views HTML file should 
start with root, e.g.:

 <a href="{{ root }}event_details/{{ event.uri }}">{{ event.name }}</a>
 
To display data from mxit, use the mxit object as follows:

 {{ mxit.nickname }}
 
To run this app, first install the necessary gems:

 sudo gem install sinatra
 sudo gem install ruty

Then run the app:
 
 ruby app.rb
 
The live app can be deployed on Apache with Passenger. During testing, the mxit class contains mock mxit headers that you can edit to allow for testing your app locally, without having to deploy through mxit. When you deploy it live, the mock data will get over-writen by live mxit data, so the testing process is seamless.

That's it! Please send comments or suggestions or pull requests with your improvements.
Toby
