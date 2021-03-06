module TitleHelper
  def display_site_title
    the_title = get_setting('site_title')
    the_title = "&nbsp;" if the_title.blank?
    content_tag "h1", the_title, :class => 'title'
  end

  def title_helper
    title_bits = []
    title_bits << get_setting('site_title')
    if @page
      title_bits << @page.title
    end
    title_bits.compact.reverse.join(" | ")
  end
end
