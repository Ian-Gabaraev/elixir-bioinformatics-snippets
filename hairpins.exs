require Integer

defmodule HairpinSequence do

  @complements %{
    "G" => "C",
    "C" => "G",
    "A" => "T",
    "T" => "A"
  }

  # Determines the length of an input hairpin sequence
  def get_hairpin_length!(nucleotide_sequence) do
    sequence_length = String.length(nucleotide_sequence)

    cond do
      _is_even_length_non_hp?(nucleotide_sequence, sequence_length) == true ->
        raise ArgumentError, message: "Even length non-hp"
      _first_last_bases_non_complementary?(nucleotide_sequence) == true ->
        raise ArgumentError, message: "First and last bases are non-complementary"
      true ->
        _hp_len(nucleotide_sequence, sequence_length)
    end
  end


  defp _hp_len(nucleotide_sequence, sequence_length) do
    indexes = Enum.to_list(0..div(sequence_length, 2)-1)

    checks = Enum.map(
      indexes, fn x -> _are_complements?(
        String.at(nucleotide_sequence, x),
        String.at(nucleotide_sequence, (sequence_length-x)-1)
        ) end
      )

    matched_complements = Enum.filter(
      Enum.to_list(0..length(checks)-2), fn x ->
        (Enum.at(checks, x) and Enum.at(checks, x+1)) == true
      end
    )

    cond do
      length(matched_complements) == 0 ->
        1
      length(matched_complements) > 0 ->
        length(matched_complements)+1
    end
  end


  defp _first_last_bases_non_complementary?(nucleotide_sequence) do
    first_base = String.first(nucleotide_sequence)
    last_base = String.last(nucleotide_sequence)

    cond do
      _are_complements?(first_base, last_base) == false ->
        true
      _are_complements?(first_base, last_base) == true ->
        false
    end
  end


  defp _is_even_length_non_hp?(nucleotide_sequence, sequence_length) do
    is_even_length = Integer.is_even(sequence_length)
    leftmost_middle_base = String.at(nucleotide_sequence, div(sequence_length, 2)-1)
    rightmost_middle_base = String.at(nucleotide_sequence, div(sequence_length, 2))

    cond do
      is_even_length and _are_complements?(leftmost_middle_base, rightmost_middle_base) == true ->
        true
      is_even_length and _are_complements?(leftmost_middle_base, rightmost_middle_base) == false ->
        false
    end
  end


  defp _are_complements?(base_one, base_two) do
    @complements[base_one] == base_two
  end

end
