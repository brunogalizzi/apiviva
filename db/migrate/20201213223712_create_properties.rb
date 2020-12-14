class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      t.string :bairro
      t.text :link
      t.text :rua
      t.text :nr
      t.text :compl
      t.string :tipologia
      t.float :area
      t.integer :quartos
      t.integer :banheiros
      t.integer :vagas
      t.integer :suites
      t.float :valor
      t.float :condominio
      t.string :codigo
      t.text :fonte
      t.text :anunciante
      t.float :iptu
      t.datetime :criacao_anuncio
      t.string :compra_alguel
      t.datetime :ultima_atualizacao_site
      t.timestamps
    end
  end
end
