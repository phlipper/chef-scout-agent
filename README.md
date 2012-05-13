# chef-scout-agent

## Description

Installs the [Scout](https://scoutapp.com/) Server Monitoring Agent.


## Requirements

This cookbooks requires the excellent [chef-rvm](https://github.com/fnichol/chef-rvm) cookbook from @fnichol.


### Supported Platforms

The following platforms are supported by this cookbook, meaning that the recipes run on these platforms without error:

* Ubuntu
* Debian
* Red Hat
* CentOS
* Fedora
* Scientific
* Amazon


## Recipes

* `scout-agent` - The default recipe.

## Usage

This cookbook installs the scout-agent components if not present, and pulls updates if they are installed on the system.

## Attributes

```ruby
default["scout_agent"]["key"]         = ""
default["scout_agent"]["user"]        = "scout"
default["scout_agent"]["group"]       = "scout"
default["scout_agent"]["version"]     = "5.5.4"
default["scout_agent"]["rvm_ruby"]    = "ruby-1.9.3-p194"
default["scout_agent"]["rvm_gemset"]  = "scout"
default["scout_agent"]["plugin_gems"] = []
default["scout_agent"]["node_name"]   = ""
```

The `node["scout_agent"]["plugin_gems"]` takes a list of additional gems that are used by your Scout plugins. The array can contain a list of Hash elements with `name` and (optional) `version` keys. Example:

```javascript
// dna ...
{
  "scout_agent": {
    // ...
    "plugin_gems": [
      { "name": "mysql", "version": "2.8.1" },
      { "name": "redis" }
    ]
  }
}
```

## Basic Settings

You must set the value for `node["scout_agent"]["key"]`.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## License

**chef-scout-agent**

* Freely distributable and licensed under the [MIT license](http://phlipper.mit-license.org/2012/license.html).
* Copyright (c) 2012 Phil Cohen (github@phlippers.net) [![endorse](http://api.coderwall.com/phlipper/endorsecount.png)](http://coderwall.com/phlipper)
* http://phlippers.net/
