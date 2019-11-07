module KMP3D
  module Callbacks
    def add_callbacks
      @dlg.add_action_callback("scroll") { |_, px| @scroll = px }
      @dlg.add_action_callback("refresh") { refresh_html }
      @dlg.add_action_callback("setGroup") { set_group }
      @dlg.add_action_callback("addGroup") { add_group }
      @dlg.add_action_callback("deleteRow") { |_, id| delete_row(id) }
      @dlg.add_action_callback("selectRow") { |_, id| select_point(id) }
      @dlg.add_action_callback("inputChange") { |_, id| edit_value(id) }
    end

    def set_group
      type.group = @dlg.get_element_value("currentGroup").to_i
    end

    def add_group
      type.add_group
    end

    def delete_row(id)
      type.on_external_settings? ? delete_group(id) : delete_point(id)
    end

    def delete_group(id)
      type.table.delete_at(id.to_i)
      Data.model.abort_operation
      Data.model.start_operation("Remove Group and Settings", true)
      Data.kmp3d_entities(type.type_name).each do |ent|
        ent.remove_kmp3d_settings(type.type_name) if \
          ent.kmp3d_settings(type.type_name)[0] == id
      end
      KMP3D::Data.model.commit_operation
    end

    def delete_point(id)
      Data.model.abort_operation
      KMP3D::Data.model.start_operation("Remove KMP3D Point Settings", true)
      ent = Data.get_entity(type.type_name, id)
      ent.remove_kmp3d_settings(type.type_name) if ent
      KMP3D::Data.model.commit_operation
    end

    def select_point(id)
      ent = Data.get_entity(type.type_name, id)
      Data.selection.toggle(ent)
    end

    def edit_value(table_id)
      id = table_id.split(",").first
      row = table_id.split(",").last
      value = @dlg.get_element_value(table_id)
      if value == "true" then value = "false"
      elsif value == "false" then value = "true"
      end
      type.on_external_settings? ? \
        edit_group_value(value, id, row) : edit_point_value(value, id, row)
    end

    def edit_group_value(value, id, row)
      return unless valid?(type.external_settings[row.to_i].input, value)
      type.table[id.to_i + 1][row.to_i] = value
    end

    def edit_point_value(value, id, row)
      return unless valid?(type.settings[row.to_i].input, value)
      ent = Data.get_entity(type.type_name, id)
      ent.kmp3d_settings_insert(type.type_name, row.to_i, value)
    end

    private

    def valid_int_within(value, min, max)
      /^(0x(\d|[A-f])+|-?\d+)$/.match(value) \
      && min <= value.to_i && value.to_i <= max
    end

    def valid?(type, value)
      case type
      when :byte then valid_int_within(value, 0, 255)
      when :bytes then value.split(",").all? { valid_int_within(value, 0, 255) }
      when :float then /^[-]?\d*\.?\d+$/.match(value)
      when :int16 then valid_int_within(value, -32767, 32767)
      when :uint16 then valid_int_within(value, 0, 65535)
      else true
      end
    end
  end
end
