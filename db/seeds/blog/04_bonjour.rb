#!/bin/env ruby
# encoding: utf-8

@bonjour_experiment = Blog::Experiment.create :user => @primal_user.blog_user,
  :title => "Bonjour",
  :summary => %q{
    Parceque écrire "bonjour" c'est stylé ! ... Et que j'aime bien écrire "bonjour" de toute façon ! (full HTML/CSS)
  },
  :published => false


@bonjour_version = Blog::Version.create :user => @primal_user.blog_user,
  :experiment => @bonjour_experiment,
  :params => %q{
    # No Params
  },
  :ruby => %q{
    # No Ruby
  },
  :scss => %q{
    #bonjour{
      font-size: 32px;
		  margin: 2em;
		  text-align: center;
		  
		  div{
    		display: inline-block;
    		height: 1em;
    		width: 1em;

    		background-color: $primary-color;
    		margin-right: 1em;

    		position: relative;
    	}
    	
    	#b{
    		height: 2em;
    		
    		&:before{
      		position: absolute;
      		top: -1em;
      		left: -1em;

      		border-color: $primary-color transparent transparent transparent;
      		border-style: solid;
      		border-width: 1.264em .632em 0 2.529em;

      		-webkit-transform-origin: 0 0;
      		-webkit-transform: rotate(.321rad); 

      		content: '';
      	}

      	&:after{
      		position: absolute;
      		bottom: -1em;
      		left: -1em;

      		border-color: transparent transparent $primary-color transparent;
      		border-style: solid;
      		border-width: 0 .632em 1.264em 2.529em;

      		-webkit-transform-origin: 0 100%;
      		-webkit-transform: rotate(-.321rad);

      		content: "";
      	}
    	}

    	#o{
    		top: -.293em;

    		height: 1.414em;
    		width: 1.414em;
    		-webkit-transform: rotate(45deg);
    	}

    	#n{
    		top: -1em;
    		margin-right: 2em;
    		
    		&:before{
      		position: absolute;
      		bottom: -1em;
      		left: 0;

      		border-color: $primary-color transparent transparent $primary-color;
      		border-style: solid;
      		border-width: .5em;

      		content: "";
      	}

      	&:after{
      		position: absolute;
      		top: .5em;
      		right: -1em;

      		height: 1em;
      		width: 1em;
      		background-color: $primary-color;
      		-webkit-transform: skewY(45deg);

      		content: "";
      	}
    	}

    	#j{
    		height: 2em;
    		
    		&:before{
      		position: absolute;
      		bottom: -2em;
      		left: 0;

      		border-color: $primary-color transparent transparent $primary-color;
      		border-style: solid;
      		border-width: 1em .5em;

      		content: "";
      	}

      	&:after{
      		position: absolute;
      		bottom: -2em;
      		left: -1em;

      		border-color: $primary-color $primary-color transparent transparent;
      		border-style: solid;
      		border-width: .5em;

      		content: "";
      	}
    	}
      
    	#u{
    		margin-left: 1em;
    		-webkit-transform: rotate(180deg);
    	  
      	&:before{
      		position: absolute;
      		bottom: -1em;
      		left: 0;

      		border-color: $primary-color transparent transparent $primary-color;
      		border-style: solid;
      		border-width: .5em;

      		content: "";
      	}

      	&:after{
      		position: absolute;
      		top: .5em;
      		right: -1em;

      		height: 1em;
      		width: 1em;
      		background-color: $primary-color;
      		-webkit-transform: skewY(45deg);

      		content: "";
      	}
    	}

    	#r{
    		width: 2em;
    		top: -1em;
    		
    		&:before{
      		position: absolute;
      		bottom: -1em;
      		left: 0;

      		border-color: $primary-color transparent transparent $primary-color;
      		border-style: solid;
      		border-width: .5em;

      		content: "";
      	}
    	}
    }
  },
  :erb => %q{
    <div id="bonjour">
    	<div id="b"></div><!--
    	--><div id="o"></div><!--
    	--><div id="n"></div><!--
    	--><div id="j"></div><!--
    	--><div id="o"></div><!--
    	--><div id="u"></div><!--
    	--><div id="r"></div>
    </div>
  },
  :js => "// No JS",
  :published => true
