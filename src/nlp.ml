let split_on_space s = Astring.String.cuts ~sep:" " s

module Tokens = Map.Make(String)

let tokenise s =
  let tokens = split_on_space s in
  let m = Tokens.empty in
  let f acc s =
    let count =
      match
        try
          Some (Tokens.find s acc)
        with Not_found -> None
      with
      | None -> 0
      | Some x -> x
    in
    Tokens.add s (count+1) acc in
  List.fold_left (fun acc s -> f acc s) m tokens

let count x y = match x, y with
| Some x, None -> x
| Some x, Some _ -> x
| _ -> 0

let vectorise m1 m2 =
  let cm1 = Tokens.merge(fun _ x y -> Some (count x y)) m1 m2 in
  let cm2 = Tokens.merge (fun _ x y -> Some (count x y)) m2 m1 in
  let v1 = Tokens.bindings cm1 |> List.split |> snd in
  let v2 = Tokens.bindings cm2 |> List.split |> snd in
  v1, v2

let cosine_similarity l1 l2 =
  let s1 = List.fold_left (fun acc i -> acc + (i * i)) 0 l1 in
  let s2 = List.fold_left (fun acc i -> acc + (i * i)) 0 l2 in
  let dot = List.fold_left2 (fun acc i j -> acc + (i * j)) 0 l1 l2 in
  float_of_int(dot) /. (sqrt (float_of_int s1) *. (sqrt (float_of_int s2)))
