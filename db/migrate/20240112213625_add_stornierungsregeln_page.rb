class AddStornierungsregelnPage < ActiveRecord::Migration[7.1]
  def change
    Page.create!(
      [
        {
          url: 'stornierungsregeln',
          content: 'stornierungsregeln'
        }
      ]
    )
  end
end
