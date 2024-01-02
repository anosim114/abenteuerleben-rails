class AddLiabilityAndImportantInformationParentRecords < ActiveRecord::Migration[7.1]
  def change
    Page.create!([
                   {
                     url: 'eltern_wichtige-informationen',
                     content: 'Eltern wichtige infos'
                   },
                   {
                     url: 'eltern_haftungsausschluss',
                     content: 'Eltern Haftungsausschluss'
                   }
                 ])
  end
end
