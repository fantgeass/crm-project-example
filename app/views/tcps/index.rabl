collection @tcps
attributes :id, :title, :status

node(:tasks_size) { |tcp| tcp.tasks.size }