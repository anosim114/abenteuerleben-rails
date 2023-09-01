class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.string :url
      t.text :content

      t.timestamps
    end

    add_index :pages, :url, unique: true

    downloads = Page.new
    downloads.url = 'downloads'
    downloads.content = '<h1>Downloads</h1>'
    downloads.save

    donations = Page.new
    donations.url = 'spenden'
    donations.content = '<h1>Spenden</h1>'
    donations.save

  end
end
