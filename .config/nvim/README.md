# nvim config 

![](https://matsu.fi/scientist-vim-meme.png)

Config are created in the `lua/configs` directory. They should export an object with the following optional parameters:

- **setup** - A function run to setup the config
- **packages** - A function which takes in use (from packer) and should install
  	all the requirements for this config to work
- **keybindings** - A function which takes the keybind function and should set
  	all the keybindings used by this config
