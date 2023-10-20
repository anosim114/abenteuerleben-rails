class AddDownloadPages < ActiveRecord::Migration[7.0]
  def change
    Page.create!(
      [
        {
          url: 'download_before',
          content: ''
        },
        {
          url: 'download_after',
          content: ''
        }
      ]
    )
  end
end
