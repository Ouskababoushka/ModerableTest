class ModeratedModel < ApplicationRecord
  include Moderable

  # Votre code
  # Le concern prend en argument la ou les colonnes qui seront modérées.
  # Le concern doit appeler notre API de modération, voir si le contenu des colonnes est rejeté ou accepté,
  # et stocker le résultat sous forme de booléen dans la classe modérée dans une colonne appelée "is_accepted".
end
