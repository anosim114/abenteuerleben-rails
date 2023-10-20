class CreateDownloads < ActiveRecord::Migration[7.0]
  def change
    create_table :downloads do |t|
      t.string :name, null: false
      t.string :description
      t.boolean :download_area

      t.timestamps
    end

    Download.create!(
      [
        { name: 'mitarbeiter - haftungsausschluss', description: '', download_area: true },
        { name: 'mitarbeiter - wichtige informationen', description: '', download_area: true },
        { name: 'teilnehmer - haftungsausschluss', description: '', download_area: true },
        { name: 'teilnehmer - wichtige informationen', description: '', download_area: true }
      ]
    )
  end
end
