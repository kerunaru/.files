#
#   __ _     _
#  / _(_)___| |__
# | |_| / __| '_ \
# |  _| \__ \ | | |
# |_| |_|___/_| |_|
#
# Configuración personalizada de mi intérprete de comandos favorito :3
#

set -x PATH $PATH ~/.bin
set -x PATH $PATH ~/.composer/vendor/bin

set -x LESS -SRXF # Permite que less use más del ancho de la pantalla en mycli
set -x PROMPT_TOOLKIT_ANSI_COLORS_ONLY 1 # Obliga a mycli a usar solo 16
                                         # colores
