# config/initializers/pagy.rb

# 1. Descomentamos a linha para o Pagy injetar as classes do Tailwind nos botões
#require 'pagy/extras/tailwindcss'

# 2. Sintaxe atualizada para o Pagy v9.0+ (usando :limit em vez de :items)
Pagy.options[:limit] = 5
