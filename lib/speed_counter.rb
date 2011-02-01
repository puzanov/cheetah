class SpeedCounter
  def calculate_speed filesize, seconds
    return filesize / seconds / 1024
  end
end
