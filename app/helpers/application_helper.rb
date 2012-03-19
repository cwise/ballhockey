# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def entry_nav_items
    menu_items = ""
    menu_items += "<li>" + submit_link("Save Changes")  + "</li>"
    menu_items += "<li>" + link_to('Cancel', :back) + "</li>"
  end

  def edit_nav_items(id)
    menu_items = ""
    menu_items += "<li>" + link_to('Edit ' + @current_controller.capitalize, :action => 'edit', :id => id)+ "</li>"
  end
  
  def index_nav_items
    menu_items = ""
    menu_items += "<li>" + link_to('New ' + @current_controller.capitalize, :action => 'new') + "</li>"
    menu_items += "<li>" + link_to('Back to Index', root_path) + "</li>"
  end

  def index_only_nav_items
     "<li>" + link_to('Back to Index', root_path) + "</li>"
  end

  def link_nav(nav_items)
	  menu = "<p><div class='link_button'>"
	  menu += "<ul>"
	  menu += nav_items
	  menu += "</ul>"
	  menu += "</div></p>"
  end

  def entry_nav
    link_nav(entry_nav_items)
  end

  def edit_nav(id)
    link_nav(edit_nav_items(id))
  end

  def controller_header
	  "<table width=675px><caption>" + @current_controller.capitalize.pluralize + "</caption></table>"
  end

  def index_nav
	  link_nav(index_nav_items)
  end

  def index_only_nav
	  link_nav(index_only_nav_items)
  end

  def button_link(name, options)
    button_to(name, options, :class => 'trackstar_button', :method => :get)
  end
  
  def submit_link(caption)
    link_to_function(caption, "$(this).up('form').submit()")
  end
end
