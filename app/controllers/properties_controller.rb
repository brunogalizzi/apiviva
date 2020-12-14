# frozen_string_literal: true

require 'json'
require 'open-uri'
require 'io/console'
# Teste
class PropertiesController < ApplicationController
  def index; end

  def atualizar
    Property.destroy_all
    buscar_api_viva
    @count = Property.all
  end

  def buscar_api_viva
    bairros = %w[Anchieta Belvedere Carmo Cruzeiro Funcionarios Lourdes
                 Santo%20Agostinho Sao%20Pedro Savassi Sion Serra
                 Vale%20dos%20Cristais Vale%20do%20Sereno Vila%20da%20Serra]
    tipos = %w[RENTAL SALE]
    bairros.each do |bairro|
      cidades = []
      cidades << ((bairro = 'Vale%20dos%20Cristais' || 'Vale%20do%20Sereno' || 'Vila%20da%20Serra') ? 'Nova%20Lima' : 'Belo%20Horizonte')
      cidades << ((bairro = 'Vila%20da%20Serra') ? 'Belo%20Horizonte' : nil)
      tipos.each do |tipo|
        cidades.each do |cidade|
          url = 'https://glue-api.vivareal.com/v2/listings?addressCity=' + cidade + '&addressLocationId=BR%3EMinas%20Gerais%3ENULL%3E' + cidade + '%3EBarrios%3E' + bairro + '&addressNeighborhood=' + bairro + '&addressState=Minas%20Gerais&addressCountry=&addressStreet=&addressZone=Bairros&addressPointLat=&addressPointLon=&business=' + tipo + '&facets=amenities&unitTypes=&unitSubTypes=&unitTypesV3=&usageTypes=&listingType=USED&parentId=null&categoryPage=RESULT&includeFields=search(result(listings(listing(updatedAt%2CcreatedAt%2CusableAreas%2ClistingType%2CunitTypes%2CpropertyType%2Cid%2CparkingSpaces%2Caddress(neighborhood%2Cstreet%2CstreetNumber%2Ccomplement)%2Csuites%2Cbathrooms%2Cbedrooms%2CpricingInfos(monthlyRentalTotalPrice%2CyearlyIptu%2Cprice%2CbusinessType%2CmonthlyCondoFee))%2Caccount(id%2Cname)%2Clink))%2CtotalCount%2Clink)%2Cpage%2CfullUriFragments%2Cexpansion(search(result(listings(listing(usableAreas%2ClistingType%2CunitTypes%2CpropertyType%2Cid%2CparkingSpaces%2Caddress(neighborhood%2Cstreet%2CstreetNumber%2Ccomplement)%2Csuites%2Cbathrooms%2Cbedrooms%2CpricingInfos(monthlyRentalTotalPrice%2CyearlyIptu%2Cprice%2CbusinessType%2CmonthlyCondoFee))%2Caccount(id%2Cname)%2Clink))%2CtotalCount))%2Cowners(search(result(listings(listing(usableAreas%2ClistingType%2Cdescription%2Ctitle%2CunitTypes%2CpropertyType%2Cid%2CparkingSpaces%2Caddress(neighborhood%2Cstreet%2CstreetNumber%2Ccomplement)%2Csuites%2Cbathrooms%2Cbedrooms%2CpricingInfos(monthlyRentalTotalPrice%2CyearlyIptu%2Cprice%2CbusinessType%2CmonthlyCondoFee))%2Caccount(id%2Cname)%2Clink))%2CtotalCount))&size=1&from=1&q=&developmentsSize=5&__vt=psc%3Aa'
          properties = JSON.parse(open(url, 'x-domain' => 'www.vivareal.com.br').read())
          contagem = properties['search']['totalCount'].to_i
          paginas = (contagem / 300).to_i + 1
          (1..paginas).each do |pagina|
            sleep rand(2..7)
            pagina_inicial = (((pagina - 1) * 300) + 1).to_s
            url = 'https://glue-api.vivareal.com/v2/listings?addressCity=' + cidade + '&addressLocationId=BR%3EMinas%20Gerais%3ENULL%3E' + cidade + '%3EBarrios%3E' + bairro + '&addressNeighborhood=' + bairro + '&addressState=Minas%20Gerais&addressCountry=&addressStreet=&addressZone=Bairros&addressPointLat=&addressPointLon=&business=' + tipo + '&facets=amenities&unitTypes=&unitSubTypes=&unitTypesV3=&usageTypes=&listingType=USED&parentId=null&categoryPage=RESULT&includeFields=search(result(listings(listing(updatedAt%2CcreatedAt%2CusableAreas%2ClistingType%2CunitTypes%2CpropertyType%2Cid%2CparkingSpaces%2Caddress(neighborhood%2Cstreet%2CstreetNumber%2Ccomplement)%2Csuites%2Cbathrooms%2Cbedrooms%2CpricingInfos(monthlyRentalTotalPrice%2CyearlyIptu%2Cprice%2CbusinessType%2CmonthlyCondoFee))%2Caccount(id%2Cname)%2Clink))%2CtotalCount%2Clink)%2Cpage%2CfullUriFragments%2Cexpansion(search(result(listings(listing(usableAreas%2ClistingType%2CunitTypes%2CpropertyType%2Cid%2CparkingSpaces%2Caddress(neighborhood%2Cstreet%2CstreetNumber%2Ccomplement)%2Csuites%2Cbathrooms%2Cbedrooms%2CpricingInfos(monthlyRentalTotalPrice%2CyearlyIptu%2Cprice%2CbusinessType%2CmonthlyCondoFee))%2Caccount(id%2Cname)%2Clink))%2CtotalCount))%2Cowners(search(result(listings(listing(usableAreas%2ClistingType%2Cdescription%2Ctitle%2CunitTypes%2CpropertyType%2Cid%2CparkingSpaces%2Caddress(neighborhood%2Cstreet%2CstreetNumber%2Ccomplement)%2Csuites%2Cbathrooms%2Cbedrooms%2CpricingInfos(monthlyRentalTotalPrice%2CyearlyIptu%2Cprice%2CbusinessType%2CmonthlyCondoFee))%2Caccount(id%2Cname)%2Clink))%2CtotalCount))&size=300&from=' + pagina_inicial + '&q=&developmentsSize=5&__vt=psc%3Aa'
            properties_serialized = open(url, 'x-domain' => 'www.vivareal.com.br').read()
            properties = JSON.parse(properties_serialized)
            (0..(contagem - pagina_inicial.to_i >= 300 ? 299 : contagem - pagina_inicial.to_i - 1)).each do |property|
              neighborhood = properties['search']['result']['listings'][property]['listing']['address']['neighborhood']
              link = properties['search']['result']['listings'][property]['link']['href']
              street = properties['search']['result']['listings'][property]['listing']['address']['street']
              street_number = properties['search']['result']['listings'][property]['listing']['address']['streetNumber']
              complement = properties['search']['result']['listings'][property]['listing']['address']['complement']
              unit_types = properties['search']['result']['listings'][property]['listing']['unitTypes'][0]
              usable_areas = properties['search']['result']['listings'][property]['listing']['usableAreas'][0]
              bedrooms = properties['search']['result']['listings'][property]['listing']['bedrooms'][0]
              bathrooms = properties['search']['result']['listings'][property]['listing']['bathrooms'][0]
              parking_spaces = properties['search']['result']['listings'][property]['listing']['parkingSpaces'][0]
              price = properties['search']['result']['listings'][property]['listing']['pricingInfos'][0]['price']
              condo = properties['search']['result']['listings'][property]['listing']['pricingInfos'][0]['monthlyCondoFee']
              id = properties['search']['result']['listings'][property]['listing']['id']
              account_name = properties['search']['result']['listings'][property]['account']['name']
              yearly_iptu = properties['search']['result']['listings'][property]['listing']['pricingInfos'][0]['yearlyIptu']
              created_at = properties['search']['result']['listings'][property]['listing']['createdAt']
              business_type = properties['search']['result']['listings'][property]['listing']['pricingInfos'][0]['businessType']
              updated_at = properties['search']['result']['listings'][property]['listing']['updatedAt']
              Property.create!(bairro: neighborhood, link: 'https://www.vivareal.com.br' + link, rua: street, nr: street_number, compl: complement, tipologia: unit_types, area: usable_areas, quartos: bedrooms, banheiros: bathrooms, vagas: parking_spaces, valor: price.to_f, condominio: condo.to_f, codigo: id, fonte: 'Viva Real', anunciante: account_name, iptu: yearly_iptu, criacao_anuncio: created_at, compra_alguel: business_type, ultima_atualizacao_site: updated_at)
            end
          end
        end
      end
    end
  end
end
