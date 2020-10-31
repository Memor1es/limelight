# esx_windowcleaner

REPLACE THIS IN THE SQL OTHERWISE YOU WILL RUN IN TO AN ERROR  

*THIS PART*

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
('contrat', 'W.C receipt', 100, 0, 1)


*TO THIS*

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
('receipt', 'W.C receipt', 100, 0, 1)

====================================================================================
Window cleaner Job for ESX

# Getting Started

1. Add esx_windowcleaner folder into resources
2. Add in server.cfg
3. Add esx_windowcleaner.sql to database

# Configuration

1. Configuration only in config.lua

Thanks to Anthony for esx_garbage, wich is the base of all of this.
https://github.com/AnthonyEl
