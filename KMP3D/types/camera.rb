module KMP3D
  class CAME < Type
    attr_accessor :op_cam_index

    CamType = Struct.new(:name, :model, :route, :opening)
    CAMTYPES = [
      CamType.new("0 Goal",           :rails, false, false),
      CamType.new("1 FixSearch",      :point, false, false),
      CamType.new("2 PathSearch",     :point,  true, false),
      CamType.new("3 KartFollow",     :point, false, false),
      CamType.new("4 KartPathFollow",  :both, false,  true),
      CamType.new("5 OP_FixMoveAt",   :rails,  true,  true),
      CamType.new("6 OP_PathMoveAt",  :point,  true,  true)
    ]

    def initialize
      @name = "Cameras"
      @op_cam_index = Data.model.get_attribute("KMP3D", "CAME", 0)
      @settings = [
        Settings.new(:text, :byte, "Next", "0xFF"),
        Settings.new(:text, :byte, "Route", "0xFF"),
        Settings.new(:text, :uint16, "Zoom vel.", "60"),
        Settings.new(:text, :uint16, "View vel.", "60"),
        Settings.new(:text, :float, "Zoom start", "0.0"),
        Settings.new(:text, :float, "Zoom end", "0.0"),
        Settings.new(:text, :float, "Time", "60.0")
      ]
      super
    end

    def camtype
      CAMTYPES.map { |type| type.name } << "Camera Settings"
    end

    def camera?
      true
    end

    def hide_point?
      CAMTYPES[@group].model != :point && @step < 2
    end

    def draw_connected_points(view, pos, selection=false)
      return unless (on_external_settings? || hide_point?) && pos && @step == 1
      view.line_stipple = "-"
      view.draw_polyline([@prev, pos])
    end

    def transform(comp, pos)
      comp.transform!(Geom::Transformation.translation(pos))
    end

    def advance_steps(pos)
      case CAMTYPES[@group].model
      when :rails
        # needed for add_comp
        add_rails(pos) if @step == 1
        @step += 1
        @step %= 2
      when :both
        add_rails(pos) if @step == 1
        add_point(pos) if @step == 2
        @step += 1
        @step %= 3
      end
      @prev = pos
      return @step
    end

    def helper_text
      case CAMTYPES[@group].model
      when :point
        "Click to place the position of the camera."
      when :rails
        case @step
        when 0 then "(Step 1/2) Click to place the camera view start."
        when 1 then "(Step 2/2) Click to place the camera view end."
        end
      when :both
        case @step
        when 0 then "(Step 1/3) Click to place the camera view start."
        when 1 then "(Step 2/3) Click to place the camera view end."
        when 2 then "(Step 3/3) Click to place the position of the camera."
        end
      end
    end

    def table_helper_text
      # Based off http://wiki.tockdom.com/wiki/KMP_Editing/Cameras
      case @group
      when 0
        "Activates immediately after passing the goal; with the player as the origin, the camera's View Start position both follows and looks at the player. It can be reactivated as a Replay Camera if linked to an AREA, but does not display in spectator (online/waiting) mode."
      when 1
        "Camera stays static in View Start location, and always looks towards the player."
      when 2
        "Route controlled, always looks at the player."
      when 3
        "With the player as the origin, the camera's View Start position both follows and looks at the player."
      when 4
        "From its position, it looks at View Start and shifts view to View End."
      when 5
        "Opening camera, follows route; from its position, it looks at View Start and shifts view to View End."
      when 6
        "Opening camera onboard with same effects as normal drive Camera (unsure)."
      else
        "Unused"
      end
    end

    def import(pos, rail_start, rails_end, group, settings)
      @group = group
      camtypemdl = CAMTYPES[@group].model
      settings = camtype_settings(settings)
      skp_grp = Data.entities.add_group
      skp_grp.entities.add_cline(rail_start, rails_end) if camtypemdl != :point
      skp_grp.entities.add_instance(model, pos) if camtypemdl != :rails
      comp = skp_grp.to_component
      comp.name = "KMP3D #{type_name}(#{group},#{settings * ','})"
      comp.layer = name
    end

    def inputs
      # settings added due to next point using previous settings
      inputs = [[-1, false] + camtype_settings(@settings.map { |s| s.default })]
      Data.entities_in_group(type_name, @group).each do |ent|
        id = ent.kmp3d_id(type_name)
        selected = Data.selection.include?(ent)
        inputs << [id, selected] + ent.kmp3d_settings[1..-1]
      end
      return inputs
    end

    def to_html
      if on_external_settings?
        tag(:div, :class => "cameras") { camera_settings_html }
      else
        tag(:table) \
          { table_rows(inputs, camtype_settings(@settings)) * "" } + \
        tag(:div, :class => "helper-text") { table_helper_text }
      end
    end

    def on_external_settings?
      @group == 7
    end

    def add_comp(comp)
      if CAMTYPES[@group].model == :point
        super(comp)
      else
        comp.erase!
        super(@comp_group.to_component)
      end
    end

    def camtype_settings(settings)
      settings = settings.clone
      settings[0] = nil unless CAMTYPES[@group].opening # next camera
      settings[1] = nil unless CAMTYPES[@group].route # route
      settings[3] = nil unless CAMTYPES[@group].model != :point # viewspeed
      settings[6] = nil unless CAMTYPES[@group].opening # time
      return settings.compact
    end

    def save_settings
      Data.model.set_attribute("KMP3D", "CAME", @op_cam_index)
    end

    private

    def camera_settings_html
      "Initial opening camera index: " + \
      tag(:input, :id => "opCameIdx", :type => "text", :size => "2", \
        :value => @op_cam_index, :onchange => callback("setOpCamIdx")) + br + \
      tag(:button, :onclick => callback("playOpening")) \
        { "Play Opening Cameras" } + br + \
      tag(:button, :onclick => callback("playReplay")) \
        { "Play Replay Cameras" } + br + \
      tag(:button, :onclick => callback("stopReplay")) \
        { "Stop Camera Playback" }
    end

    def add_rails(pos)
      @comp_group = Data.entities.add_group
      @comp_group.layer = name
      @comp_group.entities.add_cline(@prev, pos)
    end

    def add_point(pos)
      @comp_group.entities.add_instance(model, pos)
    end

    def transform_rail_start(comp, pos)
      comp.transform!(Geom::Transformation.translation(pos - [0, 1500.m, 0]))
    end
  end
end
