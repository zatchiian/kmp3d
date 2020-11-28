module KMP3D
  class CameraPreview
    Route = Struct.new(:pos, :speed)
    Path  = Struct.new(:points, :prog)
    MKW_FRAMERATE = 59.94

    def initialize(ent)
      @fov = Data.model.active_view.camera.fov
      get_ent_settings(ent)
      @prev_time = Time.now
    end

    def get_ent_settings(ent)
      @group      = ent.kmp3d_group.to_i
      @camtype    = CAME::CAMTYPES[@group]
      @settings   = ent.kmp3d_settings[1..-1]
      @route      = Path.new(route_path(ent), 0)
      @rail_start, @rail_end = came_rails(ent)
      @rail_dist  = @rail_start.distance(@rail_end).to_m
      @rail_prog  = 0
      @next_came  = @settings[0]
      @zoom_vel   = @settings[4].to_f
      @view_vel   = @settings[5].to_f
      @zoom_prog  = @settings[10].to_f
      @zoom_end   = @settings[11].to_f
      @total_time = @settings[14].to_f
      @start_time = Time.now
    end

    def rel_pos(enpt)
      x, y, z = @settings[12].split(",")
      pt1, pt2 = @enpt.points[0].pos, @enpt.points[1].pos
      vec = Geom::Vector3d.new(x.to_f.m, -z.to_f.m, (y.to_f + 200).m)
      angle = Math::PI - Math.atan2(pt2.x - pt1.x, pt2.y - pt1.y)
      vec.transform!(Geom::Transformation.rotation(enpt, Z_AXIS, angle))
      return enpt + vec
    end

    def time
      (Time.now - @start_time) * MKW_FRAMERATE
    end

    def delta
      Time.now - @prev_time
    end

    def lerp(p1, p2, t)
      Geom::Transformation.interpolate(p1, p2, t).origin
    end

    def next_pos(path)
      loop do
        return path.points[0].pos if path.points.length == 1
        path.prog += delta * path.points[0].speed * MKW_FRAMERATE
        ratio = path.prog / path.points[0].pos.distance(path.points[1].pos).to_m
        return lerp(path.points[0].pos, path.points[1].pos, ratio) if ratio <= 1
        path.prog = 0
        path.points.shift
      end
    end

    def zoom
      @zoom_prog += delta * @zoom_vel * 100 / MKW_FRAMERATE
      @zoom_prog = @zoom_end if @zoom_prog >= @zoom_end
      return @zoom_prog
    end

    def route_path(ent)
      return [Route.new(ent.transformation.origin, 0)] unless @camtype.route
      return Data.entities_in_group("POTI", @settings[2]).map do |ent|
        Route.new(ent.transformation.origin, ent.kmp3d_settings[1].to_f)
      end
    end

    def came_rails(ent)
      return Array.new(2, ent.transformation.origin) if @camtype.model == :point

      ents = ent.definition.entities
      line = ents.select { |e| e.typename == "ConstructionLine" }.first
      return [line.start, line.end]
    end

    def sketchup_camera(pos, tgt)
      up = Z_AXIS
      up = Y_AXIS if (pos - tgt).normalize == Z_AXIS
      Sketchup::Camera.new(pos, tgt, up, true, zoom)
    end

    def stop
      @draw_current_enpt = false
      return unless @fov
      Data.model.active_view.camera.fov = @fov
      @fov = nil
    end

    def draw_enpt(view)
      return unless @draw_current_enpt && @enpt
      view.draw_points(next_pos(@enpt), 20, 3, "red")
    end
  end

  class CameraOpening < CameraPreview
    def nextFrame(view)
      pos = next_pos(@route)
      view.camera = sketchup_camera(pos, target)
      view.show_frame
      @prev_time = Time.now
      return true if time < @total_time # continue animation if true
      return false if ["0xFF", "-1", "255"].include?(@next_came)

      get_ent_settings(Data.get_entity("CAME", @next_came))
      return true
    end

    def target
      @rail_prog += delta * @view_vel * 100 / MKW_FRAMERATE
      ratio = @rail_prog / @rail_dist
      ratio = 1 if ratio > 1
      lerp(@rail_start, @rail_end, ratio)
    end
  end

  class CameraReplay < CameraPreview
    def initialize(ent)
      super
      @draw_current_enpt = true
      @enpt = Path.new(enpt_path, 0)
      @area = Data.kmp3d_entities("AREA")
    end

    def enpt_path
      enpts = []
      grp = 0
      type = Data.type_by_typename("ENPT")
      speed = 45 * Data.type_by_typename("STGI").table[1][6].to_f # speedmod
      lap = 0
      loop do
        enpts += Data.entities_in_group("ENPT", grp).map do |e|
          Route.new(e.transformation.origin, speed)
        end
        # always pick the first group in a split path
        grp = type.table[grp + 1][0].split(",").first.to_i
        lap += 1 if grp == 0
        break if lap == 3
      end
      return enpts
    end

    def nextFrame(view)
      enpt = next_pos(@enpt)
      switch_camera(enpt)
      pos = ([0, 3, 6].include?(@group) ? rel_pos(enpt) : next_pos(@route))
      view.camera = sketchup_camera(pos, enpt)
      view.show_frame
      @prev_time = Time.now
      return @enpt.points.length > 1
    end

    def switch_camera(enpt)
      # TODO: area priority
      area = @area.select { |a| KMP3D::KMPMath.intersect_area?(a, enpt) }.first
      return unless area

      @cam = area.kmp3d_settings[3]
      return if @prev_cam == @cam

      puts "Switching to camera ID #{@cam}"
      get_ent_settings(Data.get_entity("CAME", @cam)) if area
      @prev_cam = @cam
    end
  end
end
