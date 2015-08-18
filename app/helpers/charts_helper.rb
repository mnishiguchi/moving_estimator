module ChartsHelper

  def data_by_categories(items)
    initial_hash = Hash.new(0)  # key's default value is 0
    output = items.inject(initial_hash) do |builder, item|
      builder[item.category.downcase] += (item.volume * item.quantity)
      builder
    end
    Hash[output.sort_by{ |_, v| -v }]
  end

  def data_by_rooms(items)
    initial_hash = Hash.new(0)  # key's default value is 0
    output = items.inject(initial_hash) do |builder, item|
      builder[item.room.downcase] += (item.volume * item.quantity)
      builder
    end
    Hash[output.sort_by{ |_, v| -v }]
  end

  def data_for_bar_chart(items)
    items_sorted = data_by_categories(items)
    labels       = items_sorted.keys
    data         = []
    labels.each { |label| data << items_sorted[label] }
    output = {
      labels: labels,
      datasets: [
        {
          label: "",
          fillColor:       "rgba(220,220,220,0.5)",
          strokeColor:     "rgba(220,220,220,0.8)",
          highlightFill:   "rgba(220,220,220,0.75)",
          highlightStroke: "rgba(220,220,220,1)",
          data: data
        }
      ]
    }
  end

  def data_for_pie_chart(items)
    colors = ["#FE2E2E", "#FE9A2E", "#9AFE2E", "#2EFE2E", "#2EFE9A", "#2EFEF7",
              "#2E9AFE", "#2E2EFE", "#9A2EFE", "#FE2EF7", "#FE2E9A", "#0099cc",
              "#9933cc", "#669900", "#ff8a00", "#cc0000", "#6dcaec", "#cf9fe7",
              "#b6db49", "#ff7979"]
    colors.shuffle!

    items_sorted = data_by_rooms(items)
    labels       = items_sorted.keys
    output       = []
    index        = 0
    for label in labels
      output << { value:     items_sorted[label],
                  color:     colors[index],
                  highlight: colors[index],
                  label:     label }
      index += 1
    end
    output
  end
end
