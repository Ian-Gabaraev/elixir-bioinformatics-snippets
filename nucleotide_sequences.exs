defmodule GBlocks do

  def gc_content(sequence) do
    sequence = String.upcase(sequence)
    sequence_length = String.length(sequence)
    freqs = sequence |> String.graphemes |> Enum.frequencies

    g_count = freqs["G"]
    c_count = freqs["C"]

    _percentage(g_count+c_count, sequence_length)
  end

  defp _percentage(numerator, denominator) do
    (numerator / denominator) * 100
  end

end

# Test
sequence = "AGATGTCAGCGACATCG"
gcc = GBlocks.gc_content(sequence)
IO.puts("GC Content of #{sequence} is #{gcc}")
