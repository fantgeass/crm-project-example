module ApplicationHelper
  def truncate(text, max_sentences = 3, max_words = 50)
    # Take first 3 setences (blah. blah. blah)
    three_sentences = text.split('. ').slice(0, max_sentences).join('. ')
    # Take first 50 words of the above
    shortened = three_sentences.split(' ').slice(0, max_words).join(' ')
    return shortened # bah, explicit return is evil
  end

  def last_news
    Post.order('created_at DESC').limit(5).decorate
  end

  def empty_value(value)
    value ? value : t(:empty)
  end

  def empty_date(date, options={format: :long})
    date ? l(date, options) : t(:empty_date)
  end

  # icon_tag :download
  def icon_tag(name, size = :default)
    size = size === :default ? '' : "icon-#{size}"
    "<i class='icon-#{name} #{size}'></i>".html_safe
  end

  # icon_ling_to :pencil, comments_path
  def icon_link_to(*args, &block)
    args[0] = icon_tag(args[0], :large)
    args[2] ||= {}
    args[2][:class] = 'link-as-icon ' + args[2][:class].to_s

    link_to *args, &block
  end

  # update_link_to polymorphic_path([parent, task])
  def update_link_to(*args, &block)
    options      = args[0] || {}
    html_options = args[1] || {}
    html_options[:title] = t(:update)
    html_options[:class] = 'action action-edit'

    args[0] = ''
    args[1] = options
    args[2] = html_options

    link_to *args, &block
  end

  # delete_link_to polymorphic_path([parent, task])
  def delete_link_to(*args, &block)
    options      = args[0] || {}
    html_options = args[1] || {}
    html_options[:data] ||= {}

    html_options[:title] = t(:delete)
    html_options[:method] = :delete
    html_options[:data][:confirm] = t(:are_you_sure?)

    args[0] =  icon_tag('remove', 'large')
    args[1] = options
    args[2] = html_options

    link_to *args, &block
  end

  # back_link_to comments_path
  def back_link_to(path)
    link_to icon_tag('arrow-left') + ' ' +  t(:back), path, class: 'btn btn-inverse btn-mini'
  end

  # This is like a hack to use new format with date localization
  # There must be a better way to do this
  def localize(date, options = {})
    if options[:format] == :near_date
      time_addon = date.is_a?(Date) ? '' : ", #{date.strftime('%H:%M')}"

      date_string = t(:yesterday) if date == Date.yesterday
      date_string = t(:today) if date.today?
      date_string = t(:tomorrow) if date == Date.tomorrow

      return date_string + time_addon unless date_string.nil?
      options[:format] = :long
    end
    super(date, options)
  end
  alias :l :localize

end
