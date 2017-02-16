module Tokens : Map.S
(* The type for storing tokens *)

val tokenise : string -> int Tokens.t
(* splits a string in to an [int Tokens.t] *)

val vectorise : int Tokens.t -> int Tokens.t -> int list * int list
(* Transforms a pair of [int Tokens.t] in to two, sorted, 1d arrays *)

val cosine_similarity : int list -> int list -> float
(* calculates the Cosine similarity between two 1d arrays *)
