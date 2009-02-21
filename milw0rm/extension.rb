require 'milw0rm'

ronin_extension do

  def remote
    section(:remote)
  end

  def local
    section(:local)
  end

  def web
    section(:webapps)
  end

  def dos
    section(:dos)
  end

  def section(name)
    var = "@#{name}"

    unless instance_variable_get(var)
      instance_variable_set(var,Milw0rm::Section.new(name))
    end

    return instance_variable_get(var)
  end

end
