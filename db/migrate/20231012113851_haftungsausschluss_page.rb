class HaftungsausschlussPage < ActiveRecord::Migration[7.0]
  def change
    Page.create!([{
      url: 'mitarbeiter_haftungsausschluss',
      content: ''
    },{
      url: 'mitarbeiter_wichtige-infos',
      content: ''
    }])
  end
end
