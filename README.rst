==================
Sudo Puppet module
==================

Since the version 1.7.2 a new `#includedir` directive is available in sudoers.                                                                                
To keep backward compatibility with old sudo versions the `common::concatfilepart` definition is used. Some default distribution versions are defined in `sudo::params::majversion` but it is also possible to specify your own version in the global parameter `$sudo_version`

The definition `sudo::directive` provides a simple way to write sudo configurations parts. If you use a sudo version >= 1.7.2, the sudo directive part is validated via visudo and removed if syntax is not correct.


This module is provided to you by Camptocamp_.

.. _Camptocamp: http://www.camptocamp.com/

For more information about sudo see http://www.gratisoft.us/sudo/

