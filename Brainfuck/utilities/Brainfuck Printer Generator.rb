def brainturing_printer_generator(text)
  ords = text.chars.map(&:ord)
  ("+" * ords.first + ".\n") + ords
    .zip(ords[1..-1])
    .take(ords.size - 1)
    .map {|prev, curr| (curr > prev ? "+" : "-") * (curr - prev).abs}
    .join(".\n") + ".\n"
end

print brainturing_printer_generator("Across the Great Wall we can reach every corner in the world.\n")
