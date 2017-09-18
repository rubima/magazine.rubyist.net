  @@ layout
  !!! 5
  %html
    %head
      %title= yield_content(:title) || @title
    %body
      %h1= yield_content(:header) || @title
      %div= yield

  @@ index
  - content_for :title do
    This is title from helper
  - content_for :header do
    This is header from helper
  %p My Way
