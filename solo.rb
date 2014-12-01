root = File.expand_path('..', File.dirname(__FILE__))
cookbook_path [ root + '/cookbooks', root + '/site-cookbooks' ]
ssl_verify_mode :verify_peer
