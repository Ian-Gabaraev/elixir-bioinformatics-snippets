defmodule NucleotideSequence do

  # Generate a random AGTC-sequence
  def get_sample_sequence(seq_length) do
    for _ <- 1..seq_length, into: "", do: <<Enum.random('AGTC')>>
  end

  # Get a GC content for a nucleotide sequence
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
