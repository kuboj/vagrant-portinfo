# Vagrant-portinfo

Vagrant plugin for displaying (currently active) forwarded ports. Currently, only VirtualBox provider is supported.

## Installation

```
$ vagrant plugin install vagrant-portinfo
```

## Usage

```
$ vagrant portinfo [name] [name] ...
```

## Example

```
$ vagrant portinfo
default (c516429) running
--------------------------------------------------------------------------------
guest: 22	host: 2222
```

```
$ vagrant portinfo c516429 04e4471
default (c516429) running
--------------------------------------------------------------------------------
guest: 22	host: 2222
default (04e4471) running
--------------------------------------------------------------------------------
guest: 22	host: 2220
guest: 80	host: 8080
```

Plugin also supports `--machine-readable` flag:
```
$ vagrant portinfo --machine-readable
1437575900,db,forwarded_port,22,2202
1437575900,db,forwarded_port,80,2201
1437575900,web,forwarded_port,22,2200
1437575900,web,forwarded_port,80,10081
```

## Contributing

1. Fork it ( https://github.com/kuboj/vagrant-portinfo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
