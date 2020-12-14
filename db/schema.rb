# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_13_223712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "properties", force: :cascade do |t|
    t.string "bairro"
    t.text "link"
    t.text "rua"
    t.text "nr"
    t.text "compl"
    t.string "tipologia"
    t.float "area"
    t.integer "quartos"
    t.integer "banheiros"
    t.integer "vagas"
    t.integer "suites"
    t.float "valor"
    t.float "condominio"
    t.string "codigo"
    t.text "fonte"
    t.text "anunciante"
    t.float "iptu"
    t.datetime "criacao_anuncio"
    t.string "compra_alguel"
    t.datetime "ultima_atualizacao_site"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
