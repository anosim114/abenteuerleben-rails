module HtmlelementHelper
  def tag_dropdown_action actions
    tag.div class: 'dropdown-action' do
      toggle_btn = tag.div do
        tag.button class: 'dropdown-action__toggle' do
          tag.span('Weitere Aktionen ') + forticon('caret-down', height: 16)
        end
      end
      dropdown = tag.div class: 'dropdown-action__dropdown' do
        safe_join(
          actions.map do |action|
            inner = if action[:js_function] != nil
                      tag.button action[:text], class: 'dropdown-action__action', onclick: action[:js_function]
                    elsif action[:link] != nil
                      tag.anchor action[:text], href: action[:link], class: 'dropdown-action__action'
                    else
                      tag.span action[:text], class: 'dropdown-action__action'
                    end
            inner
          end
        )
      end

      toggle_btn + dropdown
    end
  end
end
