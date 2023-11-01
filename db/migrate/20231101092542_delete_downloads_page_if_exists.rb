class DeleteDownloadsPageIfExists < ActiveRecord::Migration[7.1]
  def change
    if Page.where(url: 'downloads').exists?
      Page.where(url: 'downloads').first!.destroy
    end
  end
end
