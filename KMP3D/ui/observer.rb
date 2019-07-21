module KMP3D
  module Observer
    def activate
      @dlg.show unless @dlg.visible?
      refresh_html
    end

    def deactivate(view)
      view.invalidate
    end

    def onMouseMove(flags, x, y, view)
      @ip.pick(view, x, y)
      view.tooltip = @ip.tooltip if @ip.valid?
      view.invalidate
    end

    def onLButtonDown(flags, x, y, view)
      @ip.pick(view, x, y)
      next unless @ip.valid?
      ph = view.pick_helper
      ph.do_pick(x, y)
      ent = ph.best_picked
      if ent && ent.kmp3d_object?
        type.add_to_component(ent)
      else
        type.add_to_model(@ip.position)
      end
      refresh_html
    end

    def onSelectionBulkChange(_)
      type.selected_points = Data.selection.map { |s| s.kmp3d_id(type_name) }
      refresh_html
    end

    def onSelectionCleared(_)
      type.selected_points = []
      refresh_html
    end

    def onOpenModel(_)
      Data.reload_types
      refresh_html
    end

    def draw(view)
      @ip.draw(view)
    end
  end
end
