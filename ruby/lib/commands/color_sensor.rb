# ruby-nxt Control Mindstorms NXT via Bluetooth Serial Port Connection
# Copyright (C) 2006 Tony Buser <tbuser@gmail.com> - http://juju.org
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

require "commands/mixins/sensor"
# require "nxt_comm"

# Implements (and extens) the "Light Sensor" block in NXT-G
class Commands::ColorSensor

  include Commands::Mixins::Sensor

  attr_reader :port, :color_mode
  attr_accessor :trigger_point, :comparison

  def initialize(nxt,port=3)
    @nxt      = nxt

    # defaults the same as NXT-G
    @port           = port
    @trigger_point  = 50
    @comparison     = ">"
    @color_mode = NXTComm::COLORFULL
    set_mode
  end

  def green_only
    self.color_mode = NXTComm::COLORGREEN
  end

  def red_only
    self.color_mode = NXTComm::COLORRED
  end

  def blue_only
    self.color_mode = NXTComm::COLORBLUE
  end

  def all_colors
    self.color_mode = NXTComm::COLORFULL
  end

  def light_sensor
    self.color_mode = NXTComm::COLORNONE
  end


  # Turns the sensor's LED on or off.
  # Takes true or false as the argument; if true, light will be turned on,
  # if false, light will be turned off.
  def color_mode=(mode)
    @color_mode = mode
    set_mode
  end

  def current_color
    case value_scaled
    when NXTComm::BLACK
      "black"
    when NXTComm::BLUE
      "blue"
    when NXTComm::GREEN
      "green"
    when NXTComm::YELLOW
      "yellow"
    when NXTComm::RED
      "red"
    when NXTComm::WHITE
      "white"
    else
      raise "Unrecognized color value: #{value_scaled}"
    end
  end

  def current_rgb_value
    rgb_values = {}

    red_only
    rgb_values[:red] = value_scaled

    green_only
    rgb_values[:green] = value_scaled

    blue_only
    rgb_values[:blue] = value_scaled

    rgb_values
  end

  def light_intensity
    light_sensor
    value_scaled
  end

  # sets up the sensor port
  def set_mode
    mode = @color_mode
    @nxt.set_input_mode(
      NXTComm.const_get("SENSOR_#{@port}"),
      mode,
      NXTComm::RAWMODE
    )
  end

  # attempt to return the input_value requested
  def method_missing(cmd)
    @nxt.get_input_values(NXTComm.const_get("SENSOR_#{@port}"))[cmd]
  end
end
