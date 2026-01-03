name        = "Polish Language Pack (Latest)"
description = "Spolsczenie do Don't Starve, ktore uzywa plikow z gry."
              .."\n\nZresetuj gre kazdorazowo po zmianie konfiguracji!"
author      = "heapy, marecik16, Lukasz Marecik"
version     = "1.4.1"


dont_starve_compatible     = true
reign_of_giants_compatible = true
shipwrecked_compatible     = true
hamlet_compatible          = true

forumthread = ""
api_version = 6

icon_atlas = "modicon.xml"
icon       = "modicon.tex"

restart_required = true


configuration_options =
{
  {
    name = "CONTROLLER",
    label = "Ikony kontrolera:",
    options = {
      { description = "Xbox",        data = "xbox" },
      { description = "PlayStation", data = "ps"   },
    },
    
    default = "xbox"
  },
}
