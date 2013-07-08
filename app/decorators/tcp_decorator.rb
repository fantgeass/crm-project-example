# encoding: utf-8

class TcpDecorator < ApplicationDecorator
  include ProjectableDecorator

  def link_to_create_project
    if source.state_completed?
      link_to 'Создать проект', create_project_tcp_path(source), method: :post, confirm: 'Are you sure?',
              class: 'btn btn-spbec'
    end
  end

  def link_to_project
    link_to 'Посмотреть проект', project_path(source.project), class: 'btn btn-spbec'
  end

  def link_to_create_or_show_project
    if source.project
      link_to_project
    else
      link_to_create_project
    end
  end

end
