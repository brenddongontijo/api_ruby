module FreightHandler
  require 'faker'
  Faker::Config.locale = 'pt-BR'

  def calculate_freight(product)
    origin_zip_code = Faker::Address.zip_code
    destination_zip_code = Faker::Address.zip_code

    freight = Correios::Frete::Calculador.new(
      :cep_origem => origin_zip_code,
      :cep_destino => destination_zip_code,
      :peso => product.weight,
      :comprimento => product.length,
      :largura => product.width,
      :altura => product.height )

    begin
      freight.calcular :sedex, :pac
    rescue SocketError => e
      raise
    end
  end
end