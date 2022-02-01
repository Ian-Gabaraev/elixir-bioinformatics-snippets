require Integer

defmodule HairpinSequence do

  @complements %{
    "G" => "C",
    "C" => "G",
    "A" => "T",
    "T" => "A"
  }

  # Determines the length of an input hairpin sequence
  def get_hairpin_length(nucleotide_sequence) do
    sequence_length = String.length(nucleotide_sequence)
    is_even_length = Integer.is_even(sequence_length)

    if not _are_complements(
      String.first(nucleotide_sequence),
      String.last(nucleotide_sequence)
      ) do
        0
    end

    if is_even_length do
      if _are_complements(
        String.at(nucleotide_sequence, div(sequence_length, 2)-1),
        String.at(nucleotide_sequence, div(sequence_length, 2))
      ) do
        0
      end
    end

    indexes = Enum.to_list(0..div(sequence_length, 2)-1)

    checks = Enum.map(
      indexes, fn x -> _are_complements(
        String.at(nucleotide_sequence, x),
        String.at(nucleotide_sequence, (sequence_length-x)-1)
        ) end
      )

    matched_complements = Enum.filter(
      Enum.to_list(0..length(checks)-2), fn x ->
        Enum.at(checks, x) and Enum.at(checks, x+1) == true
      end
    )

    length(matched_complements)+1

  end

  defp _are_complements(base_one, base_two) do
    @complements[base_one] == base_two
  end
end
